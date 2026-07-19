# Botaniq - Yayın ve Geliştirme Planı

Bu doküman, Botaniq uygulamasını tamamlayıp, canlıya almak ve gelir elde etmek için izlenmesi gereken adım adım yol haritasını içermektedir. Takıldığın her adımda doğrudan bana sorabilirsin; o adımı birlikte çözeriz.

---

## Adım 1: Veritabanı ve Backend Yönetimi (Supabase)
Uygulamanın kullanıcı verilerini, bitki fotoğraflarını ve diğer tüm dinamik verilerini tutmak için Supabase'i bağlayacağız. Daha önce kendi sunucumuzda (self-hosted) barındırma fikrini konuşmuştuk, bunu göz önünde bulundurarak:
1. **Supabase Projesinin Kurulumu:**
   - Supabase Cloud (hazır servis) kullanmak başlangıç için en kolayıdır. Ancak kendi sunucuna (self-hosted) kurmak istersen, Docker kullanarak bunu sunucunda ayağa kaldırabiliriz.
2. **Flutter ile Supabase Bağlantısı:**
   - `supabase_flutter` paketini projeye eklemek.
   - Flutter tarafında projenin `URL` ve `Anon Key` bilgilerini tanımlamak.
3. **Veritabanı Tablolarının Oluşturulması:**
   - `users` (Kullanıcı bilgileri)
   - `plants` (Bitki bilgileri)
   - `schedules` (Sulama/bakım takvimleri)
4. **Kimlik Doğrulama (Auth) ve Depolama (Storage):**f
   - Kullanıcıların e-posta/şifre veya Google/Apple ile giriş yapmasını sağlamak.
   - Çekilen bitki fotoğraflarını Supabase Storage (Buckets) üzerine kaydetmek.

---

## Adım 2: Domain (Alan Adı / Hostname) Satın Alma
Uygulamanın bir marka yüzü (web sitesi) ve API haberleşmesi için bir alan adına ihtiyacı var (örneğin: `botaniqapp.com` veya `botaniq.app`).
1. **Domain Seçimi ve Satın Alımı:**
   - Hostinger, GoDaddy, Namecheap veya Cloudflare gibi güvenilir bir firmadan alan adı satın almak.
   - Uygulamalar için özellikle `.app` veya `.com` uzantıları harika durur.
2. **DNS Ayarları ve Yönlendirmeler:**
   - Domain satın alındıktan sonra DNS ayarlarını yapılandıracağız. Sunucumuzun veya Supabase projemizin adreslerini yönlendireceğiz.

---

## Adım 3: Sunucu (VPS) Satın Alınması ve Kurulumu
Eğer Supabase'i veya özel backend servislerimizi kendimiz barındıracaksak bir sunucuya ihtiyacımız var. Ayrıca uygulamanın tanıtım web sitesi de burada çalışabilir.
1. **Firma Seçimi:**
   - DigitalOcean, Hetzner, AWS (Amazon) veya Vultr arasından seçim yapmak. Başlangıç için **Hetzner** veya **DigitalOcean** fiyat/performans olarak çok iyidir.
2. **Sunucu İşletim Sistemi:**
   - Genellikle Ubuntu 22.04 LTS veya 24.04 LTS tercih ederiz.
3. **Gerekli Kurulumlar:**
   - Sunucuya bağlanıp Docker, Nginx, SSL sertifikaları gibi temel yapılandırmaları yapacağız. (Bunu tamamen ben yönlendirebilirim).

---

## Adım 4: Uygulama Marketlerine (App Store & Google Play) Hazırlık
Uygulamayı herkesin indirebilmesi ve para kazanabilmek için marketlere koyma aşaması.
1. **Geliştirici Hesaplarının Açılması:**
   - **Google Play Console:** Tek seferlik 25$ ödeme ile hesap açılır.
   - **Apple Developer Program:** Yıllık 99$ ödeme gerektirir (Uygulamanın iOS'a çıkması için şart).
2. **Uygulama İçi Satın Alma (Para Kazanma):**
   - Abonelik (Premium özellikler, bitki analizi vb.) işlemleri için en sağlıklı yöntem olan **RevenueCat** entegrasyonu yapacağız. Bu, hem iOS hem Android ödemelerini tek yerden yönetmemizi sağlar.
3. **Market Materyallerinin Hazırlanması:**
   - Uygulama ikonları, ekran görüntüleri (screenshot), gizlilik politikası (privacy policy - web sitesinden sunulur) ve uygulama açıklamaları.
4. **Derleme ve Yayına Gönderme (Release & Publish):**
   - Flutter'da `Release` (Üretim) sürümünü oluşturacağız.
   - Hataları test ettikten sonra Apple ve Google'a incelemeye göndereceğiz.

---

## Nasıl İlerleyelim?

Bu bir maraton ama harika bir ürün ortaya çıkaracağız. **İlk adım** olarak Supabase kurulumu ile başlamak ister misin? Yoksa Domain veya Sunucu işlerini mi önce halletmek istersin? Hangi adımdan başlamak istediğini söylersen, hemen teknik detaylara ve kodlara girerek o adımı tamamlayalım.
