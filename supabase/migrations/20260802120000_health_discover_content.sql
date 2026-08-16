-- Database-managed, multilingual content for Care Center > Discover.
-- Dashboard/SQL editors use privileged roles for authoring; mobile clients can
-- only read rows that have been published.

begin;

create table if not exists public.health_discover_content (
  id uuid primary key default gen_random_uuid(),
  content_type text not null
    check (content_type in ('tip', 'spotlight')),
  title jsonb not null default '{}'::jsonb
    check (jsonb_typeof(title) = 'object'),
  subtitle jsonb not null default '{}'::jsonb
    check (jsonb_typeof(subtitle) = 'object'),
  body jsonb not null default '{}'::jsonb
    check (jsonb_typeof(body) = 'object'),
  image_url text,
  icon_name text,
  accent_color text
    check (accent_color is null or accent_color ~ '^#[0-9A-Fa-f]{6}$'),
  metadata jsonb not null default '{}'::jsonb
    check (jsonb_typeof(metadata) = 'object'),
  sort_order integer not null default 0,
  is_published boolean not null default false,
  published_at timestamptz,
  created_at timestamptz not null default timezone('utc'::text, now()),
  updated_at timestamptz not null default timezone('utc'::text, now())
);

create index if not exists health_discover_published_order_idx
  on public.health_discover_content (content_type, sort_order, published_at desc)
  where is_published = true;

drop trigger if exists set_health_discover_content_updated_at
  on public.health_discover_content;
create trigger set_health_discover_content_updated_at
  before update on public.health_discover_content
  for each row execute function public.set_updated_at();

alter table public.health_discover_content enable row level security;

drop policy if exists health_discover_read_published
  on public.health_discover_content;
create policy health_discover_read_published
  on public.health_discover_content
  for select
  to anon, authenticated
  using (
    is_published = true
    and (published_at is null or published_at <= timezone('utc'::text, now()))
  );

revoke insert, update, delete
  on public.health_discover_content from anon, authenticated;
grant select on public.health_discover_content to anon, authenticated;

insert into public.health_discover_content (
  id,
  content_type,
  title,
  subtitle,
  body,
  image_url,
  icon_name,
  accent_color,
  sort_order,
  is_published,
  published_at
)
values
  (
    '9a65e51f-4267-46b3-bb0b-b01036a81901',
    'tip',
    '{"tr":"Kışa Hazırlık: Nem Dengesini Korumak","en":"Preparing for Winter: Keeping Humidity Balanced"}'::jsonb,
    '{"tr":"Soğuk aylarda yaprak uçlarını koruyan pratik nem adımları.","en":"Practical humidity steps that protect leaf tips during colder months."}'::jsonb,
    '{}'::jsonb,
    'https://images.unsplash.com/photo-1497250681960-ef046c08a56e?auto=format&fit=crop&q=80&w=900',
    'water',
    '#4FA976',
    10,
    true,
    timezone('utc'::text, now())
  ),
  (
    '9a65e51f-4267-46b3-bb0b-b01036a81902',
    'spotlight',
    '{"tr":"Yaprak Biti İstilası","en":"Aphid Infestation"}'::jsonb,
    '{"tr":"Erken evre müdahalesi ve doğal Neem Yağı kürü.","en":"Early intervention and a natural Neem Oil treatment."}'::jsonb,
    '{}'::jsonb,
    null,
    'bug',
    '#4FA976',
    20,
    true,
    timezone('utc'::text, now())
  )
on conflict (id) do nothing;

commit;
