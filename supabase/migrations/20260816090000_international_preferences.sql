-- International preferences and canonical measurement fields.
-- Forward-only and backward compatible with language_code and legacy text data.

alter table public.profiles add column if not exists locale text;
alter table public.profiles
  add column if not exists theme_mode text default 'system';
alter table public.profiles
  add column if not exists measurement_system text default 'system';
alter table public.profiles add column if not exists timezone text default 'UTC';
alter table public.profiles add column if not exists preferences_updated_at timestamptz;

update public.profiles
set language_code = 'en'
where language_code is not null
  and language_code not in (
    'en', 'tr', 'de', 'fr', 'es', 'it', 'pt', 'pl', 'ru', 'zh', 'id',
    'th', 'ar', 'nl'
  );

update public.profiles
set locale = language_code
where locale is null
  and language_code in (
    'en', 'tr', 'de', 'fr', 'es', 'it', 'pt', 'pl', 'ru', 'id', 'th', 'ar'
  );

alter table public.profiles
  drop constraint if exists profiles_language_code_supported;
alter table public.profiles
  add constraint profiles_language_code_supported check (
    language_code is null or language_code in (
      'en', 'tr', 'de', 'fr', 'es', 'it', 'pt', 'pl', 'ru', 'zh', 'id',
      'th', 'ar', 'nl'
    )
  );

alter table public.profiles
  drop constraint if exists profiles_locale_supported;
alter table public.profiles
  add constraint profiles_locale_supported check (
    locale is null or locale in (
      'en', 'tr', 'de', 'fr', 'es', 'it', 'pt', 'pt-BR', 'pl', 'ru',
      'zh-Hans', 'zh-Hant', 'id', 'th', 'ar', 'nl-NL', 'nl-BE'
    )
  );

alter table public.profiles
  drop constraint if exists profiles_theme_mode_supported;
alter table public.profiles
  add constraint profiles_theme_mode_supported check (
    theme_mode in ('system', 'light', 'dark')
  );

alter table public.profiles
  drop constraint if exists profiles_measurement_system_supported;
alter table public.profiles
  add constraint profiles_measurement_system_supported check (
    measurement_system in ('system', 'metric', 'imperial')
  );

alter table public.profiles
  drop constraint if exists profiles_timezone_valid;
alter table public.profiles
  add constraint profiles_timezone_valid check (
    timezone is null or
    timezone ~ '^[A-Za-z_+-]+(/[A-Za-z0-9_+-]+)*$'
  );

-- New writes can use canonical numeric units while older clients keep using
-- their existing display-oriented text fields.
alter table public.plants add column if not exists height_mm numeric;
alter table public.plants add column if not exists pot_diameter_mm numeric;
alter table public.care_tasks add column if not exists amount_ml numeric;
alter table public.care_tasks add column if not exists amount_g numeric;
alter table public.plant_catalog add column if not exists temperature_min_c numeric;
alter table public.plant_catalog add column if not exists temperature_max_c numeric;

alter table public.plants
  drop constraint if exists plants_height_mm_nonnegative;
alter table public.plants
  add constraint plants_height_mm_nonnegative check (
    height_mm is null or height_mm >= 0
  );
alter table public.plants
  drop constraint if exists plants_pot_diameter_mm_nonnegative;
alter table public.plants
  add constraint plants_pot_diameter_mm_nonnegative check (
    pot_diameter_mm is null or pot_diameter_mm >= 0
  );
alter table public.care_tasks
  drop constraint if exists care_tasks_amount_ml_nonnegative;
alter table public.care_tasks
  add constraint care_tasks_amount_ml_nonnegative check (
    amount_ml is null or amount_ml >= 0
  );
alter table public.care_tasks
  drop constraint if exists care_tasks_amount_g_nonnegative;
alter table public.care_tasks
  add constraint care_tasks_amount_g_nonnegative check (
    amount_g is null or amount_g >= 0
  );
alter table public.plant_catalog
  drop constraint if exists plant_catalog_temperature_range_ordered;
alter table public.plant_catalog
  add constraint plant_catalog_temperature_range_ordered check (
    temperature_min_c is null or temperature_max_c is null or
    temperature_min_c <= temperature_max_c
  );

alter table public.diagnosis_messages
  add column if not exists content_locale text;
alter table public.sick_plants
  add column if not exists diagnosis_locale text;
alter table public.sick_plants
  add column if not exists urgency_code text default 'medium';

update public.sick_plants
set urgency_code = case
  when lower(coalesce(urgency, '')) in ('kritik', 'critical', 'high')
    then 'critical'
  when lower(coalesce(urgency, '')) in ('düşük', 'dusuk', 'low')
    then 'low'
  else 'medium'
end;

alter table public.sick_plants
  drop constraint if exists sick_plants_urgency_code_supported;
alter table public.sick_plants
  add constraint sick_plants_urgency_code_supported check (
    urgency_code in ('low', 'medium', 'critical')
  );

alter table public.sick_plants
  drop constraint if exists sick_plants_diagnosis_locale_supported;
alter table public.sick_plants
  add constraint sick_plants_diagnosis_locale_supported check (
    diagnosis_locale is null or diagnosis_locale in (
      'en', 'tr', 'de', 'fr', 'es', 'it', 'pt', 'pt-BR', 'pl', 'ru',
      'zh-Hans', 'zh-Hant', 'id', 'th', 'ar', 'nl-NL', 'nl-BE'
    )
  );

alter table public.diagnosis_messages
  drop constraint if exists diagnosis_messages_content_locale_supported;
alter table public.diagnosis_messages
  add constraint diagnosis_messages_content_locale_supported check (
    content_locale is null or content_locale in (
      'en', 'tr', 'de', 'fr', 'es', 'it', 'pt', 'pt-BR', 'pl', 'ru',
      'zh-Hans', 'zh-Hant', 'id', 'th', 'ar', 'nl-NL', 'nl-BE'
    )
  );

-- RLS remains unchanged: all added preferences stay on the existing
-- owner-scoped profiles row.
