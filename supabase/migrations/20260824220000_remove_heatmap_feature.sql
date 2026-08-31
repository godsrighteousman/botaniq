begin;

-- Etkileşim ısı haritası özelliği tamamen kaldırıldı (uygulamadan da
-- sökülen HeatmapService/HeatmapTapRegion/consent dialog ile birlikte).
-- Bu migration, 20260822090000_heatmap_taps.sql ve
-- 20260822090500_heatmap_taps_grant.sql ile oluşturulan tüm sunucu
-- tarafı nesneleri geri alır. Tabloda kullanıcı kimliği hiç
-- bulunmadığından (bkz. ilgili migration'ın kendi yorumu) bu, hiçbir
-- kullanıcı hesabını/verisini etkilemez.

drop policy if exists "heatmap_reference_update_authenticated" on storage.objects;
drop policy if exists "heatmap_reference_insert_authenticated" on storage.objects;

-- storage.buckets/objects doğrudan SQL ile silinemiyor (Storage API
-- zorunlu, SQLSTATE 42501). Bucket boştu (hiç referans görüntü
-- yüklenmemişti) ve Storage Admin API üzerinden ayrıca silindi —
-- burada sadece SQL ile yönetilebilen politika/tablo temizliği kalıyor.

drop table if exists public.heatmap_taps;

commit;
