-- Botaniq persistence hardening
-- Safe to run against an existing project: no tables or user data are dropped.
-- Run with Supabase migrations or paste the whole file into SQL Editor.

begin;

create extension if not exists pgcrypto;

-- ---------------------------------------------------------------------------
-- Shared timestamp helper
-- ---------------------------------------------------------------------------
create or replace function public.set_updated_at()
returns trigger
language plpgsql
set search_path = ''
as $$
begin
  new.updated_at = timezone('utc'::text, now());
  return new;
end;
$$;

-- ---------------------------------------------------------------------------
-- User/profile records used by the current Flutter application
-- ---------------------------------------------------------------------------
create table if not exists public.profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  email text,
  full_name text,
  avatar_url text,
  location text,
  watering_reminders boolean not null default true,
  fertilizer_reminders boolean not null default true,
  fcm_token text,
  language_code text,
  created_at timestamptz not null default timezone('utc'::text, now()),
  updated_at timestamptz not null default timezone('utc'::text, now())
);

-- Older schemas made profiles.email mandatory. OAuth/phone users may not have it.
alter table public.profiles add column if not exists email text;
alter table public.profiles add column if not exists full_name text;
alter table public.profiles add column if not exists avatar_url text;
alter table public.profiles add column if not exists location text;
alter table public.profiles add column if not exists watering_reminders boolean default true;
alter table public.profiles add column if not exists fertilizer_reminders boolean default true;
alter table public.profiles add column if not exists fcm_token text;
alter table public.profiles add column if not exists language_code text;
alter table public.profiles add column if not exists created_at timestamptz default timezone('utc'::text, now());
alter table public.profiles add column if not exists updated_at timestamptz default timezone('utc'::text, now());
alter table public.profiles alter column email drop not null;

-- The current sign-up and edit-profile screens use public.users.
create table if not exists public.users (
  id uuid primary key references auth.users(id) on delete cascade,
  email text,
  full_name text,
  avatar_url text,
  location text,
  watering_reminders boolean not null default true,
  fertilizer_reminders boolean not null default true,
  created_at timestamptz not null default timezone('utc'::text, now()),
  updated_at timestamptz not null default timezone('utc'::text, now())
);

alter table public.users add column if not exists email text;
alter table public.users add column if not exists full_name text;
alter table public.users add column if not exists avatar_url text;
alter table public.users add column if not exists location text;
alter table public.users add column if not exists watering_reminders boolean default true;
alter table public.users add column if not exists fertilizer_reminders boolean default true;
alter table public.users add column if not exists created_at timestamptz default timezone('utc'::text, now());
alter table public.users add column if not exists updated_at timestamptz default timezone('utc'::text, now());

create or replace function public.handle_new_user()
returns trigger
language plpgsql
security definer
set search_path = ''
as $$
declare
  display_name text;
  picture_url text;
begin
  display_name := coalesce(
    new.raw_user_meta_data ->> 'full_name',
    new.raw_user_meta_data ->> 'name'
  );
  picture_url := coalesce(
    new.raw_user_meta_data ->> 'avatar_url',
    new.raw_user_meta_data ->> 'picture'
  );

  insert into public.profiles (id, email, full_name, avatar_url)
  values (new.id, new.email, display_name, picture_url)
  on conflict (id) do update
    set email = excluded.email,
        full_name = coalesce(excluded.full_name, public.profiles.full_name),
        avatar_url = coalesce(excluded.avatar_url, public.profiles.avatar_url),
        updated_at = timezone('utc'::text, now());

  insert into public.users (id, email, full_name, avatar_url)
  values (new.id, new.email, display_name, picture_url)
  on conflict (id) do update
    set email = excluded.email,
        full_name = coalesce(excluded.full_name, public.users.full_name),
        avatar_url = coalesce(excluded.avatar_url, public.users.avatar_url),
        updated_at = timezone('utc'::text, now());

  return new;
end;
$$;

drop trigger if exists on_auth_user_created on auth.users;
create trigger on_auth_user_created
  after insert or update of email, raw_user_meta_data on auth.users
  for each row execute function public.handle_new_user();

-- Backfill application records for users created before this migration.
insert into public.profiles (id, email, full_name, avatar_url)
select
  au.id,
  au.email,
  coalesce(au.raw_user_meta_data ->> 'full_name', au.raw_user_meta_data ->> 'name'),
  coalesce(au.raw_user_meta_data ->> 'avatar_url', au.raw_user_meta_data ->> 'picture')
from auth.users au
on conflict (id) do nothing;

insert into public.users (id, email, full_name, avatar_url)
select
  au.id,
  au.email,
  coalesce(au.raw_user_meta_data ->> 'full_name', au.raw_user_meta_data ->> 'name'),
  coalesce(au.raw_user_meta_data ->> 'avatar_url', au.raw_user_meta_data ->> 'picture')
