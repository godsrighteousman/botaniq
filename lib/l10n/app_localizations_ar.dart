// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'Botaniq';

  @override
  String get settings => 'الإعدادات';

  @override
  String get preferences => 'التفضيلات';

  @override
  String get darkMode => 'الوضع المظلم';

  @override
  String get metricSystem => 'النظام المتري';

  @override
  String get metricSystemSubtitle => 'استخدام مئوية وعدادات';

  @override
  String get account => 'الحساب';

  @override
  String get editProfile => 'تحرير الملف الشخصي';

  @override
  String get changePassword => 'تغيير كلمة المرور';

  @override
  String get subscriptionManagement => 'إدارة الاشتراكات';

  @override
  String get premium => 'قسط';

  @override
  String get language => 'اللغة';

  @override
  String get languageSubtitle => 'تغيير لغة التطبيق';

  @override
  String get selectLanguage => 'اختر اللغة';

  @override
  String get systemLanguage => 'لغة النظام';

  @override
  String get english => 'الإنجليزية';

  @override
  String get turkish => 'تركية';

  @override
  String get languageChanged => 'تم تغيير اللغة بنجاح.';

  @override
  String get languageSearchHint => 'لغات البحث';

  @override
  String get languageRecommended => 'موصى به';

  @override
  String get languageWelcomeTitle => 'اختر لغتك';

  @override
  String get languageWelcomeSubtitle =>
      'حدد اللغة التي تريد استخدامها في Botaniq. يمكنك تغييره في أي وقت.';

  @override
  String get languageUseSystem => 'استخدم لغة الجهاز';

  @override
  String get preferenceSystem => 'استخدام إعداد النظام';

  @override
  String get themeLight => 'ضوء';

  @override
  String get themeDark => 'الظلام';

  @override
  String get themeSelectionTitle => 'اختر المظهر';

  @override
  String get measurementMetric => 'متري';

  @override
  String get measurementImperial => 'إمبراطوري';

  @override
  String get measurementSelectionTitle => 'اختر نظام القياس';

  @override
  String get settingsSubtitle =>
      'قم بتشكيل Botaniq حول إيقاع الرعاية الخاص بك.';

  @override
  String get settingsLocalPreference => 'تم الحفظ على هذا الجهاز';

  @override
  String get settingsDarkModeSubtitle =>
      'لوحة أكثر هدوءًا للحظات الإضاءة المنخفضة';

  @override
  String get settingsAccountSubtitle => 'الهوية والوصول والعضوية';

  @override
  String get settingsEditProfileSubtitle => 'الاسم والموقع وتفضيلات الرعاية';

  @override
  String get settingsPasswordSubtitle =>
      'أرسل رابط إعادة تعيين آمن إلى بريدك الإلكتروني';

  @override
  String get settingsSubscriptionSubtitle => 'الخطة المميزة وتفاصيل الفواتير';

  @override
  String get settingsPasswordResetSent =>
      'تم إرسال البريد الإلكتروني لإعادة تعيين كلمة المرور.';

  @override
  String get settingsComingSoon => 'هذه المساحة لا تزال تنمو.';

  @override
  String get subscriptionPageTitle => 'العضوية المميزة';

  @override
  String get subscriptionHeroEyebrow => 'BOTANIQ PREMIUM';

  @override
  String get subscriptionHeroTitle => 'رعاية أكثر ذكاءً لكل نبات';

  @override
  String get subscriptionHeroSubtitle =>
      'أطلق العنان لكل أداة رعاية متميزة وقم بتنمية مساحتك الخضراء بثقة.';

  @override
  String get subscriptionBenefitsTitle => 'كل شيء في بريميوم';

  @override
  String get subscriptionBenefitIdentification =>
      'تحديد غير محدود للنباتات والتحليل الصحي';

  @override
  String get subscriptionBenefitCare => 'خطط الرعاية الشخصية والتذكيرات';

  @override
  String get subscriptionBenefitInsights =>
      'محتوى الخبراء ورؤى الرعاية المتقدمة';

  @override
  String get subscriptionMonthlyPlan => 'شهريا';

  @override
  String get subscriptionAnnualPlan => 'سنوي';

  @override
  String subscriptionPerMonth(String price) {
    return '$price / شهر';
  }

  @override
  String subscriptionPerYear(String price) {
    return '$price / سنة';
  }

  @override
  String get subscriptionBestValue => 'أفضل قيمة';

  @override
  String subscriptionSavePercent(int percent) {
    return 'حفظ $percent%';
  }

  @override
  String get subscriptionContinue => 'فتح بريميوم';

  @override
  String get subscriptionRestorePurchases => 'استعادة المشتريات';

  @override
  String get subscriptionRestoring => 'جارٍ الاستعادة...';

  @override
  String get subscriptionManage => 'إدارة الاشتراك';

  @override
  String get subscriptionActiveTitle => 'عضويتك المميزة نشطة';

  @override
  String get subscriptionActiveSubtitle => 'لديك حق الوصول إلى كل ميزة متميزة.';

  @override
  String subscriptionRenewsOn(String date) {
    return 'يتم التجديد في $date';
  }

  @override
  String subscriptionExpiresOn(String date) {
    return 'نشط حتى $date';
  }

  @override
  String get subscriptionAutoRenewDisclosure =>
      'يتم تحميل الدفع على حساب Apple أو Google الخاص بك. يتم تجديد الاشتراك تلقائيًا ما لم يتم إلغاؤه قبل 24 ساعة على الأقل من نهاية الفترة الحالية. ويمكنك إدارتها أو إلغاؤها في أي وقت من خلال إعدادات حساب المتجر الخاص بك.';

  @override
  String get subscriptionTermsLink => 'شروط الاستخدام';

  @override
  String get subscriptionPrivacyLink => 'سياسة الخصوصية';

  @override
  String get subscriptionPurchaseSuccess => 'عضويتك المميزة نشطة الآن.';

  @override
  String get subscriptionRestoreSuccess => 'تمت استعادة عضويتك المميزة.';

  @override
  String get subscriptionNothingToRestore =>
      'لم يتم العثور على عضوية نشطة لحساب المتجر هذا.';

  @override
  String get subscriptionPaymentPending =>
      'الدفع في انتظار موافقة المتجر. سيتم تفعيل عضويتك تلقائيا بمجرد الموافقة عليها.';

  @override
  String get subscriptionErrorGeneric =>
      'لا يمكن إكمال العملية. يرجى المحاولة مرة أخرى.';

  @override
  String get subscriptionErrorNetwork =>
      'تحقق من اتصالك بالإنترنت وحاول مرة أخرى.';

  @override
  String get subscriptionErrorNotAllowed =>
      'غير مسموح لهذا الجهاز أو حساب المتجر بإجراء عمليات شراء.';

  @override
  String get subscriptionErrorStore =>
      'لا يمكن الوصول إلى المتجر. يرجى المحاولة مرة أخرى قريبا.';

  @override
  String get subscriptionMissingConfiguration =>
      'مفتاح RevenueCat مفقود من هذا الإصدار.';

  @override
  String get subscriptionUnsupported =>
      'الاشتراكات متاحة فقط في تطبيقات iOS وAndroid.';

  @override
  String get subscriptionProductsUnavailable =>
      'لا يمكن تحميل المنتجات الشهرية والسنوية. تحقق من تكوين عرض RevenueCat.';

  @override
  String get subscriptionRetry => 'حاول مرة أخرى';

  @override
  String get subscriptionFree => 'مجاني';

  @override
  String get homeGoodMorning => 'مرحبًا،';

  @override
  String homePersonalGreeting(String greeting, String name) {
    return '$greeting، $name 👋';
  }

  @override
  String get homeEmptyGarden => 'حديقتك فارغة';

  @override
  String get homeEmptyGardenSubtitle =>
      'ابدأ في بناء ملاذك الأخضر\nعن طريق إضافة مصنعك الأول.';

  @override
  String get homeAddFirstPlant => 'أضف النبات الأول';

  @override
  String get homeMyPlants => 'نباتاتي';

  @override
  String get homeViewAll => 'عرض الكل';

  @override
  String get homeSmartCareReminders => 'تذكيرات الرعاية الذكية';

  @override
  String get homeWatering => 'سقي';

  @override
  String get homeWateringSubtitle => 'تتبع التربة';

  @override
  String get homeFertilizing => 'التسميد';

  @override
  String get homeFertilizingSubtitle => 'تنبيهات غذائية';

  @override
  String get gardenTitle => 'حديقتي';

  @override
  String get gardenAllPlants => 'جميع النباتات';

  @override
  String get gardenNeedsWater => 'يحتاج إلى الماء';

  @override
  String get gardenIndoor => 'داخلي';

  @override
  String get gardenNoPlants =>
      'لا توجد نباتات بعد.\nاضغط على + لإضافة مصنعك الأول!';

  @override
  String get gardenNoPlantsCategory => 'لا توجد نباتات في هذه الفئة.';

  @override
  String get discoverTitle => 'اكتشف';

  @override
  String get discoverSearchHint => 'بحث عن النباتات والمقالات والأدلة ...';

  @override
  String get discoverLatestArticles => 'أحدث المقالات';

  @override
  String get discoverSeeAll => 'شاهد الكل';

  @override
  String get discoverTrendingGuides => 'أدلة تتجه';

  @override
  String get healthyTitle => 'مركز الرعاية';

  @override
  String get healthySubtitle => 'المس روح نباتاتك وتحدث معهم.';

  @override
  String get healthyTabDoctor => 'دكتور';

  @override
  String get healthyTabHospital => 'مستشفى';

  @override
  String get healthyTabDiscover => 'اكتشف';

  @override
  String get profileTitle => 'ملفي الشخصي';

  @override
  String get profileEditProfile => 'تحرير الملف الشخصي';

  @override
  String get profileOverview => 'نظرة عامة';

  @override
  String get profileSettingsTab => 'الإعدادات';

  @override
  String get profileGardenerLevel => 'مستوى البستاني';

  @override
  String get profileTotalPlants => 'مجموع النباتات';

  @override
  String get profileCompletedTasks => 'المهام المكتملة';

  @override
  String get profileWeeklyActivity => 'نشاط الرعاية الأسبوعية';

  @override
  String get profileGeneral => 'عام';

  @override
  String get profileAppSettings => 'إعدادات التطبيق';

  @override
  String get profileNotificationPrefs => 'تفضيلات الإخطار';

  @override
  String get profileSupportLegal => 'الدعم والشؤون القانونية';

  @override
  String get profileHelpCenter => 'مركز المساعدة';

  @override
  String get profileTerms => 'شروط الاستخدام والسياسات';

  @override
  String get profileSignOut => 'تسجيل الخروج';

  @override
  String get profileDeleteAccount => 'حذف الحساب';

  @override
  String get profileSubtitle => 'قصة حديقتك والتقدم والمساحة الشخصية.';

  @override
  String get profileGardenPassport => 'جواز سفر للحديقة';

  @override
  String get profileThisWeek => 'هذا الاسبوع';

  @override
  String get profileQuietWeek => 'أسبوع هادئ - ستظهر هنا لحظة الرعاية التالية.';

  @override
  String get profileActiveWeek => 'إيقاع الرعاية الخاص بك حي ومتنامي.';

  @override
  String get profileAppSettingsSubtitle =>
      'اللغة والوحدات واتصال الذكاء الاصطناعي';

  @override
  String get profileNotificationPrefsSubtitle =>
      'اختر لحظات الرعاية التي تصل إليك';

  @override
  String get profileHelpCenterSubtitle => 'الإجابات والتوجيه السريع';

  @override
  String get profileTermsSubtitle => 'الخصوصية والشروط والسياسات';

  @override
  String get profileAccountActions => 'إجراءات الحساب';

  @override
  String get profileSignOutQuestion => 'هل أنت متأكد أنك تريد تسجيل الخروج؟';

  @override
  String get profileDeleteAccountWarning =>
      'يحتاج حذف الحساب إلى تأكيد آمن من جانب الخادم. لم يتم تغيير البيانات الخاصة بك.';

  @override
  String get cancel => 'إلغاء';

  @override
  String get continueAction => 'متابعة';

  @override
  String get profileTitleNew => 'البستاني الجديد 🌱';

  @override
  String get profileTitleSprout => 'الصديق المنبت 🌿';

  @override
  String get profileTitleLeaf => 'عاشق الأوراق ☘️';

  @override
  String get profileTitleSkilled => 'بستاني ماهر 🏡';

  @override
  String get profileTitleMaster => 'سيد الإبهام الأخضر 👑';

  @override
  String get profileNextLevelStart =>
      'أضف نباتك الأول وابدأ مغامرة البستنة الخاصة بك!';

  @override
  String profileNextLevelLeaf(int count) {
    return 'لم يتبق سوى نباتات $count لتصبح عاشقة للأوراق.';
  }

  @override
  String profileNextLevelSkilled(int count) {
    return 'لم يتبق سوى نباتات $count لتصبح بستانيًا ماهرًا.';
  }

  @override
  String profileNextLevelMaster(int count) {
    return 'لم يتبق سوى نباتات $count لتصبح Green Thumb Master.';
  }

  @override
  String get profileNextLevelMax => 'أنت في أعلى حديقتك، تهانينا!';

  @override
  String get navHome => 'الصفحة الرئيسية';

  @override
  String get navGarden => 'حديقة';

  @override
  String get navClinic => 'عيادة';

  @override
  String get navProfile => 'الملف الشخصي';

  @override
  String get scanPlant => 'مصنع المسح';

  @override
  String get deletePlantTitle => 'إزالة هذا النبات؟';

  @override
  String get deletePlantMessage =>
      'ستتم إزالة المصنع ومهام الرعاية الخاصة به وسجلات العيادة نهائيًا من حسابك.';

  @override
  String get deletePlantAction => 'إزالة النبات';

  @override
  String get deletePlantNotFound =>
      'لا يمكن العثور على النبات أو تمت إزالته بالفعل.';

  @override
  String deletePlantError(String error) {
    return 'لا يمكن إزالة النبات: $error';
  }

  @override
  String get profileChoosePhoto => 'اختر صورة الملف الشخصي';

  @override
  String get profileFullName => 'الاسم الكامل';

  @override
  String get profileFullNameHint => 'أدخل اسمك الكامل';

  @override
  String get profileNickname => 'اللقب';

  @override
  String get profileNicknameHint => 'كيف يجب أن نتصل بك؟';

  @override
  String get profileAge => 'العمر';

  @override
  String get profileAgeHint => '1-120';

  @override
  String get profileAgeValidation => 'الرجاء إدخال العمر بين 1 و 120.';

  @override
  String profileLoadError(String error) {
    return 'تعذر تحميل الملف الشخصي: $error';
  }

  @override
  String get languageEnglish => 'الإنجليزية';

  @override
  String get languageTurkish => 'تركي';

  @override
  String get profileEmailReadOnly => 'عنوان البريد الإلكتروني (للقراءة فقط)';

  @override
  String get profileEmailHint => 'أدخل بريدك الإلكتروني';

  @override
  String get profileLocation => 'الموقع';

  @override
  String get profileLocationHint => 'المدينة، البلد';

  @override
  String get profileSaveChanges => 'حفظ التغييرات';

  @override
  String get profileUpdated => 'تم تحديث ملفك الشخصي.';

  @override
  String profileSaveError(String error) {
    return 'لا يمكن حفظ الملف الشخصي: $error';
  }

  @override
  String get notificationWateringTitle => 'تذكيرات الري';

  @override
  String get notificationWateringSubtitle =>
      'احصل على إشعار عندما يحين وقت الماء';

  @override
  String get notificationFertilizerTitle => 'تذكير الأسمدة';

  @override
  String get notificationFertilizerSubtitle =>
      'تنبيهات التغذية الموسمية للنباتات الخاصة بك';

  @override
  String get notificationTitle => 'الإخطارات';

  @override
  String get notificationPlantCareAlerts => 'تنبيهات العناية بالنباتات';

  @override
  String get notificationOther => 'إشعارات أخرى';

  @override
  String get notificationWeatherTitle => 'تنبيهات الطقس';

  @override
  String get notificationWeatherSubtitle => 'تحذيرات الطقس المتطرفة';

  @override
  String get notificationArticlesTitle => 'مقالات جديدة';

  @override
  String get notificationArticlesSubtitle => 'نصائح وحيل لحديقتك';

  @override
  String get gardenMyPlantFallback => 'نباتى';

  @override
  String get gardenClinicBadge => 'في العيادة';

  @override
  String get wateringNever => 'آخر سقي: أبدا';

  @override
  String wateringLastDate(String date) {
    return 'آخر سقي: $date';
  }

  @override
  String wateringInterval(int days) {
    return 'كل $days أيام';
  }

  @override
  String get wateringNeverDue => 'لم يتم سقيها بعد • الماء اليوم';

  @override
  String wateringOverdue(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'متأخر $days يوم',
      many: 'متأخر $days يومًا',
      few: 'متأخر $days أيام',
      two: 'متأخر يومين',
      one: 'متأخر يومًا واحدًا',
      zero: 'اسقِ اليوم',
    );
    return '$_temp0';
  }

  @override
  String get wateringDueToday => 'الماء اليوم';

  @override
  String get wateringDueTomorrow => 'الماء غدا';

  @override
  String wateringDueInDays(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'اسقِ بعد $days يوم',
      many: 'اسقِ بعد $days يومًا',
      few: 'اسقِ بعد $days أيام',
      two: 'اسقِ بعد يومين',
      one: 'اسقِ بعد يوم واحد',
      zero: 'اسقِ اليوم',
    );
    return '$_temp0';
  }

  @override
  String get plantUnknown => 'نبات غير معروف';

  @override
  String get plantSpeciesFallback => 'الأنواع النباتية';

  @override
  String get plantDifficultyMedium => 'متوسط';

  @override
  String get plantAbout => 'حول';

  @override
  String get plantLocationEnvironment => 'الموقع والبيئة';

  @override
  String get plantCareProtocol => 'بروتوكول الرعاية';

  @override
  String get plantCareHistory => 'تاريخ الرعاية لآخر 10 أيام';

  @override
  String get plantHealthy => 'صحي';

  @override
  String get plantInClinic => 'في العيادة';

  @override
  String get plantDifficulty => 'صعوبة';

  @override
  String get plantToxicity => 'السمية';

  @override
  String get plantEnvironment => 'البيئة';

  @override
  String get plantLightNeed => 'حاجة خفيفة';

  @override
  String get plantToxicPets => 'سامة للحيوانات الأليفة';

  @override
  String get plantNonToxic => 'غير سامة';

  @override
  String get plantIndoor => 'داخلي';

  @override
  String get plantBrightIndirect => 'مشرق غير مباشر';

  @override
  String get plantInfoUnavailable =>
      'المعلومات التي تم التحقق منها ليست متاحة بعد.';

  @override
  String get plantIdealClimate => 'المناخ المثالي';

  @override
  String get plantHumidity => 'الرطوبة';

  @override
  String get plantTemperatureRange => 'نطاق درجة الحرارة';

  @override
  String get plantWateringFrequency => 'تردد الري';

  @override
  String plantWateringFrequencyValue(String interval) {
    return 'الماء $interval.';
  }

  @override
  String get plantNextWatering => 'الري التالي';

  @override
  String get plantWateringProtocol => 'بروتوكول الري';

  @override
  String get plantSoilProtocol => 'التربة';

  @override
  String get plantFeedingProtocol => 'بروتوكول التغذية';

  @override
  String get plantPruningCleaning => 'التقليم والتنظيف';

  @override
  String get plantPruningFallback =>
      'مسح الأوراق شهريا. تقليم الأوراق الميتة أو الصفراء لتشجيع النمو.';

  @override
  String get plantHistoryEmpty => 'لا يوجد سجل رعاية لآخر 10 أيام.';

  @override
  String get plantWateringTask => 'سقي';

  @override
  String get plantFertilizingTask => 'التسميد';

  @override
  String get plantWateredAction => 'يسقى ✓';

  @override
  String get plantWaterNowAction => 'الماء الآن';

  @override
  String get plantFertilizedAction => 'مخصبة ✓';

  @override
  String get plantFertilizeAction => 'تسميد';

  @override
  String get plantAddGardenAction => 'أضف إلى حديقتي';

  @override
  String get plantWaterSuccess => '💧 لقد سقيت نباتك! عمل عظيم!';

  @override
  String get plantFertilizeSuccess => '🌱 تمت إضافة الأسمدة! مصنعك يقول شكرا!';

  @override
  String plantWaterError(String error) {
    return 'لا يمكن حفظ الري: $error';
  }

  @override
  String plantFertilizeError(String error) {
    return 'لا يمكن حفظ التسميد: $error';
  }

  @override
  String get clinicQuickTools => 'أدوات سريعة';

  @override
  String get clinicDoctorHero => 'دكتور النبات بالذكاء الاصطناعي\nفي خدمتكم';

  @override
  String get clinicStartConsultation => 'ابدأ الاستشارة';

  @override
  String get clinicChoosePlant => 'ما النبات الذي ترغب في مناقشته؟';

  @override
  String get clinicChoosePlantSubtitle =>
      'اختر نباتًا من حديقتك أو التقط صورة جديدة.';

  @override
  String get clinicNoGardenPlants =>
      'لا توجد نباتات في حديقتك بعد.\nابدأ بالتقاط صورة جديدة.';

  @override
  String get clinicNewPhoto => 'التقط صورة جديدة';

  @override
  String get clinicNewPhotoSubtitle =>
      'تصوير النبات المريض والحصول على التشخيص';

  @override
  String get clinicPestAnalysis => 'تحليل الآفات';

  @override
  String get clinicVisualDiagnosis => 'التشخيص البصري';

  @override
  String get clinicLightMeter => 'مقياس الضوء';

  @override
  String get clinicSensorSimulation => 'محاكاة الاستشعار';

  @override
  String get clinicTitle => 'عيادة النبات';

  @override
  String clinicSickCount(int count) {
    return '$count مريض';
  }

  @override
  String get clinicAllHealthy => 'جميع نباتاتك صحية! 🌿';

  @override
  String get clinicEmpty =>
      'لا توجد نباتات مريضة في العيادة.\nإذا كنت قلقًا بشأن النبات،\nاسأل من علامة التبويب \"الطبيب\".';

  @override
  String get clinicUnknown => 'غير معروف';

  @override
  String get clinicPendingDiagnosis => 'في انتظار التشخيص';

  @override
  String get clinicNoTreatment => 'لم يتم تحديد العلاج';

  @override
  String get clinicPrescription => 'وصفة طبية:';

  @override
  String get clinicRecovery => 'التعافي';

  @override
  String get clinicRecovered => 'تعافى';

  @override
  String get clinicContinue => 'متابعة';

  @override
  String get clinicRecoveredSuccess => '🎉 نبتتك أصبحت صحية مرة أخرى!';

  @override
  String get clinicUrgencyLow => 'منخفض';

  @override
  String get clinicUrgencyMedium => 'متوسط';

  @override
  String get clinicUrgencyCritical => 'حرجة';

  @override
  String get healthTrendingTips => 'تتجه النصائح الصحية';

  @override
  String get healthHumidityArticleTitle =>
      'الاستعداد لفصل الشتاء: الحفاظ على توازن الرطوبة';

  @override
  String get healthHumidityArticleSubtitle =>
      'كيفية حماية نباتاتك من هواء المبرد الجاف خلال الأشهر الباردة';

  @override
  String get healthWeeklySpotlight => 'المريض وعلاج الأسبوع';

  @override
  String get healthAphidTitle => 'غزو المن';

  @override
  String get healthAphidSubtitle => 'التدخل المبكر والعلاج الطبيعي بزيت النيم.';

  @override
  String get healthDiscoverLoadError =>
      'تعذر تحميل محتوى الاكتشاف الآن. اسحب لأسفل للمحاولة مرة أخرى.';

  @override
  String get healthDiscoverEmpty => 'لا يوجد محتوى اكتشاف منشور حتى الآن.';

  @override
  String get healthDiscoverRetry => 'حاول مرة أخرى';

  @override
  String get lightMeterTitle => 'مقياس الضوء';

  @override
  String get lightMeterInstructionTitle => 'لقياس الضوء';

  @override
  String get lightMeterInstruction =>
      'قم بتوجيه الكاميرا الأمامية للهاتف نحوها\nموقع النبات ومصدر الضوء.';

  @override
  String get lightMeterCameraEstimate =>
      'يتم حساب اللوكس التقريبي من بيانات الكاميرا';

  @override
  String get lightMeterStabilizing => 'قياس الاستقرار';

  @override
  String get lightMeterStabilizingRecommendation =>
      'أمسك الهاتف بثبات لبضع ثوانٍ أثناء تصفية التغييرات المفاجئة في التعريض الضوئي.';

  @override
  String get lightMeterUnavailable => 'القياس غير متوفر';

  @override
  String get lightMeterUnavailableRecommendation =>
      'قم بتمكين إذن الكاميرا وحاول استخدام هذه الشاشة مرة أخرى.';

  @override
  String get lightLow => 'الإضاءة المنخفضة (الظل)';

  @override
  String get lightMedium => 'ضوء متوسط (غرفة مشرقة)';

  @override
  String get lightHigh => 'الإضاءة العالية (بالقرب من النافذة)';

  @override
  String get lightVeryHigh => 'ضوء عالي جدًا (الشمس المباشرة)';

  @override
  String get lightLowRecommendation =>
      'مناسبة لنباتات كالاتيا أو السرخس أو الثعبان.';

  @override
  String get lightMediumRecommendation =>
      'مثالية لمونستيرا واللبخ والأنثوريوم.';

  @override
  String get lightHighRecommendation =>
      'مناسب للصبار والصبار وإبرة الراعي المحبة للشمس.';

  @override
  String get lightVeryHighRecommendation =>
      'الأفضل للنباتات الخارجية والعصارة.';

  @override
  String get homeLoadingPlants => 'جارٍ تحميل النباتات...';

  @override
  String get homeNotifications => 'الإخطارات';

  @override
  String get homeWateringTime => 'وقت الري';

  @override
  String get homeWateringNotification => 'نباتاتك الداخلية تحتاج إلى الري.';

  @override
  String get homeWelcome => 'مرحبًا!';

  @override
  String get homeWelcomeNotification =>
      'مرحبا بكم في Botaniq. ابدأ بإضافة مصنعك الأول.';

  @override
  String get homeTenMinutesAgo => 'منذ 10 دقائق';

  @override
  String get homeOneDayAgo => 'منذ يوم واحد';

  @override
  String get homeQuickActions => 'إجراءات سريعة';

  @override
  String get homeIdentifyCamera => 'التعرف على الكاميرا الخاصة بك';

  @override
  String get homeTomorrow => 'غدا';

  @override
  String get homeNoTasks => 'لا توجد مهام لهذا اليوم!';

  @override
  String get homeAllCared => 'نباتاتك كلها يتم الاعتناء بها 🌿';

  @override
  String get homeOverdue => 'متأخر';

  @override
  String get homeInstructions => 'تعليمات';

  @override
  String homeRequiredAmount(String amount) {
    return 'مطلوب: $amount';
  }

  @override
  String get homeLater => 'في وقت لاحق';

  @override
  String get homeMarkDone => 'وضع علامة \"تم\".';

  @override
  String get homeSickPlants => 'عيادة النبات';

  @override
  String homeSickCount(int count) {
    return '$count مريض';
  }

  @override
  String get homeGreetingMorning => 'صباح الخير';

  @override
  String get homeGreetingAfternoon => 'مساء الخير';

  @override
  String get homeGreetingEvening => 'مساء الخير';

  @override
  String get homeTodayTasks => 'مهام اليوم';

  @override
  String get homeTomorrowTasks => 'مهام الغد';

  @override
  String homeDateTasks(String date) {
    return '$date المهام';
  }

  @override
  String get commonSkip => 'تخطي';

  @override
  String get commonContinue => 'متابعة';

  @override
  String get commonClose => 'إغلاق';

  @override
  String get commonDelete => 'حذف';

  @override
  String get commonBack => 'العودة';

  @override
  String get commonUnknown => 'غير معروف';

  @override
  String get wizardSaveGarden => 'حفظ وإضافة إلى الحديقة';

  @override
  String wizardPlantAdded(String name) {
    return 'تمت إضافة $name إلى حديقتك! 🌿';
  }

  @override
  String get wizardRoomTitle => 'أين نباتك؟';

  @override
  String get wizardRoomSubtitle => 'قم بتصنيف مصنعك حسب الغرفة لإدارته بسهولة.';

  @override
  String get wizardLivingRoom => 'غرفة المعيشة';

  @override
  String get wizardBedroom => 'غرفة نوم';

  @override
  String get wizardKitchen => 'مطبخ';

  @override
  String get wizardOffice => 'مكتب';

  @override
  String get wizardBathroom => 'الحمام';

  @override
  String get wizardBalcony => 'شرفة';

  @override
  String get wizardLightTitle => 'كيف يكون الضوء في هذه البقعة؟';

  @override
  String get wizardLightSubtitle => 'يعد الضوء أحد أهم العوامل لصحة نباتك.';

  @override
  String get wizardDirectSun => 'الشمس المباشرة';

  @override
  String get wizardDirectSunDescription =>
      'أشعة الشمس غير المفلترة مباشرة على النبات';

  @override
  String get wizardBrightIndirect => 'مشرق غير مباشر';

  @override
  String get wizardBrightIndirectDescription =>
      'بالقرب من النافذة المواجهة للشرق أو الغرب';

  @override
  String get wizardMediumLight => 'ضوء متوسط';

  @override
  String get wizardMediumLightDescription => 'على بعد بضعة أقدام من النافذة';

  @override
  String get wizardLowLight => 'ضوء منخفض';

  @override
  String get wizardLowLightDescription =>
      'بعيدًا عن النوافذ أو تحت الضوء الاصطناعي';

  @override
  String get wizardDistanceTitle => 'المسافة إلى النافذة';

  @override
  String get wizardDistanceSubtitle => 'حدد المسافة التقريبية لأقرب نافذة.';

  @override
  String get wizardMoreThanFiveMeters => 'أكثر من 5 م';

  @override
  String get wizardActiveHoursTitle => 'ساعات الضوء النشطة';

  @override
  String get wizardActiveHoursSubtitle =>
      'ما عدد ساعات الضوء المباشر أو الساطع التي تستقبلها هذه البقعة؟';

  @override
  String wizardHour(int count) {
    return '$count ساعة';
  }

  @override
  String wizardHours(int count) {
    return '$count ساعة';
  }

  @override
  String get wizardSixPlusHours => '6+ ساعات';

  @override
  String get wizardRepottedTitle => 'متى تم إعادة زرع هذا النبات آخر مرة؟';

  @override
  String get wizardRepottedSubtitle =>
      'التربة الطازجة أمر بالغ الأهمية لنبات سعيد.';

  @override
  String get wizardRecently => 'مؤخرًا (أقل من 3 أشهر)';

  @override
  String get wizardSixMonthsAgo => 'منذ 6 أشهر';

  @override
  String get wizardOneYearAgo => 'منذ سنة واحدة';

  @override
  String get wizardTwoYearsAgo => 'منذ أكثر من عامين';

  @override
  String get wizardDontKnow => 'لا أعرف';

  @override
  String get wizardPotTitle => 'ما هي المادة وعاء؟';

  @override
  String get wizardPotSubtitle => 'تؤثر مادة الوعاء على سرعة جفاف التربة.';

  @override
  String get wizardPlasticPot => 'بلاستيك / حضانة';

  @override
  String get wizardTerracottaPot => 'الطين';

  @override
  String get wizardCeramicPot => 'السيراميك / المزجج';

  @override
  String get wizardMetalPot => 'معدن';

  @override
  String get wizardWateredTitle => 'متى قمت بسقي هذا النبات آخر مرة؟';

  @override
  String get wizardWateredSubtitle =>
      'وهذا يساعد على حساب وقت الري التالي بالضبط.';

  @override
  String get wizardToday => 'اليوم';

  @override
  String get wizardYesterday => 'أمس';

  @override
  String get wizardFewDaysAgo => 'قبل بضعة أيام';

  @override
  String get wizardWeekAgo => 'منذ أسبوع';

  @override
  String get wizardMoreWeekAgo => 'منذ أكثر من أسبوع';

  @override
  String get historyTitle => 'سجل البحث';

  @override
  String get historyClearTitle => 'مسح التاريخ';

  @override
  String get historyClearMessage =>
      'سيتم حذف سجل البحث والمسح بالكامل. هل أنت متأكد؟';

  @override
  String get historyClearTooltip => 'مسح التاريخ';

  @override
  String get historyEmptyTitle => 'لا يوجد سجل بحث';

  @override
  String get historyEmptySubtitle =>
      'ستظهر هنا النباتات التي تم مسحها بالكاميرا أو تم البحث عنها.';

  @override
  String get historyNoDetails => 'المعلومات التفصيلية غير متوفرة.';

  @override
  String get historyRegularWater => 'سقي منتظم';

  @override
  String get historyIndirectLight => 'ضوء غير مباشر';

  @override
  String get historyDescription => 'الوصف';

  @override
  String get historyWatering => 'سقي';

  @override
  String get historyLight => 'ضوء';

  @override
  String get historyRecently => 'مؤخرا';

  @override
  String historyMinutesAgo(int minutes) {
    return '$minutes قبل دقيقة';
  }

  @override
  String historyHoursAgo(int hours) {
    return '$hours منذ ساعات';
  }

  @override
  String get historyYesterday => 'أمس';

  @override
  String get historyPlantRecord => 'سجل بحث النبات';

  @override
  String get photoWholeSpecimen => 'صورة للكل\nنبات أو فطر';

  @override
  String get photoWholeSpecimenSubtitle =>
      'أبقِ العينة بأكملها متمركزة في الإطار للتعرف عليها بشكل أفضل.';

  @override
  String get photoCorrect => 'صحيح';

  @override
  String get photoTooClose => 'قريب جدًا';

  @override
  String get photoInstructions => 'تعليمات';

  @override
  String get photoOpenCamera => 'أفهم ذلك، افتح الكاميرا';

  @override
  String get scannerPlant => 'نبات';

  @override
  String get scannerMushroom => 'فطر';

  @override
  String get scannerIdentifyingPlant => 'تحديد النبات...';

  @override
  String get scannerIdentifyingMushroom => 'التعرف على الفطر...';

  @override
  String get scannerCapture => 'التقاط الصور والمسح الضوئي';

  @override
  String get scannerFailed => 'فشل المسح. يرجى المحاولة مرة أخرى.';

  @override
  String scannerError(String error) {
    return 'حدث خطأ: $error';
  }

  @override
  String get scannerUnknownPlant => 'نبات غير معروف';

  @override
  String get scannerUnknownMushroom => 'فطر غير معروف';

  @override
  String get scheduleTitle => 'الجدول الزمني';

  @override
  String get scheduleTodayTask => 'مهام اليوم';

  @override
  String get scheduleNoTasks => 'لا توجد مهام لهذا اليوم!';

  @override
  String get scheduleInstructions => 'تعليمات';

  @override
  String scheduleRequired(String amount) {
    return 'مطلوب: $amount';
  }

  @override
  String get scheduleRemindLater => 'أذكر لاحقًا';

  @override
  String get scheduleDone => 'تم';

  @override
  String get scheduleCareFallback => 'اعتني بنباتك.';

  @override
  String get chatDoctorTitle => 'دكتور النبات بالذكاء الاصطناعي';

  @override
  String chatPatient(String name) {
    return 'المريض: $name';
  }

  @override
  String get chatAnalyzing => 'جارٍ التحليل...';

  @override
  String chatHint(String name) {
    return 'اسأل عن $name...';
  }

  @override
  String chatWelcome(String name) {
    return 'مرحبا! 🌿 أنا طبيب النبات الذي يعمل بالذكاء الاصطناعي. كيف يمكنني المساعدة في $name؟\n\nيمكنني تشخيص الصورة أو الإجابة على أسئلة الرعاية الخاصة بك.';
  }

  @override
  String chatContinueWelcome(String name) {
    return 'مرحبا! دعونا نواصل مع $name. 🌱';
  }

  @override
  String get chatQuestionYellowing => 'ما هو سبب اصفرار الأوراق؟';

  @override
  String get chatQuestionTreatment => 'كيف يمكنني علاج هذا النبات؟';

  @override
  String get chatQuestionWatering => 'هل يجب أن أغير وتيرة الري؟';

  @override
  String get chatQuestionFertilizer => 'ما الأسمدة التي يجب أن أستخدمها؟';

  @override
  String get chatPhotoSent => 'تم إرسال الصورة';

  @override
  String get chatAnalyzePhoto => 'تحليل الصورة';

  @override
  String get chatDiagnosisUnknown => 'لا يمكن تحديد التشخيص';

  @override
  String get chatNoTreatment => 'لا توجد توصية العلاج';

  @override
  String get chatRecoveryUnknown => 'غير معروف';

  @override
  String get chatUnableIdentify => 'مصنع مجهول';

  @override
  String chatError(String error) {
    return 'عذرًا، حدث خطأ: $error. يرجى المحاولة مرة أخرى.';
  }

  @override
  String get chatCareTips => 'نصائح العناية';

  @override
  String get chatPlantLabel => 'نبات';

  @override
  String get chatDiagnosisLabel => 'التشخيص';

  @override
  String get chatTreatmentLabel => 'العلاج';

  @override
  String get chatUrgencyLabel => 'إلحاح';

  @override
  String get chatRecoveryLabel => 'الاسترداد المقدر';

  @override
  String get discoverMonsteraTitle => 'سر نمو Monstera';

  @override
  String get discoverIndoorPlants => 'نباتات داخلية';

  @override
  String get discoverSucculentWatering => 'دليل سقي العصارة';

  @override
  String get discoverCacti => 'الصبار والعصارة';

  @override
  String get discoverHerbSoil => 'أفضل أنواع التربة للأعشاب';

  @override
  String get discoverHerbs => 'الأعشاب';

  @override
  String get discoverPropagation => 'الانتشار 101: دليل المبتدئين';

  @override
  String get discoverPests => 'الآفات الشائعة وكيفية علاجها';

  @override
  String get discoverRepotting => 'إعادة السمعة: متى وكيف؟';

  @override
  String discoverMinutesRead(int minutes) {
    return '$minutes دقيقة للقراءة';
  }

  @override
  String get skip => 'تخطي';

  @override
  String get skipForNow => 'تخطي الآن';

  @override
  String get continueLabel => 'متابعة';

  @override
  String get getStarted => 'ابدأ';

  @override
  String get nextStep => 'الخطوة التالية';

  @override
  String get maybeLater => 'ربما في وقت لاحق';

  @override
  String get emailAddress => 'عنوان البريد الإلكتروني';

  @override
  String get password => 'كلمة المرور';

  @override
  String get firstName => 'الاسم الأول';

  @override
  String get lastName => 'الاسم الأخير';

  @override
  String get login => 'تسجيل الدخول';

  @override
  String get signUp => 'قم بالتسجيل';

  @override
  String get welcomeBack => 'مرحبا بكم مرة أخرى';

  @override
  String get loginSubtitle => 'قم بتسجيل الدخول لمواصلة العناية بحديقتك.';

  @override
  String get signUpSubtitle => 'انضم إلينا وابدأ في بناء ملاذك الأخضر.';

  @override
  String get forgotPassword => 'هل نسيت كلمة المرور؟';

  @override
  String get enterEmailPassword =>
      'الرجاء إدخال البريد الإلكتروني الخاص بك وكلمة المرور.';

  @override
  String get fillAllFields => 'يرجى ملء جميع الحقول.';

  @override
  String authError(String error) {
    return 'حدث خطأ ما: $error';
  }

  @override
  String get loginWith => 'أو قم بتسجيل الدخول باستخدام';

  @override
  String get signUpWith => 'أو قم بالتسجيل مع';

  @override
  String get noAccount => 'ليس لديك حساب؟';

  @override
  String get alreadyAccount => 'هل لديك حساب بالفعل؟';

  @override
  String get developerSession => 'إنشاء جلسة المطور';

  @override
  String get welcomeBotaniq => 'مرحبا بكم في Botaniq';

  @override
  String get loginOptionsSubtitle =>
      'قم بتسجيل الدخول أو الاشتراك لعمل نسخة احتياطية من نباتاتك وجداولك وتفضيلاتك.';

  @override
  String get notificationAccessTitle => 'لا تفوت الري';

  @override
  String get notificationAccessSubtitle =>
      'سنذكرك بلطف عندما يحين وقت الاهتمام بأصدقائك البيئيين. أصبحت العناية بالنباتات سهلة وخالية من الإجهاد.';

  @override
  String get notificationTurnOn => 'قم بتشغيل التذكيرات';

  @override
  String get creatingClimate => 'تحليل المناخ الجزئي الخاص بك...';

  @override
  String get creatingSchedules => 'تخصيص جداول الرعاية...';

  @override
  String get creatingSanctuary => 'تجهيز ملجأك الأخضر...';

  @override
  String get locationAccessTitle => 'الوصول إلى الموقع';

  @override
  String get locationAccessSubtitle =>
      'قم بتخصيص العناية بالنباتات بناءً على مناخك المحلي.';

  @override
  String get locationRecommendation => 'التوصيات المحلية';

  @override
  String get locationRecommendationSubtitle =>
      'النباتات التي تزدهر في مناخ منطقتك';

  @override
  String get locationWeather => 'مزامنة الطقس الذكية';

  @override
  String get locationWeatherSubtitle =>
      'تتكيف الجداول مع المطر المحلي في الوقت الحقيقي';

  @override
  String get locationAlerts => 'تنبيهات الصقيع والحرارة';

  @override
  String get locationAlertsSubtitle =>
      'الحصول على إخطار قبل أن يضرب الطقس القاسي';

  @override
  String get locationEnable => 'تمكين الوصول إلى الموقع';

  @override
  String get wherePlantsTitle => 'أين نباتاتك؟';

  @override
  String get wherePlantsSubtitle =>
      'حدد كل ما ينطبق لتخصيص جداول الرعاية الخاصة بك.';

  @override
  String get locationIndoor => 'داخلي';

  @override
  String get locationIndoorSubtitle => 'غرفة المعيشة، غرفة النوم، المكتب';

  @override
  String get locationBalcony => 'شرفة';

  @override
  String get locationBalconySubtitle => 'نباتات في وعاء على سطح أو تراس';

  @override
  String get locationGarden => 'حديقة';

  @override
  String get locationGardenSubtitle =>
      'النباتات وأحواض الزهور الموجودة في الأرض';

  @override
  String get helpTitleBefore => 'ماذا يمكننا';

  @override
  String get helpTitleHighlight => 'مساعدتك';

  @override
  String get helpTitleAfter => 'مع؟';

  @override
  String get helpSubtitle => 'حدد هدفًا واحدًا أو أكثر لتخصيص حديقتك.';

  @override
  String get helpHeal => 'شفاء المرضى\nالنباتات';

  @override
  String get helpCare => 'رعاية\nتذكير';

  @override
  String get helpIdentify => 'تحديد\nالأنواع';

  @override
  String get helpJournal => 'النمو\nمجلة';

  @override
  String get helpOther => 'شيء آخر';

  @override
  String get journeyTitle => 'رحلتك الخضراء';

  @override
  String get journeySubtitle => 'حدد مستوى الرعاية الذي ترغب في تقديمه.';

  @override
  String get journeyCasualLabel => 'كاجوال';

  @override
  String get journeyCasualTitle => 'صيانة منخفضة';

  @override
  String get journeyCasualSubtitle =>
      'أريد فقط أن أبقي نباتاتي البسيطة حية ومزدهرة.';

  @override
  String get journeyEnthusiastLabel => 'متحمس';

  @override
  String get journeyEnthusiastTitle => 'رعاية متوازنة';

  @override
  String get journeyEnthusiastSubtitle =>
      'أنا أستمتع بقضاء بعض الوقت الأسبوعي مع مجموعتي المتنامية.';

  @override
  String get journeyObsessedLabel => 'مهووس';

  @override
  String get journeyObsessedTitle => 'أصل النبات الاستثنائي';

  @override
  String get journeyObsessedSubtitle =>
      'أنا أعيش من أجل نباتاتي وأريد جداول زمنية متخصصة للغابة الداخلية الخاصة بي.';

  @override
  String get masteryTitleBefore => 'كيف حالك';

  @override
  String get masteryTitleHighlight => 'أخضر\nالإبهام';

  @override
  String get masteryTitleAfter => 'في الآونة الأخيرة؟';

  @override
  String get masterySubtitle =>
      'كن صادقًا، لقد كنا جميعًا \"القاتل المتسلسل\" في مرحلة ما. حدد إتقانك الحالي.';

  @override
  String get masteryKiller => 'القاتل المتسلسل';

  @override
  String get masteryKillerSubtitle =>
      'حتى نباتاتي البلاستيكية تبدو قلقة عندما أدخل الغرفة.';

  @override
  String get masteryAccidental => 'الوالد العرضي';

  @override
  String get masteryAccidentalSubtitle =>
      'لقد نجا الصبار الخاص بي لمدة أسبوعين. ما زلنا نتعرف على بعضنا البعض.';

  @override
  String get masteryGrowth => 'عقلية النمو';

  @override
  String get masteryGrowthSubtitle =>
      'معظم أصدقائي لديهم أوراق. أنا أعرف الوحوش الخاصة بي من البوثوس الخاصة بي.';

  @override
  String get masteryWhisperer => 'همس النبات';

  @override
  String get masteryWhispererSubtitle =>
      'أقوم بنشر النباتات النادرة وأتحدث اللغة اللاتينية النباتية بطلاقة.';

  @override
  String get onboardingOneTitle => 'اعتني بنفسك\nمن النباتات الخاصة بك';

  @override
  String get onboardingOneHighlight => 'مثل المحترفين';

  @override
  String get onboardingOneSubtitle =>
      'جداول ذكية وتحديد فوري للغابة الحضرية الخاصة بك.';

  @override
  String get onboardingOneBadge => 'رعاية مدعومة بالذكاء الاصطناعي';

  @override
  String get onboardingAiScan => 'مسح الذكاء الاصطناعي';

  @override
  String get onboardingSmartWater => 'المياه الذكية';

  @override
  String get onboardingLightTracking => 'تتبع الضوء';

  @override
  String get onboardingTwoTitle => 'تحديد أي\nزرع في';

  @override
  String get onboardingTwoHighlight => 'ثواني';

  @override
  String get onboardingTwoSubtitle =>
      'التقط صورة للتعرف على اسمها وأنواعها ومتطلبات العناية بها.';

  @override
  String get onboardingTwoBadge => 'خبير نباتي';

  @override
  String get onboardingSnapPhoto => 'التقط الصورة';

  @override
  String get onboardingAccurateResult => 'نتيجة دقيقة';

  @override
  String get onboardingPlantWiki => 'ويكي النبات';

  @override
  String get onboardingThreeTitle => 'لا تنسى أبدا\nإلى الماء';

  @override
  String get onboardingThreeHighlight => 'مرة أخرى';

  @override
  String get onboardingThreeSubtitle =>
      'احصل على تذكيرات بتوقيت مناسب لاحتياجات مصنعك وبيئته.';

  @override
  String get onboardingThreeBadge => 'جداول ذكية';

  @override
  String get onboardingReminders => 'تذكيرات';

  @override
  String get onboardingClimateData => 'بيانات المناخ';

  @override
  String get onboardingHealthyGrowth => 'النمو الصحي';

  @override
  String get onboardingCommunity => 'انضم إلى أكثر من 50000 من آباء النباتات';

  @override
  String get onboardingAgreement =>
      'من خلال المتابعة، فإنك توافق على الشروط وسياسة الخصوصية الخاصة بنا';

  @override
  String get termsTitle => 'الشروط والسياسات';

  @override
  String get termsUpdated => 'آخر تحديث: يوليو 2026';

  @override
  String get termsUseTitle => '1. شروط الاستخدام';

  @override
  String get termsUseBody =>
      'من خلال الوصول إلى Botaniq أو استخدامه، فإنك توافق على شروط الاستخدام هذه والقوانين المعمول بها. إذا كنت لا توافق، فلا يجوز لك استخدام الخدمة.';

  @override
  String get termsPrivacyTitle => '2. خصوصية المستخدم';

  @override
  String get termsPrivacyBody =>
      'نحن نجمع فقط البيانات الشخصية اللازمة لتوفير جداول مخصصة للعناية بالنباتات. نحن لا نبيع بياناتك الشخصية لأطراف ثالثة.';

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
  String get termsPlantTitle => '3. بيانات النبات';

  @override
  String get termsPlantBody =>
      'يتم توفير معلومات العناية بالنباتات وتحديد الهوية والتشخيص لأغراض إعلامية. قد لا تكون نتائج الذكاء الاصطناعي صحيحة دائمًا، لذا راقب نباتك وابحث عن خبير لمواجهة المخاطر الجسيمة.';

  @override
  String get termsLiabilityTitle => '6. Disclaimers, Liability, and Indemnity';

  @override
  String get termsLiabilityBody =>
      'Botaniq is provided \"as is\" and \"as available,\" without warranties of any kind, express or implied, including accuracy, reliability, or fitness for a particular purpose. To the fullest extent permitted by law, we and our service providers are not liable for any indirect, incidental, special, or consequential damages, or for any loss of data, plants, or property arising from your use of the service, and our total liability for any claim is limited to the amount you paid us, if any, in the twelve months before the claim. You agree to indemnify and hold us harmless from claims arising from your use of the service, your content, or your violation of these Terms or applicable law.';

  @override
  String get termsPremiumTitle => '4. الاشتراكات المميزة';

  @override
  String get termsPremiumBody =>
      'يتم تحميل اشتراكك المميز الشهري أو السنوي على حساب Apple أو Google الخاص بك بعد تأكيد الشراء. يتم تجديده تلقائيًا ما لم يتم إلغاؤه قبل 24 ساعة على الأقل من انتهاء الفترة الحالية. يمكنك إدارتها أو إلغاؤها في إعدادات حساب المتجر الخاص بك. تتم معالجة طلبات استرداد الأموال بموجب سياسة المتجر المعمول بها.';

  @override
  String get termsLawTitle => '8. Governing Law and Changes';

  @override
  String get termsLawBody =>
      'These Terms are governed by the laws of the jurisdiction in which we operate, without regard to conflict-of-law principles, and any dispute will be resolved under that jurisdiction\'s applicable procedures to the fullest extent permitted by law. We may update these Terms and our data practices at any time by posting the revised version in the app.';

  @override
  String get termsClosing => 'استمتع براحة البال والنباتات الأكثر سعادة.';

  @override
  String get weatherTitle => 'الطقس';

  @override
  String get weatherSunnyTip => 'مشمس اليوم - افحص التربة قبل الري.';

  @override
  String get weatherCloudyTip => 'الطقس الغائم يبطئ التبخر. الماء أقل قليلا.';

  @override
  String get weatherRainyTip =>
      'ممطر ورطب - تجنب الإفراط في سقي النباتات الخارجية.';

  @override
  String get weatherStormTip =>
      'الطقس العاصف - انقل الأواني الحساسة إلى مكان محمي.';

  @override
  String get weatherSnowTip => 'البرد والثلج - حماية النباتات من صدمة الحرارة.';
}
