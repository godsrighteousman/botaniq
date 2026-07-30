-- Keep public.plants.health_status synchronized with active clinic records.
-- No records are deleted.

begin;

alter table public.sick_plants
  add column if not exists species text;

-- Repair older clinic records only when the name resolves to exactly one
-- garden plant owned by the same user.
with possible_matches as (
  select
    sp.id as sick_plant_id,
    p.id as plant_id,
    count(*) over (partition by sp.id) as match_count
  from public.sick_plants sp
  join public.plants p
    on p.user_id = sp.user_id
   and (
     lower(btrim(sp.name)) = lower(btrim(coalesce(p.custom_name, '')))
     or lower(btrim(sp.name)) = lower(btrim(coalesce(p.name, '')))
     or lower(btrim(sp.name)) = lower(btrim(coalesce(p.species, '')))
   )
  where sp.plant_id is null
),
unique_matches as (
  select sick_plant_id, plant_id
  from possible_matches
  where match_count = 1
)
update public.sick_plants sp
set plant_id = matches.plant_id,
    updated_at = timezone('utc'::text, now())
from unique_matches matches
where sp.id = matches.sick_plant_id;

create or replace function public.refresh_plant_health_status(target_plant_id uuid)
returns void
language plpgsql
security definer
set search_path = ''
as $$
begin
  if target_plant_id is null then
    return;
  end if;

  update public.plants p
  set health_status = case
    when exists (
      select 1
      from public.sick_plants sp
      where sp.plant_id = target_plant_id
        and sp.status = 'active'
    ) then 'Sick'
    else 'Healthy'
  end
  where p.id = target_plant_id;
end;
$$;

create or replace function public.sync_plant_health_from_clinic()
returns trigger
language plpgsql
security definer
set search_path = ''
as $$
begin
  if tg_op = 'DELETE' then
    perform public.refresh_plant_health_status(old.plant_id);
    return old;
  end if;

  perform public.refresh_plant_health_status(new.plant_id);

  if tg_op = 'UPDATE' and old.plant_id is distinct from new.plant_id then
    perform public.refresh_plant_health_status(old.plant_id);
  end if;

  return new;
end;
$$;

revoke all on function public.refresh_plant_health_status(uuid)
  from public, anon, authenticated;
revoke all on function public.sync_plant_health_from_clinic()
  from public, anon, authenticated;

drop trigger if exists sick_plants_sync_garden_health on public.sick_plants;
create trigger sick_plants_sync_garden_health
  after insert or update or delete
  on public.sick_plants
  for each row execute function public.sync_plant_health_from_clinic();

-- Bring all currently linked plants to the correct state immediately.
update public.plants p
set health_status = 'Sick'
where exists (
  select 1
  from public.sick_plants sp
  where sp.plant_id = p.id
    and sp.status = 'active'
);

update public.plants p
set health_status = 'Healthy'
where lower(coalesce(p.health_status, '')) in ('sick', 'hasta')
  and not exists (
    select 1
    from public.sick_plants sp
    where sp.plant_id = p.id
      and sp.status = 'active'
  );

commit;
