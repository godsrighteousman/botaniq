-- Run after 20260730120000_persistence_hardening.sql.
-- Read-only verification: this query does not change data.

with required_tables(table_name) as (
  values
    ('profiles'),
    ('users'),
    ('plant_catalog'),
    ('plants'),
    ('care_tasks'),
    ('sick_plants'),
    ('diagnosis_messages')
),
table_checks as (
  select
    'table:' || rt.table_name as check_name,
    case when t.table_name is not null then 'OK' else 'MISSING' end as status
  from required_tables rt
  left join information_schema.tables t
    on t.table_schema = 'public'
   and t.table_name = rt.table_name
),
required_columns(table_name, column_name) as (
  values
    ('profiles', 'language_code'),
    ('users', 'watering_reminders'),
    ('users', 'fertilizer_reminders'),
    ('plant_catalog', 'difficulty'),
    ('plant_catalog', 'toxicity'),
    ('plant_catalog', 'environment'),
    ('plant_catalog', 'sunlight'),
    ('plant_catalog', 'humidity'),
    ('plant_catalog', 'temperature_range'),
    ('plant_catalog', 'watering_protocol'),
    ('plant_catalog', 'soil_protocol'),
    ('plant_catalog', 'feeding_protocol'),
    ('plant_catalog', 'care_protocol'),
    ('plant_catalog', 'source_urls'),
    ('plants', 'custom_name'),
    ('plants', 'catalog_id'),
    ('plants', 'watering_interval_days'),
    ('care_tasks', 'instruction'),
    ('sick_plants', 'diagnosis'),
    ('diagnosis_messages', 'content')
),
column_checks as (
  select
    'column:' || rc.table_name || '.' || rc.column_name as check_name,
    case when c.column_name is not null then 'OK' else 'MISSING' end as status
  from required_columns rc
  left join information_schema.columns c
    on c.table_schema = 'public'
   and c.table_name = rc.table_name
   and c.column_name = rc.column_name
),
required_policies(table_name, policy_name) as (
  values
    ('profiles', 'profiles_owner_all'),
    ('users', 'users_owner_all'),
    ('plants', 'plants_owner_all'),
    ('care_tasks', 'care_tasks_owner_all'),
    ('sick_plants', 'sick_plants_owner_all'),
    ('diagnosis_messages', 'diagnosis_messages_owner_all'),
    ('plant_catalog', 'plant_catalog_public_read'),
    ('objects', 'plant_images_public_read'),
    ('objects', 'plant_images_owner_insert'),
    ('objects', 'plant_images_owner_update'),
    ('objects', 'plant_images_owner_delete')
),
policy_checks as (
  select
    'policy:' || rp.table_name || '.' || rp.policy_name as check_name,
    case when p.policyname is not null then 'OK' else 'MISSING' end as status
  from required_policies rp
  left join pg_policies p
    on p.tablename = rp.table_name
   and p.policyname = rp.policy_name
),
bucket_check as (
  select
    'bucket:plant-images' as check_name,
    case
      when exists (
        select 1
        from storage.buckets
        where id = 'plant-images' and public = true
      ) then 'OK'
      else 'MISSING'
    end as status
),
trigger_checks as (
  select
    expected.check_name,
    case when actual.trigger_name is not null then 'OK' else 'MISSING' end as status
  from (
    values
      ('trigger:auth.on_auth_user_created', 'auth', 'auth.users', 'on_auth_user_created'),
      ('trigger:plants.normalize_plant_name_before_write', 'public', 'public.plants', 'normalize_plant_name_before_write')
  ) as expected(check_name, schema_name, relation_name, trigger_name)
  left join (
    select
      n.nspname as schema_name,
      c.oid::regclass::text as relation_name,
      t.tgname as trigger_name
    from pg_trigger t
    join pg_class c on c.oid = t.tgrelid
    join pg_namespace n on n.oid = c.relnamespace
    where not t.tgisinternal
  ) actual
    on actual.schema_name = expected.schema_name
   and actual.relation_name = expected.relation_name
   and actual.trigger_name = expected.trigger_name
)
select * from table_checks
union all
select * from column_checks
union all
select * from policy_checks
union all
select * from bucket_check
union all
select * from trigger_checks
order by status desc, check_name;
