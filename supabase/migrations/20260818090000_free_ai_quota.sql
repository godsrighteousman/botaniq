-- Free-tier AI usage quota: every account gets 2 lifetime free AI calls
-- (plant identification scan, photo diagnosis, or a chat message — all
-- share one counter) before the app must show the paywall. The counter is
-- kept server-side (not on the device) so it survives reinstalls and can't
-- be reset by clearing local storage; incrementing it goes through a single
-- SECURITY DEFINER RPC so the check-and-increment is atomic (no race where
-- two fast taps both read "1 left" and both get through).

begin;

alter table public.users
  add column if not exists free_ai_queries_used integer not null default 0;

alter table public.profiles
  add column if not exists free_ai_queries_used integer not null default 0;

-- Lifetime free-call allowance. Kept as a SQL constant (not a table row) so
-- there's a single source of truth the RPC below reads from.
create or replace function public.free_ai_query_limit()
returns integer
language sql
immutable
as $$
  select 2;
$$;

-- Atomically checks the caller's remaining free-call allowance and, if any
-- remain, consumes one. Returns whether the call is allowed and how many
-- free calls are left afterward — the client never has to (and cannot)
-- decide this itself, since the limit is enforced here.
--
-- The increment itself is a single UPDATE ... WHERE ... RETURNING against
-- public.users, which is safe under concurrent calls: Postgres takes a row
-- lock on the first UPDATE, so a second simultaneous call waits and then
-- re-evaluates the WHERE condition against the already-incremented value —
-- unlike a separate SELECT-then-UPDATE, two fast taps can't both read "1
-- left" and both get through.
create or replace function public.consume_free_ai_query()
returns table (allowed boolean, remaining integer)
language plpgsql
security definer
set search_path = ''
as $$
declare
  uid uuid := (select auth.uid());
  cap integer := public.free_ai_query_limit();
  new_used integer;
begin
  if uid is null then
    return query select false, 0;
    return;
  end if;

  -- Ensure a row exists to lock/update (older accounts created before this
  -- migration, or before the users-row-creation trigger, may not have one).
  insert into public.users (id, free_ai_queries_used)
  values (uid, 0)
  on conflict (id) do nothing;

  update public.users
  set free_ai_queries_used = free_ai_queries_used + 1
  where id = uid and free_ai_queries_used < cap
  returning free_ai_queries_used into new_used;

  if new_used is null then
    return query select false, 0;
    return;
  end if;

  -- Kept best-effort in sync for callers still reading public.profiles.
  update public.profiles set free_ai_queries_used = new_used where id = uid;

  return query select true, greatest(cap - new_used, 0);
end;
$$;

revoke all on function public.consume_free_ai_query() from public, anon;
grant execute on function public.consume_free_ai_query() to authenticated;

revoke all on function public.free_ai_query_limit() from public, anon;
grant execute on function public.free_ai_query_limit() to authenticated;

commit;
