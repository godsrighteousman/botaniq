# Botaniq RevenueCat ve mağaza kurulum rehberi

Uygulama tarafındaki satın alma akışı hazırdır. Canlı ürünlerin görünmesi için
App Store Connect, Google Play Console ve RevenueCat panellerindeki aşağıdaki
ayarların birbiriyle aynı olması gerekir.

## 1. Kimlikler ve ürünler

- iOS Bundle ID: `com.farukertas.botaniq`
- Android Application ID: `com.farukertas.botaniq`
- RevenueCat entitlement: `premium`
- Önerilen aylık ürün ID: `com.farukertas.botaniq.premium.monthly`
- Önerilen yıllık ürün ID: `com.farukertas.botaniq.premium.annual`

Ürün ID'leri mağazada oluşturulduktan sonra değiştirilemez. Farklı ID
kullanılacaksa aynı değerler RevenueCat'e de aynen girilmelidir.

## 2. App Store Connect

1. Agreements, Tax and Banking alanlarını tamamla.
2. Uygulamada `Subscriptions` altında `Botaniq Premium` adlı tek bir
   subscription group oluştur.
3. Aynı grup içinde aylık ve yıllık otomatik yenilenen abonelikleri oluştur.
4. Her ürün için Türkçe ve İngilizce görünen ad/açıklama, fiyat, inceleme notu
   ve inceleme ekran görüntüsü ekle.
5. App Store Connect API için bir In-App Purchase anahtarı oluştur ve
   RevenueCat iOS uygulamasına bağla.
6. Sözleşme, vergi, banka ve ürün metadata durumlarının eksiksiz olduğunu
   doğrula. Ürünler en az `Ready to Submit` durumuna gelmelidir.

Xcode projesinde In-App Purchase capability uygulama hedefi için eklenmiştir.

## 3. Google Play Console

1. Paket adı `com.farukertas.botaniq` olan uygulamayı oluştur.
2. Monetize > Products > Subscriptions altında aylık ve yıllık ürünleri aç.
3. Ürünlerin base plan, fiyat, ülke ve etkinlik ayarlarını tamamla.
4. RevenueCat servis hesabına gerekli Play Console erişimini ver ve JSON
   kimlik bilgisini yalnızca RevenueCat paneline yükle.
5. Test kullanıcılarını License Testing listesine ve uygun kapalı test kanalına
   ekle.

Android manifestinde Billing izni eklenmiştir. Release imzalama hâlâ proje
dışında güvenli bir keystore ile yapılandırılmalıdır; debug anahtarıyla mağaza
yayını yapılmamalıdır.

## 4. RevenueCat paneli

1. Bir RevenueCat projesi oluştur ve iOS/Android uygulamalarını yukarıdaki
   kimliklerle ekle.
2. Mağazalardaki iki ürünü RevenueCat `Products` alanına aktar.
3. `premium` entitlement oluştur ve iki ürünü de bu entitlement'a bağla.
4. `default` adlı bir Offering oluştur.
5. Aylık ürünü `$rc_monthly`, yıllık ürünü `$rc_annual` package'ına bağla.
6. `default` offering'i Current olarak işaretle.
7. RevenueCat Project Settings > API Keys alanındaki **public SDK key**
   değerlerini yerel derleme yapılandırmasına ekle. Secret REST key hiçbir
   zaman Flutter uygulamasına konulmamalıdır.

Uygulama RevenueCat App User ID olarak e-posta yerine Supabase kullanıcı
UUID'sini kullanır. Bu kimlik akışı değiştirilmemelidir.

## 5. Yerel derleme yapılandırması

Git'e eklenmeyen `config/env.local.json` dosyasını oluştur:

```json
{
  "REVENUECAT_IOS_API_KEY": "iOS public SDK key",
  "REVENUECAT_ANDROID_API_KEY": "Android public SDK key",
  "REVENUECAT_ENTITLEMENT_ID": "premium"
}
```

