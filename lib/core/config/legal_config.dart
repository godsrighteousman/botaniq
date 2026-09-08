/// Uygulamanın yasal metinlerine ait genel erişim noktaları.
///
/// App Store, abonelik sunan uygulamalarda Kullanım Koşulları (EULA) ve
/// Gizlilik Politikası'na çalışan bağlantılar bulunmasını zorunlu tutuyor.
/// Bu adresler App Store Connect'teki metadata ile aynı olmalı.
class LegalConfig {
  LegalConfig._();

  static const String termsUrl = 'https://askbotaniq.netlify.app/terms.html';
  static const String privacyUrl =
      'https://askbotaniq.netlify.app/privacy.html';
  static const String supportUrl = 'https://askbotaniq.netlify.app/';
}
