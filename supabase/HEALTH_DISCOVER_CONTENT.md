# Bakım Merkezi keşfet içerikleri

`20260802120000_health_discover_content.sql` migration'ı uygulandıktan sonra
içerikler Supabase Dashboard içindeki `health_discover_content` tablosundan
yönetilir. Mobil uygulama yalnızca `is_published = true` olan ve yayın tarihi
gelmiş satırları okuyabilir.

## Alanlar

- `content_type`: `tip` veya `spotlight`
- `title`, `subtitle`, `body`: `{"tr":"...", "en":"..."}` biçiminde JSON
- `image_url`: `tip` kartında gösterilecek herkese açık HTTPS görseli
- `icon_name`: `star`, `bug`, `water`, `light`, `health` veya `leaf`
- `accent_color`: `#4FA976` biçiminde renk
- `sort_order`: küçük değer önce gösterilir
- `is_published`: mobil uygulamada görünürlük
- `published_at`: ileri tarih verilirse o tarihe kadar gizli kalır
- `metadata`: ileride kullanılabilecek serbest JSON alanı

Yeni bir içeriği önce `is_published = false` ile hazırlayıp kontrol ettikten
sonra yayınlamak güvenli akıştır. İçerik değişiklikleri uygulama güncellemesi
gerektirmez; kullanıcı ekranı yenilediğinde son yayınlanan satırlar gelir.
