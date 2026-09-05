/* Botaniq destek/gizlilik sayfaları için basit iki dilli metin katmanı.
 *
 * Kural: tarayıcı dili Türkçe ise sayfa Türkçe, değilse İngilizce açılır.
 * Kullanıcı sağ üstteki düğmeden dili değiştirirse tercihi localStorage'da
 * saklanır ve sonraki ziyaretlerde otomatik dil algılamanın önüne geçer.
 *
 * Metinler HTML'de değil burada durur; HTML tarafında yalnızca
 * data-i18n="anahtar" (metin) ve data-i18n-html="anahtar" (içinde etiket
 * geçen metin) nitelikleri bulunur.
 */
(function () {
  'use strict';

  var STRINGS = {
    en: {
      'nav.support': 'Support',
      'nav.privacy': 'Privacy Policy',

      'support.title': 'Need help with Botaniq?',
      'support.p1': 'Botaniq is your smart plant care companion — identify plants, get AI-powered health diagnoses, and follow personalized care schedules.',
      'support.p2': "If you're running into an issue, have feedback, or need help with your account or subscription, reach out and we'll get back to you as soon as we can.",
      'support.topics': 'Common topics',
      'support.billing': "<strong>Subscription &amp; billing</strong> — Manage or cancel your Botaniq Premium subscription anytime from your device's Settings → [Your Name] → Subscriptions.",
      'support.deletion': "<strong>Account deletion</strong> — You can permanently delete your account, and everything stored with it, from Botaniq's Settings screen inside the app.",
      'support.accuracy': '<strong>Plant identification accuracy</strong> — For best results, photograph the whole plant in good lighting, following the in-app guidance.',

      'privacy.updated': 'Last updated: September 2, 2026',
      'privacy.overview': 'Overview',
      'privacy.overviewBody': 'This Privacy Policy explains what information Botaniq ("we", "us") collects when you use the Botaniq mobile app, how we use it, and the choices you have. Botaniq is a plant care app that helps you identify plants, get AI-assisted health diagnoses, and follow personalized care reminders.',
      'privacy.collect': 'Information we collect',
      'privacy.thCategory': 'Category',
      'privacy.thUse': "What it's used for",
      'privacy.rowAccount': 'Account info (email, name)',
      'privacy.rowAccountUse': 'Creating and securing your account, sign-in via email, Google, or Apple',
      'privacy.rowPhotos': 'Photos you take or upload',
      'privacy.rowPhotosUse': 'Identifying plants and diagnosing health issues via AI analysis',
      'privacy.rowLocation': 'Location (while app is in use)',
      'privacy.rowLocationUse': 'Providing weather-aware, local care recommendations — only with your permission',
      'privacy.rowCamera': 'Camera & microphone',
      'privacy.rowCameraUse': 'Only used when you actively scan a plant or record a video within the app',
      'privacy.rowSub': 'Subscription & purchase data',
      'privacy.rowSubUse': 'Processing and managing your Botaniq Premium subscription',
      'privacy.rowUsage': 'Usage data',
      'privacy.rowUsageUse': 'Understanding app performance and improving features',
      'privacy.third': 'Third-party services we use',
      'privacy.thirdBody': 'We rely on trusted third-party providers to operate Botaniq. Data may be shared with them strictly to provide the service:',
      'privacy.thirdSupabase': '<strong>Supabase</strong> — backend infrastructure, authentication, and data storage',
      'privacy.thirdOpenAI': '<strong>OpenAI</strong> — analyzing plant photos and powering the AI Plant Doctor chat',
      'privacy.thirdRC': '<strong>RevenueCat</strong> — managing subscriptions and in-app purchases',
      'privacy.thirdAuth': '<strong>Google Sign-In / Sign in with Apple</strong> — optional authentication methods',
      'privacy.thirdNote': 'These providers process data on our behalf and are not permitted to use it for their own purposes.',
      'privacy.retention': 'Data retention & deletion',
      'privacy.retentionBody': "We retain your data for as long as your account is active. You can permanently delete your account at any time from Botaniq's Settings screen inside the app — this removes your account and the data stored with it, including your plants, care history and uploaded photos. The deletion is immediate and cannot be undone.",
      'privacy.choices': 'Your choices',
      'privacy.choice1': "Camera, photo library, location, and microphone permissions can be managed anytime in your device's Settings.",
      'privacy.choice2': 'You can cancel your subscription anytime via Settings → [Your Name] → Subscriptions on your device.',
      'privacy.choice3': 'You can permanently delete your account and its data directly within the app.',
      'privacy.contact': 'Contact us',
      'privacy.contactBody': 'If you have questions about this Privacy Policy or how your data is handled, contact us at'
    },
    tr: {
      'nav.support': 'Destek',
      'nav.privacy': 'Gizlilik Politikası',

      'support.title': 'Botaniq ile ilgili yardıma mı ihtiyacın var?',
      'support.p1': 'Botaniq akıllı bitki bakım arkadaşın — bitkileri tanı, yapay zekâ destekli sağlık teşhisleri al ve sana özel bakım programını takip et.',
      'support.p2': 'Bir sorunla karşılaştıysan, geri bildirimin varsa ya da hesabın veya aboneliğinle ilgili yardıma ihtiyacın olursa bize yaz; en kısa sürede dönüş yapacağız.',
      'support.topics': 'Sık sorulan konular',
      'support.billing': '<strong>Abonelik ve ödeme</strong> — Botaniq Premium aboneliğini istediğin an cihazındaki Ayarlar → [Adın] → Abonelikler yolundan yönetebilir veya iptal edebilirsin.',
      'support.deletion': '<strong>Hesap silme</strong> — Hesabını ve onunla birlikte saklanan her şeyi, uygulama içindeki Ayarlar ekranından kalıcı olarak silebilirsin.',
      'support.accuracy': '<strong>Bitki tanıma doğruluğu</strong> — En iyi sonuç için bitkinin tamamını iyi ışıkta, uygulamadaki yönlendirmeye uyarak fotoğrafla.',

      'privacy.updated': 'Son güncelleme: 2 Eylül 2026',
      'privacy.overview': 'Genel bakış',
      'privacy.overviewBody': 'Bu Gizlilik Politikası, Botaniq mobil uygulamasını kullandığında Botaniq\'in ("biz") hangi bilgileri topladığını, bunları nasıl kullandığını ve sahip olduğun seçenekleri açıklar. Botaniq; bitkileri tanımana, yapay zekâ destekli sağlık teşhisleri almana ve sana özel bakım hatırlatmalarını takip etmene yardımcı olan bir bitki bakım uygulamasıdır.',
      'privacy.collect': 'Topladığımız bilgiler',
      'privacy.thCategory': 'Kategori',
      'privacy.thUse': 'Ne için kullanılıyor',
      'privacy.rowAccount': 'Hesap bilgileri (e-posta, ad)',
      'privacy.rowAccountUse': 'Hesabını oluşturmak ve güvenceye almak; e-posta, Google veya Apple ile giriş',
      'privacy.rowPhotos': 'Çektiğin veya yüklediğin fotoğraflar',
      'privacy.rowPhotosUse': 'Yapay zekâ analiziyle bitkileri tanımak ve sağlık sorunlarını teşhis etmek',
      'privacy.rowLocation': 'Konum (uygulama açıkken)',
      'privacy.rowLocationUse': 'Hava durumuna duyarlı, yerel bakım önerileri sunmak — yalnızca senin izninle',
      'privacy.rowCamera': 'Kamera ve mikrofon',
      'privacy.rowCameraUse': 'Yalnızca uygulama içinde bir bitki taradığında veya video kaydettiğinde kullanılır',
      'privacy.rowSub': 'Abonelik ve satın alma verileri',
      'privacy.rowSubUse': 'Botaniq Premium aboneliğini işlemek ve yönetmek',
      'privacy.rowUsage': 'Kullanım verileri',
      'privacy.rowUsageUse': 'Uygulama performansını anlamak ve özellikleri geliştirmek',
      'privacy.third': 'Kullandığımız üçüncü taraf hizmetler',
      'privacy.thirdBody': 'Botaniq\'i çalıştırmak için güvenilir üçüncü taraf sağlayıcılardan yararlanıyoruz. Veriler yalnızca hizmeti sunmak amacıyla bu sağlayıcılarla paylaşılabilir:',
      'privacy.thirdSupabase': '<strong>Supabase</strong> — sunucu altyapısı, kimlik doğrulama ve veri saklama',
      'privacy.thirdOpenAI': '<strong>OpenAI</strong> — bitki fotoğraflarının analizi ve Yapay Zekâ Bitki Doktoru sohbeti',
      'privacy.thirdRC': '<strong>RevenueCat</strong> — abonelik ve uygulama içi satın alma yönetimi',
      'privacy.thirdAuth': '<strong>Google ile Giriş / Apple ile Giriş</strong> — isteğe bağlı kimlik doğrulama yöntemleri',
      'privacy.thirdNote': 'Bu sağlayıcılar verileri bizim adımıza işler ve kendi amaçları için kullanamaz.',
      'privacy.retention': 'Veri saklama ve silme',
      'privacy.retentionBody': 'Verilerini hesabın aktif olduğu sürece saklarız. Hesabını istediğin an uygulama içindeki Ayarlar ekranından kalıcı olarak silebilirsin — bu işlem hesabını ve onunla saklanan verileri (bitkilerin, bakım geçmişin ve yüklediğin fotoğraflar dâhil) kaldırır. Silme işlemi anında gerçekleşir ve geri alınamaz.',
      'privacy.choices': 'Senin seçeneklerin',
      'privacy.choice1': 'Kamera, fotoğraf galerisi, konum ve mikrofon izinlerini istediğin an cihazının Ayarlar bölümünden yönetebilirsin.',
      'privacy.choice2': 'Aboneliğini istediğin an cihazındaki Ayarlar → [Adın] → Abonelikler yolundan iptal edebilirsin.',
      'privacy.choice3': 'Hesabını ve verilerini doğrudan uygulama içinden kalıcı olarak silebilirsin.',
      'privacy.contact': 'Bize ulaş',
      'privacy.contactBody': 'Bu Gizlilik Politikası veya verilerinin nasıl işlendiği hakkında sorun varsa bize şu adresten ulaşabilirsin:'
    }
  };

  var STORAGE_KEY = 'botaniq.lang';

  function detectLang() {
    var saved;
    try {
      saved = window.localStorage.getItem(STORAGE_KEY);
    } catch (e) {
      saved = null; // gizli sekme / depolama kapalı
    }
    if (saved === 'tr' || saved === 'en') return saved;

    var candidates = (navigator.languages && navigator.languages.length)
      ? navigator.languages
      : [navigator.language || 'en'];
    for (var i = 0; i < candidates.length; i++) {
      if (String(candidates[i]).toLowerCase().indexOf('tr') === 0) return 'tr';
    }
    return 'en';
  }

  function apply(lang) {
    var dict = STRINGS[lang] || STRINGS.en;
    document.documentElement.setAttribute('lang', lang);

    document.querySelectorAll('[data-i18n]').forEach(function (el) {
      var value = dict[el.getAttribute('data-i18n')];
      if (value !== undefined) el.textContent = value;
    });
    document.querySelectorAll('[data-i18n-html]').forEach(function (el) {
      var value = dict[el.getAttribute('data-i18n-html')];
      if (value !== undefined) el.innerHTML = value;
    });

    document.querySelectorAll('[data-lang-btn]').forEach(function (btn) {
      btn.classList.toggle('active', btn.getAttribute('data-lang-btn') === lang);
    });
  }

  function init() {
    apply(detectLang());
    document.querySelectorAll('[data-lang-btn]').forEach(function (btn) {
      btn.addEventListener('click', function () {
        var lang = btn.getAttribute('data-lang-btn');
        try {
          window.localStorage.setItem(STORAGE_KEY, lang);
        } catch (e) {
          /* depolama yoksa tercih sadece bu sayfa için geçerli olur */
        }
        apply(lang);
      });
    });
  }

  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', init);
  } else {
    init();
  }
})();
