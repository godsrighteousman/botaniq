// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Thai (`th`).
class AppLocalizationsTh extends AppLocalizations {
  AppLocalizationsTh([String locale = 'th']) : super(locale);

  @override
  String get appTitle => 'Botaniq';

  @override
  String get settings => 'การตั้งค่า';

  @override
  String get preferences => 'การตั้งค่า';

  @override
  String get darkMode => 'โหมดมืด';

  @override
  String get metricSystem => 'ระบบเมตริก';

  @override
  String get metricSystemSubtitle => 'ใช้เซลเซียสและเมตร';

  @override
  String get account => 'บัญชี';

  @override
  String get editProfile => 'แก้ไขโปรไฟล์';

  @override
  String get changePassword => 'เปลี่ยนรหัสผ่าน';

  @override
  String get subscriptionManagement => 'การจัดการการสมัครสมาชิก';

  @override
  String get premium => 'พรีเมี่ยม';

  @override
  String get language => 'ภาษา';

  @override
  String get languageSubtitle => 'เปลี่ยนภาษาของแอป';

  @override
  String get selectLanguage => 'เลือกภาษา';

  @override
  String get systemLanguage => 'ภาษาของระบบ';

  @override
  String get english => 'อังกฤษ';

  @override
  String get turkish => 'เติร์กเช่';

  @override
  String get languageChanged => 'เปลี่ยนภาษาเรียบร้อยแล้ว';

  @override
  String get languageSearchHint => 'ค้นหาภาษา';

  @override
  String get languageRecommended => 'แนะนำ';

  @override
  String get languageWelcomeTitle => 'เลือกภาษาของคุณ';

  @override
  String get languageWelcomeSubtitle =>
      'เลือกภาษาที่คุณต้องการใช้ใน Botaniq คุณสามารถเปลี่ยนได้ตลอดเวลา';

  @override
  String get languageUseSystem => 'ใช้ภาษาของอุปกรณ์';

  @override
  String get preferenceSystem => 'ใช้การตั้งค่าระบบ';

  @override
  String get themeLight => 'เบา';

  @override
  String get themeDark => 'มืด';

  @override
  String get themeSelectionTitle => 'เลือกลักษณะที่ปรากฏ';

  @override
  String get measurementMetric => 'เมตริก';

  @override
  String get measurementImperial => 'อิมพีเรียล';

  @override
  String get measurementSelectionTitle => 'เลือกระบบการวัด';

  @override
  String get settingsSubtitle => 'กำหนด Botaniq ตามจังหวะการดูแลของคุณเอง';

  @override
  String get settingsLocalPreference => 'บันทึกไว้ในอุปกรณ์นี้';

  @override
  String get settingsDarkModeSubtitle =>
      'โทนสีที่สงบยิ่งขึ้นสำหรับช่วงเวลาที่มีแสงน้อย';

  @override
  String get settingsAccountSubtitle => 'ตัวตน การเข้าถึง และการเป็นสมาชิก';

  @override
  String get settingsEditProfileSubtitle => 'ชื่อ สถานที่ และการตั้งค่าการดูแล';

  @override
  String get settingsPasswordSubtitle =>
      'ส่งลิงก์รีเซ็ตที่ปลอดภัยไปยังอีเมลของคุณ';

  @override
  String get settingsSubscriptionSubtitle =>
      'แผนพรีเมียมและรายละเอียดการเรียกเก็บเงิน';

  @override
  String get settingsPasswordResetSent => 'ส่งอีเมลรีเซ็ตรหัสผ่านแล้ว';

  @override
  String get settingsComingSoon => 'พื้นที่นี้ยังคงเติบโต';

  @override
  String get subscriptionPageTitle => 'สมาชิกระดับพรีเมียม';

  @override
  String get subscriptionHeroEyebrow => 'BOTANIQ PREMIUM';

  @override
  String get subscriptionHeroTitle => 'การดูแลพืชทุกชนิดอย่างชาญฉลาดยิ่งขึ้น';

  @override
  String get subscriptionHeroSubtitle =>
      'ปลดล็อกเครื่องมือการดูแลระดับพรีเมียมทั้งหมด และเพิ่มพื้นที่สีเขียวของคุณด้วยความมั่นใจ';

  @override
  String get subscriptionBenefitsTitle => 'ทุกอย่างในระดับพรีเมียม';

  @override
  String get subscriptionBenefitIdentification =>
      'การระบุพืชและการวิเคราะห์สุขภาพไม่จำกัด';

  @override
  String get subscriptionBenefitCare => 'แผนการดูแลและการเตือนความจำส่วนบุคคล';

  @override
  String get subscriptionBenefitInsights =>
      'เนื้อหาจากผู้เชี่ยวชาญและข้อมูลเชิงลึกด้านการดูแลขั้นสูง';

  @override
  String get subscriptionMonthlyPlan => 'รายเดือน';

  @override
  String get subscriptionAnnualPlan => 'ประจำปี';

  @override
  String subscriptionPerMonth(String price) {
    return '$price / เดือน';
  }

  @override
  String subscriptionPerYear(String price) {
    return '$price/ปี';
  }

  @override
  String get subscriptionBestValue => 'คุ้มค่าที่สุด';

  @override
  String subscriptionSavePercent(int percent) {
    return 'บันทึก $percent%';
  }

  @override
  String get subscriptionContinue => 'ปลดล็อคพรีเมี่ยม';

  @override
  String get subscriptionRestorePurchases => 'คืนค่าการซื้อ';

  @override
  String get subscriptionRestoring => 'กำลังคืนค่า...';

  @override
  String get subscriptionManage => 'จัดการการสมัครสมาชิก';

  @override
  String get subscriptionActiveTitle => 'สมาชิกพรีเมี่ยมของคุณเปิดใช้งานอยู่';

  @override
  String get subscriptionActiveSubtitle =>
      'คุณสามารถเข้าถึงฟีเจอร์พรีเมียมทั้งหมดได้';

  @override
  String subscriptionRenewsOn(String date) {
    return 'ต่ออายุเมื่อ $date';
  }

  @override
  String subscriptionExpiresOn(String date) {
    return 'ใช้งานจนถึง $date';
  }

  @override
  String get subscriptionAutoRenewDisclosure =>
      'การชำระเงินจะถูกหักออกจากบัญชี Apple หรือ Google ของคุณ การสมัครสมาชิกจะต่ออายุโดยอัตโนมัติเว้นแต่จะยกเลิกอย่างน้อย 24 ชั่วโมงก่อนสิ้นสุดระยะเวลาปัจจุบัน คุณสามารถจัดการหรือยกเลิกได้ตลอดเวลาในการตั้งค่าบัญชีร้านค้าของคุณ';

  @override
  String get subscriptionTermsLink => 'เงื่อนไขการใช้งาน';

  @override
  String get subscriptionPrivacyLink => 'นโยบายความเป็นส่วนตัว';

  @override
  String get subscriptionPurchaseSuccess =>
      'สมาชิกระดับพรีเมียมของคุณใช้งานได้แล้ว';

  @override
  String get subscriptionRestoreSuccess =>
      'การเป็นสมาชิก Premium ของคุณได้รับการกู้คืนแล้ว';

  @override
  String get subscriptionNothingToRestore =>
      'ไม่พบสมาชิกที่ใช้งานอยู่สำหรับบัญชีร้านค้านี้';

  @override
  String get subscriptionPaymentPending =>
      'การชำระเงินอยู่ระหว่างรอการอนุมัติจากร้านค้า ความเป็นสมาชิกของคุณจะเปิดใช้งานโดยอัตโนมัติเมื่อได้รับการอนุมัติ';

  @override
  String get subscriptionErrorGeneric =>
      'ไม่สามารถดำเนินการให้เสร็จสิ้นได้ โปรดลองอีกครั้ง';