from auth.users au
on conflict (id) do nothing;

-- ---------------------------------------------------------------------------
-- Verified plant catalog structure
-- ---------------------------------------------------------------------------
create table if not exists public.plant_catalog (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  species text not null,
  description text,
  difficulty text,
  toxicity text,
  is_toxic_to_pets boolean not null default false,
  is_toxic_to_humans boolean not null default false,
  environment text,
  sunlight text,
  ideal_climate text,
  humidity text,
  temperature_range text,
  watering_protocol text,
  soil_protocol text,
  feeding_protocol text,
  care_protocol text,
  source_urls text[] not null default array[]::text[],
  image text,
  created_at timestamptz not null default timezone('utc'::text, now()),
  updated_at timestamptz not null default timezone('utc'::text, now())
);

alter table public.plant_catalog add column if not exists description text;
alter table public.plant_catalog add column if not exists difficulty text;
alter table public.plant_catalog add column if not exists toxicity text;
alter table public.plant_catalog add column if not exists is_toxic_to_pets boolean default false;
alter table public.plant_catalog add column if not exists is_toxic_to_humans boolean default false;
alter table public.plant_catalog add column if not exists environment text;
alter table public.plant_catalog add column if not exists sunlight text;
alter table public.plant_catalog add column if not exists ideal_climate text;
alter table public.plant_catalog add column if not exists humidity text;
alter table public.plant_catalog add column if not exists temperature_range text;
alter table public.plant_catalog add column if not exists watering_protocol text;
alter table public.plant_catalog add column if not exists soil_protocol text;
alter table public.plant_catalog add column if not exists feeding_protocol text;
alter table public.plant_catalog add column if not exists care_protocol text;
alter table public.plant_catalog add column if not exists source_urls text[] default array[]::text[];
alter table public.plant_catalog add column if not exists image text;
alter table public.plant_catalog add column if not exists created_at timestamptz default timezone('utc'::text, now());
alter table public.plant_catalog add column if not exists updated_at timestamptz default timezone('utc'::text, now());

create index if not exists plant_catalog_species_ci_idx
  on public.plant_catalog (lower(species));

-- ---------------------------------------------------------------------------
-- User plants and maintenance tasks
-- ---------------------------------------------------------------------------
create table if not exists public.plants (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references public.profiles(id) on delete cascade,
  name text,
  custom_name text,
  species text,
  image_url text,
  location text,
  room text,
  light_requirement text,
  water_requirement text,
  light_condition text,
  distance_to_window text,
  sunlight_hours text,
  last_repotted text,
  pot_type text,
  last_watered_at date,
  watering_interval_days integer not null default 7,
  health_status text not null default 'Healthy',
  catalog_id uuid references public.plant_catalog(id) on delete set null,
  notes text,
  created_at timestamptz not null default timezone('utc'::text, now()),
  updated_at timestamptz not null default timezone('utc'::text, now())
);

alter table public.plants add column if not exists name text;
alter table public.plants add column if not exists custom_name text;
alter table public.plants add column if not exists species text;
alter table public.plants add column if not exists image_url text;
alter table public.plants add column if not exists location text;
alter table public.plants add column if not exists room text;
alter table public.plants add column if not exists light_requirement text;
alter table public.plants add column if not exists water_requirement text;
alter table public.plants add column if not exists light_condition text;
alter table public.plants add column if not exists distance_to_window text;
alter table public.plants add column if not exists sunlight_hours text;
alter table public.plants add column if not exists last_repotted text;
alter table public.plants add column if not exists pot_type text;
alter table public.plants add column if not exists last_watered_at date;
alter table public.plants add column if not exists watering_interval_days integer default 7;
alter table public.plants add column if not exists health_status text default 'Healthy';
alter table public.plants add column if not exists catalog_id uuid;
alter table public.plants add column if not exists notes text;
alter table public.plants add column if not exists created_at timestamptz default timezone('utc'::text, now());
alter table public.plants add column if not exists updated_at timestamptz default timezone('utc'::text, now());
alter table public.plants alter column name drop not null;

do $$
begin
  if not exists (
    select 1
    from pg_constraint
    where conname = 'plants_catalog_id_fkey'
      and conrelid = 'public.plants'::regclass
  ) then
    alter table public.plants
      add constraint plants_catalog_id_fkey
      foreign key (catalog_id) references public.plant_catalog(id) on delete set null;
  end if;
end
$$;

