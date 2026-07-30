# Botaniq geliştirme rehberi

## Proje sınırları

- Uygulama Flutter/Dart ile geliştirilir; mevcut feature-first dizilimi, ekran tasarımı ve doğrudan Supabase veri akışları korunur.
- Yeni paket, katman veya durum yönetimi yaklaşımı eklemeden önce mevcut servisleri, `HomeController` yapısını ve `Provider` kullanımını değerlendir.
- Kullanıcıya ait `.vscode/` ve görev dışı değişikliklere dokunma.

## Kod düzeni

- Özellik kodları `lib/features/<feature>/` altında, ortak servisler `lib/core/services/`, tema `lib/core/theme/`, yerelleştirme `lib/l10n/` altındadır.
- Yeni metinleri ARB dosyalarına ekle; üretilen yerelleştirme dosyalarını elle düzenleme.
- İş mantığını mümkün olduğunda widget'lardan ayır ve mevcut model/controller/service kalıplarını kullan.
- Büyük çaplı yeniden yazım yerine küçük, geriye uyumlu değişiklikler yap.

## Supabase ve veri güvenliği

- Şema değişiklikleri yalnızca `supabase/migrations/` altında, tarih sıralı ve ileri yönlü migration olarak eklenir.
- Veritabanını silme, sıfırlama, production migration çalıştırma veya canlı veriyi değiştirme.
- Her kullanıcı tablosunda RLS ve sahiplik kontrolünü koru. `SUPABASE_SERVICE_ROLE_KEY` hiçbir istemci derlemesine girmez.
- `SUPABASE_KURULUM.sql`, `SUPABASE_CALISTIR.sql`, `seed_catalog.sql` ve `VERITABANI_MIMARISI.md` güncel migration zinciriyle çelişebilir; doğrulamadan kaynak kabul etme.
- Storage değişikliklerinde `plant-images` bucket ve politikalarını migration ile tanımlamadan canlı ortam varsayımı yapma.

## Ortam değişkenleri

- Gizli değerleri koda, teste, loga veya commit'e yazma. `.env.example` yalnızca değişken adlarını içerir.
- Flutter istemci değerlerini güvenli yerel dosyadan `--dart-define-from-file` ile sağla. Sunucu sırlarını yalnızca Supabase Edge Function secrets içinde tut.
- `OPENAI_API_KEY` yalnızca `analyze-plant` Edge Function secret'ıdır; Flutter'a veya kullanıcı ayarlarına ekleme.
- Eksik değer gerekiyorsa kullanıcıdan yalnızca değişken adını iste; değeri yanıtta tekrar etme.

## Doğrulama

```bash
flutter pub get
flutter analyze
flutter test test/features/home/domain/care_task_planner_test.dart
flutter run -d chrome
```

- `test/supabase_test.dart` ve `bin/test_supabase.dart` canlı Supabase'te kullanıcı oluşturur; izole/mocked hale getirilmeden çalıştırma.
- `test/widget_test.dart` eski sayaç şablonudur ve güncel uygulamayı test etmez.
- Değişiklikten sonra ilgili hedefte test et; kamera, konum, Apple/Google giriş ve bildirim akışları için gerçek cihaz kontrolü gerektiğini belirt.