  @override
  String get subscriptionErrorNetwork =>
      'ตรวจสอบการเชื่อมต่ออินเทอร์เน็ตของคุณแล้วลองอีกครั้ง';

  @override
  String get subscriptionErrorNotAllowed =>
      'อุปกรณ์หรือบัญชีร้านค้านี้ไม่ได้รับอนุญาตให้ทำการซื้อ';

  @override
  String get subscriptionErrorStore =>
      'ไม่สามารถเข้าถึงร้านค้าได้ โปรดลองอีกครั้งในอีกสักครู่';

  @override
  String get subscriptionMissingConfiguration =>
      'คีย์ RevenueCat หายไปจากโครงสร้างนี้';

  @override
  String get subscriptionUnsupported =>
      'การสมัครสมาชิกมีเฉพาะในแอป iOS และ Android เท่านั้น';

  @override
  String get subscriptionProductsUnavailable =>
      'ไม่สามารถโหลดผลิตภัณฑ์รายเดือนและรายปีได้ ตรวจสอบการกำหนดค่าข้อเสนอ RevenueCat';

  @override
  String get subscriptionRetry => 'ลองอีกครั้ง';

  @override
  String get subscriptionFree => 'ฟรี';

  @override
  String get homeGoodMorning => 'สวัสดี';

  @override
  String homePersonalGreeting(String greeting, String name) {
    return '$greeting $name 👋';
  }

  @override
  String get homeEmptyGarden => 'สวนของคุณว่างเปล่า';

  @override
  String get homeEmptyGardenSubtitle =>
      'เริ่มสร้างเขตรักษาพันธุ์สัตว์ป่าสีเขียวของคุณ\nโดยการเพิ่มต้นแรกของคุณ';

  @override
  String get homeAddFirstPlant => 'เพิ่มโรงงานแรก';

  @override
  String get homeMyPlants => 'พืชของฉัน';

  @override
  String get homeViewAll => 'ดูทั้งหมด';

  @override
  String get homeSmartCareReminders => 'การแจ้งเตือนการดูแลอย่างชาญฉลาด';

  @override
  String get homeWatering => 'การรดน้ำ';

  @override
  String get homeWateringSubtitle => 'การติดตามดิน';

  @override
  String get homeFertilizing => 'การใส่ปุ๋ย';

  @override
  String get homeFertilizingSubtitle => 'การแจ้งเตือนสารอาหาร';

  @override
  String get gardenTitle => 'สวนของฉัน';

  @override
  String get gardenAllPlants => 'พืชทั้งหมด';

  @override
  String get gardenNeedsWater => 'ต้องการน้ำ';

  @override
  String get gardenIndoor => 'ในร่ม';

  @override
  String get gardenNoPlants => 'ยังไม่มีพืช.\nแตะ + เพื่อเพิ่มโรงงานแรกของคุณ!';

  @override
  String get gardenNoPlantsCategory => 'ไม่มีพืชในหมวดนี้';

  @override
  String get discoverTitle => 'ค้นพบ';

  @override
  String get discoverSearchHint => 'ค้นหาพืช บทความ คำแนะนำ...';

  @override
  String get discoverLatestArticles => 'บทความล่าสุด';

  @override
  String get discoverSeeAll => 'ดูทั้งหมด';

  @override
  String get discoverTrendingGuides => 'คำแนะนำที่ได้รับความนิยม';

  @override
  String get healthyTitle => 'ศูนย์ดูแล';

  @override
  String get healthySubtitle =>
      'สัมผัสจิตวิญญาณของพืชพรรณของคุณ พูดคุยกับพวกมัน';

  @override
  String get healthyTabDoctor => 'คุณหมอ';

  @override
  String get healthyTabHospital => 'โรงพยาบาล';

  @override
  String get healthyTabDiscover => 'ค้นพบ';

  @override
  String get profileTitle => 'โปรไฟล์ของฉัน';

  @override
  String get profileEditProfile => 'แก้ไขโปรไฟล์';

  @override
  String get profileOverview => 'ภาพรวม';

  @override
  String get profileSettingsTab => 'การตั้งค่า';

  @override
  String get profileGardenerLevel => 'ระดับคนสวน';

  @override
  String get profileTotalPlants => 'พืชทั้งหมด';

  @override
  String get profileCompletedTasks => 'งานที่เสร็จสมบูรณ์';

  @override
  String get profileWeeklyActivity => 'กิจกรรมการดูแลรายสัปดาห์';

  @override
  String get profileGeneral => 'ทั่วไป';

  @override
  String get profileAppSettings => 'การตั้งค่าแอพ';

  @override
  String get profileNotificationPrefs => 'การตั้งค่าการแจ้งเตือน';

  @override
  String get profileSupportLegal => 'การสนับสนุนและกฎหมาย';

  @override
  String get profileHelpCenter => 'ศูนย์ช่วยเหลือ';

  @override
  String get profileTerms => 'ข้อกำหนดการใช้งานและนโยบาย';

  @override
  String get profileSignOut => 'ออกจากระบบ';

  @override
  String get profileDeleteAccount => 'ลบบัญชี';

  @override
  String get profileSubtitle =>
      'เรื่องราวสวนของคุณ ความก้าวหน้า และพื้นที่ส่วนตัว';

  @override
  String get profileGardenPassport => 'หนังสือเดินทางสวน';

  @override
  String get profileThisWeek => 'สัปดาห์นี้';

  @override
  String get profileQuietWeek =>
      'สัปดาห์ที่เงียบสงบ ช่วงเวลาแห่งการดูแลครั้งต่อไปของคุณจะปรากฏที่นี่';

  @override
  String get profileActiveWeek => 'จังหวะการดูแลของคุณมีชีวิตชีวาและเติบโต';

  @override
  String get profileAppSettingsSubtitle => 'ภาษา หน่วย และการเชื่อมต่อ AI';

  @override
  String get profileNotificationPrefsSubtitle =>
      'เลือกช่วงเวลาการดูแลที่เข้าถึงคุณ';

  @override
  String get profileHelpCenterSubtitle => 'คำตอบและคำแนะนำอย่างรวดเร็ว';

  @override
  String get profileTermsSubtitle => 'ความเป็นส่วนตัว ข้อกำหนด และนโยบาย';

  @override
  String get profileAccountActions => 'การดำเนินการของบัญชี';

  @override
  String get profileSignOutQuestion => 'คุณแน่ใจหรือไม่ว่าต้องการออกจากระบบ?';

  @override
  String get profileDeleteAccountWarning =>
      'การลบบัญชีจำเป็นต้องได้รับการยืนยันจากฝั่งเซิร์ฟเวอร์ที่ปลอดภัย ข้อมูลของคุณไม่มีการเปลี่ยนแปลง';

  @override
  String get cancel => 'ยกเลิก';

  @override
  String get continueAction => 'ดำเนินการต่อ';

  @override
  String get profileTitleNew => 'ชาวสวนคนใหม่ 🌱';

  @override
  String get profileTitleSprout => 'เพื่อนต้นกล้า 🌿';

  @override
  String get profileTitleLeaf => 'คนรักใบไม้ ☘️';

  @override
  String get profileTitleSkilled => 'ชาวสวนฝีมือดี 🏡';

  @override
  String get profileTitleMaster => 'อาจารย์หัวแม่มือสีเขียว 👑';

  @override
  String get profileNextLevelStart =>
      'เพิ่มต้นไม้ต้นแรกของคุณและเริ่มการผจญภัยทำสวนของคุณ!';

  @override
  String profileNextLevelLeaf(int count) {
    return 'เหลือเพียงต้น $count ที่จะมาเป็น Leaf Lover';
  }

  @override
  String profileNextLevelSkilled(int count) {
    return 'เหลือเพียงต้น $count ที่จะเป็นนักจัดสวนที่มีทักษะ';
  }