Çalıştırma örneği:

```bash
flutter run --dart-define-from-file=config/env.local.json
```

Bu dosya `.gitignore` kapsamındadır. CI/CD üzerinde aynı değişkenler güvenli
build secret'larından üretilmelidir.

## 6. Akışta hazır olan parçalar

- Aylık/yıllık planların RevenueCat Current Offering üzerinden alınması
- Mağazanın para birimi ve yerelleştirilmiş fiyatının gösterilmesi
- Yıllık plan için, iki ürün aynı para birimindeyken otomatik tasarruf hesabı
- Satın alma iptali, bekleyen ödeme, ağ ve mağaza hatalarının ayrıştırılması
- Satın almaları geri yükleme
- Aktif `premium` entitlement kontrolü ve anlık CustomerInfo güncellemesi
- Yenileme/bitiş tarihinin gösterilmesi
- App Store/Play Store abonelik yönetim bağlantısının açılması
- Supabase kullanıcı değişince RevenueCat kullanıcısının senkronize edilmesi
- Oturum kapanınca eski kullanıcı güncellemelerinin uygulama durumundan ayrılması
- Uygulama yeniden öne geldiğinde entitlement bilgisinin sessizce yenilenmesi
- Türkçe ve İngilizce paywall metinleri, otomatik yenileme açıklaması ve yasal
  sayfa bağlantıları

## 7. Yayından önce zorunlu test matrisi

- Yeni kullanıcı: aylık satın alma ve yıllık satın alma
- Satın alma ekranından vazgeçme: hata mesajı gösterilmemeli
- Ask to Buy / pending ödeme: bekleme mesajı ve daha sonra otomatik entitlement
  güncellemesi
- Aynı mağaza hesabıyla uygulamayı silip yeniden kurma ve Restore Purchases
- Farklı Botaniq hesabıyla oturum açma/çıkma
- Süresi bitmiş, iptal edilmiş ve yenilenecek abonelik durumları
- İnternet yokken paywall ve restore davranışı
- Türkçe/İngilizce, küçük ekran ve büyük yazı boyutu
- TestFlight Sandbox ve Google Play kapalı test kanalında gerçek cihaz
- RevenueCat dashboard Customer History içinde doğru Supabase UUID ve
  `premium` entitlement görünümü

## 8. Mağaza metadata ve backend kontrol listesi

- App Store/Play Store sayfalarına herkese açık Gizlilik Politikası, Kullanım
  Koşulları ve Destek URL'leri eklenmelidir.
- Abonelik adı, dönem, fiyat ve otomatik yenileme bilgileri inceleme notlarında
  açıkça belirtilmelidir.
- App Privacy / Data Safety formları RevenueCat ve Supabase veri akışlarını da
  kapsamalıdır.
- Premium kapsamındaki ücretli sunucu işlemleri (özellikle AI analizi) yalnızca
  istemci kontrolüne güvenmemelidir. RevenueCat webhook veya REST doğrulaması
  Supabase Edge Function tarafında, secret key yalnızca Edge Function secrets
  içinde tutularak uygulanmalıdır.
- Ücretsiz kullanım kotası, deneme süresi veya intro offer verilecekse önce ürün
  kuralı netleştirilmeli; ardından aynı kural hem paywall metnine hem sunucu
  yetkilendirmesine uygulanmalıdır.

## 9. Yayın öncesi açık karar

Şu an ödeme ve entitlement altyapısı hazırdır; ancak hangi özelliklerin ücretsiz,
hangilerinin Premium olduğu ürün kararıdır. Mağazaya göndermeden önce ücretsiz
kota/deneme kuralı belirlenmeli ve ücretli AI uç noktaları bu kurala göre sunucu
tarafında kilitlenmelidir. Paywall'daki fayda metinleri de nihai kuralla birebir
aynı olmalıdır.
