// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Botaniq';

  @override
  String get settings => 'Settings';

  @override
  String get preferences => 'Preferences';

  @override
  String get darkMode => 'Dark Mode';

  @override
  String get metricSystem => 'Metric System';

  @override
  String get metricSystemSubtitle => 'Use Celsius and Meters';

  @override
  String get account => 'Account';

  @override
  String get editProfile => 'Edit Profile';

  @override
  String get changePassword => 'Change Password';

  @override
  String get subscriptionManagement => 'Subscription Management';

  @override
  String get premium => 'Premium';

  @override
  String get language => 'Language';

  @override
  String get languageSubtitle => 'Change app language';

  @override
  String get selectLanguage => 'Select Language';

  @override
  String get systemLanguage => 'System Language';

  @override
  String get english => 'English';

  @override
  String get turkish => 'Türkçe';

  @override
  String get languageChanged => 'Language changed successfully.';

  @override
  String get languageSearchHint => 'Search languages';

  @override
  String get languageRecommended => 'Recommended';

  @override
  String get languageWelcomeTitle => 'Choose your language';

  @override
  String get languageWelcomeSubtitle =>
      'Select the language you want to use in Botaniq. You can change it anytime.';

  @override
  String get languageUseSystem => 'Use device language';

  @override
  String get preferenceSystem => 'Use system setting';

  @override
  String get themeLight => 'Light';

  @override
  String get themeDark => 'Dark';

  @override
  String get themeSelectionTitle => 'Choose appearance';

  @override
  String get measurementMetric => 'Metric';

  @override
  String get measurementImperial => 'Imperial';

  @override
  String get measurementSelectionTitle => 'Choose measurement system';

  @override
  String get settingsSubtitle => 'Shape Botaniq around your own care rhythm.';

  @override
  String get settingsLocalPreference => 'Saved on this device';

  @override
  String get settingsDarkModeSubtitle =>
      'A calmer palette for low-light moments';

  @override
  String get settingsAccountSubtitle => 'Identity, access and membership';

  @override
  String get settingsEditProfileSubtitle =>
      'Name, location and care preferences';

  @override
  String get settingsPasswordSubtitle =>
      'Send a secure reset link to your email';

  @override
  String get settingsSubscriptionSubtitle => 'Premium plan and billing details';

  @override
  String get settingsPasswordResetSent => 'Password reset email sent.';

  @override
  String get settingsComingSoon => 'This space is still growing.';

  @override
  String get subscriptionPageTitle => 'Premium Membership';

  @override
  String get subscriptionHeroEyebrow => 'BOTANIQ PREMIUM';

  @override
  String get subscriptionHeroTitle => 'Smarter care for every plant';

  @override
  String get subscriptionHeroSubtitle =>
      'Unlock every premium care tool and grow your green space with confidence.';

  @override
  String get subscriptionBenefitsTitle => 'Everything in Premium';

  @override
  String get subscriptionBenefitIdentification =>
      'Unlimited plant identification and health analysis';

  @override
  String get subscriptionBenefitCare => 'Personalized care plans and reminders';

  @override
  String get subscriptionBenefitInsights =>
      'Expert content and advanced care insights';

  @override
  String get subscriptionMonthlyPlan => 'Monthly';

  @override
  String get subscriptionAnnualPlan => 'Annual';

  @override
  String subscriptionPerMonth(String price) {
    return '$price / month';
  }

  @override
  String subscriptionPerYear(String price) {
    return '$price / year';
  }

  @override
  String get subscriptionBestValue => 'BEST VALUE';

  @override
  String subscriptionSavePercent(int percent) {
    return 'Save $percent%';
  }

  @override
  String get subscriptionContinue => 'Unlock Premium';

  @override
  String get subscriptionRestorePurchases => 'Restore Purchases';

  @override
  String get subscriptionRestoring => 'Restoring...';

  @override
  String get subscriptionManage => 'Manage Subscription';

  @override
  String get subscriptionActiveTitle => 'Your Premium membership is active';

  @override
  String get subscriptionActiveSubtitle =>
      'You have access to every premium feature.';

  @override
  String subscriptionRenewsOn(String date) {
    return 'Renews on $date';
  }

  @override
  String subscriptionExpiresOn(String date) {
    return 'Active until $date';
  }

  @override
  String get subscriptionAutoRenewDisclosure =>
      'Payment is charged to your Apple or Google account. The subscription renews automatically unless canceled at least 24 hours before the end of the current period. You can manage or cancel it anytime in your store account settings.';

  @override
  String get subscriptionTermsLink => 'Terms of Use';

  @override
  String get subscriptionPrivacyLink => 'Privacy Policy';

  @override
  String get subscriptionPurchaseSuccess =>
      'Your Premium membership is now active.';

  @override
  String get subscriptionRestoreSuccess =>
      'Your Premium membership was restored.';

  @override
  String get subscriptionNothingToRestore =>
      'No active membership was found for this store account.';

  @override
  String get subscriptionPaymentPending =>
      'The payment is awaiting store approval. Your membership will activate automatically once approved.';

  @override
  String get subscriptionErrorGeneric =>
      'The operation could not be completed. Please try again.';

  @override
  String get subscriptionErrorNetwork =>
      'Check your internet connection and try again.';

  @override
  String get subscriptionErrorNotAllowed =>
      'This device or store account is not allowed to make purchases.';

  @override
  String get subscriptionErrorStore =>
      'The store could not be reached. Please try again shortly.';

  @override
  String get subscriptionMissingConfiguration =>
      'The RevenueCat key is missing from this build.';

  @override
  String get subscriptionUnsupported =>
      'Subscriptions are available only in the iOS and Android apps.';

  @override
  String get subscriptionProductsUnavailable =>
      'Monthly and annual products could not be loaded. Check the RevenueCat offering configuration.';

  @override
  String get subscriptionRetry => 'Try Again';

  @override
  String get subscriptionFree => 'Free';

  @override
  String get homeGoodMorning => 'Hello,';

  @override
  String homePersonalGreeting(String greeting, String name) {
    return '$greeting, $name 👋';
  }

  @override
  String get homeEmptyGarden => 'Your garden is empty';

  @override
  String get homeEmptyGardenSubtitle =>
      'Start building your green sanctuary\nby adding your first plant.';

  @override
  String get homeAddFirstPlant => 'Add First Plant';

  @override
  String get homeMyPlants => 'My Plants';

  @override
  String get homeViewAll => 'View All';

  @override
  String get homeSmartCareReminders => 'Smart Care Reminders';

  @override
  String get homeWatering => 'Watering';

  @override
  String get homeWateringSubtitle => 'Soil tracking';

  @override
  String get homeFertilizing => 'Fertilizing';

  @override
  String get homeFertilizingSubtitle => 'Nutrient alerts';

  @override
  String get gardenTitle => 'My Garden';

  @override
  String get gardenAllPlants => 'All Plants';

  @override
  String get gardenNeedsWater => 'Needs Water';

  @override
  String get gardenIndoor => 'Indoor';

  @override
  String get gardenNoPlants => 'No plants yet.\nTap + to add your first plant!';

  @override
  String get gardenNoPlantsCategory => 'No plants in this category.';

  @override
  String get discoverTitle => 'Discover';

  @override
  String get discoverSearchHint => 'Search plants, articles, guides...';

  @override
  String get discoverLatestArticles => 'Latest Articles';

  @override
  String get discoverSeeAll => 'See all';

  @override
  String get discoverTrendingGuides => 'Trending Guides';

  @override
  String get healthyTitle => 'Care Center';

  @override
  String get healthySubtitle => 'Touch the soul of your plants, talk to them.';

  @override
  String get healthyTabDoctor => 'Doctor';

  @override
  String get healthyTabHospital => 'Hospital';

  @override
  String get healthyTabDiscover => 'Discover';

  @override
  String get profileTitle => 'My Profile';

  @override
  String get profileEditProfile => 'Edit Profile';

  @override
  String get profileOverview => 'Overview';

  @override
  String get profileSettingsTab => 'Settings';

  @override
  String get profileGardenerLevel => 'Gardener Level';

  @override
  String get profileTotalPlants => 'Total Plants';

  @override
  String get profileCompletedTasks => 'Completed Tasks';

  @override
  String get profileWeeklyActivity => 'Weekly Care Activity';

  @override
  String get profileGeneral => 'General';

  @override
  String get profileAppSettings => 'App Settings';

  @override
  String get profileNotificationPrefs => 'Notification Preferences';

  @override
  String get profileSupportLegal => 'Support & Legal';

  @override
  String get profileHelpCenter => 'Help Center';

  @override
  String get profileTerms => 'Terms of Use & Policies';

  @override
  String get profileSignOut => 'Sign Out';

  @override
  String get profileDeleteAccount => 'Delete Account';

  @override
  String get profileSubtitle =>
      'Your garden story, progress and personal space.';

  @override
  String get profileGardenPassport => 'GARDEN PASSPORT';

  @override
  String get profileThisWeek => 'This week';

  @override
  String get profileQuietWeek =>
      'A quiet week — your next care moment will appear here.';

  @override
  String get profileActiveWeek => 'Your care rhythm is alive and growing.';

  @override
  String get profileAppSettingsSubtitle => 'Language, units and AI connection';

  @override
  String get profileNotificationPrefsSubtitle =>
      'Choose which care moments reach you';

  @override
  String get profileHelpCenterSubtitle => 'Answers and quick guidance';

  @override
  String get profileTermsSubtitle => 'Privacy, terms and policies';

  @override
  String get profileAccountActions => 'Account actions';

  @override
  String get profileSignOutQuestion => 'Are you sure you want to sign out?';

  @override
  String get profileDeleteAccountWarning =>
      'Your account will be deleted: your personal information (name, email, profile photo) is permanently removed and your account is anonymized. This cannot be undone.';

  @override
  String get cancel => 'Cancel';

  @override
  String get continueAction => 'Continue';

  @override
  String get profileTitleNew => 'New Gardener 🌱';

  @override
  String get profileTitleSprout => 'Sprout Friend 🌿';

  @override
  String get profileTitleLeaf => 'Leaf Lover ☘️';

  @override
  String get profileTitleSkilled => 'Skilled Gardener 🏡';

  @override
  String get profileTitleMaster => 'Green Thumb Master 👑';

  @override
  String get profileNextLevelStart =>
      'Add your first plant and start your gardening adventure!';

  @override
  String profileNextLevelLeaf(int count) {
    return 'Only $count plants left to become Leaf Lover.';
  }

  @override
  String profileNextLevelSkilled(int count) {
    return 'Only $count plants left to become Skilled Gardener.';
  }

  @override
  String profileNextLevelMaster(int count) {
    return 'Only $count plants left to become Green Thumb Master.';
  }

  @override
  String get profileNextLevelMax =>
      'You are at the top of your garden, congratulations!';

  @override
  String get navHome => 'Home';

  @override
  String get navGarden => 'Garden';

  @override
  String get navClinic => 'Clinic';

  @override
  String get navProfile => 'Profile';

  @override
  String get scanPlant => 'Scan Plant';

  @override
  String get deletePlantTitle => 'Remove this plant?';

  @override
  String get deletePlantMessage =>
      'The plant, its care tasks and Clinic records will be permanently removed from your account.';

  @override
  String get deletePlantAction => 'Remove Plant';

  @override
  String get deletePlantNotFound =>
      'The plant could not be found or has already been removed.';

  @override
  String deletePlantError(String error) {
    return 'The plant could not be removed: $error';
  }

  @override
  String get profileChoosePhoto => 'Choose Profile Photo';

  @override
  String get profileFullName => 'Full Name';

  @override
  String get profileFullNameHint => 'Enter your full name';

  @override
  String get profileNickname => 'Nickname';

  @override
  String get profileNicknameHint => 'How should we call you?';

  @override
  String get profileAge => 'Age';

  @override
  String get profileAgeHint => '1–120';

  @override
  String get profileAgeValidation => 'Please enter an age between 1 and 120.';

  @override
  String profileLoadError(String error) {
    return 'Could not load profile: $error';
  }

  @override
  String get languageEnglish => 'English';

  @override
  String get languageTurkish => 'Turkish';

  @override
  String get profileEmailReadOnly => 'Email Address (Read Only)';

  @override
  String get profileEmailHint => 'Enter your email';

  @override
  String get profileLocation => 'Location';

  @override
  String get profileLocationHint => 'City, Country';

  @override
  String get profileSaveChanges => 'Save Changes';

  @override
  String get profileUpdated => 'Your profile has been updated.';

  @override
  String profileSaveError(String error) {
    return 'Profile could not be saved: $error';
  }

  @override
  String get notificationWateringTitle => 'Watering Reminders';

  @override
  String get notificationWateringSubtitle =>
      'Get notified when it’s time to water';

  @override
  String get notificationFertilizerTitle => 'Fertilizer Reminders';

  @override
  String get notificationFertilizerSubtitle =>
      'Seasonal feeding alerts for your plants';

  @override
  String get notificationTitle => 'Notifications';

  @override
  String get notificationPlantCareAlerts => 'Plant Care Alerts';

  @override
  String get notificationOther => 'Other Notifications';

  @override
  String get notificationWeatherTitle => 'Weather Alerts';

  @override
  String get notificationWeatherSubtitle => 'Extreme weather warnings';

  @override
  String get notificationArticlesTitle => 'New Articles';

  @override
  String get notificationArticlesSubtitle => 'Tips and tricks for your garden';

  @override
  String get gardenMyPlantFallback => 'My Plant';

  @override
  String get gardenClinicBadge => 'In Clinic';

  @override
  String get wateringNever => 'Last watered: Never';

  @override
  String wateringLastDate(String date) {
    return 'Last watered: $date';
  }

  @override
  String wateringInterval(int days) {
    return 'Every $days days';
  }

  @override
  String get wateringNeverDue => 'Not watered yet • Water today';

  @override
  String wateringOverdue(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days days overdue',
      one: '1 day overdue',
      zero: 'Water today',
    );
    return '$_temp0';
  }

  @override
  String get wateringDueToday => 'Water today';

  @override
  String get wateringDueTomorrow => 'Water tomorrow';

  @override
  String wateringDueInDays(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'Water in $days days',
      one: 'Water in 1 day',
      zero: 'Water today',
    );
    return '$_temp0';
  }

  @override
  String get plantUnknown => 'Unknown Plant';

  @override
  String get plantSpeciesFallback => 'Plant Species';

  @override
  String get plantDifficultyMedium => 'Medium';

  @override
  String get plantAbout => 'About';

  @override
  String get plantLocationEnvironment => 'Location & Environment';

  @override
  String get plantCareProtocol => 'Care Protocol';

  @override
  String get plantCareHistory => 'Last 10 Days Care History';

  @override
  String get plantHealthy => 'Healthy';

  @override
  String get plantInClinic => 'In Clinic';

  @override
  String get plantDifficulty => 'Difficulty';

  @override
  String get plantToxicity => 'Toxicity';

  @override
  String get plantEnvironment => 'Environment';

  @override
  String get plantLightNeed => 'Light Need';

  @override
  String get plantToxicPets => 'Toxic to pets';

  @override
  String get plantNonToxic => 'Non-toxic';

  @override
  String get plantIndoor => 'Indoor';

  @override
  String get plantBrightIndirect => 'Bright Indirect';

  @override
  String get plantInfoUnavailable =>
      'Verified information is not available yet.';

  @override
  String get plantIdealClimate => 'Ideal Climate';

  @override
  String get plantHumidity => 'Humidity';

  @override
  String get plantTemperatureRange => 'Temperature Range';

  @override
  String get plantWateringFrequency => 'Watering Frequency';

  @override
  String plantWateringFrequencyValue(String interval) {
    return 'Water $interval.';
  }

  @override
  String get plantNextWatering => 'Next Watering';

  @override
  String get plantWateringProtocol => 'Watering Protocol';

  @override
  String get plantSoilProtocol => 'Soil';

  @override
  String get plantFeedingProtocol => 'Feeding Protocol';

  @override
  String get plantPruningCleaning => 'Pruning & Cleaning';

  @override
  String get plantPruningFallback =>
      'Wipe leaves monthly. Prune dead or yellowing leaves to encourage growth.';

  @override
  String get plantHistoryEmpty => 'No care history for the last 10 days.';

  @override
  String get plantWateringTask => 'Watering';

  @override
  String get plantFertilizingTask => 'Fertilizing';

  @override
  String get plantWateredAction => 'Watered ✓';

  @override
  String get plantWaterNowAction => 'Water Now';

  @override
  String get plantFertilizedAction => 'Fertilized ✓';

  @override
  String get plantFertilizeAction => 'Fertilize';

  @override
  String get plantAddGardenAction => 'Add to My Garden';

  @override
  String get plantWaterSuccess => '💧 You watered your plant! Great job!';

  @override
  String get plantFertilizeSuccess =>
      '🌱 Fertilizer added! Your plant says thanks!';

  @override
  String plantWaterError(String error) {
    return 'Watering could not be saved: $error';
  }

  @override
  String plantFertilizeError(String error) {
    return 'Fertilizing could not be saved: $error';
  }

  @override
  String get clinicQuickTools => 'Quick Tools';

  @override
  String get clinicDoctorHero => 'AI Plant Doctor\nAt Your Service';

  @override
  String get clinicStartConsultation => 'Start Consultation';

  @override
  String get clinicChoosePlant => 'Which plant would you like to discuss?';

  @override
  String get clinicChoosePlantSubtitle =>
      'Choose a plant from your garden or take a new photo.';

  @override
  String get clinicNoGardenPlants =>
      'There are no plants in your garden yet.\nStart by taking a new photo.';

  @override
  String get clinicNewPhoto => 'Take a New Photo';

  @override
  String get clinicNewPhotoSubtitle =>
      'Photograph the sick plant and get a diagnosis';

  @override
  String get clinicPestAnalysis => 'Pest Analysis';

  @override
  String get clinicVisualDiagnosis => 'Visual diagnosis';

  @override
  String get clinicLightMeter => 'Light Meter';

  @override
  String get clinicSensorSimulation => 'Sensor simulation';

  @override
  String get clinicTitle => 'Plant Clinic';

  @override
  String clinicSickCount(int count) {
    return '$count Sick';
  }

  @override
  String get clinicAllHealthy => 'All Your Plants Are Healthy! 🌿';

  @override
  String get clinicEmpty =>
      'There are no sick plants in the Clinic.\nIf you are concerned about a plant,\nask from the Doctor tab.';

  @override
  String get clinicUnknown => 'Unknown';

  @override
  String get clinicPendingDiagnosis => 'Waiting for diagnosis';

  @override
  String get clinicNoTreatment => 'Treatment has not been determined';

  @override
  String get clinicPrescription => 'Prescription:';

  @override
  String get clinicRecovery => 'Recovery';

  @override
  String get clinicRecovered => 'Recovered';

  @override
  String get clinicContinue => 'Continue';

  @override
  String get clinicRecoveredSuccess => '🎉 Your plant is healthy again!';

  @override
  String get clinicUrgencyLow => 'Low';

  @override
  String get clinicUrgencyMedium => 'Medium';

  @override
  String get clinicUrgencyCritical => 'Critical';

  @override
  String get healthTrendingTips => 'Trending Health Tips';

  @override
  String get healthHumidityArticleTitle =>
      'Winter Prep: Keeping Humidity Balanced';

  @override
  String get healthHumidityArticleSubtitle =>
      'How to protect your plants from dry radiator air during cold months.';

  @override
  String get healthWeeklySpotlight => 'Patient & Remedy of the Week';

  @override
  String get healthAphidTitle => 'Aphid Infestation';

  @override
  String get healthAphidSubtitle =>
      'Early intervention and a natural Neem Oil treatment.';

  @override
  String get healthDiscoverLoadError =>
      'Discover content could not be loaded right now. Pull down to try again.';

  @override
  String get healthDiscoverEmpty =>
      'There is no published discover content yet.';

  @override
  String get healthDiscoverRetry => 'Try Again';

  @override
  String get lightMeterTitle => 'Light Meter';

  @override
  String get lightMeterInstructionTitle => 'To Measure Light';

  @override
  String get lightMeterInstruction =>
      'Point the phone’s front camera toward\nthe plant’s position and light source.';

  @override
  String get lightMeterCameraEstimate =>
      'Approximate lux calculated from camera data';

  @override
  String get lightMeterStabilizing => 'Stabilizing measurement';

  @override
  String get lightMeterStabilizingRecommendation =>
      'Hold the phone steady for a few seconds while sudden exposure changes are filtered.';

  @override
  String get lightMeterUnavailable => 'Measurement unavailable';

  @override
  String get lightMeterUnavailableRecommendation =>
      'Enable camera permission and try this screen again.';

  @override
  String get lightLow => 'Low Light (Shade)';

  @override
  String get lightMedium => 'Medium Light (Bright Room)';

  @override
  String get lightHigh => 'High Light (Near Window)';

  @override
  String get lightVeryHigh => 'Very High Light (Direct Sun)';

  @override
  String get lightLowRecommendation =>
      'Suitable for Calathea, ferns or snake plants.';

  @override
  String get lightMediumRecommendation =>
      'Ideal for Monstera, Ficus and Anthurium.';

  @override
  String get lightHighRecommendation =>
      'Suitable for sun-loving Aloe, cacti and geraniums.';

  @override
  String get lightVeryHighRecommendation =>
      'Best for outdoor plants and succulents.';

  @override
  String get homeLoadingPlants => 'Loading plants...';

  @override
  String get homeNotifications => 'Notifications';

  @override
  String get homeWateringTime => 'Watering Time';

  @override
  String get homeWateringNotification => 'Your indoor plants need watering.';

  @override
  String get homeWelcome => 'Welcome!';

  @override
  String get homeWelcomeNotification =>
      'Welcome to Botaniq. Start by adding your first plant.';

  @override
  String get homeTenMinutesAgo => '10 min ago';

  @override
  String get homeOneDayAgo => '1 day ago';

  @override
  String get homeQuickActions => 'Quick Actions';

  @override
  String get homeIdentifyCamera => 'Identify with your camera';

  @override
  String get homeTomorrow => 'Tomorrow';

  @override
  String get homeNoTasks => 'No tasks for this day!';

  @override
  String get homeAllCared => 'Your plants are all taken care of 🌿';

  @override
  String get homeOverdue => 'OVERDUE';

  @override
  String get homeInstructions => 'Instructions';

  @override
  String homeRequiredAmount(String amount) {
    return 'Required: $amount';
  }

  @override
  String get homeLater => 'Later';

  @override
  String get homeMarkDone => 'Mark as Done';

  @override
  String get homeSickPlants => 'Plant Clinic';

  @override
  String homeSickCount(int count) {
    return '$count Sick';
  }

  @override
  String get homeGreetingMorning => 'Good Morning';

  @override
  String get homeGreetingAfternoon => 'Good Afternoon';

  @override
  String get homeGreetingEvening => 'Good Evening';

  @override
  String get homeTodayTasks => 'Today\'s Tasks';

  @override
  String get homeTomorrowTasks => 'Tomorrow\'s Tasks';

  @override
  String homeDateTasks(String date) {
    return '$date Tasks';
  }

  @override
  String get commonSkip => 'Skip';

  @override
  String get commonContinue => 'Continue';

  @override
  String get commonClose => 'Close';

  @override
  String get commonDelete => 'Delete';

  @override
  String get commonBack => 'Go Back';

  @override
  String get commonUnknown => 'Unknown';

  @override
  String get wizardSaveGarden => 'Save & Add to Garden';

  @override
  String wizardPlantAdded(String name) {
    return '$name was added to your garden! 🌿';
  }

  @override
  String get wizardRoomTitle => 'Where is your plant?';

  @override
  String get wizardRoomSubtitle =>
      'Categorize your plant by room to manage it easily.';

  @override
  String get wizardLivingRoom => 'Living Room';

  @override
  String get wizardBedroom => 'Bedroom';

  @override
  String get wizardKitchen => 'Kitchen';

  @override
  String get wizardOffice => 'Office';

  @override
  String get wizardBathroom => 'Bathroom';

  @override
  String get wizardBalcony => 'Balcony';

  @override
  String get wizardLightTitle => 'How is the light in this spot?';

  @override
  String get wizardLightSubtitle =>
      'Light is one of the most important factors for your plant’s health.';

  @override
  String get wizardDirectSun => 'Direct Sun';

  @override
  String get wizardDirectSunDescription =>
      'Unfiltered sunlight directly on the plant';

  @override
  String get wizardBrightIndirect => 'Bright Indirect';

  @override
  String get wizardBrightIndirectDescription =>
      'Close to an east- or west-facing window';

  @override
  String get wizardMediumLight => 'Medium Light';

  @override
  String get wizardMediumLightDescription => 'A few feet away from a window';

  @override
  String get wizardLowLight => 'Low Light';

  @override
  String get wizardLowLightDescription =>
      'Far from windows or under artificial light';

  @override
  String get wizardDistanceTitle => 'Distance to Window';

  @override
  String get wizardDistanceSubtitle =>
      'Select the approximate distance to the nearest window.';

  @override
  String get wizardMoreThanFiveMeters => 'More than 5 m';

  @override
  String get wizardActiveHoursTitle => 'Active Light Hours';

  @override
  String get wizardActiveHoursSubtitle =>
      'How many hours of direct or bright light does this spot receive?';

  @override
  String wizardHour(int count) {
    return '$count hour';
  }

  @override
  String wizardHours(int count) {
    return '$count hours';
  }

  @override
  String get wizardSixPlusHours => '6+ hours';

  @override
  String get wizardRepottedTitle => 'When was this plant last repotted?';

  @override
  String get wizardRepottedSubtitle =>
      'Fresh soil is crucial for a happy plant.';

  @override
  String get wizardRecently => 'Recently (under 3 months)';

  @override
  String get wizardSixMonthsAgo => '6 months ago';

  @override
  String get wizardOneYearAgo => '1 year ago';

  @override
  String get wizardTwoYearsAgo => '2+ years ago';

  @override
  String get wizardDontKnow => 'I don’t know';

  @override
  String get wizardPotTitle => 'What material is the pot?';

  @override
  String get wizardPotSubtitle =>
      'Pot material affects how quickly the soil dries.';

  @override
  String get wizardPlasticPot => 'Plastic / Nursery';

  @override
  String get wizardTerracottaPot => 'Terracotta';

  @override
  String get wizardCeramicPot => 'Ceramic / Glazed';

  @override
  String get wizardMetalPot => 'Metal';

  @override
  String get wizardWateredTitle => 'When did you last water this plant?';

  @override
  String get wizardWateredSubtitle =>
      'This helps calculate the exact next watering time.';

  @override
  String get wizardToday => 'Today';

  @override
  String get wizardYesterday => 'Yesterday';

  @override
  String get wizardFewDaysAgo => 'A few days ago';

  @override
  String get wizardWeekAgo => 'A week ago';

  @override
  String get wizardMoreWeekAgo => 'More than a week ago';

  @override
  String get historyTitle => 'Search History';

  @override
  String get historyClearTitle => 'Clear History';

  @override
  String get historyClearMessage =>
      'All search and scan history will be deleted. Are you sure?';

  @override
  String get historyClearTooltip => 'Clear History';

  @override
  String get historyEmptyTitle => 'No Search History';

  @override
  String get historyEmptySubtitle =>
      'Plants scanned with the camera or searched for will appear here.';

  @override
  String get historyNoDetails => 'Detailed information is not available.';

  @override
  String get historyRegularWater => 'Regular watering';

  @override
  String get historyIndirectLight => 'Indirect light';

  @override
  String get historyDescription => 'Description';

  @override
  String get historyWatering => 'Watering';

  @override
  String get historyLight => 'Light';

  @override
  String get historyRecently => 'Recently';

  @override
  String historyMinutesAgo(int minutes) {
    return '$minutes min ago';
  }

  @override
  String historyHoursAgo(int hours) {
    return '$hours hours ago';
  }

  @override
  String get historyYesterday => 'Yesterday';

  @override
  String get historyPlantRecord => 'Plant Search Record';

  @override
  String get photoWholeSpecimen => 'Photo of the whole\nplant or mushroom';

  @override
  String get photoWholeSpecimenSubtitle =>
      'Keep the whole specimen centered in the frame for better identification.';

  @override
  String get photoCorrect => 'Correct';

  @override
  String get photoTooClose => 'Too Close';

  @override
  String get photoInstructions => 'Instructions';

  @override
  String get photoOpenCamera => 'I Understand, Open Camera';

  @override
  String get scannerPlant => 'Plant';

  @override
  String get scannerMushroom => 'Mushroom';

  @override
  String get scannerIdentifyingPlant => 'Identifying Plant...';

  @override
  String get scannerIdentifyingMushroom => 'Identifying Mushroom...';

  @override
  String get scannerCapture => 'Take Photo & Scan';

  @override
  String get scannerFailed => 'Scanning failed. Please try again.';

  @override
  String scannerError(String error) {
    return 'An error occurred: $error';
  }

  @override
  String get scannerUnknownPlant => 'Unknown Plant';

  @override
  String get scannerUnknownMushroom => 'Unknown Mushroom';

  @override
  String get scheduleTitle => 'Schedule';

  @override
  String get scheduleTodayTask => 'Today’s Tasks';

  @override
  String get scheduleNoTasks => 'No tasks for today!';

  @override
  String get scheduleInstructions => 'Instructions';

  @override
  String scheduleRequired(String amount) {
    return 'Required: $amount';
  }

  @override
  String get scheduleRemindLater => 'Remind Later';

  @override
  String get scheduleDone => 'Done';

  @override
  String get scheduleCareFallback => 'Take care of your plant.';

  @override
  String get chatDoctorTitle => 'AI Plant Doctor';

  @override
  String chatPatient(String name) {
    return 'Patient: $name';
  }

  @override
  String get chatAnalyzing => 'Analyzing...';

  @override
  String chatHint(String name) {
    return 'Ask about $name...';
  }

  @override
  String chatWelcome(String name) {
    return 'Hello! 🌿 I’m your AI Plant Doctor. How can I help with $name?\n\nI can diagnose a photo or answer your care questions.';
  }

  @override
  String chatContinueWelcome(String name) {
    return 'Hello! Let’s continue with $name. 🌱';
  }

  @override
  String get chatQuestionYellowing => 'What is causing the yellow leaves?';

  @override
  String get chatQuestionTreatment => 'How can I treat this plant?';

  @override
  String get chatQuestionWatering => 'Should I change the watering frequency?';

  @override
  String get chatQuestionFertilizer => 'Which fertilizer should I use?';

  @override
  String get chatPhotoSent => 'Photo sent';

  @override
  String get chatAnalyzePhoto => 'Analyze the photo';

  @override
  String get chatDiagnosisUnknown => 'Diagnosis could not be determined';

  @override
  String get chatNoTreatment => 'No treatment recommendation';

  @override
  String get chatRecoveryUnknown => 'Unknown';

  @override
  String get chatUnableIdentify => 'Unidentified Plant';

  @override
  String chatError(String error) {
    return 'Sorry, an error occurred: $error. Please try again.';
  }

  @override
  String get chatCareTips => 'Care Tips';

  @override
  String get chatPlantLabel => 'Plant';

  @override
  String get chatDiagnosisLabel => 'Diagnosis';

  @override
  String get chatTreatmentLabel => 'Treatment';

  @override
  String get chatUrgencyLabel => 'Urgency';

  @override
  String get chatRecoveryLabel => 'Estimated Recovery';

  @override
  String get discoverMonsteraTitle => 'The Secret to Monstera Growth';

  @override
  String get discoverIndoorPlants => 'Indoor Plants';

  @override
  String get discoverSucculentWatering => 'Watering Guide for Succulents';

  @override
  String get discoverCacti => 'Cacti & Succulents';

  @override
  String get discoverHerbSoil => 'Best Soil Types for Herbs';

  @override
  String get discoverHerbs => 'Herbs';

  @override
  String get discoverPropagation => 'Propagation 101: A Beginner’s Manual';

  @override
  String get discoverPests => 'Common Pests and How to Treat Them';

  @override
  String get discoverRepotting => 'Repotting: When and How?';

  @override
  String discoverMinutesRead(int minutes) {
    return '$minutes min read';
  }

  @override
  String get skip => 'Skip';

  @override
  String get skipForNow => 'Skip for now';

  @override
  String get continueLabel => 'Continue';

  @override
  String get getStarted => 'Get Started';

  @override
  String get nextStep => 'Next Step';

  @override
  String get maybeLater => 'Maybe Later';

  @override
  String get emailAddress => 'Email Address';

  @override
  String get password => 'Password';

  @override
  String get firstName => 'First Name';

  @override
  String get lastName => 'Last Name';

  @override
  String get login => 'Log In';

  @override
  String get signUp => 'Sign Up';

  @override
  String get welcomeBack => 'Welcome Back';

  @override
  String get loginSubtitle => 'Log in to continue caring for your garden.';

  @override
  String get signUpSubtitle =>
      'Join us and start building your green sanctuary.';

  @override
  String get forgotPassword => 'Forgot Password?';

  @override
  String get enterEmailPassword => 'Please enter your email and password.';

  @override
  String get fillAllFields => 'Please fill all fields.';

  @override
  String authError(String error) {
    return 'Something went wrong: $error';
  }

  @override
  String get loginWith => 'Or log in with';

  @override
  String get signUpWith => 'Or sign up with';

  @override
  String get noAccount => 'Don’t have an account? ';

  @override
  String get alreadyAccount => 'Already have an account? ';

  @override
  String get developerSession => 'Create Developer Session';

  @override
  String get welcomeBotaniq => 'Welcome to Botaniq';

  @override
  String get loginOptionsSubtitle =>
      'Log in or sign up to back up your plants, schedules, and preferences.';

  @override
  String get notificationAccessTitle => 'Don’t miss a watering';

  @override
  String get notificationAccessSubtitle =>
      'We’ll gently remind you when it’s time to care for your green friends. Plant care made effortless and stress-free.';

  @override
  String get notificationTurnOn => 'Turn on Reminders';

  @override
  String get creatingClimate => 'Analyzing your micro-climate...';

  @override
  String get creatingSchedules => 'Customizing care schedules...';

  @override
  String get creatingSanctuary => 'Preparing your green sanctuary...';

  @override
  String get locationAccessTitle => 'Location Access';

  @override
  String get locationAccessSubtitle =>
      'Personalize plant care based on your local micro-climate.';

  @override
  String get locationRecommendation => 'Local Recommendations';

  @override
  String get locationRecommendationSubtitle =>
      'Plants that thrive in your area’s climate';

  @override
  String get locationWeather => 'Smart Weather Sync';

  @override
  String get locationWeatherSubtitle =>
      'Schedules adjust to real-time local rain';

  @override
  String get locationAlerts => 'Frost & Heat Alerts';

  @override
  String get locationAlertsSubtitle =>
      'Get notified before extreme weather hits';

  @override
  String get locationEnable => 'Enable Location Access';

  @override
  String get wherePlantsTitle => 'Where are your plants?';

  @override
  String get wherePlantsSubtitle =>
      'Select all that apply to customize your care schedules.';

  @override
  String get locationIndoor => 'Indoor';

  @override
  String get locationIndoorSubtitle => 'Living room, bedroom, office';

  @override
  String get locationBalcony => 'Balcony';

  @override
  String get locationBalconySubtitle => 'Potted plants on a deck or terrace';

  @override
  String get locationGarden => 'Garden';

  @override
  String get locationGardenSubtitle => 'In-ground plants and flowerbeds';

  @override
  String get helpTitleBefore => 'What can we\n';

  @override
  String get helpTitleHighlight => 'help you ';

  @override
  String get helpTitleAfter => 'with?';

  @override
  String get helpSubtitle =>
      'Select one or more goals to personalize your garden.';

  @override
  String get helpHeal => 'Heal sick\nplants';

  @override
  String get helpCare => 'Care\nreminders';

  @override
  String get helpIdentify => 'Identify\nspecies';

  @override
  String get helpJournal => 'Growth\njournal';

  @override
  String get helpOther => 'Something else';

  @override
  String get journeyTitle => 'Your Green Journey';

  @override
  String get journeySubtitle => 'Select the level of care you wish to provide.';

  @override
  String get journeyCasualLabel => 'CASUAL';

  @override
  String get journeyCasualTitle => 'Low Maintenance';

  @override
  String get journeyCasualSubtitle =>
      'I just want to keep my simple plants alive and thriving.';

  @override
  String get journeyEnthusiastLabel => 'ENTHUSIAST';

  @override
  String get journeyEnthusiastTitle => 'Balanced Care';

  @override
  String get journeyEnthusiastSubtitle =>
      'I enjoy spending some weekly time with my growing collection.';

  @override
  String get journeyObsessedLabel => 'OBSESSED';

  @override
  String get journeyObsessedTitle => 'Plant Parent Extraordinaire';

  @override
  String get journeyObsessedSubtitle =>
      'I live for my plants and want expert schedules for my indoor jungle.';

  @override
  String get masteryTitleBefore => 'How’s your ';

  @override
  String get masteryTitleHighlight => 'green\nthumb ';

  @override
  String get masteryTitleAfter => 'lately?';

  @override
  String get masterySubtitle =>
      'Be honest—we’ve all been “The Serial Killer” at some point. Select your current mastery.';

  @override
  String get masteryKiller => 'The Serial Killer';

  @override
  String get masteryKillerSubtitle =>
      'Even my plastic plants look worried when I enter the room.';

  @override
  String get masteryAccidental => 'Accidental Parent';

  @override
  String get masteryAccidentalSubtitle =>
      'My cactus has survived two weeks. We’re still getting to know each other.';

  @override
  String get masteryGrowth => 'Growth Mindset';

  @override
  String get masteryGrowthSubtitle =>
      'Most of my friends have leaves. I know my Monsteras from my Pothos.';

  @override
  String get masteryWhisperer => 'Plant Whisperer';

  @override
  String get masteryWhispererSubtitle =>
      'I propagate rare plants and speak fluent botanical Latin.';

  @override
  String get onboardingOneTitle => 'Take Care\nof Your Plants\n';

  @override
  String get onboardingOneHighlight => 'Like a Pro';

  @override
  String get onboardingOneSubtitle =>
      'Smart schedules and instant identification for your urban jungle.';

  @override
  String get onboardingOneBadge => 'AI-POWERED CARE';

  @override
  String get onboardingAiScan => 'AI Scan';

  @override
  String get onboardingSmartWater => 'Smart Water';

  @override
  String get onboardingLightTracking => 'Light Tracking';

  @override
  String get onboardingTwoTitle => 'Identify Any\nPlant in\n';

  @override
  String get onboardingTwoHighlight => 'Seconds';

  @override
  String get onboardingTwoSubtitle =>
      'Take a photo to learn its name, species, and care requirements.';

  @override
  String get onboardingTwoBadge => 'BOTANICAL EXPERT';

  @override
  String get onboardingSnapPhoto => 'Snap Photo';

  @override
  String get onboardingAccurateResult => 'Accurate Result';

  @override
  String get onboardingPlantWiki => 'Plant Wiki';

  @override
  String get onboardingThreeTitle => 'Never Forget\nTo Water\n';

  @override
  String get onboardingThreeHighlight => 'Again';

  @override
  String get onboardingThreeSubtitle =>
      'Get reminders timed to your plant’s needs and environment.';

  @override
  String get onboardingThreeBadge => 'SMART SCHEDULES';

  @override
  String get onboardingReminders => 'Reminders';

  @override
  String get onboardingClimateData => 'Climate Data';

  @override
  String get onboardingHealthyGrowth => 'Healthy Growth';

  @override
  String get onboardingCommunity => 'Join 50,000+ plant parents';

  @override
  String get onboardingAgreement =>
      'BY CONTINUING, YOU AGREE TO OUR TERMS & PRIVACY POLICY';

  @override
  String get termsTitle => 'Terms & Policies';

  @override
  String get termsUpdated => 'Last updated: August 2026';

  @override
  String get termsUseTitle => '1. Terms of Use';

  @override
  String get termsUseBody =>
      'By accessing or using Botaniq, you agree to these Terms and all applicable laws. We may add, change, suspend, or discontinue any part of the service at any time, with or without notice, and may suspend or terminate accounts that violate these Terms or misuse the service. Continued use after changes take effect means you accept the updated Terms.';

  @override
  String get termsPrivacyTitle => '2. Data We Collect and How We Use It';

  @override
  String get termsPrivacyBody =>
      'To operate and improve Botaniq we collect and process the data you provide or generate while using it: account and profile details (name, email, sign-in identifiers), photos and images you capture or upload (including plant and camera photos), location, device and diagnostic information, notification tokens, usage and interaction data, and content you enter (notes, chat messages, support requests). This data is processed by us and by trusted service providers acting on our behalf — including cloud hosting/database, AI image- and text-analysis, authentication (Google/Apple sign-in), push notifications, and subscription/payment processing — solely to run, secure, support, and improve the service, personalize your experience, train and evaluate the app\'s plant-recognition and care features, prevent fraud and abuse, and meet legal obligations. By using Botaniq you consent to this processing and, where applicable law requires it, to the transfer of your data outside your country to those providers\' infrastructure. We do not sell your personal data.';

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
  String get termsPlantTitle => '5. Plant Data and AI Results';

  @override
  String get termsPlantBody =>
      'Plant-care, identification, and diagnosis information — including AI-generated results — is provided for general informational purposes only and is not professional horticultural, agricultural, veterinary, or medical advice. AI results may be inaccurate or incomplete. You are solely responsible for decisions about your plants, pets, and household based on this information; observe your plant and consult a qualified expert for anything serious.';

  @override
  String get termsLiabilityTitle => '6. Disclaimers, Liability, and Indemnity';

  @override
  String get termsLiabilityBody =>
      'Botaniq is provided \"as is\" and \"as available,\" without warranties of any kind, express or implied, including accuracy, reliability, or fitness for a particular purpose. To the fullest extent permitted by law, we and our service providers are not liable for any indirect, incidental, special, or consequential damages, or for any loss of data, plants, or property arising from your use of the service, and our total liability for any claim is limited to the amount you paid us, if any, in the twelve months before the claim. You agree to indemnify and hold us harmless from claims arising from your use of the service, your content, or your violation of these Terms or applicable law.';

  @override
  String get termsPremiumTitle => '7. Premium Subscriptions';

  @override
  String get termsPremiumBody =>
      'Your monthly or annual Premium subscription is charged to your Apple or Google account after purchase confirmation. It renews automatically unless canceled at least 24 hours before the current period ends. You can manage or cancel it in your store account settings. Refund requests are handled under the applicable store policy.';

  @override
  String get termsLawTitle => '8. Governing Law and Changes';

  @override
  String get termsLawBody =>
      'These Terms are governed by the laws of the jurisdiction in which we operate, without regard to conflict-of-law principles, and any dispute will be resolved under that jurisdiction\'s applicable procedures to the fullest extent permitted by law. We may update these Terms and our data practices at any time by posting the revised version in the app.';

  @override
  String get termsClosing => 'Enjoy peace of mind and happier plants.';

  @override
  String get weatherTitle => 'Weather';

  @override
  String get weatherSunnyTip => 'Sunny today—check the soil before watering.';

  @override
  String get weatherCloudyTip =>
      'Cloudy weather slows evaporation; water a little less.';

  @override
  String get weatherRainyTip =>
      'Rainy and humid—avoid overwatering outdoor plants.';

  @override
  String get weatherStormTip =>
      'Stormy weather—move delicate pots to a sheltered spot.';

  @override
  String get weatherSnowTip =>
      'Cold and snowy—protect plants from temperature shock.';
}
