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
  String get apiSettings => 'API Ayarları (Yapay Zeka)';

  @override
  String get apiKeyHint => 'sk-proj-... veya sk-...';

  @override
  String get apiKeyDescription =>
      'Hesabınızdan API istekleri yapabilmek için kendi OpenAI API Key\'inizi girin. API Key şifreli olarak cihazınızda yerel saklanır.';

  @override
  String get apiKeySaved => 'OpenAI API Key başarıyla kaydedildi.';

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
  String get homeGoodMorning => 'Merhaba,';

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
}
