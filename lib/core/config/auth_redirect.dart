/// E-posta onayı (signUp) ve şifre sıfırlama (resetPasswordForEmail) sonrası
/// Supabase'in kullanıcıyı geri göndereceği tek, ortak deep link.
///
/// Uygulama bu şemayı (bkz. ios/Runner/Info.plist'teki `CFBundleURLTypes` ve
/// android/app/src/main/AndroidManifest.xml'deki intent-filter) kendi
/// paketiyle eşsiz olacak şekilde, bundle id'sinden türeterek dinler.
/// `supabase_flutter` bu linki otomatik yakalayıp doğru oturum olayını
/// (signedIn / passwordRecovery) fırlatır — hangi akıştan geldiğini ayırt
/// etmek için ayrı bir path/host'a gerek yok, tek bir callback URL'i her
/// iki senaryoda da yeterli.
const String kAuthCallbackUrl = 'com.farukertas.botaniq://login-callback/';
