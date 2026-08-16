// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get appTitle => 'Botaniq';

  @override
  String get settings => 'Ayarlar';

  @override
  String get preferences => 'Tercihler';

  @override
  String get darkMode => 'Karanlık Mod';

  @override
  String get metricSystem => 'Metrik Sistem';

  @override
  String get metricSystemSubtitle => 'Celsius ve Metre kullan';

  @override
  String get account => 'Hesap';

  @override
  String get editProfile => 'Profili Düzenle';

  @override
  String get changePassword => 'Şifre Değiştir';

  @override
  String get subscriptionManagement => 'Abonelik Yönetimi';

  @override
  String get premium => 'Premium';

  @override
  String get language => 'Dil';

  @override
  String get languageSubtitle => 'Uygulama dilini değiştir';

  @override
  String get selectLanguage => 'Dil Seçin';

  @override
  String get systemLanguage => 'Sistem Dili';

  @override
  String get english => 'English';

  @override
  String get turkish => 'Türkçe';

  @override
  String get languageChanged => 'Dil başarıyla değiştirildi.';

  @override
  String get languageSearchHint => 'Dillerde ara';

  @override
  String get languageRecommended => 'Önerilen';

  @override
  String get languageWelcomeTitle => 'Dilini seç';

  @override
  String get languageWelcomeSubtitle =>
      'Botaniq\'te kullanmak istediğin dili seç. Daha sonra istediğin zaman değiştirebilirsin.';

  @override
  String get languageUseSystem => 'Cihaz dilini kullan';

  @override
  String get preferenceSystem => 'Sistem ayarını kullan';

  @override
  String get themeLight => 'Açık';

  @override
  String get themeDark => 'Koyu';

  @override
  String get themeSelectionTitle => 'Görünümü seç';

  @override
  String get measurementMetric => 'Metrik';

  @override
  String get measurementImperial => 'İngiliz birimleri';

  @override
  String get measurementSelectionTitle => 'Ölçü sistemini seç';

  @override
  String get settingsSubtitle =>
      'Botaniq\'i kendi bakım ritmine göre şekillendir.';

  @override
  String get settingsLocalPreference => 'Bu cihazda saklanır';

  @override
  String get settingsDarkModeSubtitle =>
      'Düşük ışıklı anlar için daha sakin bir palet';

  @override
  String get settingsAccountSubtitle => 'Kimlik, erişim ve üyelik';

  @override
  String get settingsEditProfileSubtitle => 'İsim, konum ve bakım tercihleri';

  @override
  String get settingsPasswordSubtitle =>
      'E-postana güvenli sıfırlama bağlantısı gönder';

  @override
  String get settingsSubscriptionSubtitle =>
      'Premium plan ve ödeme ayrıntıları';

  @override
  String get settingsPasswordResetSent =>
      'Şifre sıfırlama e-postası gönderildi.';

  @override
  String get settingsComingSoon => 'Bu alan hâlâ büyüyor.';

  @override
  String get subscriptionPageTitle => 'Premium Üyelik';

  @override
  String get subscriptionHeroEyebrow => 'BOTANIQ PREMIUM';

  @override
  String get subscriptionHeroTitle => 'Bitkilerin için daha akıllı bakım';

  @override
  String get subscriptionHeroSubtitle =>
      'Tüm premium bakım araçlarına eriş ve yeşil alanını güvenle büyüt.';

  @override
  String get subscriptionBenefitsTitle => 'Premium ile gelenler';

  @override
  String get subscriptionBenefitIdentification =>
      'Sınırsız bitki tanıma ve sağlık analizi';

  @override
  String get subscriptionBenefitCare =>
      'Kişiselleştirilmiş bakım planları ve hatırlatıcılar';

  @override
  String get subscriptionBenefitInsights =>
      'Uzman içerikleri ve gelişmiş bakım içgörüleri';

  @override
  String get subscriptionMonthlyPlan => 'Aylık';

  @override
  String get subscriptionAnnualPlan => 'Yıllık';

  @override
  String subscriptionPerMonth(String price) {
    return '$price / ay';
  }

  @override
  String subscriptionPerYear(String price) {
    return '$price / yıl';
  }

  @override
  String get subscriptionBestValue => 'EN AVANTAJLI';

  @override
  String subscriptionSavePercent(int percent) {
    return '%$percent tasarruf';
  }

  @override
  String get subscriptionContinue => 'Premium’a Geç';

  @override
  String get subscriptionRestorePurchases => 'Satın Almaları Geri Yükle';

  @override
  String get subscriptionRestoring => 'Geri yükleniyor...';

  @override
  String get subscriptionManage => 'Aboneliği Yönet';

  @override
  String get subscriptionActiveTitle => 'Premium üyeliğin aktif';

  @override
  String get subscriptionActiveSubtitle =>
      'Tüm premium özelliklerden yararlanabilirsin.';

  @override
  String subscriptionRenewsOn(String date) {
    return '$date tarihinde yenilenir';
  }

  @override
  String subscriptionExpiresOn(String date) {
    return '$date tarihine kadar aktif';
  }

  @override
  String get subscriptionAutoRenewDisclosure =>
      'Ödeme Apple veya Google hesabından alınır. Abonelik, mevcut dönem bitmeden en az 24 saat önce iptal edilmezse otomatik yenilenir. Mağaza hesap ayarlarından istediğin zaman yönetebilir veya iptal edebilirsin.';

  @override
  String get subscriptionTermsLink => 'Kullanım Koşulları';

  @override
  String get subscriptionPrivacyLink => 'Gizlilik Politikası';

  @override
  String get subscriptionPurchaseSuccess => 'Premium üyeliğin etkinleştirildi.';

  @override
  String get subscriptionRestoreSuccess => 'Premium üyeliğin geri yüklendi.';

  @override
  String get subscriptionNothingToRestore =>
      'Bu mağaza hesabında geri yüklenecek aktif bir üyelik bulunamadı.';

  @override
  String get subscriptionPaymentPending =>
      'Ödeme mağaza onayı bekliyor. Onaylandığında üyeliğin otomatik olarak etkinleşir.';

  @override
  String get subscriptionErrorGeneric =>
      'İşlem şu anda tamamlanamadı. Lütfen tekrar dene.';

  @override
  String get subscriptionErrorNetwork =>
      'İnternet bağlantını kontrol edip tekrar dene.';

  @override
  String get subscriptionErrorNotAllowed =>
      'Bu cihaz veya mağaza hesabı satın almaya izin vermiyor.';

  @override
  String get subscriptionErrorStore =>
      'Mağaza ile bağlantı kurulamadı. Biraz sonra tekrar dene.';

  @override
  String get subscriptionMissingConfiguration =>
      'RevenueCat anahtarı bu derlemeye eklenmemiş.';

  @override
  String get subscriptionUnsupported =>
      'Abonelikler yalnızca iOS ve Android uygulamalarında kullanılabilir.';

  @override
  String get subscriptionProductsUnavailable =>
      'Aylık ve yıllık ürünler mağazadan alınamadı. RevenueCat offering ayarlarını kontrol et.';

  @override
  String get subscriptionRetry => 'Tekrar Dene';

  @override
  String get subscriptionFree => 'Ücretsiz';

  @override
  String get homeGoodMorning => 'Merhaba,';

  @override
  String homePersonalGreeting(String greeting, String name) {
    return '$greeting, $name 👋';
  }

  @override
  String get homeEmptyGarden => 'Bahçeniz henüz boş';

  @override
  String get homeEmptyGardenSubtitle =>
      'İlk bitkinizi ekleyerek yeşil sığınağınızı oluşturmaya başlayın.';

  @override
  String get homeAddFirstPlant => 'İlk Bitkiyi Ekle';

  @override
  String get homeMyPlants => 'Bitkilerim';

  @override
  String get homeViewAll => 'Tümünü Gör';

  @override
  String get homeSmartCareReminders => 'Akıllı Bakım Hatırlatıcıları';

  @override
  String get homeWatering => 'Sulama';

  @override
  String get homeWateringSubtitle => 'Toprak takibi';

  @override
  String get homeFertilizing => 'Gübreleme';

  @override
  String get homeFertilizingSubtitle => 'Besin alarmları';

  @override
  String get gardenTitle => 'Bahçem';

  @override
  String get gardenAllPlants => 'Tüm Bitkiler';

  @override
  String get gardenNeedsWater => 'Su İstiyor';

  @override
  String get gardenIndoor => 'Ev İçi';

  @override
  String get gardenNoPlants =>
      'Henüz bitki yok.\nİlk bitkinizi eklemek için + simgesine dokunun!';

  @override
  String get gardenNoPlantsCategory => 'Bu kategoride bitki bulunmuyor.';

  @override
  String get discoverTitle => 'Keşfet';

  @override
  String get discoverSearchHint => 'Bitki, makale, rehber ara...';

  @override
  String get discoverLatestArticles => 'Son Makaleler';

  @override
  String get discoverSeeAll => 'Tümünü gör';

  @override
  String get discoverTrendingGuides => 'Popüler Rehberler';

  @override
  String get healthyTitle => 'Bakım Merkezi';

  @override
  String get healthySubtitle => 'Bitkilerinin ruhuna dokun, onlarla konuş.';

  @override
  String get healthyTabDoctor => 'Doktor';

  @override
  String get healthyTabHospital => 'Hastane';

  @override
  String get healthyTabDiscover => 'Keşfet';

  @override
  String get profileTitle => 'Profilim';

  @override
  String get profileEditProfile => 'Profili Düzenle';

  @override
  String get profileOverview => 'Genel Bakış';

  @override
  String get profileSettingsTab => 'Ayarlar';

  @override
  String get profileGardenerLevel => 'Bahçıvan Seviyen';

  @override
  String get profileTotalPlants => 'Toplam Bitki';

  @override
  String get profileCompletedTasks => 'Tamamlanan Bakım';

  @override
  String get profileWeeklyActivity => 'Haftalık Bakım Aktivitesi';

  @override
  String get profileGeneral => 'Genel';

  @override
  String get profileAppSettings => 'Uygulama Ayarları';

  @override
  String get profileNotificationPrefs => 'Bildirim Tercihleri';

  @override
  String get profileSupportLegal => 'Destek & Yasal';

  @override
  String get profileHelpCenter => 'Yardım Merkezi';

  @override
  String get profileTerms => 'Kullanım Koşulları & Politikalar';

  @override
  String get profileSignOut => 'Çıkış Yap';

  @override
  String get profileDeleteAccount => 'Hesabı Sil';

  @override
  String get profileSubtitle => 'Bahçe hikâyen, gelişimin ve kişisel alanın.';

  @override
  String get profileGardenPassport => 'BAHÇE PASAPORTU';

  @override
  String get profileThisWeek => 'Bu hafta';

  @override
  String get profileQuietWeek =>
      'Sakin bir hafta — sıradaki bakım anın burada belirecek.';

  @override
  String get profileActiveWeek =>
      'Bakım ritmin canlı ve büyümeye devam ediyor.';

  @override
  String get profileAppSettingsSubtitle =>
      'Dil, birimler ve yapay zekâ bağlantısı';

  @override
  String get profileNotificationPrefsSubtitle =>
      'Hangi bakım anlarının sana ulaşacağını seç';

  @override
  String get profileHelpCenterSubtitle => 'Yanıtlar ve hızlı yönlendirmeler';

  @override
  String get profileTermsSubtitle => 'Gizlilik, koşullar ve politikalar';

  @override
  String get profileAccountActions => 'Hesap işlemleri';

  @override
  String get profileSignOutQuestion =>
      'Hesabından çıkış yapmak istediğine emin misin?';

  @override
  String get profileDeleteAccountWarning =>
      'Hesabın silinir; kişisel bilgilerin (ad, e-posta, profil fotoğrafı) kalıcı olarak kaldırılır ve hesabın anonim hâle getirilir. Bu işlem geri alınamaz.';

  @override
  String get cancel => 'İptal';

  @override
  String get continueAction => 'Devam et';

  @override
  String get profileTitleNew => 'Yeni Bahçıvan 🌱';

  @override
  String get profileTitleSprout => 'Filiz Dostu 🌿';

  @override
  String get profileTitleLeaf => 'Yaprak Sever ☘️';

  @override
  String get profileTitleSkilled => 'Yetenekli Bahçıvan 🏡';

  @override
  String get profileTitleMaster => 'Yeşil Başparmak Ustası 👑';

  @override
  String get profileNextLevelStart =>
      'İlk bitkini ekle ve bahçıvanlık macerana başla!';

  @override
  String profileNextLevelLeaf(int count) {
    return 'Yaprak Sever olmaya $count bitki kaldı.';
  }

  @override
  String profileNextLevelSkilled(int count) {
    return 'Yetenekli Bahçıvan olmaya $count bitki kaldı.';
  }

  @override
  String profileNextLevelMaster(int count) {
    return 'Yeşil Başparmak Ustası olmaya $count bitki kaldı.';
  }

  @override
  String get profileNextLevelMax => 'Bahçenizin zirvesindesiniz, tebrikler!';

  @override
  String get navHome => 'Ana Sayfa';

  @override
  String get navGarden => 'Bahçe';

  @override
  String get navClinic => 'Klinik';

  @override
  String get navProfile => 'Profil';

  @override
  String get scanPlant => 'Bitki Tara';

  @override
  String get deletePlantTitle => 'Bu bitki silinsin mi?';

  @override
  String get deletePlantMessage =>
      'Bitki, bakım görevleri ve Klinik kayıtları hesabından kalıcı olarak kaldırılacak.';

  @override
  String get deletePlantAction => 'Bitkiyi Sil';

  @override
  String get deletePlantNotFound => 'Bitki bulunamadı veya daha önce silinmiş.';

  @override
  String deletePlantError(String error) {
    return 'Bitki silinemedi: $error';
  }

  @override
  String get profileChoosePhoto => 'Profil Fotoğrafı Seç';

  @override
  String get profileFullName => 'Ad Soyad';

  @override
  String get profileFullNameHint => 'Adını ve soyadını gir';

  @override
  String get profileNickname => 'Kullanıcı Adı';

  @override
  String get profileNicknameHint => 'Sana nasıl hitap edelim?';

  @override
  String get profileAge => 'Yaş';

  @override
  String get profileAgeHint => '1–120';

  @override
  String get profileAgeValidation => 'Lütfen 1 ile 120 arasında bir yaş gir.';

  @override
  String profileLoadError(String error) {
    return 'Profil yüklenemedi: $error';
  }

  @override
  String get languageEnglish => 'İngilizce';

  @override
  String get languageTurkish => 'Türkçe';

  @override
  String get profileEmailReadOnly => 'E-posta Adresi (Salt Okunur)';

  @override
  String get profileEmailHint => 'E-posta adresini gir';

  @override
  String get profileLocation => 'Konum';

  @override
  String get profileLocationHint => 'Şehir, Ülke';

  @override
  String get profileSaveChanges => 'Değişiklikleri Kaydet';

  @override
  String get profileUpdated => 'Profilin güncellendi.';

  @override
  String profileSaveError(String error) {
    return 'Profil kaydedilemedi: $error';
  }

  @override
  String get notificationWateringTitle => 'Sulama Hatırlatıcıları';

  @override
  String get notificationWateringSubtitle =>
      'Sulama zamanı geldiğinde haber al';

  @override
  String get notificationFertilizerTitle => 'Gübre Hatırlatıcıları';

  @override
  String get notificationFertilizerSubtitle =>
      'Bitkilerin için mevsimsel besin uyarıları';

  @override
  String get notificationTitle => 'Bildirimler';

  @override
  String get notificationPlantCareAlerts => 'Bitki Bakım Uyarıları';

  @override
  String get notificationOther => 'Diğer Bildirimler';

  @override
  String get notificationWeatherTitle => 'Hava Durumu Uyarıları';

  @override
  String get notificationWeatherSubtitle => 'Aşırı hava koşulu uyarıları';

  @override
  String get notificationArticlesTitle => 'Yeni Makaleler';

  @override
  String get notificationArticlesSubtitle => 'Bahçen için ipuçları ve öneriler';

  @override
  String get gardenMyPlantFallback => 'Bitkim';

  @override
  String get gardenClinicBadge => 'Klinikte';

  @override
  String get wateringNever => 'Son sulama: Henüz yok';

  @override
  String wateringLastDate(String date) {
    return 'Son sulama: $date';
  }

  @override
  String wateringInterval(int days) {
    return '$days günde bir';
  }

  @override
  String get wateringNeverDue => 'Henüz sulanmadı • Bugün sulanmalı';

  @override
  String wateringOverdue(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days gün gecikti',
      zero: 'Bugün sulanmalı',
    );
    return '$_temp0';
  }

  @override
  String get wateringDueToday => 'Bugün sulanmalı';

  @override
  String get wateringDueTomorrow => 'Yarın sulanmalı';

  @override
  String wateringDueInDays(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days gün sonra sulanmalı',
      zero: 'Bugün sulanmalı',
    );
    return '$_temp0';
  }

  @override
  String get plantUnknown => 'Bilinmeyen Bitki';

  @override
  String get plantSpeciesFallback => 'Bitki Türü';

  @override
  String get plantDifficultyMedium => 'Orta';

  @override
  String get plantAbout => 'Hakkında';

  @override
  String get plantLocationEnvironment => 'Konum & Ortam';

  @override
  String get plantCareProtocol => 'Bakım Protokolü';

  @override
  String get plantCareHistory => 'Son 10 Günlük Bakım Geçmişi';

  @override
  String get plantHealthy => 'Sağlıklı';

  @override
  String get plantInClinic => 'Klinikte';

  @override
  String get plantDifficulty => 'Zorluk Seviyesi';

  @override
  String get plantToxicity => 'Toksisite';

  @override
  String get plantEnvironment => 'Yetişme Ortamı';

  @override
  String get plantLightNeed => 'Işık İhtiyacı';

  @override
  String get plantToxicPets => 'Evcil hayvanlar için toksik';

  @override
  String get plantNonToxic => 'Toksik değil';

  @override
  String get plantIndoor => 'İç mekân';

  @override
  String get plantBrightIndirect => 'Parlak dolaylı ışık';

  @override
  String get plantInfoUnavailable => 'Doğrulanmış bilgi henüz mevcut değil.';

  @override
  String get plantIdealClimate => 'İdeal İklim';

  @override
  String get plantHumidity => 'Nem Oranı';

  @override
  String get plantTemperatureRange => 'Sıcaklık Aralığı';

  @override
  String get plantWateringFrequency => 'Sulama Sıklığı';

  @override
  String plantWateringFrequencyValue(String interval) {
    return '$interval sulanmalı.';
  }

  @override
  String get plantNextWatering => 'Sonraki Sulama';

  @override
  String get plantWateringProtocol => 'Sulama Protokolü';

  @override
  String get plantSoilProtocol => 'Toprak';

  @override
  String get plantFeedingProtocol => 'Gübreleme Protokolü';

  @override
  String get plantPruningCleaning => 'Budama & Temizlik';

  @override
  String get plantPruningFallback =>
      'Yaprakları ayda bir sil. Büyümeyi desteklemek için ölü veya sararan yaprakları buda.';

  @override
  String get plantHistoryEmpty => 'Son 10 güne ait bakım geçmişi bulunmuyor.';

  @override
  String get plantWateringTask => 'Sulama';

  @override
  String get plantFertilizingTask => 'Gübreleme';

  @override
  String get plantWateredAction => 'Sulandı ✓';

  @override
  String get plantWaterNowAction => 'Şimdi Sula';

  @override
  String get plantFertilizedAction => 'Gübre Verildi ✓';

  @override
  String get plantFertilizeAction => 'Gübre Ver';

  @override
  String get plantAddGardenAction => 'Bahçeme Ekle';

  @override
  String get plantWaterSuccess => '💧 Bitkini suladın! Harika iş!';

  @override
  String get plantFertilizeSuccess => '🌱 Gübre verildi! Bitkin teşekkür eder!';

  @override
  String plantWaterError(String error) {
    return 'Sulama kaydedilemedi: $error';
  }

  @override
  String plantFertilizeError(String error) {
    return 'Gübre kaydedilemedi: $error';
  }

  @override
  String get clinicQuickTools => 'Hızlı Araçlar';

  @override
  String get clinicDoctorHero => 'AI Bitki Doktoru\nHizmetinizde';

  @override
  String get clinicStartConsultation => 'Danışmanlığı Başlat';

  @override
  String get clinicChoosePlant => 'Hangi Bitkin İçin Danışacaksın?';

  @override
  String get clinicChoosePlantSubtitle =>
      'Bahçendeki bitkilerden birini seç veya yeni bir fotoğraf çek.';

  @override
  String get clinicNoGardenPlants =>
      'Henüz bahçene bitki eklemedin.\nYeni bir fotoğraf çekerek başla.';

  @override
  String get clinicNewPhoto => 'Yeni Fotoğraf Çek';

  @override
  String get clinicNewPhotoSubtitle =>
      'Hasta bitkinin fotoğrafını çek ve teşhis al';

  @override
  String get clinicPestAnalysis => 'Haşere Analizi';

  @override
  String get clinicVisualDiagnosis => 'Görsel teşhis';

  @override
  String get clinicLightMeter => 'Işık Ölçer';

  @override
  String get clinicSensorSimulation => 'Sensör simülasyonu';

  @override
  String get clinicTitle => 'Bitki Kliniği';

  @override
  String clinicSickCount(int count) {
    return '$count Hasta';
  }

  @override
  String get clinicAllHealthy => 'Tüm Bitkilerin Sağlıklı! 🌿';

  @override
  String get clinicEmpty =>
      'Klinikte hasta bitki bulunmuyor.\nBir bitkinin sağlığından şüphe duyarsan,\nDoktor sekmesinden danışabilirsin.';

  @override
  String get clinicUnknown => 'Bilinmeyen';

  @override
  String get clinicPendingDiagnosis => 'Teşhis bekleniyor';

  @override
  String get clinicNoTreatment => 'Tedavi belirlenmedi';

  @override
  String get clinicPrescription => 'Reçete:';

  @override
  String get clinicRecovery => 'İyileşme Durumu';

  @override
  String get clinicRecovered => 'İyileşti';

  @override
  String get clinicContinue => 'Devam Et';

  @override
  String get clinicRecoveredSuccess => '🎉 Bitkin sağlığına kavuştu!';

  @override
  String get clinicUrgencyLow => 'Düşük';

  @override
  String get clinicUrgencyMedium => 'Orta';

  @override
  String get clinicUrgencyCritical => 'Kritik';

  @override
  String get healthTrendingTips => 'Trend Sağlık Tüyoları';

  @override
  String get healthHumidityArticleTitle =>
      'Kışa Hazırlık: Nem Dengesini Korumak';

  @override
  String get healthHumidityArticleSubtitle =>
      'Soğuk aylarda bitkilerini kaloriferin kuru havasından nasıl korursun?';

  @override
  String get healthWeeklySpotlight => 'Haftanın Hastası & Şifası';

  @override
  String get healthAphidTitle => 'Yaprak Biti İstilası';

  @override
  String get healthAphidSubtitle =>
      'Erken evre müdahalesi ve doğal Neem Yağı kürü.';

  @override
  String get healthDiscoverLoadError =>
      'Keşfet içerikleri şu anda yüklenemedi. Aşağı çekerek yeniden deneyebilirsin.';

  @override
  String get healthDiscoverEmpty => 'Yayınlanmış keşfet içeriği henüz yok.';

  @override
  String get healthDiscoverRetry => 'Yeniden Dene';

  @override
  String get lightMeterTitle => 'Işık Ölçer';

  @override
  String get lightMeterInstructionTitle => 'Işığı Ölçmek İçin';

  @override
  String get lightMeterInstruction =>
      'Telefonun ön kamerasını bitkinin\nbulunduğu alana ve ışık kaynağına doğru tut.';

  @override
  String get lightMeterCameraEstimate =>
      'Kamera verisinden hesaplanan yaklaşık lux değeri';

  @override
  String get lightMeterStabilizing => 'Ölçüm dengeleniyor';

  @override
  String get lightMeterStabilizingRecommendation =>
      'Telefonu birkaç saniye sabit tut; ani pozlama değişimleri filtreleniyor.';

  @override
  String get lightMeterUnavailable => 'Ölçüm kullanılamıyor';

  @override
  String get lightMeterUnavailableRecommendation =>
      'Kamera iznini açıp bu ekranı yeniden deneyin.';

  @override
  String get lightLow => 'Düşük Işık (Gölge)';

  @override
  String get lightMedium => 'Orta Işık (Aydınlık Oda)';

  @override
  String get lightHigh => 'Yüksek Işık (Pencere Önü)';

  @override
  String get lightVeryHigh => 'Çok Yüksek Işık (Direkt Güneş)';

  @override
  String get lightLowRecommendation =>
      'Calathea, eğrelti otu veya paşa kılıcı için uygundur.';

  @override
  String get lightMediumRecommendation =>
      'Monstera, Ficus ve Antoryum için ideal ortamdır.';

  @override
  String get lightHighRecommendation =>
      'Aloe, kaktüs ve sardunya gibi güneşi sevenlere uygundur.';

  @override
  String get lightVeryHighRecommendation =>
      'Dış mekân bitkileri ve sukulentler için en iyi noktadır.';

  @override
  String get homeLoadingPlants => 'Bitkiler yükleniyor...';

  @override
  String get homeNotifications => 'Bildirimler';

  @override
  String get homeWateringTime => 'Sulama Zamanı';

  @override
  String get homeWateringNotification => 'Ev bitkilerinin sulanması gerekiyor.';

  @override
  String get homeWelcome => 'Hoş geldin!';

  @override
  String get homeWelcomeNotification =>
      'Botaniq\'e hoş geldin. İlk bitkini ekleyerek başla.';

  @override
  String get homeTenMinutesAgo => '10 dakika önce';

  @override
  String get homeOneDayAgo => '1 gün önce';

  @override
  String get homeQuickActions => 'Hızlı İşlemler';

  @override
  String get homeIdentifyCamera => 'Kameranla bitkiyi tanı';

  @override
  String get homeTomorrow => 'Yarın';

  @override
  String get homeNoTasks => 'Bu gün için görev yok!';

  @override
  String get homeAllCared => 'Bitkilerinin tüm bakımları tamam 🌿';

  @override
  String get homeOverdue => 'GECİKTİ';

  @override
  String get homeInstructions => 'Talimatlar';

  @override
  String homeRequiredAmount(String amount) {
    return 'Gerekli: $amount';
  }

  @override
  String get homeLater => 'Daha Sonra';

  @override
  String get homeMarkDone => 'Tamamlandı';

  @override
  String get homeSickPlants => 'Bitki Kliniği';

  @override
  String homeSickCount(int count) {
    return '$count Hasta';
  }

  @override
  String get homeGreetingMorning => 'Günaydın';

  @override
  String get homeGreetingAfternoon => 'Tünaydın';

  @override
  String get homeGreetingEvening => 'İyi Akşamlar';

  @override
  String get homeTodayTasks => 'Bugünün Görevleri';

  @override
  String get homeTomorrowTasks => 'Yarının Görevleri';

  @override
  String homeDateTasks(String date) {
    return '$date Görevleri';
  }

  @override
  String get commonSkip => 'Atla';

  @override
  String get commonContinue => 'Devam Et';

  @override
  String get commonClose => 'Kapat';

  @override
  String get commonDelete => 'Sil';

  @override
  String get commonBack => 'Vazgeç';

  @override
  String get commonUnknown => 'Bilinmeyen';

  @override
  String get wizardSaveGarden => 'Kaydet ve Bahçeye Ekle';

  @override
  String wizardPlantAdded(String name) {
    return '$name bahçene eklendi! 🌿';
  }

  @override
  String get wizardRoomTitle => 'Bitkin nerede?';

  @override
  String get wizardRoomSubtitle =>
      'Bitkini odaya göre sınıflandırarak kolayca yönet.';

  @override
  String get wizardLivingRoom => 'Oturma Odası';

  @override
  String get wizardBedroom => 'Yatak Odası';

  @override
  String get wizardKitchen => 'Mutfak';

  @override
  String get wizardOffice => 'Ofis';

  @override
  String get wizardBathroom => 'Banyo';

  @override
  String get wizardBalcony => 'Balkon';

  @override
  String get wizardLightTitle => 'Bu noktadaki ışık nasıl?';

  @override
  String get wizardLightSubtitle =>
      'Işık, bitkinin sağlığı için en önemli etkenlerden biridir.';

  @override
  String get wizardDirectSun => 'Doğrudan Güneş';

  @override
  String get wizardDirectSunDescription =>
      'Filtrelenmemiş güneş ışığı doğrudan bitkinin üzerinde';

  @override
  String get wizardBrightIndirect => 'Parlak Dolaylı Işık';

  @override
  String get wizardBrightIndirectDescription =>
      'Doğu veya batı cephesindeki pencereye yakın';

  @override
  String get wizardMediumLight => 'Orta Işık';

  @override
  String get wizardMediumLightDescription => 'Pencereden birkaç metre uzakta';

  @override
  String get wizardLowLight => 'Düşük Işık';

  @override
  String get wizardLowLightDescription =>
      'Pencerelerden uzakta veya yapay ışık altında';

  @override
  String get wizardDistanceTitle => 'Pencereye Uzaklık';

  @override
  String get wizardDistanceSubtitle =>
      'En yakın pencereye yaklaşık uzaklığı seç.';

  @override
  String get wizardMoreThanFiveMeters => '5 metreden fazla';

  @override
  String get wizardActiveHoursTitle => 'Aktif Işık Süresi';

  @override
  String get wizardActiveHoursSubtitle =>
      'Bu nokta kaç saat doğrudan veya parlak ışık alıyor?';

  @override
  String wizardHour(int count) {
    return '$count saat';
  }

  @override
  String wizardHours(int count) {
    return '$count saat';
  }

  @override
  String get wizardSixPlusHours => '6+ saat';

  @override
  String get wizardRepottedTitle =>
      'Bu bitkinin toprağı en son ne zaman değiştirildi?';

  @override
  String get wizardRepottedSubtitle =>
      'Taze toprak, mutlu bir bitki için önemlidir.';

  @override
  String get wizardRecently => 'Yakın zamanda (3 aydan kısa)';

  @override
  String get wizardSixMonthsAgo => '6 ay önce';

  @override
  String get wizardOneYearAgo => '1 yıl önce';

  @override
  String get wizardTwoYearsAgo => '2+ yıl önce';

  @override
  String get wizardDontKnow => 'Bilmiyorum';

  @override
  String get wizardPotTitle => 'Saksının malzemesi nedir?';

  @override
  String get wizardPotSubtitle =>
      'Saksı malzemesi toprağın kuruma hızını etkiler.';

  @override
  String get wizardPlasticPot => 'Plastik / Fidanlık';

  @override
  String get wizardTerracottaPot => 'Toprak Saksı';

  @override
  String get wizardCeramicPot => 'Seramik / Sırlı';

  @override
  String get wizardMetalPot => 'Metal';

  @override
  String get wizardWateredTitle => 'Bu bitkiyi en son ne zaman suladın?';

  @override
  String get wizardWateredSubtitle =>
      'Bu bilgi sonraki sulama zamanını doğru hesaplamamıza yardım eder.';

  @override
  String get wizardToday => 'Bugün';

  @override
  String get wizardYesterday => 'Dün';

  @override
  String get wizardFewDaysAgo => 'Birkaç gün önce';

  @override
  String get wizardWeekAgo => 'Bir hafta önce';

  @override
  String get wizardMoreWeekAgo => 'Bir haftadan uzun süre önce';

  @override
  String get historyTitle => 'Arama Geçmişi';

  @override
  String get historyClearTitle => 'Geçmişi Temizle';

  @override
  String get historyClearMessage =>
      'Tüm arama ve tarama geçmişin silinecek. Emin misin?';

  @override
  String get historyClearTooltip => 'Geçmişi Temizle';

  @override
  String get historyEmptyTitle => 'Arama Kaydı Bulunmuyor';

  @override
  String get historyEmptySubtitle =>
      'Kamera ile taradığın veya aradığın bitkiler burada görüntülenir.';

  @override
  String get historyNoDetails => 'Detaylı bilgi bulunmuyor.';

  @override
  String get historyRegularWater => 'Düzenli sulama';

  @override
  String get historyIndirectLight => 'Dolaylı ışık';

  @override
  String get historyDescription => 'Açıklama';

  @override
  String get historyWatering => 'Sulama';

  @override
  String get historyLight => 'Işık';

  @override
  String get historyRecently => 'Yakın zamanda';

  @override
  String historyMinutesAgo(int minutes) {
    return '$minutes dk önce';
  }

  @override
  String historyHoursAgo(int hours) {
    return '$hours saat önce';
  }

  @override
  String get historyYesterday => 'Dün';

  @override
  String get historyPlantRecord => 'Bitki Arama Kaydı';

  @override
  String get photoWholeSpecimen =>
      'Bitkinin veya mantarın\ntamamının fotoğrafı';

  @override
  String get photoWholeSpecimenSubtitle =>
      'Daha doğru tanımlama için örneğin tamamını kadrajın ortasında tut.';

  @override
  String get photoCorrect => 'Doğru';

  @override
  String get photoTooClose => 'Çok Yakın';

  @override
  String get photoInstructions => 'Yönergeler';

  @override
  String get photoOpenCamera => 'Anladım, Kamerayı Aç';

  @override
  String get scannerPlant => 'Bitki';

  @override
  String get scannerMushroom => 'Mantar';

  @override
  String get scannerIdentifyingPlant => 'Bitki Tanımlanıyor...';

  @override
  String get scannerIdentifyingMushroom => 'Mantar Tanımlanıyor...';

  @override
  String get scannerCapture => 'Fotoğrafı Çek ve Tara';

  @override
  String get scannerFailed => 'Tarama başarısız oldu. Lütfen tekrar dene.';

  @override
  String scannerError(String error) {
    return 'Bir hata oluştu: $error';
  }

  @override
  String get scannerUnknownPlant => 'Bilinmeyen Bitki';

  @override
  String get scannerUnknownMushroom => 'Bilinmeyen Mantar';

  @override
  String get scheduleTitle => 'Takvim';

  @override
  String get scheduleTodayTask => 'Bugünün Görevleri';

  @override
  String get scheduleNoTasks => 'Bugün için görev yok!';

  @override
  String get scheduleInstructions => 'Talimatlar';

  @override
  String scheduleRequired(String amount) {
    return 'Gerekli: $amount';
  }

  @override
  String get scheduleRemindLater => 'Sonra Hatırlat';

  @override
  String get scheduleDone => 'Tamamlandı';

  @override
  String get scheduleCareFallback => 'Bitkinin bakımını yap.';

  @override
  String get chatDoctorTitle => 'AI Bitki Doktoru';

  @override
  String chatPatient(String name) {
    return 'Hasta: $name';
  }

  @override
  String get chatAnalyzing => 'Analiz ediliyor...';

  @override
  String chatHint(String name) {
    return '$name hakkında sor...';
  }

  @override
  String chatWelcome(String name) {
    return 'Merhaba! 🌿 Ben AI Bitki Doktorun. $name hakkında nasıl yardımcı olabilirim?\n\nFotoğraftan teşhis koyabilir veya bakım sorularını yanıtlayabilirim.';
  }

  @override
  String chatContinueWelcome(String name) {
    return 'Merhaba! $name hakkında devam edelim. 🌱';
  }

  @override
  String get chatQuestionYellowing => 'Yapraklardaki sararmanın sebebi ne?';

  @override
  String get chatQuestionTreatment => 'Bu bitkiyi nasıl tedavi edebilirim?';

  @override
  String get chatQuestionWatering => 'Sulama sıklığını değiştirmeli miyim?';

  @override
  String get chatQuestionFertilizer => 'Hangi gübreyi kullanmalıyım?';

  @override
  String get chatPhotoSent => 'Fotoğraf gönderildi';

  @override
  String get chatAnalyzePhoto => 'Fotoğrafı analiz et';

  @override
  String get chatDiagnosisUnknown => 'Teşhis belirlenemedi';

  @override
  String get chatNoTreatment => 'Tedavi önerisi yok';

  @override
  String get chatRecoveryUnknown => 'Belirsiz';

  @override
  String get chatUnableIdentify => 'Tanımlanamayan Bitki';

  @override
  String chatError(String error) {
    return 'Üzgünüm, bir hata oluştu: $error. Lütfen tekrar dene.';
  }

  @override
  String get chatCareTips => 'Bakım İpuçları';

  @override
  String get chatPlantLabel => 'Bitki';

  @override
  String get chatDiagnosisLabel => 'Teşhis';

  @override
  String get chatTreatmentLabel => 'Tedavi';

  @override
  String get chatUrgencyLabel => 'Aciliyet';

  @override
  String get chatRecoveryLabel => 'Tahmini İyileşme';

  @override
  String get discoverMonsteraTitle => 'Monstera Büyütmenin Sırrı';

  @override
  String get discoverIndoorPlants => 'İç Mekân Bitkileri';

  @override
  String get discoverSucculentWatering => 'Sukulent Sulama Rehberi';

  @override
  String get discoverCacti => 'Kaktüsler ve Sukulentler';

  @override
  String get discoverHerbSoil => 'Otlar İçin En İyi Toprak Türleri';

  @override
  String get discoverHerbs => 'Otlar';

  @override
  String get discoverPropagation => 'Çoğaltma 101: Başlangıç Rehberi';

  @override
  String get discoverPests => 'Yaygın Zararlılar ve Tedavileri';

  @override
  String get discoverRepotting => 'Saksı Değişimi: Ne Zaman ve Nasıl?';

  @override
  String discoverMinutesRead(int minutes) {
    return '$minutes dk okuma';
  }

  @override
  String get skip => 'Atla';

  @override
  String get skipForNow => 'Şimdilik atla';

  @override
  String get continueLabel => 'Devam Et';

  @override
  String get getStarted => 'Başlayalım';

  @override
  String get nextStep => 'Sonraki Adım';

  @override
  String get maybeLater => 'Belki Daha Sonra';

  @override
  String get emailAddress => 'E-posta Adresi';

  @override
  String get password => 'Şifre';

  @override
  String get firstName => 'Ad';

  @override
  String get lastName => 'Soyad';

  @override
  String get login => 'Giriş Yap';

  @override
  String get signUp => 'Kayıt Ol';

  @override
  String get welcomeBack => 'Tekrar Hoş Geldin';

  @override
  String get loginSubtitle =>
      'Bahçenle ilgilenmeye devam etmek için giriş yap.';

  @override
  String get signUpSubtitle =>
      'Aramıza katıl ve yeşil alanını oluşturmaya başla.';

  @override
  String get forgotPassword => 'Şifreni mi unuttun?';

  @override
  String get enterEmailPassword => 'Lütfen e-posta adresini ve şifreni gir.';

  @override
  String get fillAllFields => 'Lütfen tüm alanları doldur.';

  @override
  String authError(String error) {
    return 'Bir hata oluştu: $error';
  }

  @override
  String get loginWith => 'Veya şununla giriş yap';

  @override
  String get signUpWith => 'Veya şununla kayıt ol';

  @override
  String get noAccount => 'Hesabın yok mu? ';

  @override
  String get alreadyAccount => 'Zaten hesabın var mı? ';

  @override
  String get developerSession => 'Geliştirici Oturumu Oluştur';

  @override
  String get welcomeBotaniq => 'Botaniq’e Hoş Geldin';

  @override
  String get loginOptionsSubtitle =>
      'Bitkilerini, takvimlerini ve tercihlerini yedeklemek için giriş yap veya kayıt ol.';

  @override
  String get notificationAccessTitle => 'Sulamayı kaçırma';

  @override
  String get notificationAccessSubtitle =>
      'Yeşil dostlarının bakım zamanı geldiğinde sana nazikçe hatırlatalım. Bitki bakımı kolay ve stressiz olsun.';

  @override
  String get notificationTurnOn => 'Hatırlatıcıları Aç';

  @override
  String get creatingClimate => 'Mikro iklimin inceleniyor...';

  @override
  String get creatingSchedules => 'Bakım takvimlerin hazırlanıyor...';

  @override
  String get creatingSanctuary => 'Yeşil alanın hazırlanıyor...';

  @override
  String get locationAccessTitle => 'Konum Erişimi';

  @override
  String get locationAccessSubtitle =>
      'Bitki bakımını bulunduğun yerin mikro iklimine göre kişiselleştir.';

  @override
  String get locationRecommendation => 'Yerel Öneriler';

  @override
  String get locationRecommendationSubtitle =>
      'Bölgenin ikliminde gelişen bitkiler';

  @override
  String get locationWeather => 'Akıllı Hava Durumu Uyumu';

  @override
  String get locationWeatherSubtitle =>
      'Takvimler yerel yağışa göre güncellenir';

  @override
  String get locationAlerts => 'Don ve Sıcaklık Uyarıları';

  @override
  String get locationAlertsSubtitle => 'Aşırı hava olaylarından önce haber al';

  @override
  String get locationEnable => 'Konum Erişimini Aç';

  @override
  String get wherePlantsTitle => 'Bitkilerin nerede?';

  @override
  String get wherePlantsSubtitle =>
      'Bakım takvimini kişiselleştirmek için uygun olanların tümünü seç.';

  @override
  String get locationIndoor => 'İç Mekân';

  @override
  String get locationIndoorSubtitle => 'Salon, yatak odası, ofis';

  @override
  String get locationBalcony => 'Balkon';

  @override
  String get locationBalconySubtitle => 'Balkon veya terastaki saksı bitkileri';

  @override
  String get locationGarden => 'Bahçe';

  @override
  String get locationGardenSubtitle => 'Topraktaki bitkiler ve çiçek tarhları';

  @override
  String get helpTitleBefore => 'Sana hangi konuda\n';

  @override
  String get helpTitleHighlight => 'yardımcı ';

  @override
  String get helpTitleAfter => 'olalım?';

  @override
  String get helpSubtitle =>
      'Bahçeni kişiselleştirmek için bir veya daha fazla hedef seç.';

  @override
  String get helpHeal => 'Hasta bitkileri\niyileştirme';

  @override
  String get helpCare => 'Bakım\nhatırlatıcıları';

  @override
  String get helpIdentify => 'Tür\ntanımlama';

  @override
  String get helpJournal => 'Büyüme\ngünlüğü';

  @override
  String get helpOther => 'Başka bir şey';

  @override
  String get journeyTitle => 'Yeşil Yolculuğun';

  @override
  String get journeySubtitle =>
      'Bitkilerine vermek istediğin bakım seviyesini seç.';

  @override
  String get journeyCasualLabel => 'SAKİN';

  @override
  String get journeyCasualTitle => 'Az Bakım';

  @override
  String get journeyCasualSubtitle =>
      'Kolay bitkilerimi canlı ve sağlıklı tutmak istiyorum.';

  @override
  String get journeyEnthusiastLabel => 'MERAKLI';

  @override
  String get journeyEnthusiastTitle => 'Dengeli Bakım';

  @override
  String get journeyEnthusiastSubtitle =>
      'Büyüyen koleksiyonumla her hafta biraz zaman geçirmek hoşuma gidiyor.';

  @override
  String get journeyObsessedLabel => 'TUTKUN';

  @override
  String get journeyObsessedTitle => 'Usta Bitki Ebeveyni';

  @override
  String get journeyObsessedSubtitle =>
      'Bitkilerim için yaşıyorum; iç mekân ormanım için uzman takvimleri istiyorum.';

  @override
  String get masteryTitleBefore => 'Son zamanlarda ';

  @override
  String get masteryTitleHighlight => 'bitki bakımın\n';

  @override
  String get masteryTitleAfter => 'nasıl?';

  @override
  String get masterySubtitle =>
      'Dürüst ol; hepimiz bir dönem bitkileri yaşatmakta zorlandık. Güncel seviyeni seç.';

  @override
  String get masteryKiller => 'Seri Bitki Katili';

  @override
  String get masteryKillerSubtitle =>
      'Odaya girdiğimde plastik bitkilerim bile biraz endişeleniyor.';

  @override
  String get masteryAccidental => 'Tesadüfi Ebeveyn';

  @override
  String get masteryAccidentalSubtitle =>
      'Kaktüsüm iki haftadır hayatta. Birbirimizi hâlâ tanıyoruz.';

  @override
  String get masteryGrowth => 'Gelişim Zihniyeti';

  @override
  String get masteryGrowthSubtitle =>
      'Arkadaşlarımın çoğunun yaprakları var. Monstera ile Pothos’u ayırt ederim.';

  @override
  String get masteryWhisperer => 'Bitki Fısıldayan';

  @override
  String get masteryWhispererSubtitle =>
      'Nadir bitkileri çoğaltır ve botanik Latince konuşurum.';

  @override
  String get onboardingOneTitle => 'Bitkilerine\nBir Uzman Gibi\n';

  @override
  String get onboardingOneHighlight => 'Bak';

  @override
  String get onboardingOneSubtitle =>
      'Şehir ormanın için akıllı takvimler ve anında tanımlama.';

  @override
  String get onboardingOneBadge => 'YAPAY ZEKÂ DESTEKLİ BAKIM';

  @override
  String get onboardingAiScan => 'AI Tarama';

  @override
  String get onboardingSmartWater => 'Akıllı Sulama';

  @override
  String get onboardingLightTracking => 'Işık Takibi';

  @override
  String get onboardingTwoTitle => 'Her Bitkiyi\nSaniyeler İçinde\n';

  @override
  String get onboardingTwoHighlight => 'Tanı';

  @override
  String get onboardingTwoSubtitle =>
      'Adını, türünü ve bakım ihtiyaçlarını öğrenmek için fotoğrafını çek.';

  @override
  String get onboardingTwoBadge => 'BOTANİK UZMANI';

  @override
  String get onboardingSnapPhoto => 'Fotoğraf Çek';

  @override
  String get onboardingAccurateResult => 'Doğru Sonuç';

  @override
  String get onboardingPlantWiki => 'Bitki Ansiklopedisi';

  @override
  String get onboardingThreeTitle => 'Sulamayı Bir Daha\nAsla\n';

  @override
  String get onboardingThreeHighlight => 'Unutma';

  @override
  String get onboardingThreeSubtitle =>
      'Bitkinin ihtiyaçlarına ve ortamına uygun zamanlanmış hatırlatmalar al.';

  @override
  String get onboardingThreeBadge => 'AKILLI TAKVİMLER';

  @override
  String get onboardingReminders => 'Hatırlatıcılar';

  @override
  String get onboardingClimateData => 'İklim Verileri';

  @override
  String get onboardingHealthyGrowth => 'Sağlıklı Büyüme';

  @override
  String get onboardingCommunity => '50.000+ bitki ebeveynine katıl';

  @override
  String get onboardingAgreement =>
      'DEVAM EDEREK KOŞULLARI VE GİZLİLİK POLİTİKASINI KABUL EDERSİN';

  @override
  String get termsTitle => 'Koşullar ve Politikalar';

  @override
  String get termsUpdated => 'Son güncelleme: Ağustos 2026';

  @override
  String get termsUseTitle => '1. Kullanım Koşulları';

  @override
  String get termsUseBody =>
      'Botaniq’e erişerek veya kullanarak bu koşulları ve geçerli tüm yasaları kabul edersin. Hizmetin herhangi bir bölümünü önceden bildirmeksizin değiştirebilir, askıya alabilir veya sonlandırabiliriz; bu koşulları ihlal eden veya hizmeti kötüye kullanan hesapları askıya alabilir ya da kapatabiliriz. Değişikliklerden sonra hizmeti kullanmaya devam etmen güncel koşulları kabul ettiğin anlamına gelir.';

  @override
  String get termsPrivacyTitle => '2. Topladığımız Veriler ve Kullanım Amacı';

  @override
  String get termsPrivacyBody =>
      'Botaniq’i çalıştırmak ve geliştirmek için hizmeti kullanırken sağladığın veya oluşturduğun verileri işleriz: hesap ve profil bilgileri (ad, e-posta, giriş kimlikleri), çektiğin veya yüklediğin fotoğraflar (bitki ve kamera görselleri dâhil), konum, cihaz ve tanılama bilgileri, bildirim belirteçleri, kullanım/etkileşim verileri ve girdiğin içerikler (notlar, sohbet mesajları, destek talepleri). Bu veriler tarafımızca ve adımıza hareket eden güvenilir hizmet sağlayıcılar tarafından işlenir — bulut barındırma/veritabanı, yapay zekâ görsel ve metin analizi, kimlik doğrulama (Google/Apple ile giriş), anlık bildirim ve abonelik/ödeme işleme dâhil — yalnızca hizmeti çalıştırmak, güvenliğini sağlamak, desteklemek ve geliştirmek, deneyimini kişiselleştirmek, bitki tanıma ve bakım özelliklerini eğitmek ve değerlendirmek, dolandırıcılık ve kötüye kullanımı önlemek ve yasal yükümlülükleri yerine getirmek amacıyla. Botaniq’i kullanarak bu işlemeyi ve gerektiğinde verilerinin bu sağlayıcıların altyapısı için ülkeni aşan şekilde aktarılmasını kabul edersin. Kişisel verilerini satmayız.';

  @override
  String get termsContentTitle => '3. İçeriğin ve Bize Verdiğin Lisans';

  @override
  String get termsContentBody =>
      'Gönderdiğin fotoğraf, not ve diğer içeriklerin sahipliği sende kalır. İçerik göndererek bize, elimizde bulunduğu sürece Botaniq’i işletmek, güvenliğini sağlamak ve geliştirmek (bitki tanıma, teşhis ve diğer yapay zekâ destekli özellikleri iyileştirmek dâhil) amacıyla dünya çapında, telifsiz, münhasır olmayan, alt lisans verilebilir bir barındırma, saklama, çoğaltma, analiz etme ve kullanma lisansı vermiş olursun. Yüklediğin her şeyi paylaşma hakkına sahip olduğundan sen sorumlusun.';

  @override
  String get termsRetentionTitle => '4. Hesap Silme ve Veri Saklama';

  @override
  String get termsRetentionBody =>
      'Uygulama içinden hesap silme talebinde bulunmak hesabını anonimleştirir: ad, e-posta ve profil fotoğrafın kalıcı olarak kaldırılır ve kimliğinle yeniden ilişkilendirilemez; giriş bilgilerin ve kalan uygulama verilerin ise aynı anonimleşmiş hesapla ilişkili kalır, böylece tekrar giriş yaparsan hesabını kullanmaya devam edebilirsin. Silme talebinden sonra bile, güvenlik, dolandırıcılık önleme, yasal, muhasebe veya uyuşmazlık çözümü amaçlarıyla verileri — anonimleştirilmiş, toplulaştırılmış veya yedek biçimde dâhil — yürürlükteki mevzuatın izin verdiği azami süre boyunca saklayabiliriz.';

  @override
  String get termsPlantTitle => '5. Bitki Verileri ve Yapay Zekâ Sonuçları';

  @override
  String get termsPlantBody =>
      'Bitki bakımı, tanımlama ve teşhis bilgileri — yapay zekâ tarafından üretilenler dâhil — yalnızca genel bilgilendirme amaçlıdır; profesyonel bahçıvanlık, tarım, veterinerlik veya tıbbi tavsiye niteliği taşımaz. Yapay zekâ sonuçları yanlış veya eksik olabilir. Bitkilerin, evcil hayvanların ve hanenle ilgili bu bilgilere dayalı kararlardan yalnızca sen sorumlusun; ciddi durumlarda bitkini gözlemle ve yetkin bir uzmana danış.';

  @override
  String get termsLiabilityTitle => '6. Sorumluluk Reddi ve Tazminat';

  @override
  String get termsLiabilityBody =>
      'Botaniq, doğruluk, güvenilirlik veya belirli bir amaca uygunluk dâhil açık ya da zımni hiçbir garanti olmaksızın \"olduğu gibi\" ve \"mevcut haliyle\" sunulur. Yürürlükteki mevzuatın izin verdiği azami ölçüde; biz ve hizmet sağlayıcılarımız, hizmeti kullanmandan doğan dolaylı, arızi, özel veya sonuç niteliğindeki zararlardan ya da veri, bitki veya mal kaybından sorumlu tutulamayız ve herhangi bir talebe ilişkin toplam sorumluluğumuz, varsa, talepten önceki on iki ay içinde bize ödediğin tutarla sınırlıdır. Hizmeti kullanmandan, içeriğinden veya bu koşulları ya da yürürlükteki yasaları ihlal etmenden doğan taleplere karşı bizi tazmin etmeyi ve zarar görmemizi önlemeyi kabul edersin.';

  @override
  String get termsPremiumTitle => '7. Premium Abonelikler';

  @override
  String get termsPremiumBody =>
      'Aylık veya yıllık Premium aboneliğin, satın alma onayından sonra Apple ya da Google hesabından ücretlendirilir. Abonelik, mevcut dönem bitmeden en az 24 saat önce iptal edilmezse otomatik yenilenir. Aboneliğini mağaza hesap ayarlarından yönetebilir veya iptal edebilirsin. İade talepleri ilgili mağazanın kurallarına göre değerlendirilir.';

  @override
  String get termsLawTitle => '8. Uygulanacak Hukuk ve Değişiklikler';

  @override
  String get termsLawBody =>
      'Bu koşullar, faaliyet gösterdiğimiz yargı bölgesinin yasalarına tabidir; uyuşmazlıklar, yürürlükteki mevzuatın izin verdiği azami ölçüde o yargı bölgesinin geçerli usulleri kapsamında çözülür. Bu koşulları ve veri uygulamalarımızı, güncel sürümü uygulama içinde yayımlayarak dilediğimiz zaman değiştirebiliriz.';

  @override
  String get termsClosing => 'İçin rahat, bitkilerin mutlu olsun.';

  @override
  String get weatherTitle => 'Hava Durumu';

  @override
  String get weatherSunnyTip =>
      'Bugün güneşli; sulamadan önce toprağı kontrol et.';

  @override
  String get weatherCloudyTip =>
      'Kapalı havada buharlaşma yavaşlar; sulamayı biraz azalt.';

  @override
  String get weatherRainyTip =>
      'Hava yağmurlu ve nemli; dış mekân bitkilerini fazla sulama.';

  @override
  String get weatherStormTip =>
      'Fırtınalı hava; hassas saksıları korunaklı bir yere al.';

  @override
  String get weatherSnowTip =>
      'Hava soğuk ve karlı; bitkileri sıcaklık şokundan koru.';
}
