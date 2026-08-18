-- Global "gardener" leaderboard: ranks users by how many care tasks
-- (watering, fertilizing, etc.) they've completed, all-time, across every
-- user. care_tasks RLS (care_tasks_owner_all) is strictly owner-scoped, so
-- a plain client-side `.from('care_tasks').select()` can never see another
-- user's rows. These SECURITY DEFINER functions intentionally bypass that
-- to compute the aggregate, but only ever return aggregated counts/rank —
-- never a raw care_tasks row — so no user's individual task/plant data is
-- exposed to another user.

begin;

create or replace function public.get_care_task_leaderboard(limit_count int default 50)
returns table (
  user_id uuid,
  full_name text,
  avatar_url text,
  completed_count bigint,
  rank bigint
)
language sql
security definer
set search_path = ''
stable
as $$
  select
    u.id as user_id,
    coalesce(nullif(btrim(u.full_name), ''), nullif(btrim(p.full_name), '')) as full_name,
    coalesce(u.avatar_url, p.avatar_url) as avatar_url,
    count(ct.id) filter (where ct.is_completed) as completed_count,
    rank() over (
      order by count(ct.id) filter (where ct.is_completed) desc
    ) as rank
  from public.users u
  full outer join public.profiles p on p.id = u.id
  left join public.care_tasks ct on ct.user_id = coalesce(u.id, p.id)
  group by coalesce(u.id, p.id), u.id, u.full_name, p.full_name, u.avatar_url, p.avatar_url
  having count(ct.id) filter (where ct.is_completed) > 0
  order by completed_count desc
  limit greatest(limit_count, 0);
$$;

-- Caller's own global rank + completed count, computed over the SAME
-- population/metric as get_care_task_leaderboard above, but only the
-- calling user's row is ever returned (filtered by auth.uid() at the end).
create or replace function public.get_my_leaderboard_rank()
returns table (completed_count bigint, rank bigint)
language sql
security definer
set search_path = ''
stable
as $$
  with ranked as (
    select
      user_id,
      count(*) filter (where is_completed) as completed_count,
      rank() over (
        order by count(*) filter (where is_completed) desc
      ) as rank
    from public.care_tasks
    group by user_id
  )
  select completed_count, rank
  from ranked
  where user_id = (select auth.uid());
$$;

revoke all on function public.get_care_task_leaderboard(int) from public, anon;
grant execute on function public.get_care_task_leaderboard(int) to authenticated;

revoke all on function public.get_my_leaderboard_rank() from public, anon;
grant execute on function public.get_my_leaderboard_rank() to authenticated;

commit;
