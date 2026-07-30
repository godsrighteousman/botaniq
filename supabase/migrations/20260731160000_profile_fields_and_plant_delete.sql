-- Profile fields and an atomic, owner-scoped plant deletion flow.
-- Safe for existing data: no table or account is dropped.

begin;

alter table public.users
  add column if not exists nickname text,
  add column if not exists age smallint;

alter table public.profiles
  add column if not exists nickname text,
  add column if not exists age smallint;

alter table public.users
  drop constraint if exists users_age_check;
alter table public.users
  add constraint users_age_check
  check (age is null or age between 1 and 120);

alter table public.profiles
  drop constraint if exists profiles_age_check;
alter table public.profiles
  add constraint profiles_age_check
  check (age is null or age between 1 and 120);

-- A deleted garden plant must not leave an orphaned Clinic record.
alter table public.sick_plants
  drop constraint if exists sick_plants_plant_id_fkey;
alter table public.sick_plants
  add constraint sick_plants_plant_id_fkey
  foreign key (plant_id)
  references public.plants(id)
  on delete cascade;

create or replace function public.delete_own_plant(target_plant_id uuid)
returns boolean
language plpgsql
security invoker
set search_path = ''
as $$
declare
  deleted_count integer;
begin
  delete from public.sick_plants
  where plant_id = target_plant_id
    and user_id = (select auth.uid());

  delete from public.plants
  where id = target_plant_id
    and user_id = (select auth.uid());

  get diagnostics deleted_count = row_count;
  return deleted_count = 1;
end;
$$;

revoke all on function public.delete_own_plant(uuid) from public, anon;
grant execute on function public.delete_own_plant(uuid) to authenticated;

commit;