  @override
  String profileNextLevelMaster(int count) {
    return 'เหลือเพียงพืช $count ที่จะกลายเป็น Green Thumb Master';
  }

  @override
  String get profileNextLevelMax =>
      'คุณอยู่ที่ด้านบนสุดของสวนของคุณแล้ว ยินดีด้วย!';

  @override
  String get navHome => 'บ้าน';

  @override
  String get navGarden => 'สวน';

  @override
  String get navClinic => 'คลินิก';

  @override
  String get navProfile => 'โปรไฟล์';

  @override
  String get scanPlant => 'สแกนโรงงาน';

  @override
  String get deletePlantTitle => 'นำโรงงานนี้ออกใช่ไหม';

  @override
  String get deletePlantMessage =>
      'โรงงาน งานดูแล และบันทึกคลินิกจะถูกลบออกจากบัญชีของคุณอย่างถาวร';

  @override
  String get deletePlantAction => 'ลบพืช';

  @override
  String get deletePlantNotFound => 'ไม่พบโรงงานหรือถูกกำจัดออกไปแล้ว';

  @override
  String deletePlantError(String error) {
    return 'ไม่สามารถเอาต้นไม้ออกได้: $error';
  }

  @override
  String get profileChoosePhoto => 'เลือกรูปโปรไฟล์';

  @override
  String get profileFullName => 'ชื่อเต็ม';

  @override
  String get profileFullNameHint => 'กรอกชื่อเต็มของคุณ';

  @override
  String get profileNickname => 'ชื่อเล่น';

  @override
  String get profileNicknameHint => 'เราควรโทรหาคุณอย่างไร?';

  @override
  String get profileAge => 'อายุ';

  @override
  String get profileAgeHint => '1–120';

  @override
  String get profileAgeValidation => 'โปรดป้อนอายุระหว่าง 1 ถึง 120';

  @override
  String profileLoadError(String error) {
    return 'ไม่สามารถโหลดโปรไฟล์: $error';
  }

  @override
  String get languageEnglish => 'อังกฤษ';

  @override
  String get languageTurkish => 'ภาษาตุรกี';

  @override
  String get profileEmailReadOnly => 'ที่อยู่อีเมล (อ่านอย่างเดียว)';

  @override
  String get profileEmailHint => 'ใส่อีเมลของคุณ';

  @override
  String get profileLocation => 'ที่ตั้ง';

  @override
  String get profileLocationHint => 'เมือง, ประเทศ';

  @override
  String get profileSaveChanges => 'บันทึกการเปลี่ยนแปลง';

  @override
  String get profileUpdated => 'โปรไฟล์ของคุณได้รับการอัปเดตแล้ว';

  @override
  String profileSaveError(String error) {
    return 'ไม่สามารถบันทึกโปรไฟล์ได้: $error';
  }

  @override
  String get notificationWateringTitle => 'การแจ้งเตือนการรดน้ำ';

  @override
  String get notificationWateringSubtitle => 'รับการแจ้งเตือนเมื่อถึงเวลาน้ำ';

  @override
  String get notificationFertilizerTitle => 'คำเตือนเรื่องปุ๋ย';

  @override
  String get notificationFertilizerSubtitle =>
      'การแจ้งเตือนการให้อาหารตามฤดูกาลสำหรับพืชของคุณ';

  @override
  String get notificationTitle => 'การแจ้งเตือน';

  @override
  String get notificationPlantCareAlerts => 'การแจ้งเตือนการดูแลพืช';

  @override
  String get notificationOther => 'การแจ้งเตือนอื่น ๆ';

  @override
  String get notificationWeatherTitle => 'การแจ้งเตือนสภาพอากาศ';

  @override
  String get notificationWeatherSubtitle => 'คำเตือนสภาพอากาศที่รุนแรง';

  @override
  String get notificationArticlesTitle => 'บทความใหม่';

  @override
  String get notificationArticlesSubtitle =>
      'คำแนะนำและเคล็ดลับสำหรับสวนของคุณ';

  @override
  String get gardenMyPlantFallback => 'โรงงานของฉัน';

  @override
  String get gardenClinicBadge => 'ในคลินิก';

  @override
  String get wateringNever => 'รดน้ำครั้งสุดท้าย: ไม่เคย';

  @override
  String wateringLastDate(String date) {
    return 'รดน้ำครั้งสุดท้าย: $date';
  }

  @override
  String wateringInterval(int days) {
    return 'ทุก $days วัน';
  }

  @override
  String get wateringNeverDue => 'ยังไม่ได้รดน้ำ • รดน้ำวันนี้';

