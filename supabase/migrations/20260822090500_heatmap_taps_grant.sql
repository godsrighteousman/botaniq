begin;

-- RLS politikası tek başına yetmiyor — PostgREST üzerinden INSERT
-- yapabilmek için tablo düzeyinde de açık GRANT gerekiyor.
grant insert on public.heatmap_taps to authenticated;

commit;
