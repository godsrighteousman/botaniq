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
  String get homeGoodMorning => 'Hello,';

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
      'Account deletion needs a secure server-side confirmation. Your data has not been changed.';

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
}