  @override
  String wateringOverdue(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'เกินกำหนด $days วัน',
      zero: 'รดน้ำวันนี้',
    );
    return '$_temp0';
  }

  @override
  String get wateringDueToday => 'น้ำวันนี้';

  @override
  String get wateringDueTomorrow => 'พรุ่งนี้ลงน้ำ';

  @override
  String wateringDueInDays(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'รดน้ำในอีก $days วัน',
      zero: 'รดน้ำวันนี้',
    );
    return '$_temp0';
  }

  @override
  String get plantUnknown => 'พืชที่ไม่รู้จัก';

  @override
  String get plantSpeciesFallback => 'พันธุ์พืช';

  @override
  String get plantDifficultyMedium => 'ปานกลาง';

  @override
  String get plantAbout => 'เกี่ยวกับ';

  @override
  String get plantLocationEnvironment => 'สถานที่ตั้งและสิ่งแวดล้อม';

  @override
  String get plantCareProtocol => 'พิธีสารการดูแล';

  @override
  String get plantCareHistory => 'ประวัติการดูแล 10 วันล่าสุด';

  @override
  String get plantHealthy => 'ดีต่อสุขภาพ';

  @override
  String get plantInClinic => 'ในคลินิก';

  @override
  String get plantDifficulty => 'ความยาก';

  @override
  String get plantToxicity => 'ความเป็นพิษ';

  @override
  String get plantEnvironment => 'สิ่งแวดล้อม';

  @override
  String get plantLightNeed => 'ความต้องการแสง';

  @override
  String get plantToxicPets => 'เป็นพิษต่อสัตว์เลี้ยง';

  @override
  String get plantNonToxic => 'ปลอดสารพิษ';

  @override
  String get plantIndoor => 'ในร่ม';

  @override
  String get plantBrightIndirect => 'ทางอ้อมที่สดใส';

  @override
  String get plantInfoUnavailable => 'ยังไม่มีข้อมูลที่ตรวจสอบแล้ว';

  @override
  String get plantIdealClimate => 'สภาพภูมิอากาศในอุดมคติ';

  @override
  String get plantHumidity => 'ความชื้น';

  @override
  String get plantTemperatureRange => 'ช่วงอุณหภูมิ';

  @override
  String get plantWateringFrequency => 'ความถี่ในการรดน้ำ';

  @override
  String plantWateringFrequencyValue(String interval) {
    return 'น้ำ $interval.';
  }

  @override
  String get plantNextWatering => 'การรดน้ำครั้งต่อไป';

  @override
  String get plantWateringProtocol => 'พิธีสารการรดน้ำ';

  @override
  String get plantSoilProtocol => 'ดิน';

  @override
  String get plantFeedingProtocol => 'พิธีสารการให้อาหาร';

  @override
  String get plantPruningCleaning => 'การตัดแต่งกิ่งและการทำความสะอาด';

  @override
  String get plantPruningFallback =>
      'เช็ดใบทุกเดือน ตัดใบที่ตายแล้วหรือใบเหลืองออกเพื่อกระตุ้นการเจริญเติบโต';

  @override
  String get plantHistoryEmpty => 'ไม่มีประวัติการดูแลในช่วง 10 วันที่ผ่านมา';

  @override
  String get plantWateringTask => 'การรดน้ำ';

  @override
  String get plantFertilizingTask => 'การใส่ปุ๋ย';

  @override
  String get plantWateredAction => 'รดน้ำ ✓';

  @override
  String get plantWaterNowAction => 'น้ำตอนนี้';

  @override
  String get plantFertilizedAction => 'ปฏิสนธิ ✓';

  @override
  String get plantFertilizeAction => 'ใส่ปุ๋ย';

  @override
  String get plantAddGardenAction => 'เพิ่มไปที่สวนของฉัน';

  @override
  String get plantWaterSuccess => '💧 คุณรดน้ำต้นไม้ของคุณ! เยี่ยมมาก!';

  @override
  String get plantFertilizeSuccess => '🌱 ปุ๋ยเติม! ต้นไม้ของคุณบอกว่าขอบคุณ!';

  @override
  String plantWaterError(String error) {
    return 'ไม่สามารถบันทึกการรดน้ำได้: $error';
  }

  @override
  String plantFertilizeError(String error) {
    return 'ไม่สามารถบันทึกการใส่ปุ๋ยได้: $error';
  }

  @override
  String get clinicQuickTools => 'เครื่องมือด่วน';

  @override
  String get clinicDoctorHero => 'หมอพืช AI\nที่บริการของคุณ';

  @override
  String get clinicStartConsultation => 'เริ่มการให้คำปรึกษา';

  @override
  String get clinicChoosePlant => 'คุณต้องการหารือเกี่ยวกับโรงงานใด';

  @override
  String get clinicChoosePlantSubtitle =>
      'เลือกต้นไม้จากสวนของคุณหรือถ่ายรูปใหม่';

  @override
  String get clinicNoGardenPlants =>
      'ยังไม่มีต้นไม้ในสวนของคุณ\nเริ่มต้นด้วยการถ่ายภาพใหม่';

  @override
  String get clinicNewPhoto => 'ถ่ายรูปใหม่';

  @override
  String get clinicNewPhotoSubtitle => 'ถ่ายภาพพืชที่ป่วยและรับการวินิจฉัย';

  @override
  String get clinicPestAnalysis => 'การวิเคราะห์ศัตรูพืช';

  @override
  String get clinicVisualDiagnosis => 'การวินิจฉัยด้วยสายตา';

  @override
  String get clinicLightMeter => 'เครื่องวัดแสง';

  @override
  String get clinicSensorSimulation => 'การจำลองเซ็นเซอร์';

  @override
  String get clinicTitle => 'คลินิกพืช';

  @override
  String clinicSickCount(int count) {
    return '$count ไม่สบาย';
  }

  @override
  String get clinicAllHealthy => 'พืชทั้งหมดของคุณมีสุขภาพดี! 🌿';

  @override
  String get clinicEmpty =>
      'ในคลินิกไม่มีพืชป่วย\nหากคุณกังวลเรื่องพืช\nถามจากแท็บหมอ';

  @override
  String get clinicUnknown => 'ไม่ทราบ';

  @override
  String get clinicPendingDiagnosis => 'รอการวินิจฉัย';

  @override
  String get clinicNoTreatment => 'ยังไม่ได้กำหนดการรักษา';

  @override
  String get clinicPrescription => 'ใบสั่งยา:';

  @override
  String get clinicRecovery => 'การกู้คืน';

  @override
  String get clinicRecovered => 'ฟื้นตัวแล้ว';

  @override
  String get clinicContinue => 'ดำเนินการต่อ';

  @override
  String get clinicRecoveredSuccess => '🎉 ต้นไม้ของคุณกลับมาแข็งแรงอีกครั้ง!';

  @override
  String get clinicUrgencyLow => 'ต่ำ';

  @override
  String get clinicUrgencyMedium => 'ปานกลาง';

  @override
  String get clinicUrgencyCritical => 'สำคัญ';

  @override
  String get healthTrendingTips => 'เคล็ดลับสุขภาพที่กำลังมาแรง';

  @override
  String get healthHumidityArticleTitle =>
      'การเตรียมฤดูหนาว: รักษาความชื้นให้สมดุล';

  @override
  String get healthHumidityArticleSubtitle =>
      'วิธีปกป้องต้นไม้ของคุณจากอากาศหม้อน้ำแห้งในช่วงเดือนที่มีอากาศหนาวเย็น';

  @override
  String get healthWeeklySpotlight => 'ผู้ป่วยและการเยียวยาประจำสัปดาห์';

  @override
  String get healthAphidTitle => 'เพลี้ยอ่อนรบกวน';

  @override
  String get healthAphidSubtitle =>
      'การแทรกแซงในระยะเริ่มต้นและการบำบัดน้ำมันสะเดาตามธรรมชาติ';

  @override
  String get healthDiscoverLoadError =>
      'ไม่สามารถโหลดเนื้อหา Discover ได้ในขณะนี้ ดึงลงเพื่อลองอีกครั้ง';

  @override
  String get healthDiscoverEmpty => 'ยังไม่มีเนื้อหาการค้นพบที่เผยแพร่';

  @override
  String get healthDiscoverRetry => 'ลองอีกครั้ง';

  @override
  String get lightMeterTitle => 'เครื่องวัดแสง';

  @override
  String get lightMeterInstructionTitle => 'เพื่อวัดแสง';

  @override
  String get lightMeterInstruction =>
      'หันกล้องด้านหน้าของโทรศัพท์ไปทาง\nตำแหน่งของพืชและแหล่งกำเนิดแสง';

  @override
  String get lightMeterCameraEstimate => 'ลักซ์โดยประมาณคำนวณจากข้อมูลกล้อง';

  @override
  String get lightMeterStabilizing => 'การวัดความเสถียร';

  @override
  String get lightMeterStabilizingRecommendation =>
      'ถือโทรศัพท์ให้นิ่งสักครู่ในขณะที่กรองการเปลี่ยนแปลงการรับแสงอย่างกะทันหัน';

  @override
  String get lightMeterUnavailable => 'การวัดไม่พร้อมใช้งาน';

  @override
  String get lightMeterUnavailableRecommendation =>
      'เปิดใช้งานการอนุญาตกล้องแล้วลองหน้าจอนี้อีกครั้ง';

  @override
  String get lightLow => 'แสงน้อย (ในร่ม)';

  @override
  String get lightMedium => 'ไฟปานกลาง (ห้องสว่าง)';

  @override
  String get lightHigh => 'แสงสูง (ใกล้หน้าต่าง)';

  @override
  String get lightVeryHigh => 'แสงสูงมาก (แสงแดดโดยตรง)';

  @override
  String get lightLowRecommendation => 'เหมาะสำหรับพืช Calathea เฟิร์น หรืองู';

  @override
  String get lightMediumRecommendation =>
      'เหมาะสำหรับ Monstera, Ficus และหน้าวัว';

  @override
  String get lightHighRecommendation =>
      'เหมาะสำหรับว่านหางจระเข้ กระบองเพชร และเจอเรเนียมที่ชอบแสงแดด';

  @override
  String get lightVeryHighRecommendation =>
      'เหมาะสำหรับพืชกลางแจ้งและพืชอวบน้ำ';

  @override
  String get homeLoadingPlants => 'กำลังโหลดพืช...';

  @override
  String get homeNotifications => 'การแจ้งเตือน';

  @override
  String get homeWateringTime => 'เวลารดน้ำ';

  @override
  String get homeWateringNotification => 'พืชในร่มของคุณต้องการการรดน้ำ';

  @override
  String get homeWelcome => 'ยินดีต้อนรับ!';

  @override
  String get homeWelcomeNotification =>
      'ยินดีต้อนรับสู่ Botaniq เริ่มต้นด้วยการเพิ่มโรงงานแรกของคุณ';

  @override
  String get homeTenMinutesAgo => '10 นาทีที่แล้ว';

  @override
  String get homeOneDayAgo => '1 วันที่ผ่านมา';

  @override
  String get homeQuickActions => 'การดำเนินการด่วน';

  @override
  String get homeIdentifyCamera => 'ระบุด้วยกล้องของคุณ';

  @override
  String get homeTomorrow => 'พรุ่งนี้';

  @override
  String get homeNoTasks => 'ไม่มีงานสำหรับวันนี้!';

  @override
  String get homeAllCared => 'ต้นไม้ของคุณได้รับการดูแลอย่างดี 🌿';

  @override
  String get homeOverdue => 'เกินกำหนด';

  @override
  String get homeInstructions => 'คำแนะนำ';

  @override
  String homeRequiredAmount(String amount) {
    return 'จำเป็น: $amount';
  }

  @override
  String get homeLater => 'ต่อมา';

  @override
  String get homeMarkDone => 'ทำเครื่องหมายว่าเสร็จสิ้น';

  @override
  String get homeSickPlants => 'คลินิกพืช';

  @override
  String homeSickCount(int count) {
    return '$count ไม่สบาย';
  }

  @override
  String get homeGreetingMorning => 'สวัสดีตอนเช้า';

  @override
  String get homeGreetingAfternoon => 'สวัสดีตอนบ่าย';

  @override
  String get homeGreetingEvening => 'สวัสดีตอนเย็น';

  @override
  String get homeTodayTasks => 'ภารกิจวันนี้';

  @override
  String get homeTomorrowTasks => 'ภารกิจพรุ่งนี้';

  @override
  String homeDateTasks(String date) {
    return '$date งาน';
  }

  @override
  String get commonSkip => 'ข้าม';

  @override
  String get commonContinue => 'ดำเนินการต่อ';

  @override
  String get commonClose => 'ปิด';

  @override
  String get commonDelete => 'ลบ';

  @override
  String get commonBack => 'กลับไป';

  @override
  String get commonUnknown => 'ไม่ทราบ';

  @override
  String get wizardSaveGarden => 'บันทึกและเพิ่มลงในสวน';

  @override
  String wizardPlantAdded(String name) {
    return '$name ถูกเพิ่มในสวนของคุณแล้ว! 🌿';
  }

  @override
  String get wizardRoomTitle => 'โรงงานของคุณอยู่ที่ไหน?';

  @override
  String get wizardRoomSubtitle =>
      'จัดหมวดหมู่โรงงานของคุณตามห้องเพื่อจัดการได้อย่างง่ายดาย';

  @override
  String get wizardLivingRoom => 'ห้องนั่งเล่น';

  @override
  String get wizardBedroom => 'ห้องนอน';

  @override
  String get wizardKitchen => 'ห้องครัว';

  @override
  String get wizardOffice => 'สำนักงาน';

  @override
  String get wizardBathroom => 'ห้องน้ำ';

  @override
  String get wizardBalcony => 'ระเบียง';

  @override
  String get wizardLightTitle => 'จุดนี้แสงเป็นยังไงบ้างคะ?';

  @override
  String get wizardLightSubtitle =>
      'แสงเป็นหนึ่งในปัจจัยที่สำคัญที่สุดสำหรับสุขภาพต้นไม้ของคุณ';

  @override
  String get wizardDirectSun => 'ตรงพระอาทิตย์';

  @override
  String get wizardDirectSunDescription =>
      'แสงแดดที่ไม่มีการกรองโดยตรงบนต้นไม้';

  @override
  String get wizardBrightIndirect => 'ทางอ้อมที่สดใส';

  @override
  String get wizardBrightIndirectDescription =>
      'ใกล้กับหน้าต่างหันหน้าไปทางทิศตะวันออกหรือทิศตะวันตก';

  @override
  String get wizardMediumLight => 'แสงปานกลาง';

  @override
  String get wizardMediumLightDescription => 'ห่างจากหน้าต่างไม่กี่ฟุต';

  @override
  String get wizardLowLight => 'แสงน้อย';

  @override
  String get wizardLowLightDescription => 'ห่างจากหน้าต่างหรือใต้แสงประดิษฐ์';

  @override
  String get wizardDistanceTitle => 'ระยะห่างจากหน้าต่าง';

  @override
  String get wizardDistanceSubtitle =>
      'เลือกระยะทางโดยประมาณไปยังหน้าต่างที่ใกล้ที่สุด';

  @override
  String get wizardMoreThanFiveMeters => 'มากกว่า 5 ม';

  @override
  String get wizardActiveHoursTitle => 'ชั่วโมงแสงที่ใช้งานอยู่';

  @override
  String get wizardActiveHoursSubtitle =>
      'จุดนี้ได้รับแสงโดยตรงหรือสว่างกี่ชั่วโมง?';

  @override
  String wizardHour(int count) {
    return '$count ชั่วโมง';
  }

  @override
  String wizardHours(int count) {
    return '$count ชั่วโมง';
  }

  @override
  String get wizardSixPlusHours => '6+ ชั่วโมง';

  @override
  String get wizardRepottedTitle =>
      'โรงงานแห่งนี้ได้รับการปลูกใหม่ครั้งล่าสุดเมื่อใด?';

  @override
  String get wizardRepottedSubtitle =>
      'ดินสดเป็นสิ่งสำคัญสำหรับพืชที่มีความสุข';

  @override
  String get wizardRecently => 'ล่าสุด (ต่ำกว่า 3 เดือน)';

  @override
  String get wizardSixMonthsAgo => '6 เดือนที่แล้ว';

  @override
  String get wizardOneYearAgo => '1 ปีที่ผ่านมา';

  @override
  String get wizardTwoYearsAgo => '2+ ปีที่แล้ว';

  @override
  String get wizardDontKnow => 'ฉันไม่รู้';

  @override
  String get wizardPotTitle => 'หม้อเป็นวัสดุอะไรคะ?';

  @override
  String get wizardPotSubtitle => 'วัสดุหม้อส่งผลต่อความแห้งเร็วของดิน';

  @override
  String get wizardPlasticPot => 'พลาสติก / เนอสเซอรี่';

  @override
  String get wizardTerracottaPot => 'ดินเผา';

  @override
  String get wizardCeramicPot => 'เซรามิก / เคลือบ';

  @override
  String get wizardMetalPot => 'โลหะ';

  @override
  String get wizardWateredTitle => 'คุณรดน้ำต้นไม้นี้ครั้งสุดท้ายเมื่อไหร่?';

  @override
  String get wizardWateredSubtitle =>
      'ซึ่งจะช่วยคำนวณเวลารดน้ำครั้งต่อไปที่แน่นอน';

  @override
  String get wizardToday => 'วันนี้';

  @override
  String get wizardYesterday => 'เมื่อวาน';

  @override
  String get wizardFewDaysAgo => 'ไม่กี่วันที่ผ่านมา';

  @override
  String get wizardWeekAgo => 'หนึ่งสัปดาห์ที่ผ่านมา';

  @override
  String get wizardMoreWeekAgo => 'มากกว่าหนึ่งสัปดาห์ที่ผ่านมา';

  @override
  String get historyTitle => 'ประวัติการค้นหา';

  @override
  String get historyClearTitle => 'ล้างประวัติ';

  @override
  String get historyClearMessage =>
      'ประวัติการค้นหาและการสแกนทั้งหมดจะถูกลบ คุณแน่ใจเหรอ?';

  @override
  String get historyClearTooltip => 'ล้างประวัติ';

  @override
  String get historyEmptyTitle => 'ไม่มีประวัติการค้นหา';

  @override
  String get historyEmptySubtitle =>
      'พืชที่สแกนด้วยกล้องหรือค้นหาจะปรากฏที่นี่';

  @override
  String get historyNoDetails => 'ไม่มีข้อมูลรายละเอียด';

  @override
  String get historyRegularWater => 'รดน้ำเป็นประจำ';

  @override
  String get historyIndirectLight => 'แสงทางอ้อม';

  @override
  String get historyDescription => 'คำอธิบาย';

  @override
  String get historyWatering => 'การรดน้ำ';

  @override
  String get historyLight => 'เบา';

  @override
  String get historyRecently => 'เมื่อเร็วๆ นี้';

  @override
  String historyMinutesAgo(int minutes) {
    return '$minutes นาทีที่แล้ว';
  }

  @override
  String historyHoursAgo(int hours) {
    return '$hours ชั่วโมงที่ผ่านมา';
  }

  @override
  String get historyYesterday => 'เมื่อวาน';

  @override
  String get historyPlantRecord => 'บันทึกการค้นหาพืช';

  @override
  String get photoWholeSpecimen => 'ภาพถ่ายทั้งหมด\nพืชหรือเห็ด';

  @override
  String get photoWholeSpecimenSubtitle =>
      'เก็บตัวอย่างทั้งหมดไว้ตรงกลางกรอบเพื่อการระบุตัวตนที่ดีขึ้น';

  @override
  String get photoCorrect => 'ถูกต้อง';

  @override
  String get photoTooClose => 'ใกล้เกินไป';

  @override
  String get photoInstructions => 'คำแนะนำ';

  @override
  String get photoOpenCamera => 'ฉันเข้าใจ เปิดกล้อง';

  @override
  String get scannerPlant => 'พืช';

  @override
  String get scannerMushroom => 'เห็ด';

  @override
  String get scannerIdentifyingPlant => 'ระบุพืช...';

  @override
  String get scannerIdentifyingMushroom => 'การระบุเห็ด...';

  @override
  String get scannerCapture => 'ถ่ายภาพและสแกน';

  @override
  String get scannerFailed => 'การสแกนล้มเหลว โปรดลองอีกครั้ง';

  @override
  String scannerError(String error) {
    return 'เกิดข้อผิดพลาด: $error';
  }

  @override
  String get scannerUnknownPlant => 'พืชที่ไม่รู้จัก';

  @override
  String get scannerUnknownMushroom => 'เห็ดที่ไม่รู้จัก';

  @override
  String get scheduleTitle => 'กำหนดการ';

  @override
  String get scheduleTodayTask => 'งานวันนี้';

  @override
  String get scheduleNoTasks => 'ไม่มีงานสำหรับวันนี้!';

  @override
  String get scheduleInstructions => 'คำแนะนำ';

  @override
  String scheduleRequired(String amount) {
    return 'จำเป็น: $amount';
  }

  @override
  String get scheduleRemindLater => 'เตือนทีหลัง';

  @override
  String get scheduleDone => 'เสร็จแล้ว';

  @override
  String get scheduleCareFallback => 'ดูแลพืชของคุณ';

  @override
  String get chatDoctorTitle => 'หมอพืช AI';

  @override
  String chatPatient(String name) {
    return 'คนไข้: $name';
  }

  @override
  String get chatAnalyzing => 'กำลังวิเคราะห์...';

  @override
  String chatHint(String name) {
    return 'ถามเกี่ยวกับ $name...';
  }

  @override
  String chatWelcome(String name) {
    return 'สวัสดี! 🌿 ฉันเป็น AI Plant Doctor ของคุณ ฉันจะช่วย $name ได้อย่างไร\n\nฉันสามารถวินิจฉัยรูปถ่ายหรือตอบคำถามการดูแลของคุณได้';
  }

  @override
  String chatContinueWelcome(String name) {
    return 'สวัสดี! มาต่อด้วย $name กันดีกว่า 🌱';
  }

  @override
  String get chatQuestionYellowing => 'ใบไม้เหลืองเกิดจากอะไร?';

  @override
  String get chatQuestionTreatment => 'ฉันจะรักษาพืชชนิดนี้ได้อย่างไร?';

  @override
  String get chatQuestionWatering => 'ควรเปลี่ยนความถี่ในการรดน้ำหรือไม่?';

  @override
  String get chatQuestionFertilizer => 'ฉันควรใช้ปุ๋ยชนิดใด?';

  @override
  String get chatPhotoSent => 'ส่งรูปภาพแล้ว';

  @override
  String get chatAnalyzePhoto => 'วิเคราะห์ภาพถ่าย';

  @override
  String get chatDiagnosisUnknown => 'ไม่สามารถระบุการวินิจฉัยได้';

  @override
  String get chatNoTreatment => 'ไม่มีคำแนะนำการรักษา';

  @override
  String get chatRecoveryUnknown => 'ไม่ทราบ';

  @override
  String get chatUnableIdentify => 'พืชที่ไม่ปรากฏชื่อ';

  @override
  String chatError(String error) {
    return 'ขออภัย เกิดข้อผิดพลาด: $error โปรดลองอีกครั้ง';
  }

  @override
  String get chatCareTips => 'เคล็ดลับการดูแล';

  @override
  String get chatPlantLabel => 'พืช';

  @override
  String get chatDiagnosisLabel => 'การวินิจฉัย';

  @override
  String get chatTreatmentLabel => 'การรักษา';

  @override
  String get chatUrgencyLabel => 'ความเร่งด่วน';

  @override
  String get chatRecoveryLabel => 'การกู้คืนโดยประมาณ';

  @override
  String get discoverMonsteraTitle => 'ความลับสู่การเติบโตของ Monstera';

  @override
  String get discoverIndoorPlants => 'พืชในร่ม';

  @override
  String get discoverSucculentWatering => 'คู่มือการรดน้ำสำหรับ Succulents';

  @override
  String get discoverCacti => 'กระบองเพชรและไม้อวบน้ำ';

  @override
  String get discoverHerbSoil => 'ชนิดของดินที่ดีที่สุดสำหรับสมุนไพร';

  @override
  String get discoverHerbs => 'สมุนไพร';

  @override
  String get discoverPropagation =>
      'การขยายพันธุ์ 101: คู่มือสำหรับผู้เริ่มต้น';

  @override
  String get discoverPests => 'สัตว์รบกวนที่พบบ่อยและวิธีการปฏิบัติต่อพวกมัน';

  @override
  String get discoverRepotting => 'การเติมใหม่: เมื่อไหร่และอย่างไร?';

  @override
  String discoverMinutesRead(int minutes) {
    return '$minutes อ่านนาที';
  }

  @override
  String get skip => 'ข้าม';

  @override
  String get skipForNow => 'ข้ามไปก่อน';

  @override
  String get continueLabel => 'ดำเนินการต่อ';

  @override
  String get getStarted => 'เริ่มต้นเลย';

  @override
  String get nextStep => 'ขั้นตอนต่อไป';

  @override
  String get maybeLater => 'อาจจะภายหลัง';

  @override
  String get emailAddress => 'ที่อยู่อีเมล';

  @override
  String get password => 'รหัสผ่าน';

  @override
  String get firstName => 'ชื่อ';

  @override
  String get lastName => 'นามสกุล';

  @override
  String get login => 'เข้าสู่ระบบ';

  @override
  String get signUp => 'ลงทะเบียน';

  @override
  String get welcomeBack => 'ยินดีต้อนรับกลับ';

  @override
  String get loginSubtitle => 'เข้าสู่ระบบเพื่อดูแลสวนของคุณต่อไป';

  @override
  String get signUpSubtitle =>
      'เข้าร่วมกับเราและเริ่มสร้างเขตรักษาพันธุ์สัตว์ป่าสีเขียวของคุณ';

  @override
  String get forgotPassword => 'ลืมรหัสผ่าน?';

  @override
  String get enterEmailPassword => 'กรุณากรอกอีเมล์และรหัสผ่านของคุณ';

  @override
  String get fillAllFields => 'กรุณากรอกข้อมูลให้ครบทุกช่อง';

  @override
  String authError(String error) {
    return 'มีข้อผิดพลาดเกิดขึ้น: $error';
  }

  @override
  String get loginWith => 'หรือเข้าสู่ระบบด้วย';

  @override
  String get signUpWith => 'หรือสมัครสมาชิกกับ';

  @override
  String get noAccount => 'ยังไม่มีบัญชี?';

  @override
  String get alreadyAccount => 'มีบัญชีอยู่แล้ว?';

  @override
  String get developerSession => 'สร้างเซสชันนักพัฒนา';

  @override
  String get welcomeBotaniq => 'ยินดีต้อนรับสู่ Botaniq';

  @override
  String get loginOptionsSubtitle =>
      'เข้าสู่ระบบหรือลงทะเบียนเพื่อสำรองข้อมูลโรงงาน ตารางเวลา และการตั้งค่าของคุณ';

  @override
  String get notificationAccessTitle => 'อย่าพลาดการรดน้ำ';

  @override
  String get notificationAccessSubtitle =>
      'เราจะเตือนคุณอย่างอ่อนโยนเมื่อถึงเวลาที่ต้องดูแลเพื่อนสีเขียวของคุณ การดูแลพืชทำได้อย่างง่ายดายและปราศจากความเครียด';

  @override
  String get notificationTurnOn => 'เปิดการช่วยเตือน';

  @override
  String get creatingClimate => 'กำลังวิเคราะห์สภาพอากาศขนาดเล็กของคุณ...';

  @override
  String get creatingSchedules => 'การปรับแต่งตารางการดูแล...';

  @override
  String get creatingSanctuary => 'เตรียมพื้นที่สีเขียวของคุณ...';

  @override
  String get locationAccessTitle => 'การเข้าถึงตำแหน่ง';

  @override
  String get locationAccessSubtitle =>
      'ปรับแต่งการดูแลพืชตามสภาพอากาศขนาดเล็กในท้องถิ่นของคุณ';

  @override
  String get locationRecommendation => 'คำแนะนำในท้องถิ่น';

  @override
  String get locationRecommendationSubtitle =>
      'พืชที่เจริญเติบโตในสภาพอากาศในพื้นที่ของคุณ';

  @override
  String get locationWeather => 'การซิงค์สภาพอากาศอัจฉริยะ';

  @override
  String get locationWeatherSubtitle =>
      'ตารางจะปรับตามปริมาณฝนในท้องถิ่นแบบเรียลไทม์';

  @override
  String get locationAlerts => 'การแจ้งเตือนน้ำค้างแข็งและความร้อน';

  @override
  String get locationAlertsSubtitle =>
      'รับการแจ้งเตือนก่อนที่สภาพอากาศจะรุนแรง';

  @override
  String get locationEnable => 'เปิดใช้งานการเข้าถึงตำแหน่ง';

  @override
  String get wherePlantsTitle => 'พืชของคุณอยู่ที่ไหน?';

  @override
  String get wherePlantsSubtitle =>
      'เลือกทั้งหมดที่เกี่ยวข้องเพื่อกำหนดตารางการดูแลของคุณ';

  @override
  String get locationIndoor => 'ในร่ม';

  @override
  String get locationIndoorSubtitle => 'ห้องนั่งเล่นห้องนอนสำนักงาน';

  @override
  String get locationBalcony => 'ระเบียง';

  @override
  String get locationBalconySubtitle => 'กระถางต้นไม้บนดาดฟ้าหรือระเบียง';

  @override
  String get locationGarden => 'สวน';

  @override
  String get locationGardenSubtitle => 'พืชในดินและแปลงดอกไม้';

  @override
  String get helpTitleBefore => 'สิ่งที่เราสามารถทำได้';

  @override
  String get helpTitleHighlight => 'ช่วยคุณ';

  @override
  String get helpTitleAfter => 'ด้วย?';

  @override
  String get helpSubtitle => 'เลือกหนึ่งเป้าหมายขึ้นไปเพื่อปรับแต่งสวนของคุณ';

  @override
  String get helpHeal => 'หายป่วย\nพืช';

  @override
  String get helpCare => 'การดูแล\nการแจ้งเตือน';

  @override
  String get helpIdentify => 'ระบุตัวตน\nสายพันธุ์';

  @override
  String get helpJournal => 'การเจริญเติบโต\nวารสาร';

  @override
  String get helpOther => 'อย่างอื่น';

  @override
  String get journeyTitle => 'การเดินทางสีเขียวของคุณ';

  @override
  String get journeySubtitle => 'เลือกระดับการดูแลที่คุณต้องการให้';

  @override
  String get journeyCasualLabel => 'ลำลอง';

  @override
  String get journeyCasualTitle => 'การบำรุงรักษาต่ำ';

  @override
  String get journeyCasualSubtitle =>
      'ฉันแค่อยากให้ต้นไม้ที่เรียบง่ายของฉันมีชีวิตและเจริญรุ่งเรือง';

  @override
  String get journeyEnthusiastLabel => 'ผู้กระตือรือร้น';

  @override
  String get journeyEnthusiastTitle => 'การดูแลที่สมดุล';

  @override
  String get journeyEnthusiastSubtitle =>
      'ฉันสนุกกับการใช้เวลาทุกสัปดาห์กับคอลเลกชั่นที่กำลังเติบโตของฉัน';

  @override
  String get journeyObsessedLabel => 'หมกมุ่น';

  @override
  String get journeyObsessedTitle => 'ผู้ปกครองพืชวิสามัญ';

  @override
  String get journeyObsessedSubtitle =>
      'ฉันใช้ชีวิตเพื่อต้นไม้ของฉัน และต้องการตารางเวลาของผู้เชี่ยวชาญสำหรับป่าในร่มของฉัน';

  @override
  String get masteryTitleBefore => 'คุณเป็นยังไงบ้าง';

  @override
  String get masteryTitleHighlight => 'สีเขียว\nนิ้วหัวแม่มือ';

  @override
  String get masteryTitleAfter => 'เมื่อเร็ว ๆ นี้?';

  @override
  String get masterySubtitle =>
      'บอกตรงๆ เราทุกคนเคยเป็น \"ฆาตกรต่อเนื่อง\" มาก่อน เลือกความเชี่ยวชาญในปัจจุบันของคุณ';

  @override
  String get masteryKiller => 'ฆาตกรต่อเนื่อง';

  @override
  String get masteryKillerSubtitle =>
      'แม้แต่ต้นไม้พลาสติกของฉันก็ดูกังวลเมื่อเข้าไปในห้อง';

  @override
  String get masteryAccidental => 'ผู้ปกครองโดยบังเอิญ';

  @override
  String get masteryAccidentalSubtitle =>
      'กระบองเพชรของฉันมีชีวิตอยู่ได้สองสัปดาห์ เรายังคงรู้จักกัน';

  @override
  String get masteryGrowth => 'ความคิดการเจริญเติบโต';

  @override
  String get masteryGrowthSubtitle =>
      'เพื่อนของฉันส่วนใหญ่มีใบไม้ ฉันรู้จัก Monsteras ของฉันจาก Pothos ของฉัน';

  @override
  String get masteryWhisperer => 'พืชกระซิบ';

  @override
  String get masteryWhispererSubtitle =>
      'ฉันเผยแพร่พืชหายากและพูดภาษาละตินด้านพฤกษศาสตร์ได้อย่างคล่องแคล่ว';

  @override
  String get onboardingOneTitle => 'ดูแล\nของพืชของคุณ';

  @override
  String get onboardingOneHighlight => 'เหมือนมือโปร';

  @override
  String get onboardingOneSubtitle =>
      'ตารางเวลาที่ชาญฉลาดและการระบุตัวตนทันทีสำหรับป่าในเมืองของคุณ';

  @override
  String get onboardingOneBadge => 'การดูแลที่ขับเคลื่อนด้วย AI';

  @override
  String get onboardingAiScan => 'เอไอสแกน';

  @override
  String get onboardingSmartWater => 'สมาร์ทวอเตอร์';

  @override
  String get onboardingLightTracking => 'การติดตามแสง';

  @override
  String get onboardingTwoTitle => 'ระบุใด ๆ\nปลูกใน';

  @override
  String get onboardingTwoHighlight => 'วินาที';

  @override
  String get onboardingTwoSubtitle =>
      'ถ่ายภาพเพื่อทราบชื่อ สายพันธุ์ และข้อกำหนดในการดูแล';

  @override
  String get onboardingTwoBadge => 'ผู้เชี่ยวชาญด้านพฤกษศาสตร์';

  @override
  String get onboardingSnapPhoto => 'ถ่ายภาพ';

  @override
  String get onboardingAccurateResult => 'ผลลัพธ์ที่แม่นยำ';

  @override
  String get onboardingPlantWiki => 'วิกิพืช';

  @override
  String get onboardingThreeTitle => 'ไม่เคยลืม\nสู่น้ำ';

  @override
  String get onboardingThreeHighlight => 'อีกครั้ง';

  @override
  String get onboardingThreeSubtitle =>
      'รับการแจ้งเตือนตามเวลาตามความต้องการและสภาพแวดล้อมของโรงงานของคุณ';

  @override
  String get onboardingThreeBadge => 'ตารางสมาร์ท';

  @override
  String get onboardingReminders => 'การแจ้งเตือน';

  @override
  String get onboardingClimateData => 'ข้อมูลสภาพภูมิอากาศ';

  @override
  String get onboardingHealthyGrowth => 'การเจริญเติบโตที่ดี';

  @override
  String get onboardingCommunity => 'เข้าร่วมกับพ่อแม่พันธุ์พืชกว่า 50,000 ราย';

  @override
  String get onboardingAgreement =>
      'การดำเนินการต่อแสดงว่าคุณยอมรับข้อกำหนดและนโยบายความเป็นส่วนตัวของเรา';

  @override
  String get termsTitle => 'ข้อกำหนดและนโยบาย';

  @override
  String get termsUpdated => 'อัปเดตล่าสุด: กรกฎาคม 2026';

  @override
  String get termsUseTitle => '1. ข้อกำหนดการใช้งาน';

  @override
  String get termsUseBody =>
      'การเข้าถึงหรือใช้ Botaniq แสดงว่าคุณยอมรับข้อกำหนดการใช้งานและกฎหมายที่บังคับใช้ หากคุณไม่ตกลงคุณไม่สามารถใช้บริการได้';

  @override
  String get termsPrivacyTitle => '2. ความเป็นส่วนตัวของผู้ใช้';

  @override
  String get termsPrivacyBody =>
      'เรารวบรวมเฉพาะข้อมูลส่วนบุคคลที่จำเป็นในการจัดตารางการดูแลพืชที่ปรับให้เหมาะสม เราไม่ขายข้อมูลส่วนบุคคลของคุณให้กับบุคคลที่สาม';

  @override
  String get termsContentTitle => '3. Your Content and License to Us';

  @override
  String get termsContentBody =>
      'You keep ownership of the photos, notes, and other content you submit. By submitting content you grant us a worldwide, royalty-free, non-exclusive, sublicensable license to host, store, reproduce, analyze, and use it to operate, secure, and improve Botaniq (including improving plant identification, diagnosis, and other AI-assisted features), for as long as we hold the content. You are responsible for having the right to share whatever you upload.';

  @override
  String get termsRetentionTitle => '4. Account Deletion and Data Retention';

  @override
  String get termsRetentionBody =>
      'Requesting account deletion in the app anonymizes your account: your name, email, and profile photo are permanently removed and cannot be reattached to your identity, while your sign-in and remaining app data stay linked to the same anonymized account so you can keep using it if you sign in again. We may retain data — including in anonymized, aggregated, or backup form — for as long as needed for security, fraud-prevention, legal, accounting, or dispute-resolution purposes, even after a deletion request, to the fullest extent permitted by applicable law.';

  @override
  String get termsPlantTitle => '3. ข้อมูลพืช';

  @override
  String get termsPlantBody =>
      'ข้อมูลการดูแลพืช การจำแนก และการวินิจฉัยมีไว้เพื่อวัตถุประสงค์ในการให้ข้อมูล ผลลัพธ์ของ AI อาจไม่ถูกต้องเสมอไป ดังนั้นให้สังเกตโรงงานของคุณและค้นหาผู้เชี่ยวชาญเกี่ยวกับความเสี่ยงร้ายแรง';

  @override
  String get termsLiabilityTitle => '6. Disclaimers, Liability, and Indemnity';

  @override
  String get termsLiabilityBody =>
      'Botaniq is provided \"as is\" and \"as available,\" without warranties of any kind, express or implied, including accuracy, reliability, or fitness for a particular purpose. To the fullest extent permitted by law, we and our service providers are not liable for any indirect, incidental, special, or consequential damages, or for any loss of data, plants, or property arising from your use of the service, and our total liability for any claim is limited to the amount you paid us, if any, in the twelve months before the claim. You agree to indemnify and hold us harmless from claims arising from your use of the service, your content, or your violation of these Terms or applicable law.';

  @override
  String get termsPremiumTitle => '4. การสมัครสมาชิกแบบพรีเมียม';

  @override
  String get termsPremiumBody =>
      'การสมัครสมาชิกพรีเมียมรายเดือนหรือรายปีของคุณจะถูกเรียกเก็บเงินจากบัญชี Apple หรือ Google ของคุณหลังจากยืนยันการซื้อ จะต่ออายุโดยอัตโนมัติเว้นแต่จะยกเลิกอย่างน้อย 24 ชั่วโมงก่อนที่ช่วงเวลาปัจจุบันจะสิ้นสุดลง คุณสามารถจัดการหรือยกเลิกได้ในการตั้งค่าบัญชีร้านค้าของคุณ การขอคืนเงินได้รับการจัดการภายใต้นโยบายร้านค้าที่เกี่ยวข้อง';

  @override
  String get termsLawTitle => '8. Governing Law and Changes';

  @override
  String get termsLawBody =>
      'These Terms are governed by the laws of the jurisdiction in which we operate, without regard to conflict-of-law principles, and any dispute will be resolved under that jurisdiction\'s applicable procedures to the fullest extent permitted by law. We may update these Terms and our data practices at any time by posting the revised version in the app.';

  @override
  String get termsClosing =>
      'เพลิดเพลินไปกับความสงบของจิตใจและพืชพรรณที่มีความสุขมากขึ้น';

  @override
  String get weatherTitle => 'สภาพอากาศ';

  @override
  String get weatherSunnyTip => 'วันนี้แดดออก—ตรวจสอบดินก่อนรดน้ำ';

  @override
  String get weatherCloudyTip =>
      'สภาพอากาศที่มีเมฆมากจะทำให้การระเหยช้าลง น้ำน้อยลงเล็กน้อย';

  @override
  String get weatherRainyTip =>
      'ฝนตกและชื้น หลีกเลี่ยงการรดน้ำต้นไม้กลางแจ้งมากเกินไป';

  @override
  String get weatherStormTip =>
      'สภาพอากาศที่มีพายุ—ย้ายกระถางที่ละเอียดอ่อนไปยังจุดกำบัง';

  @override
  String get weatherSnowTip =>
      'หนาวเย็นและมีหิมะตก—ปกป้องพืชจากการเปลี่ยนแปลงของอุณหภูมิ';
}