-- Keep legacy `name` and current `custom_name` compatible in both directions.
create or replace function public.normalize_plant_name()
returns trigger
language plpgsql
set search_path = ''
as $$
begin
  new.custom_name := coalesce(nullif(btrim(new.custom_name), ''), nullif(btrim(new.name), ''), nullif(btrim(new.species), ''), 'My Plant');
  new.name := coalesce(nullif(btrim(new.name), ''), new.custom_name);
  return new;
end;
$$;

drop trigger if exists normalize_plant_name_before_write on public.plants;
create trigger normalize_plant_name_before_write
  before insert or update of name, custom_name, species on public.plants
  for each row execute function public.normalize_plant_name();

update public.plants
set custom_name = coalesce(nullif(btrim(custom_name), ''), nullif(btrim(name), ''), nullif(btrim(species), ''), 'My Plant'),
    name = coalesce(nullif(btrim(name), ''), nullif(btrim(custom_name), ''), nullif(btrim(species), ''), 'My Plant')
where name is null
   or btrim(name) = ''
   or custom_name is null
   or btrim(custom_name) = '';

create table if not exists public.care_tasks (
  id uuid primary key default gen_random_uuid(),
  plant_id uuid not null references public.plants(id) on delete cascade,
  user_id uuid not null references public.profiles(id) on delete cascade,
  task_type text not null,
  due_date timestamptz not null,
  is_completed boolean not null default false,
  completed_at timestamptz,
  amount text,
  instruction text,
  created_at timestamptz not null default timezone('utc'::text, now())
);

alter table public.care_tasks add column if not exists amount text;
alter table public.care_tasks add column if not exists instruction text;

-- ---------------------------------------------------------------------------
-- Plant diagnosis history
-- ---------------------------------------------------------------------------
create table if not exists public.sick_plants (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references public.profiles(id) on delete cascade,
  plant_id uuid references public.plants(id) on delete set null,
  name text not null,
  image_url text,
  diagnosis text,
  prescription text,
  urgency text not null default 'Orta',
  recovery_progress numeric not null default 0.0,
  status text not null default 'active',
  created_at timestamptz not null default timezone('utc'::text, now()),
  updated_at timestamptz not null default timezone('utc'::text, now()),
  constraint sick_plants_urgency_check check (urgency in ('Düşük', 'Orta', 'Kritik')),
  constraint sick_plants_recovery_check check (recovery_progress between 0 and 1),
  constraint sick_plants_status_check check (status in ('active', 'recovered', 'archived'))
);

create table if not exists public.diagnosis_messages (
  id uuid primary key default gen_random_uuid(),
  sick_plant_id uuid not null references public.sick_plants(id) on delete cascade,
  role text not null check (role in ('user', 'assistant')),
  content text not null,
  image_url text,
  created_at timestamptz not null default timezone('utc'::text, now())
);

-- ---------------------------------------------------------------------------
-- RLS: authenticated users can only access their own records
-- ---------------------------------------------------------------------------
alter table public.profiles enable row level security;
alter table public.users enable row level security;
alter table public.plants enable row level security;
alter table public.care_tasks enable row level security;
alter table public.sick_plants enable row level security;
alter table public.diagnosis_messages enable row level security;
alter table public.plant_catalog enable row level security;

drop policy if exists "Users can view their own profile" on public.profiles;
drop policy if exists "Users can update their own profile" on public.profiles;
drop policy if exists "Users can manage own profile" on public.profiles;
drop policy if exists profiles_owner_all on public.profiles;
create policy profiles_owner_all on public.profiles
  for all to authenticated
  using (id = (select auth.uid()))
  with check (id = (select auth.uid()));

drop policy if exists users_owner_all on public.users;
create policy users_owner_all on public.users
  for all to authenticated
  using (id = (select auth.uid()))
  with check (id = (select auth.uid()));

drop policy if exists "Users can manage their own plants" on public.plants;
drop policy if exists "Users can manage own plants" on public.plants;
drop policy if exists plants_owner_all on public.plants;
create policy plants_owner_all on public.plants
  for all to authenticated
  using (user_id = (select auth.uid()))
  with check (user_id = (select auth.uid()));

drop policy if exists "Users can manage their own care tasks" on public.care_tasks;
drop policy if exists "Users can manage own care_tasks" on public.care_tasks;
drop policy if exists care_tasks_owner_all on public.care_tasks;
create policy care_tasks_owner_all on public.care_tasks
  for all to authenticated
  using (
    user_id = (select auth.uid())
    and exists (
      select 1 from public.plants p
      where p.id = care_tasks.plant_id
        and p.user_id = (select auth.uid())
    )
  )
  with check (
    user_id = (select auth.uid())
    and exists (
      select 1 from public.plants p
      where p.id = care_tasks.plant_id
        and p.user_id = (select auth.uid())
    )
  );

