# Botaniq Uygulaması - Veritabanı Mimarisi (Entity Relationship Schema)

Bu belge, uygulamanın UI (Kullanıcı Arayüzü) ekranlarında gösterilen verilerden yola çıkarak hazırlanmış, Supabase sistemine kurulacak olan veritabanı tablolarının yapısını gösterir.

---

## 1. `users` Tablosu
Kullanıcıların temel ve sistemsel bilgilerini barındırır. Supabase'in kendi Auth tablosuyla eşleşerek çalışır.

| Sütun Adı | Veri Tipi | Açıklama |
| --- | --- | --- |
| `id` | uuid (Primary Key) | Supabase Auth tarafındaki kullanıcı ID'si (Foreign Key) |
| `full_name` | text | Kullanıcının adı soyadı (örn: "Good morning, [Name]") |
| `email` | text | Kullanıcının e-posta adresi |
| `avatar_url` | text | Kullanıcının profil fotoğrafı URL'si |
| `location` | text | Şehir veya bölge (Hava durumu widget'i için, örn: "San Francisco") |
| `watering_reminders` | boolean | Sulama bildirimleri açık/kapalı (Settings UI) |
| `fertilizer_reminders`| boolean | Gübreleme bildirimleri açık/kapalı (Settings UI) |
| `created_at` | timestamp | Hesabın oluşturulma tarihi |

---

## 2. `plants` (Benim Bahçem) Tablosu
Kullanıcının kendi "My Garden" ekranına eklediği bitkileri tutar.

| Sütun Adı | Veri Tipi | Açıklama |
| --- | --- | --- |
| `id` | uuid (Primary Key) | Benzersiz bitki numarası |
| `user_id` | uuid | Bu bitkinin sahibi olan kullanıcının ID'si (users referansı) |
| `custom_name` | text | Kullanıcının verdiği özel ad (örn: "Monstera") |
| `species` | text | Bitkinin türü (örn: "Swiss Cheese") |
| `image_url` | text | Supabase Storage'daki (veya ağdaki) resmin URL'si |
| `health_status` | text | "Healthy", "Sick", vb. mevcut sağlık durumu |
| `created_at` | timestamp | Bitkinin eklendiği tarih |

---

## 3. `plant_catalog` (Bitki Ansiklopedisi) Tablosu
(Opsiyonel) "Search Plant" (Arama) ve "Discover" ekranları için sabit, dünyadaki bitkilerin genel özellikleri. Eğer bunlar API'den gelmeyecekse kendi veritabanımızda tutulur.

| Sütun Adı | Veri Tipi | Açıklama |
| --- | --- | --- |
| `id` | uuid (Primary Key) | Ansiklopedi kayıt no |
| `species` | text | Tür (örn: "Fiddle Leaf Fig") |
| `description` | text | Hakkında ("About") yazısı |
| `difficulty` | text | Bakım Zorluğu (örn: "Medium", "Hard") |
| `toxicity` | text | Toksik durumu (örn: "Toxic to pets") |
| `environment` | text | "Indoor", "Outdoor" |
| `sunlight` | text | "Bright Indirect", "Low Light" |
| `ideal_climate` | text | Sıcaklık vs nem oranı |
| `watering_protocol`| text | Genel sulama talimatnamesi ("Every 7-10 days") |
| `feeding_protocol` | text | Genel gübreleme talimatnamesi |

---

## 4. `schedules` (Bakım ve Hatırlatıcılar) Tablosu
Ana sayfadaki "Today Tasks" ve "Calendar" (Takvim) ekranlarındaki yapılacak işleri barındırır.

| Sütun Adı | Veri Tipi | Açıklama |
| --- | --- | --- |
| `id` | uuid (Primary Key) | Görev numarası |
| `user_id` | uuid | Görevin sahibi kullanıcı |
| `plant_id` | uuid | Görevin bağlı olduğu bitki (`plants` referansı) |
| `task_type` | text | Görev tipi: "Watering", "Fertilize", "Pruning" vb. |
| `amount` | text | İşlem miktarı (örn: "250ml", "Liquid Fertilizer") |
| `instruction` | text | Yapılacak işin açıklaması ("Altı delik saksıdan akana kadar sula...") |
| `scheduled_date` | date | İşlemin yapılması/hatırlatılması gereken tarih |
| `is_completed` | boolean | Tamamlandı mı? (Checkbox) (Varsayılan: `false`) |
| `completed_at` | timestamp | Kullanıcı "Completed" butonuna ne zaman bastı |

---

**Mimarın Notu:**
Bu mimari kurulduğu anda uygulamanın %90'lık dinamik veri iskeleti tamamlanmış sayılır. İlk girişten abonelik ekranına kadar bu altyapıyı kullanacağız.
