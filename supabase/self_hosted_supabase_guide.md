# Botaniq Self-Hosted Supabase Integration Guide

Bu doküman, Botaniq uygulaması için yerel bilgisayarınızda veya kendi sunucunuzda (self-hosted) çalıştırabileceğiniz Supabase yapısının nasıl kurulacağını, veritabanı şemalarını ve Edge Function kodlarını detaylandırmaktadır.

## 📁 Dizin Yapısı

Proje içerisine eklenen `supabase` klasörü şu yapıyı takip eder:

```text
supabase/
  ├── migrations/
  │   └── 20260715140500_botaniq_schema.sql  # Veritabanı tablo ve RLS yapıları
  ├── functions/
  │   ├── analyze-plant/
  │   │   └── index.ts                       # Bitki fotoğrafı analizi için Edge Function
  │   └── send-reminders/
  │       └── index.ts                       # Günlük bakım bildirimleri için Edge Function
  └── self_hosted_supabase_guide.md          # Bu doküman
```

---

## 🏗️ Veritabanı Yapısı (Database Schema)

Botaniq uygulaması için temel veritabanı tabloları `migrations/` klasörü altındaki SQL dosyasında tanımlanmıştır. Oluşturulan ana yapılar şunlardır:

1. **`profiles` Tablosu**: `auth.users` sistemine bağlıdır. Kullanıcıların detaylı bilgilerini (isim, avatar) tutar. Trigger mekanizması ile yeni bir kullanıcı kayıt olduğunda otomatik olarak bir profil satırı oluşturulur.
2. **`plants` Tablosu**: Kullanıcılara ait bitkileri depolar. Tür, isim, lokasyon, ışık ve su ihtiyacı gibi verileri tutar.
3. **`care_tasks` Tablosu**: Uygulamanın görev yönetim altyapısını oluşturur. Su, gübre, budama gibi bakım görevlerini (task_type), bitiş tarihlerini (due_date) ve tamamlanma durumlarını takip eder.
4. **`light_measurements` Tablosu**: Light Meter (Işık Ölçer) özelliğinde cihaz kamerası veya sensörlerinden toplanan lux ve değerlendirme verilerini depolar.

Tüm bu tablolarda **Row Level Security (RLS)** (Satır Bazlı Güvenlik) aktiftir. Politikalar (Policies) sayesinde bir kullanıcı sadece kendi verilerini okuyabilir ve düzenleyebilir.

---

## ⚡ Edge Functions (Sunucusuz Fonksiyonlar)

Uygulamanın özel sunucu mantığını (backend logic) Supabase Edge Functions ile Deno ortamında çalıştırıyoruz. `functions/` dizini altındaki fonksiyonlar:

### 1. `analyze-plant`
- **Görev**: Kullanıcının çektiği bitki fotoğrafını Base64 olarak alır, bir yapay zeka/görüntü işleme servisine gönderir ve bitkinin türünü, sağlık durumunu ve bakım gereksinimlerini döner.
- **Kullanım**: Uygulama üzerinden `POST` isteği ile çağrılır.

### 2. `send-reminders`
- **Görev**: `care_tasks` tablosunu kontrol ederek vadesi dolmuş ve henüz tamamlanmamış bakım görevlerini bulur. Bu görevler için kullanıcılara anlık bildirim (Push Notification, örn. FCM/OneSignal üzerinden) gönderilmesini simüle veya entegre eder.
- **Kullanım**: pg_cron ile Supabase veritabanı üzerinden belirli aralıklarla tetiklenebilir ya da dışarıdan yetkili bir HTTP çağrısıyla çalıştırılabilir.

---

## 🚀 Kurulum ve Çalıştırma Seçenekleri (Self-Hosted)

### Adım 1: Supabase CLI Kurulumu
Bilgisayarınızda (macOS dâhil) Supabase CLI aracının kurulu olduğundan emin olun. Kurulu değilse Homebrew ile kurabilirsiniz:
```bash
brew install supabase/tap/supabase
```

### Adım 2: Docker Engine'ı Çalıştırın
Supabase'in self-hosted local sürümü arka planda Docker container'ları kullanır. (Docker Desktop veya OrbStack çalışır durumda olmalıdır).

### Adım 3: Local Supabase'i Başlatma
Proje ana dizininde (`/Users/farukertas/Project_mobil/Botaniq`) terminal üzerinden şu komutu çalıştırın:
```bash
supabase start
```
Bu işlem Supabase x API'sini, Postgres veritabanını ve Edge Functions alt yapısını ayağa kaldırır. Gerekli erişim anahtarları (API URL, anon key, service_role key vb.) terminalinizde görüntülenecektir.

Ayrıca otomatik olarak `/supabase/migrations` içindeki SQL dosyamızı okuyup local veritabanını hazırlayacaktır.

### Adım 4: Edge Function'ları Test Etme veya Sunma
Edge fonksiyonlarını yerelde çalıştırmak için:
```bash
supabase functions serve analyze-plant
```

### Adım 5: Flutter (Dart) ile Bağlantı
Botaniq uygulamasının `lib/main.dart` veya backend servis yapılandırma dosyasında (örn. `.env` yapısı), terminale yansıyan **Localhost API URL** ve **anon_key** bilgilerini `Supabase.initialize` fonksiyonunda güncelleyin. Örneğin:
```dart
await Supabase.initialize(
  url: 'http://127.0.0.1:54321', // supabase start komutunun verdiği API URL'i
  anonKey: 'eyJ...',             // supabase start komutunun verdiği anon key
);
```

### Adım 6: Dashboard'a Erişim
Local ortamda çalışırken veritabanı tablolarını görsel arayüzle (Studio) düzenlemek için şu adrese gidin:
**http://127.0.0.1:54323**
Buradan auth, veritabanı şemaları ve RLS loglarını canlı izleyebilirsiniz.

---
*Başarılar! Bu altyapı projenizi cloud/yerel sunucu bağımsız bir "Backend as a Service" (BaaS) yaklaşımı ile oldukça ölçeklenebilir ve sağlam hale getirecektir.*
