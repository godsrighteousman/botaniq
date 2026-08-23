begin;

-- Etkileşim ısı haritası için tamamen anonim dokunuş verisi. Kullanıcı
-- kimliği/oturum ID'si YOK — hangi kullanıcının tıkladığı asla
-- bilinmez, sadece ekran adı + ekrana göre oranlı (0-1) koordinat.
create table if not exists public.heatmap_taps (
  id bigint generated always as identity primary key,
  screen_id text not null,
  x_norm double precision not null check (x_norm >= 0 and x_norm <= 1),
  y_norm double precision not null check (y_norm >= 0 and y_norm <= 1),
  screen_width double precision,
  screen_height double precision,
  created_at timestamptz not null default now()
);

create index if not exists heatmap_taps_screen_id_idx
  on public.heatmap_taps (screen_id);

alter table public.heatmap_taps enable row level security;

-- Sadece giriş yapmış istemciler yazabilir (uygulamanın ilgili ekranları
-- zaten oturum gerektiriyor); veri anonim olduğu için "kimin yazdığı"
-- kısıtlaması yok, sadece "kimlik doğrulanmış istemci mi" kontrolü var.
drop policy if exists "heatmap_taps_insert_authenticated" on public.heatmap_taps;
create policy "heatmap_taps_insert_authenticated"
  on public.heatmap_taps
  for insert
  to authenticated
  with check (true);

-- Hiçbir istemci (anon/authenticated) doğrudan okuyamaz — analiz/agregasyon
-- yalnızca Supabase panelinden (service role) yapılır.
revoke select, update, delete on public.heatmap_taps from anon, authenticated;

-- Geliştiricinin tek seferlik, gerçek kullanıcı verisi İÇERMEYEN referans
-- ekran düzeni görüntülerini yüklediği bucket (ısı haritasının üzerine
-- bindirileceği zemin).
insert into storage.buckets (id, name, public)
values ('heatmap_reference_screens', 'heatmap_reference_screens', false)
on conflict (id) do nothing;

drop policy if exists "heatmap_reference_insert_authenticated" on storage.objects;
create policy "heatmap_reference_insert_authenticated"
  on storage.objects
  for insert
  to authenticated
  with check (bucket_id = 'heatmap_reference_screens');

drop policy if exists "heatmap_reference_update_authenticated" on storage.objects;
create policy "heatmap_reference_update_authenticated"
  on storage.objects
  for update
  to authenticated
  using (bucket_id = 'heatmap_reference_screens');

commit;
