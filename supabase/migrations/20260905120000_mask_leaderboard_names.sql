-- Sıralama tablosunda başka kullanıcıların adları kısmen gizlenir.
--
-- Maskeleme neden istemcide değil burada: get_care_task_leaderboard bir
-- SECURITY DEFINER fonksiyonu ve sonucu doğrudan istemciye dönüyor.
-- Adları Flutter tarafında gizleseydik tam adlar yine de ağ üzerinden her
-- kullanıcının cihazına ulaşır, API yanıtına bakan biri hepsini görebilirdi.
-- Kaynağında maskeleyince tam ad veritabanından hiç çıkmıyor.
--
-- Kullanıcının KENDİ satırı maskelenmez — kendi adını zaten biliyor ve
-- listede kendini bulabilmesi gerekiyor.

begin;

create or replace function public.mask_display_name(raw text)
returns text
language sql
immutable
set search_path = ''
as $$
  -- "Faruk Ertaş" -> "F•••• E••••"; her kelimenin yalnızca ilk harfi kalır,
  -- kalanı en fazla 5 noktayla temsil edilir (çok uzun adlar listeyi
  -- bozmasın diye sınırlı).
  select case
    when raw is null or btrim(raw) = '' then null
    else (
      select string_agg(
        case
          when length(word) <= 1 then word
          else left(word, 1) || repeat('•', least(length(word) - 1, 5))
        end,
        ' ' order by ord
      )
      from unnest(
        string_to_array(btrim(regexp_replace(raw, '\s+', ' ', 'g')), ' ')
      ) with ordinality as t(word, ord)
    )
  end;
$$;

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
    case
      when coalesce(u.id, p.id) = (select auth.uid())
        then coalesce(nullif(btrim(u.full_name), ''), nullif(btrim(p.full_name), ''))
      else public.mask_display_name(
        coalesce(nullif(btrim(u.full_name), ''), nullif(btrim(p.full_name), ''))
      )
    end as full_name,
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

revoke all on function public.mask_display_name(text) from public, anon;
grant execute on function public.mask_display_name(text) to authenticated;

revoke all on function public.get_care_task_leaderboard(int) from public, anon;
grant execute on function public.get_care_task_leaderboard(int) to authenticated;

commit;
