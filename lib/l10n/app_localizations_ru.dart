// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'Botaniq';

  @override
  String get settings => 'Настройки';

  @override
  String get preferences => 'Предпочтения';

  @override
  String get darkMode => 'Темный режим';

  @override
  String get metricSystem => 'Метрическая система';

  @override
  String get metricSystemSubtitle => 'Используйте градусы Цельсия и метры';

  @override
  String get account => 'Аккаунт';

  @override
  String get editProfile => 'Редактировать профиль';

  @override
  String get changePassword => 'Изменить пароль';

  @override
  String get subscriptionManagement => 'Управление подпиской';

  @override
  String get premium => 'Премиум';

  @override
  String get language => 'Язык';

  @override
  String get languageSubtitle => 'Изменить язык приложения';

  @override
  String get selectLanguage => 'Выберите язык';

  @override
  String get systemLanguage => 'Системный язык';

  @override
  String get english => 'английский';

  @override
  String get turkish => 'Тюркче';

  @override
  String get languageChanged => 'Язык успешно изменен.';

  @override
  String get languageSearchHint => 'Поиск языков';

  @override
  String get languageRecommended => 'Рекомендуется';

  @override
  String get languageWelcomeTitle => 'Выберите свой язык';

  @override
  String get languageWelcomeSubtitle =>
      'Выберите язык, который вы хотите использовать в Botaniq. Вы можете изменить его в любое время.';

  @override
  String get languageUseSystem => 'Использовать язык устройства';

  @override
  String get preferenceSystem => 'Использовать системные настройки';

  @override
  String get themeLight => 'Свет';

  @override
  String get themeDark => 'Темный';

  @override
  String get themeSelectionTitle => 'Выберите внешний вид';

  @override
  String get measurementMetric => 'Метрика';

  @override
  String get measurementImperial => 'Империал';

  @override
  String get measurementSelectionTitle => 'Выберите систему измерения';

  @override
  String get settingsSubtitle =>
      'Формируйте Botaniq в соответствии с вашим собственным ритмом ухода.';

  @override
  String get settingsLocalPreference => 'Сохранено на этом устройстве';

  @override
  String get settingsDarkModeSubtitle =>
      'Более спокойная палитра для моментов при слабом освещении';

  @override
  String get settingsAccountSubtitle => 'Идентичность, доступ и членство';

  @override
  String get settingsEditProfileSubtitle =>
      'Имя, местоположение и предпочтения по уходу';

  @override
  String get settingsPasswordSubtitle =>
      'Отправьте ссылку безопасного сброса на свою электронную почту.';

  @override
  String get settingsSubscriptionSubtitle =>
      'Премиум-план и платежные реквизиты';

  @override
  String get settingsPasswordResetSent =>
      'Письмо для сброса пароля отправлено.';

  @override
  String get settingsComingSoon => 'Это пространство продолжает расти.';

  @override
  String get subscriptionPageTitle => 'Премиум-членство';

  @override
  String get subscriptionHeroEyebrow => 'BOTANIQ PREMIUM';

  @override
  String get subscriptionHeroTitle => 'Разумный уход за каждым растением';

  @override
  String get subscriptionHeroSubtitle =>
      'Разблокируйте все инструменты для ухода премиум-класса и уверенно выращивайте свои зеленые зоны.';

  @override
  String get subscriptionBenefitsTitle => 'Все в Премиум';

  @override
  String get subscriptionBenefitIdentification =>
      'Неограниченная идентификация растений и анализ здоровья';

  @override
  String get subscriptionBenefitCare =>
      'Персонализированные планы ухода и напоминания';

  @override
  String get subscriptionBenefitInsights =>
      'Экспертный контент и расширенная информация по уходу';

  @override
  String get subscriptionMonthlyPlan => 'Ежемесячно';

  @override
  String get subscriptionAnnualPlan => 'Ежегодный';

  @override
  String subscriptionPerMonth(String price) {
    return '$price / месяц';
  }

  @override
  String subscriptionPerYear(String price) {
    return '$price / год';
  }

  @override
  String get subscriptionBestValue => 'ЛУЧШАЯ ЦЕНА';

  @override
  String subscriptionSavePercent(int percent) {
    return 'Сэкономьте $percent%';
  }

  @override
  String get subscriptionContinue => 'Разблокировать Премиум';

  @override
  String get subscriptionRestorePurchases => 'Восстановить покупки';

  @override
  String get subscriptionRestoring => 'Восстановление...';

  @override
  String get subscriptionManage => 'Управление подпиской';

  @override
  String get subscriptionActiveTitle => 'Ваше Премиум-членство активно';

  @override
  String get subscriptionActiveSubtitle =>
      'У вас есть доступ ко всем функциям премиум-класса.';

  @override
  String subscriptionRenewsOn(String date) {
    return 'Обновления на $date';
  }

  @override
  String subscriptionExpiresOn(String date) {
    return 'Активен до $date';
  }

  @override
  String get subscriptionAutoRenewDisclosure =>
      'Оплата списывается с вашей учетной записи Apple или Google. Подписка продлевается автоматически, если она не отменена по крайней мере за 24 часа до окончания текущего периода. Вы можете управлять им или отменить его в любое время в настройках учетной записи вашего магазина.';

  @override
  String get subscriptionTermsLink => 'Условия использования';

  @override
  String get subscriptionPrivacyLink => 'Политика конфиденциальности';

  @override
  String get subscriptionPurchaseSuccess =>
      'Ваше Премиум-членство теперь активно.';

  @override
  String get subscriptionRestoreSuccess =>
      'Ваше Премиум-членство было восстановлено.';

  @override
  String get subscriptionNothingToRestore =>
      'Для этой учетной записи магазина не обнаружено активного членства.';

  @override
  String get subscriptionPaymentPending =>
      'Платеж ожидает одобрения магазина. Ваше членство активируется автоматически после одобрения.';

  @override
  String get subscriptionErrorGeneric =>
      'Операцию не удалось завершить. Пожалуйста, попробуйте еще раз.';

  @override
  String get subscriptionErrorNetwork =>
      'Проверьте подключение к Интернету и повторите попытку.';

  @override
  String get subscriptionErrorNotAllowed =>
      'На этом устройстве или в учетной записи магазина нельзя совершать покупки.';

  @override
  String get subscriptionErrorStore =>
      'Дойти до магазина не удалось. Пожалуйста, повторите попытку в ближайшее время.';

  @override
  String get subscriptionMissingConfiguration =>
      'В этой сборке отсутствует ключ RevenueCat.';

  @override
  String get subscriptionUnsupported =>
      'Подписки доступны только в приложениях для iOS и Android.';

  @override
  String get subscriptionProductsUnavailable =>
      'Не удалось загрузить ежемесячные и годовые продукты. Проверьте конфигурацию предложения RevenueCat.';

  @override
  String get subscriptionRetry => 'Попробуйте еще раз';

  @override
  String get subscriptionFree => 'Бесплатно';

  @override
  String get homeGoodMorning => 'Привет,';

  @override
  String homePersonalGreeting(String greeting, String name) {
    return '$greeting, $name 👋';
  }

  @override
  String get homeEmptyGarden => 'Твой сад пуст';

  @override
  String get homeEmptyGardenSubtitle =>
      'Начните строить свой зеленый заповедник\nдобавив свое первое растение.';

  @override
  String get homeAddFirstPlant => 'Добавить первое растение';

  @override
  String get homeMyPlants => 'Мои растения';

  @override
  String get homeViewAll => 'Посмотреть все';

  @override
  String get homeSmartCareReminders => 'Умные напоминания об уходе';

  @override
  String get homeWatering => 'Полив';

  @override
  String get homeWateringSubtitle => 'Отслеживание почвы';

  @override
  String get homeFertilizing => 'Удобрение';

  @override
  String get homeFertilizingSubtitle => 'Оповещения о питательных веществах';

  @override
  String get gardenTitle => 'Мой сад';

  @override
  String get gardenAllPlants => 'Все растения';

  @override
  String get gardenNeedsWater => 'Нужна вода';

  @override
  String get gardenIndoor => 'Крытый';

  @override
  String get gardenNoPlants =>
      'Растений пока нет.\nНажмите +, чтобы добавить свое первое растение!';

  @override
  String get gardenNoPlantsCategory => 'В этой категории нет растений.';

  @override
  String get discoverTitle => 'Откройте для себя';

  @override
  String get discoverSearchHint => 'Поиск растений, статей, руководств...';

  @override
  String get discoverLatestArticles => 'Последние статьи';

  @override
  String get discoverSeeAll => 'Посмотреть все';

  @override
  String get discoverTrendingGuides => 'Трендовые руководства';

  @override
  String get healthyTitle => 'Центр ухода';

  @override
  String get healthySubtitle =>
      'Прикоснитесь к душе ваших растений, поговорите с ними.';

  @override
  String get healthyTabDoctor => 'Доктор';

  @override
  String get healthyTabHospital => 'Больница';

  @override
  String get healthyTabDiscover => 'Откройте для себя';

  @override
  String get profileTitle => 'Мой профиль';

  @override
  String get profileEditProfile => 'Редактировать профиль';

  @override
  String get profileOverview => 'Обзор';

  @override
  String get profileSettingsTab => 'Настройки';

  @override
  String get profileGardenerLevel => 'Уровень садовника';

  @override
  String get profileTotalPlants => 'Всего растений';

  @override
  String get profileCompletedTasks => 'Выполненные задачи';

  @override
  String get profileWeeklyActivity => 'Еженедельная деятельность по уходу';

  @override
  String get profileGeneral => 'Общий';

  @override
  String get profileAppSettings => 'Настройки приложения';

  @override
  String get profileNotificationPrefs => 'Настройки уведомлений';

  @override
  String get profileSupportLegal => 'Поддержка и юридическая поддержка';

  @override
  String get profileHelpCenter => 'Справочный центр';

  @override
  String get profileTerms => 'Условия использования и политика';

  @override
  String get profileSignOut => 'Выйти';

  @override
  String get profileDeleteAccount => 'Удалить аккаунт';

  @override
  String get profileSubtitle =>
      'Ваша садовая история, прогресс и личное пространство.';

  @override
  String get profileGardenPassport => 'САДОВЫЙ ПАСПОРТ';

  @override
  String get profileThisWeek => 'На этой неделе';

  @override
  String get profileQuietWeek =>
      'Тихая неделя — здесь появится ваш следующий момент заботы.';

  @override
  String get profileActiveWeek => 'Ваш ритм ухода жив и растет.';

  @override
  String get profileAppSettingsSubtitle =>
      'Язык, единицы измерения и подключение к AI';

  @override
  String get profileNotificationPrefsSubtitle =>
      'Выбирайте, какие моменты заботы дойдут до вас';

  @override
  String get profileHelpCenterSubtitle => 'Ответы и быстрые рекомендации';

  @override
  String get profileTermsSubtitle => 'Конфиденциальность, условия и политика';

  @override
  String get profileAccountActions => 'Действия с аккаунтом';

  @override
  String get profileSignOutQuestion => 'Вы уверены, что хотите выйти?';

  @override
  String get profileDeleteAccountWarning =>
      'Удаление учетной записи требует безопасного подтверждения на стороне сервера. Ваши данные не были изменены.';

  @override
  String get cancel => 'Отмена';

  @override
  String get continueAction => 'Продолжить';

  @override
  String get profileTitleNew => 'Новый Садовник 🌱';

  @override
  String get profileTitleSprout => 'Росток Друг 🌿';

  @override
  String get profileTitleLeaf => 'Любитель листьев ☘️';

  @override
  String get profileTitleSkilled => 'Опытный садовник 🏡';

  @override
  String get profileTitleMaster => 'Мастер зеленого пальца 👑';

  @override
  String get profileNextLevelStart =>
      'Добавьте свое первое растение и начните свое садовое приключение!';

  @override
  String profileNextLevelLeaf(int count) {
    return 'Осталось всего $count растений, чтобы стать Leaf Lover.';
  }

  @override
  String profileNextLevelSkilled(int count) {
    return 'Осталось всего $count растений, чтобы стать опытным садовником.';
  }

  @override
  String profileNextLevelMaster(int count) {
    return 'Осталось всего $count растений, чтобы стать Green Thum Master.';
  }

  @override
  String get profileNextLevelMax =>
      'Вы находитесь на вершине своего сада, поздравляем!';

  @override
  String get navHome => 'Главная';

  @override
  String get navGarden => 'Сад';

  @override
  String get navClinic => 'Клиника';

  @override
  String get navProfile => 'Профиль';

  @override
  String get scanPlant => 'Сканирование завода';

  @override
  String get deletePlantTitle => 'Удалить это растение?';

  @override
  String get deletePlantMessage =>
      'Растение, его задачи по уходу и записи клиники будут навсегда удалены из вашей учетной записи.';

  @override
  String get deletePlantAction => 'Удалить растение';

  @override
  String get deletePlantNotFound =>
      'Растение не удалось найти или оно уже удалено.';

  @override
  String deletePlantError(String error) {
    return 'Не удалось удалить растение: $error.';
  }

  @override
  String get profileChoosePhoto => 'Выберите фотографию профиля';

  @override
  String get profileFullName => 'Полное имя';

  @override
  String get profileFullNameHint => 'Введите свое полное имя';

  @override
  String get profileNickname => 'Псевдоним';

  @override
  String get profileNicknameHint => 'Как нам следует вас называть?';

  @override
  String get profileAge => 'Возраст';

  @override
  String get profileAgeHint => '1–120';

  @override
  String get profileAgeValidation => 'Введите возраст от 1 до 120.';

  @override
  String profileLoadError(String error) {
    return 'Не удалось загрузить профиль: $error.';
  }

  @override
  String get languageEnglish => 'английский';

  @override
  String get languageTurkish => 'турецкий';

  @override
  String get profileEmailReadOnly => 'Адрес электронной почты (только чтение)';

  @override
  String get profileEmailHint => 'Введите адрес электронной почты';

  @override
  String get profileLocation => 'Расположение';

  @override
  String get profileLocationHint => 'Город, Страна';

  @override
  String get profileSaveChanges => 'Сохранить изменения';

  @override
  String get profileUpdated => 'Ваш профиль обновлен.';

  @override
  String profileSaveError(String error) {
    return 'Не удалось сохранить профиль: $error.';
  }

  @override
  String get notificationWateringTitle => 'Напоминания о поливе';

  @override
  String get notificationWateringSubtitle =>
      'Получайте уведомления, когда пришло время полива';

  @override
  String get notificationFertilizerTitle => 'Напоминания об удобрениях';

  @override
  String get notificationFertilizerSubtitle =>
      'Оповещения о сезонной подкормке ваших растений';

  @override
  String get notificationTitle => 'Уведомления';

  @override
  String get notificationPlantCareAlerts =>
      'Предупреждения об уходе за растениями';

  @override
  String get notificationOther => 'Другие уведомления';

  @override
  String get notificationWeatherTitle => 'Оповещения о погоде';

  @override
  String get notificationWeatherSubtitle =>
      'Предупреждения об экстремальных погодных условиях';

  @override
  String get notificationArticlesTitle => 'Новые статьи';

  @override
  String get notificationArticlesSubtitle =>
      'Советы и рекомендации для вашего сада';

  @override
  String get gardenMyPlantFallback => 'Мое растение';

  @override
  String get gardenClinicBadge => 'В клинике';

  @override
  String get wateringNever => 'Последний полив: Никогда';

  @override
  String wateringLastDate(String date) {
    return 'Последний полив: $date';
  }

  @override
  String wateringInterval(int days) {
    return 'Каждые $days дней';
  }

  @override
  String get wateringNeverDue => 'Еще не поливали • Поливайте сегодня';

  @override
  String wateringOverdue(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'Просрочено на $days дня',
      many: 'Просрочено на $days дней',
      few: 'Просрочено на $days дня',
      one: 'Просрочено на 1 день',
      zero: 'Полить сегодня',
    );
    return '$_temp0';
  }

  @override
  String get wateringDueToday => 'Вода сегодня';

  @override
  String get wateringDueTomorrow => 'Вода завтра';

  @override
  String wateringDueInDays(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'Полить через $days дня',
      many: 'Полить через $days дней',
      few: 'Полить через $days дня',
      one: 'Полить через 1 день',
      zero: 'Полить сегодня',
    );
    return '$_temp0';
  }

  @override
  String get plantUnknown => 'Неизвестное растение';

  @override
  String get plantSpeciesFallback => 'Виды растений';

  @override
  String get plantDifficultyMedium => 'Средний';

  @override
  String get plantAbout => 'О';

  @override
  String get plantLocationEnvironment => 'Местоположение и окружающая среда';

  @override
  String get plantCareProtocol => 'Протокол ухода';

  @override
  String get plantCareHistory => 'История ухода за последние 10 дней';

  @override
  String get plantHealthy => 'Здоровый';

  @override
  String get plantInClinic => 'В клинике';

  @override
  String get plantDifficulty => 'Сложность';

  @override
  String get plantToxicity => 'Токсичность';

  @override
  String get plantEnvironment => 'Окружающая среда';

  @override
  String get plantLightNeed => 'Легкая потребность';

  @override
  String get plantToxicPets => 'Токсичен для домашних животных';

  @override
  String get plantNonToxic => 'Нетоксичный';

  @override
  String get plantIndoor => 'Крытый';

  @override
  String get plantBrightIndirect => 'Яркий непрямой';

  @override
  String get plantInfoUnavailable => 'Проверенная информация пока недоступна.';

  @override
  String get plantIdealClimate => 'Идеальный климат';

  @override
  String get plantHumidity => 'Влажность';

  @override
  String get plantTemperatureRange => 'Температурный диапазон';

  @override
  String get plantWateringFrequency => 'Частота полива';

  @override
  String plantWateringFrequencyValue(String interval) {
    return 'Вода $interval.';
  }

  @override
  String get plantNextWatering => 'Следующий полив';

  @override
  String get plantWateringProtocol => 'Протокол полива';

  @override
  String get plantSoilProtocol => 'Почва';

  @override
  String get plantFeedingProtocol => 'Протокол кормления';

  @override
  String get plantPruningCleaning => 'Обрезка и очистка';

  @override
  String get plantPruningFallback =>
      'Протирайте листья ежемесячно. Обрезайте мертвые или желтеющие листья, чтобы стимулировать рост.';

  @override
  String get plantHistoryEmpty =>
      'Отсутствие истории болезни за последние 10 дней.';

  @override
  String get plantWateringTask => 'Полив';

  @override
  String get plantFertilizingTask => 'Удобрение';

  @override
  String get plantWateredAction => 'Поливал ✓';

  @override
  String get plantWaterNowAction => 'Вода сейчас';

  @override
  String get plantFertilizedAction => 'Удобренный ✓';

  @override
  String get plantFertilizeAction => 'Удобрять';

  @override
  String get plantAddGardenAction => 'Добавить в мой сад';

  @override
  String get plantWaterSuccess => '💧Вы полили свое растение! Отличная работа!';

  @override
  String get plantFertilizeSuccess =>
      '🌱Добавлены удобрения! Ваше растение говорит спасибо!';

  @override
  String plantWaterError(String error) {
    return 'Не удалось сохранить полив: $error';
  }

  @override
  String plantFertilizeError(String error) {
    return 'Не удалось сохранить удобрения: $error';
  }

  @override
  String get clinicQuickTools => 'Быстрые инструменты';

  @override
  String get clinicDoctorHero => 'ИИ-доктор растений\nК вашим услугам';

  @override
  String get clinicStartConsultation => 'Начать консультацию';

  @override
  String get clinicChoosePlant => 'О каком растении вы бы хотели поговорить?';

  @override
  String get clinicChoosePlantSubtitle =>
      'Выберите растение из своего сада или сделайте новую фотографию.';

  @override
  String get clinicNoGardenPlants =>
      'В вашем саду пока нет растений.\nНачните с создания новой фотографии.';

  @override
  String get clinicNewPhoto => 'Сделать новую фотографию';

  @override
  String get clinicNewPhotoSubtitle =>
      'Сфотографируйте больное растение и получите диагноз';

  @override
  String get clinicPestAnalysis => 'Анализ вредителей';

  @override
  String get clinicVisualDiagnosis => 'Визуальная диагностика';

  @override
  String get clinicLightMeter => 'Люксметр';

  @override
  String get clinicSensorSimulation => 'Симуляция датчика';

  @override
  String get clinicTitle => 'Плант Клиника';

  @override
  String clinicSickCount(int count) {
    return '$count Больной';
  }

  @override
  String get clinicAllHealthy => 'Все ваши растения здоровы! 🌿';

  @override
  String get clinicEmpty =>
      'Больных растений в Клинике нет.\nЕсли вы беспокоитесь о растении,\nспросите на вкладке Доктор.';

  @override
  String get clinicUnknown => 'Неизвестно';

  @override
  String get clinicPendingDiagnosis => 'Жду диагноза';

  @override
  String get clinicNoTreatment => 'Лечение не определено';

  @override
  String get clinicPrescription => 'Рецепт:';

  @override
  String get clinicRecovery => 'Восстановление';

  @override
  String get clinicRecovered => 'Восстановлено';

  @override
  String get clinicContinue => 'Продолжить';

  @override
  String get clinicRecoveredSuccess => '🎉 Ваше растение снова здорово!';

  @override
  String get clinicUrgencyLow => 'Низкий';

  @override
  String get clinicUrgencyMedium => 'Средний';

  @override
  String get clinicUrgencyCritical => 'Критический';

  @override
  String get healthTrendingTips => 'Актуальные советы по здоровью';

  @override
  String get healthHumidityArticleTitle =>
      'Подготовка к зиме: поддержание баланса влажности';

  @override
  String get healthHumidityArticleSubtitle =>
      'Как защитить растения от сухого воздуха радиатора в холодные месяцы.';

  @override
  String get healthWeeklySpotlight => 'Пациент и лекарство недели';

  @override
  String get healthAphidTitle => 'Заражение тлей';

  @override
  String get healthAphidSubtitle =>
      'Раннее вмешательство и лечение натуральным маслом нима.';

  @override
  String get healthDiscoverLoadError =>
      'Не удалось загрузить контент Discover. Потяните вниз, чтобы повторить попытку.';

  @override
  String get healthDiscoverEmpty =>
      'Опубликованного контента для поиска пока нет.';

  @override
  String get healthDiscoverRetry => 'Попробуйте еще раз';

  @override
  String get lightMeterTitle => 'Люксметр';

  @override
  String get lightMeterInstructionTitle => 'Измерение света';

  @override
  String get lightMeterInstruction =>
      'Направьте переднюю камеру телефона на\nрасположение растения и источник света.';

  @override
  String get lightMeterCameraEstimate =>
      'Приблизительное значение люкс, рассчитанное на основе данных камеры.';

  @override
  String get lightMeterStabilizing => 'Стабилизирующее измерение';

  @override
  String get lightMeterStabilizingRecommendation =>
      'Держите телефон неподвижно в течение нескольких секунд, пока резкие изменения экспозиции не будут отфильтрованы.';

  @override
  String get lightMeterUnavailable => 'Измерение недоступно';

  @override
  String get lightMeterUnavailableRecommendation =>
      'Включите разрешение камеры и повторите попытку.';

  @override
  String get lightLow => 'Низкое освещение (тень)';

  @override
  String get lightMedium => 'Средний свет (Светлая комната)';

  @override
  String get lightHigh => 'Высокий свет (возле окна)';

  @override
  String get lightVeryHigh => 'Очень сильный свет (прямое солнце)';

  @override
  String get lightLowRecommendation =>
      'Подходит для калатеи, папоротников или змеиных растений.';

  @override
  String get lightMediumRecommendation =>
      'Идеально подходит для монстеры, фикуса и антуриума.';

  @override
  String get lightHighRecommendation =>
      'Подходит для солнцелюбивых алоэ, кактусов и герани.';

  @override
  String get lightVeryHighRecommendation =>
      'Лучше всего подходит для уличных растений и суккулентов.';

  @override
  String get homeLoadingPlants => 'Загрузка растений...';

  @override
  String get homeNotifications => 'Уведомления';

  @override
  String get homeWateringTime => 'Время полива';

  @override
  String get homeWateringNotification =>
      'Ваши комнатные растения нуждаются в поливе.';

  @override
  String get homeWelcome => 'Добро пожаловать!';

  @override
  String get homeWelcomeNotification =>
      'Добро пожаловать в Botaniq. Начните с добавления вашего первого растения.';

  @override
  String get homeTenMinutesAgo => '10 минут назад';

  @override
  String get homeOneDayAgo => '1 день назад';

  @override
  String get homeQuickActions => 'Быстрые действия';

  @override
  String get homeIdentifyCamera => 'Идентифицируйтесь с помощью камеры';

  @override
  String get homeTomorrow => 'Завтра';

  @override
  String get homeNoTasks => 'Заданий на этот день нет!';

  @override
  String get homeAllCared => 'О ваших растениях забота 🌿';

  @override
  String get homeOverdue => 'ПРОСРОЧЕНО';

  @override
  String get homeInstructions => 'Инструкции';

  @override
  String homeRequiredAmount(String amount) {
    return 'Требуется: $amount';
  }

  @override
  String get homeLater => 'Позже';

  @override
  String get homeMarkDone => 'Отметить как выполненное';

  @override
  String get homeSickPlants => 'Плант Клиника';

  @override
  String homeSickCount(int count) {
    return '$count Больной';
  }

  @override
  String get homeGreetingMorning => 'Доброе утро';

  @override
  String get homeGreetingAfternoon => 'Добрый день';

  @override
  String get homeGreetingEvening => 'Добрый вечер';

  @override
  String get homeTodayTasks => 'Сегодняшние задачи';

  @override
  String get homeTomorrowTasks => 'Задачи на завтра';

  @override
  String homeDateTasks(String date) {
    return '$date Задачи';
  }

  @override
  String get commonSkip => 'Пропустить';

  @override
  String get commonContinue => 'Продолжить';

  @override
  String get commonClose => 'Закрыть';

  @override
  String get commonDelete => 'Удалить';

  @override
  String get commonBack => 'Вернуться назад';

  @override
  String get commonUnknown => 'Неизвестно';

  @override
  String get wizardSaveGarden => 'Сохранить и добавить в сад';

  @override
  String wizardPlantAdded(String name) {
    return '$name добавлен в ваш сад! 🌿';
  }

  @override
  String get wizardRoomTitle => 'Где ваш завод?';

  @override
  String get wizardRoomSubtitle =>
      'Классифицируйте свое растение по комнатам, чтобы легко управлять им.';

  @override
  String get wizardLivingRoom => 'Гостиная';

  @override
  String get wizardBedroom => 'Спальня';

  @override
  String get wizardKitchen => 'Кухня';

  @override
  String get wizardOffice => 'Офис';

  @override
  String get wizardBathroom => 'Ванная комната';

  @override
  String get wizardBalcony => 'Балкон';

  @override
  String get wizardLightTitle => 'Как свет в этом месте?';

  @override
  String get wizardLightSubtitle =>
      'Свет – один из важнейших факторов здоровья вашего растения.';

  @override
  String get wizardDirectSun => 'Прямое Солнце';

  @override
  String get wizardDirectSunDescription =>
      'Нефильтрованный солнечный свет прямо на растение';

  @override
  String get wizardBrightIndirect => 'Яркий непрямой';

  @override
  String get wizardBrightIndirectDescription =>
      'Рядом с окном, выходящим на восток или запад.';

  @override
  String get wizardMediumLight => 'Средний свет';

  @override
  String get wizardMediumLightDescription => 'В нескольких футах от окна';

  @override
  String get wizardLowLight => 'Низкое освещение';

  @override
  String get wizardLowLightDescription =>
      'Вдали от окон или при искусственном освещении';

  @override
  String get wizardDistanceTitle => 'Расстояние до окна';

  @override
  String get wizardDistanceSubtitle =>
      'Выберите примерное расстояние до ближайшего окна.';

  @override
  String get wizardMoreThanFiveMeters => 'Более 5 м';

  @override
  String get wizardActiveHoursTitle => 'Активное световое время';

  @override
  String get wizardActiveHoursSubtitle =>
      'Сколько часов прямого или яркого света получает это место?';

  @override
  String wizardHour(int count) {
    return '$count час';
  }

  @override
  String wizardHours(int count) {
    return '$count часов';
  }

  @override
  String get wizardSixPlusHours => '6+ часов';

  @override
  String get wizardRepottedTitle =>
      'Когда это растение в последний раз пересаживали?';

  @override
  String get wizardRepottedSubtitle =>
      'Свежая почва имеет решающее значение для счастливого растения.';

  @override
  String get wizardRecently => 'Недавно (менее 3 месяцев)';

  @override
  String get wizardSixMonthsAgo => '6 месяцев назад';

  @override
  String get wizardOneYearAgo => '1 год назад';

  @override
  String get wizardTwoYearsAgo => '2+ года назад';

  @override
  String get wizardDontKnow => 'я не знаю';

  @override
  String get wizardPotTitle => 'Из какого материала горшок?';

  @override
  String get wizardPotSubtitle =>
      'Материал горшка влияет на скорость высыхания почвы.';

  @override
  String get wizardPlasticPot => 'Пластик / Детская';

  @override
  String get wizardTerracottaPot => 'Терракота';

  @override
  String get wizardCeramicPot => 'Керамика / Глазурованная';

  @override
  String get wizardMetalPot => 'Металл';

  @override
  String get wizardWateredTitle =>
      'Когда вы в последний раз поливали это растение?';

  @override
  String get wizardWateredSubtitle =>
      'Это помогает рассчитать точное время следующего полива.';

  @override
  String get wizardToday => 'Сегодня';

  @override
  String get wizardYesterday => 'Вчера';

  @override
  String get wizardFewDaysAgo => 'Несколько дней назад';

  @override
  String get wizardWeekAgo => 'Неделю назад';

  @override
  String get wizardMoreWeekAgo => 'Больше недели назад';

  @override
  String get historyTitle => 'История поиска';

  @override
  String get historyClearTitle => 'Очистить историю';

  @override
  String get historyClearMessage =>
      'Вся история поиска и сканирования будет удалена. Вы уверены?';

  @override
  String get historyClearTooltip => 'Очистить историю';

  @override
  String get historyEmptyTitle => 'Нет истории поиска';

  @override
  String get historyEmptySubtitle =>
      'Здесь появятся растения, отсканированные камерой или найденные.';

  @override
  String get historyNoDetails => 'Подробная информация недоступна.';

  @override
  String get historyRegularWater => 'Регулярный полив';

  @override
  String get historyIndirectLight => 'Непрямой свет';

  @override
  String get historyDescription => 'Описание';

  @override
  String get historyWatering => 'Полив';

  @override
  String get historyLight => 'Свет';

  @override
  String get historyRecently => 'Недавно';

  @override
  String historyMinutesAgo(int minutes) {
    return '$minutes мин. назад';
  }

  @override
  String historyHoursAgo(int hours) {
    return '$hours часов назад';
  }

  @override
  String get historyYesterday => 'Вчера';

  @override
  String get historyPlantRecord => 'Запись поиска растений';

  @override
  String get photoWholeSpecimen => 'Фото целиком\nрастение или гриб';

  @override
  String get photoWholeSpecimenSubtitle =>
      'Держите весь образец по центру рамки для лучшей идентификации.';

  @override
  String get photoCorrect => 'Правильно';

  @override
  String get photoTooClose => 'Слишком близко';

  @override
  String get photoInstructions => 'Инструкции';

  @override
  String get photoOpenCamera => 'Я понимаю, откройте камеру';

  @override
  String get scannerPlant => 'Завод';

  @override
  String get scannerMushroom => 'Гриб';

  @override
  String get scannerIdentifyingPlant => 'Определение растения...';

  @override
  String get scannerIdentifyingMushroom => 'Определение гриба...';

  @override
  String get scannerCapture => 'Сделать фото и отсканировать';

  @override
  String get scannerFailed =>
      'Сканирование не удалось. Пожалуйста, попробуйте еще раз.';

  @override
  String scannerError(String error) {
    return 'Произошла ошибка: $error.';
  }

  @override
  String get scannerUnknownPlant => 'Неизвестное растение';

  @override
  String get scannerUnknownMushroom => 'Неизвестный гриб';

  @override
  String get scheduleTitle => 'Расписание';

  @override
  String get scheduleTodayTask => 'Сегодняшние задачи';

  @override
  String get scheduleNoTasks => 'На сегодня нет задач!';

  @override
  String get scheduleInstructions => 'Инструкции';

  @override
  String scheduleRequired(String amount) {
    return 'Требуется: $amount';
  }

  @override
  String get scheduleRemindLater => 'Напомнить позже';

  @override
  String get scheduleDone => 'Готово';

  @override
  String get scheduleCareFallback => 'Позаботьтесь о своем растении.';

  @override
  String get chatDoctorTitle => 'ИИ-доктор растений';

  @override
  String chatPatient(String name) {
    return 'Пациент: $name';
  }

  @override
  String get chatAnalyzing => 'Анализ...';

  @override
  String chatHint(String name) {
    return 'Спросите о $name...';
  }

  @override
  String chatWelcome(String name) {
    return 'Здравствуйте! 🌿 Я ваш ИИ-доктор растений. Как я могу помочь с $name?\n\nМогу поставить диагноз по фото или ответить на ваши вопросы по уходу.';
  }

  @override
  String chatContinueWelcome(String name) {
    return 'Здравствуйте! Давайте продолжим с $name. 🌱';
  }

  @override
  String get chatQuestionYellowing => 'Что является причиной желтых листьев?';

  @override
  String get chatQuestionTreatment => 'Как лечить это растение?';

  @override
  String get chatQuestionWatering => 'Стоит ли менять частоту полива?';

  @override
  String get chatQuestionFertilizer => 'Какое удобрение следует использовать?';

  @override
  String get chatPhotoSent => 'Фото отправлено';

  @override
  String get chatAnalyzePhoto => 'Проанализируйте фотографию';

  @override
  String get chatDiagnosisUnknown => 'Диагноз не удалось установить';

  @override
  String get chatNoTreatment => 'Нет рекомендаций по лечению';

  @override
  String get chatRecoveryUnknown => 'Неизвестно';

  @override
  String get chatUnableIdentify => 'Неопознанное растение';

  @override
  String chatError(String error) {
    return 'Извините, произошла ошибка: $error. Пожалуйста, попробуйте еще раз.';
  }

  @override
  String get chatCareTips => 'Советы по уходу';

  @override
  String get chatPlantLabel => 'Завод';

  @override
  String get chatDiagnosisLabel => 'Диагностика';

  @override
  String get chatTreatmentLabel => 'Лечение';

  @override
  String get chatUrgencyLabel => 'срочность';

  @override
  String get chatRecoveryLabel => 'Предполагаемое восстановление';

  @override
  String get discoverMonsteraTitle => 'Секрет роста монстеры';

  @override
  String get discoverIndoorPlants => 'Комнатные Растения';

  @override
  String get discoverSucculentWatering => 'Руководство по поливу суккулентов';

  @override
  String get discoverCacti => 'Кактусы и суккуленты';

  @override
  String get discoverHerbSoil => 'Лучшие типы почвы для трав';

  @override
  String get discoverHerbs => 'Травы';

  @override
  String get discoverPropagation =>
      'Распространение 101: Руководство для начинающих';

  @override
  String get discoverPests =>
      'Распространенные вредители и способы борьбы с ними';

  @override
  String get discoverRepotting => 'Пересадка: когда и как?';

  @override
  String discoverMinutesRead(int minutes) {
    return '$minutes минута чтения';
  }

  @override
  String get skip => 'Пропустить';

  @override
  String get skipForNow => 'Пропустить сейчас';

  @override
  String get continueLabel => 'Продолжить';

  @override
  String get getStarted => 'Начать';

  @override
  String get nextStep => 'Следующий шаг';

  @override
  String get maybeLater => 'Может быть, позже';

  @override
  String get emailAddress => 'Адрес электронной почты';

  @override
  String get password => 'Пароль';

  @override
  String get firstName => 'Имя';

  @override
  String get lastName => 'Фамилия';

  @override
  String get login => 'Войти';

  @override
  String get signUp => 'Зарегистрироваться';

  @override
  String get welcomeBack => 'Добро пожаловать обратно';

  @override
  String get loginSubtitle => 'Войдите, чтобы продолжить уход за своим садом.';

  @override
  String get signUpSubtitle =>
      'Присоединяйтесь к нам и начните строить свой зеленый заповедник.';

  @override
  String get forgotPassword => 'Забыли пароль?';

  @override
  String get enterEmailPassword =>
      'Пожалуйста, введите свой адрес электронной почты и пароль.';

  @override
  String get fillAllFields => 'Пожалуйста, заполните все поля.';

  @override
  String authError(String error) {
    return 'Что-то пошло не так: $error';
  }

  @override
  String get loginWith => 'Или войдите через';

  @override
  String get signUpWith => 'Или зарегистрируйтесь через';

  @override
  String get noAccount => 'У вас нет учетной записи?';

  @override
  String get alreadyAccount => 'У вас уже есть аккаунт?';

  @override
  String get developerSession => 'Создать сеанс разработчика';

  @override
  String get welcomeBotaniq => 'Добро пожаловать в Botaniq';

  @override
  String get loginOptionsSubtitle =>
      'Войдите или зарегистрируйтесь, чтобы создать резервную копию своих растений, расписаний и предпочтений.';

  @override
  String get notificationAccessTitle => 'Не пропускайте полив';

  @override
  String get notificationAccessSubtitle =>
      'Мы нежно напомним вам, когда придет время позаботиться о ваших зеленых друзьях. Уход за растениями стал легким и без стресса.';

  @override
  String get notificationTurnOn => 'Включите напоминания';

  @override
  String get creatingClimate => 'Анализ микроклимата...';

  @override
  String get creatingSchedules => 'Составление графика ухода...';

  @override
  String get creatingSanctuary => 'Подготовка вашего зеленого заповедника...';

  @override
  String get locationAccessTitle => 'Доступ к местоположению';

  @override
  String get locationAccessSubtitle =>
      'Персонализируйте уход за растениями в зависимости от местного микроклимата.';

  @override
  String get locationRecommendation => 'Местные рекомендации';

  @override
  String get locationRecommendationSubtitle =>
      'Растения, которые хорошо растут в климате вашего региона';

  @override
  String get locationWeather => 'Умная синхронизация погоды';

  @override
  String get locationWeatherSubtitle =>
      'Расписание адаптируется к местному дождю в режиме реального времени.';

  @override
  String get locationAlerts => 'Оповещения о заморозках и жаре';

  @override
  String get locationAlertsSubtitle =>
      'Получайте уведомления до того, как наступит экстремальная погода';

  @override
  String get locationEnable => 'Включить доступ к местоположению';

  @override
  String get wherePlantsTitle => 'Где ваши растения?';

  @override
  String get wherePlantsSubtitle =>
      'Выберите все, что подходит, чтобы настроить график ухода.';

  @override
  String get locationIndoor => 'Крытый';

  @override
  String get locationIndoorSubtitle => 'Гостиная, спальня, кабинет';

  @override
  String get locationBalcony => 'Балкон';

  @override
  String get locationBalconySubtitle =>
      'Горшечные растения на веранде или террасе';

  @override
  String get locationGarden => 'Сад';

  @override
  String get locationGardenSubtitle => 'Наземные растения и клумбы';

  @override
  String get helpTitleBefore => 'Что мы можем';

  @override
  String get helpTitleHighlight => 'помочь тебе';

  @override
  String get helpTitleAfter => 'с?';

  @override
  String get helpSubtitle =>
      'Выберите одну или несколько целей, чтобы персонализировать свой сад.';

  @override
  String get helpHeal => 'Исцелить больных\nрастения';

  @override
  String get helpCare => 'Уход\nнапоминания';

  @override
  String get helpIdentify => 'Определить\nвид';

  @override
  String get helpJournal => 'Рост\nжурнал';

  @override
  String get helpOther => 'Что-то еще';

  @override
  String get journeyTitle => 'Ваше зеленое путешествие';

  @override
  String get journeySubtitle =>
      'Выберите уровень ухода, который вы хотите предоставить.';

  @override
  String get journeyCasualLabel => 'СЛУЧАЙНЫЙ';

  @override
  String get journeyCasualTitle => 'Низкие эксплуатационные расходы';

  @override
  String get journeyCasualSubtitle =>
      'Я просто хочу, чтобы мои простые растения оставались живыми и процветающими.';

  @override
  String get journeyEnthusiastLabel => 'ЭНТУЗИАСТ';

  @override
  String get journeyEnthusiastTitle => 'Сбалансированный уход';

  @override
  String get journeyEnthusiastSubtitle =>
      'Мне нравится проводить некоторое время в неделю с моей растущей коллекцией.';

  @override
  String get journeyObsessedLabel => 'Одержимый';

  @override
  String get journeyObsessedTitle => 'Экстраординарный родитель растений';

  @override
  String get journeyObsessedSubtitle =>
      'Я живу ради своих растений и хочу, чтобы у меня были профессиональные графики для моих домашних джунглей.';

  @override
  String get masteryTitleBefore => 'Как твой';

  @override
  String get masteryTitleHighlight => 'зеленый\nбольшой палец';

  @override
  String get masteryTitleAfter => 'в последнее время?';

  @override
  String get masterySubtitle =>
      'Будьте честны: мы все когда-то были «серийными убийцами». Выберите свое текущее мастерство.';

  @override
  String get masteryKiller => 'Серийный убийца';

  @override
  String get masteryKillerSubtitle =>
      'Даже мои пластиковые растения выглядят обеспокоенными, когда я вхожу в комнату.';

  @override
  String get masteryAccidental => 'Случайный Родитель';

  @override
  String get masteryAccidentalSubtitle =>
      'Мой кактус прожил две недели. Мы еще узнаем друг друга.';

  @override
  String get masteryGrowth => 'Мышление роста';

  @override
  String get masteryGrowthSubtitle =>
      'У большинства моих друзей есть листья. Я знаю своих Монстер от своего Потоса.';

  @override
  String get masteryWhisperer => 'Заклинатель растений';

  @override
  String get masteryWhispererSubtitle =>
      'Я размножаю редкие растения и свободно говорю на ботанической латыни.';

  @override
  String get onboardingOneTitle => 'Берегите себя\nваших растений';

  @override
  String get onboardingOneHighlight => 'Как профессионал';

  @override
  String get onboardingOneSubtitle =>
      'Умное расписание и мгновенная идентификация для ваших городских джунглей.';

  @override
  String get onboardingOneBadge => 'УХОД НА УПРАВЛЕНИИ ИИ';

  @override
  String get onboardingAiScan => 'AI-сканирование';

  @override
  String get onboardingSmartWater => 'Умная вода';

  @override
  String get onboardingLightTracking => 'Световое отслеживание';

  @override
  String get onboardingTwoTitle => 'Определите любой\nЗавод в';

  @override
  String get onboardingTwoHighlight => 'Секунды';

  @override
  String get onboardingTwoSubtitle =>
      'Сфотографируйте, чтобы узнать его название, вид и требования к уходу.';

  @override
  String get onboardingTwoBadge => 'БОТАНИЧЕСКИЙ ЭКСПЕРТ';

  @override
  String get onboardingSnapPhoto => 'Сфотографировать';

  @override
  String get onboardingAccurateResult => 'Точный результат';

  @override
  String get onboardingPlantWiki => 'Растение вики';

  @override
  String get onboardingThreeTitle => 'Никогда не забывай\nПоливать';

  @override
  String get onboardingThreeHighlight => 'снова';

  @override
  String get onboardingThreeSubtitle =>
      'Получайте напоминания, соответствующие потребностям вашего растения и окружающей среде.';

  @override
  String get onboardingThreeBadge => 'УМНЫЕ РАСПИСАНИЯ';

  @override
  String get onboardingReminders => 'Напоминания';

  @override
  String get onboardingClimateData => 'Климатические данные';

  @override
  String get onboardingHealthyGrowth => 'Здоровый рост';

  @override
  String get onboardingCommunity =>
      'Присоединяйтесь к более чем 50 000 родителям растений';

  @override
  String get onboardingAgreement =>
      'ПРОДОЛЖАЯ, ВЫ СОГЛАШАЕТЕСЬ С НАШИМИ УСЛОВИЯМИ И ПОЛИТИКОЙ КОНФИДЕНЦИАЛЬНОСТИ';

  @override
  String get termsTitle => 'Условия и политика';

  @override
  String get termsUpdated => 'Последнее обновление: июль 2026 г.';

  @override
  String get termsUseTitle => '1. Условия использования';

  @override
  String get termsUseBody =>
      'Получая доступ к Botaniq или используя его, вы соглашаетесь с настоящими Условиями использования и применимыми законами. Если вы не согласны, вы не можете использовать услугу.';

  @override
  String get termsPrivacyTitle => '2. Конфиденциальность пользователя';

  @override
  String get termsPrivacyBody =>
      'Мы собираем только те персональные данные, которые необходимы для составления индивидуального графика ухода за растениями. Мы не продаем ваши персональные данные третьим лицам.';

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
  String get termsPlantTitle => '3. Данные о заводе';

  @override
  String get termsPlantBody =>
      'Информация об уходе за растениями, идентификации и диагностике предоставлена в информационных целях. Результаты искусственного интеллекта не всегда могут быть правильными, поэтому наблюдайте за своим растением и обратитесь к эксперту, чтобы исключить серьезные риски.';

  @override
  String get termsLiabilityTitle => '6. Disclaimers, Liability, and Indemnity';

  @override
  String get termsLiabilityBody =>
      'Botaniq is provided \"as is\" and \"as available,\" without warranties of any kind, express or implied, including accuracy, reliability, or fitness for a particular purpose. To the fullest extent permitted by law, we and our service providers are not liable for any indirect, incidental, special, or consequential damages, or for any loss of data, plants, or property arising from your use of the service, and our total liability for any claim is limited to the amount you paid us, if any, in the twelve months before the claim. You agree to indemnify and hold us harmless from claims arising from your use of the service, your content, or your violation of these Terms or applicable law.';

  @override
  String get termsPremiumTitle => '4. Премиум-подписки';

  @override
  String get termsPremiumBody =>
      'Ваша ежемесячная или годовая подписка Premium списывается с вашей учетной записи Apple или Google после подтверждения покупки. Он продлевается автоматически, если не отменен по крайней мере за 24 часа до окончания текущего периода. Вы можете управлять им или отменить его в настройках учетной записи вашего магазина. Запросы на возврат средств обрабатываются в соответствии с применимой политикой магазина.';

  @override
  String get termsLawTitle => '8. Governing Law and Changes';

  @override
  String get termsLawBody =>
      'These Terms are governed by the laws of the jurisdiction in which we operate, without regard to conflict-of-law principles, and any dispute will be resolved under that jurisdiction\'s applicable procedures to the fullest extent permitted by law. We may update these Terms and our data practices at any time by posting the revised version in the app.';

  @override
  String get termsClosing =>
      'Наслаждайтесь душевным спокойствием и счастливыми растениями.';

  @override
  String get weatherTitle => 'Погода';

  @override
  String get weatherSunnyTip =>
      'Сегодня солнечно — проверьте почву перед поливом.';

  @override
  String get weatherCloudyTip =>
      'Пасмурная погода замедляет испарение; воды немного меньше.';

  @override
  String get weatherRainyTip =>
      'Дождливо и влажно — избегайте чрезмерного полива уличных растений.';

  @override
  String get weatherStormTip =>
      'Ненастная погода — переставьте хрупкие горшки в защищенное место.';

  @override
  String get weatherSnowTip =>
      'Холодно и снежно — защитите растения от температурного шока.';
}