drop policy if exists "Users can manage their own sick plants" on public.sick_plants;
drop policy if exists sick_plants_owner_all on public.sick_plants;
create policy sick_plants_owner_all on public.sick_plants
  for all to authenticated
  using (user_id = (select auth.uid()))
  with check (
    user_id = (select auth.uid())
    and (
      plant_id is null
      or exists (
        select 1 from public.plants p
        where p.id = sick_plants.plant_id
          and p.user_id = (select auth.uid())
      )
    )
  );

drop policy if exists "Users can manage diagnosis messages for their sick plants" on public.diagnosis_messages;
drop policy if exists diagnosis_messages_owner_all on public.diagnosis_messages;
create policy diagnosis_messages_owner_all on public.diagnosis_messages
  for all to authenticated
  using (
    exists (
      select 1 from public.sick_plants sp
      where sp.id = diagnosis_messages.sick_plant_id
        and sp.user_id = (select auth.uid())
    )
  )
  with check (
    exists (
      select 1 from public.sick_plants sp
      where sp.id = diagnosis_messages.sick_plant_id
        and sp.user_id = (select auth.uid())
    )
  );

drop policy if exists "catalog_public_read" on public.plant_catalog;
drop policy if exists plant_catalog_public_read on public.plant_catalog;
create policy plant_catalog_public_read on public.plant_catalog
  for select to anon, authenticated
  using (true);

grant select, insert, update, delete on public.profiles to authenticated;
grant select, insert, update, delete on public.users to authenticated;
grant select, insert, update, delete on public.plants to authenticated;
grant select, insert, update, delete on public.care_tasks to authenticated;
grant select, insert, update, delete on public.sick_plants to authenticated;
grant select, insert, update, delete on public.diagnosis_messages to authenticated;
grant select on public.plant_catalog to anon, authenticated;

-- ---------------------------------------------------------------------------
-- Storage bucket and ownership policies used by AddPlantWizard
-- ---------------------------------------------------------------------------
insert into storage.buckets (id, name, public)
values ('plant-images', 'plant-images', true)
on conflict (id) do update set public = excluded.public;

drop policy if exists plant_images_public_read on storage.objects;
create policy plant_images_public_read on storage.objects
  for select to public
  using (bucket_id = 'plant-images');

drop policy if exists plant_images_owner_insert on storage.objects;
create policy plant_images_owner_insert on storage.objects
  for insert to authenticated
  with check (
    bucket_id = 'plant-images'
    and name like ((select auth.uid())::text || '\_%') escape '\'
  );

drop policy if exists plant_images_owner_update on storage.objects;
create policy plant_images_owner_update on storage.objects
  for update to authenticated
  using (
    bucket_id = 'plant-images'
    and name like ((select auth.uid())::text || '\_%') escape '\'
  )
  with check (
    bucket_id = 'plant-images'
    and name like ((select auth.uid())::text || '\_%') escape '\'
  );

drop policy if exists plant_images_owner_delete on storage.objects;
create policy plant_images_owner_delete on storage.objects
  for delete to authenticated
  using (
    bucket_id = 'plant-images'
    and name like ((select auth.uid())::text || '\_%') escape '\'
  );

-- ---------------------------------------------------------------------------
-- Query indexes
-- ---------------------------------------------------------------------------
create index if not exists plants_user_id_idx on public.plants(user_id);
create index if not exists plants_catalog_id_idx on public.plants(catalog_id);
create index if not exists care_tasks_user_due_idx on public.care_tasks(user_id, due_date);
create index if not exists care_tasks_plant_idx on public.care_tasks(plant_id);
create index if not exists sick_plants_user_id_idx on public.sick_plants(user_id);
create index if not exists diagnosis_messages_sick_plant_created_idx
  on public.diagnosis_messages(sick_plant_id, created_at);

drop trigger if exists profiles_set_updated_at on public.profiles;
create trigger profiles_set_updated_at
  before update on public.profiles
  for each row execute function public.set_updated_at();

drop trigger if exists users_set_updated_at on public.users;
create trigger users_set_updated_at
  before update on public.users
  for each row execute function public.set_updated_at();

drop trigger if exists plants_set_updated_at on public.plants;
create trigger plants_set_updated_at
  before update on public.plants
  for each row execute function public.set_updated_at();

drop trigger if exists plant_catalog_set_updated_at on public.plant_catalog;
create trigger plant_catalog_set_updated_at
  before update on public.plant_catalog
  for each row execute function public.set_updated_at();

drop trigger if exists sick_plants_set_updated_at on public.sick_plants;
create trigger sick_plants_set_updated_at
  before update on public.sick_plants
  for each row execute function public.set_updated_at();

commit;
