-- The 20260730120000_persistence_hardening.sql migration defines
-- on_auth_user_created but the CREATE TRIGGER statement was never applied
-- to the live database (only the trigger *function* existed — confirmed via
-- `select * from pg_trigger where tgname ilike '%new_user%'` returning zero
-- rows). Without this trigger, public.users/public.profiles rows are never
-- created server-side on signup, so the app's client-side upsert has to do
-- it — and that upsert requires an authenticated session, which does not
-- exist yet when Supabase's "Confirm email" setting is enabled (signUp()
-- returns a user but no session until the email is confirmed). The RLS
-- grant on public.users has no INSERT for the `anon` role, so that
-- unauthenticated upsert is rejected outright and sign-up shows a generic
-- "could not complete" error to the user.
--
-- This migration only needs to (re)create the trigger — creating triggers
-- on auth.users requires the elevated role used by `supabase db push`;
-- it cannot be done through the restricted `supabase db query` CLI path.

begin;

drop trigger if exists on_auth_user_created on auth.users;
create trigger on_auth_user_created
  after insert or update of email, raw_user_meta_data on auth.users
  for each row execute function public.handle_new_user();

-- Backfill application records for any users created while the trigger
-- was missing.
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

commit;
