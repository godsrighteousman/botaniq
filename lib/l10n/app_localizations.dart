import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_tr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('tr'),
  ];

  /// Application title
  ///
  /// In en, this message translates to:
  /// **'Botaniq'**
  String get appTitle;

  /// Settings page title
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// Preferences section header
  ///
  /// In en, this message translates to:
  /// **'Preferences'**
  String get preferences;

  /// Dark mode toggle label
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get darkMode;

  /// Metric system toggle label
  ///
  /// In en, this message translates to:
  /// **'Metric System'**
  String get metricSystem;

  /// Metric system subtitle
  ///
  /// In en, this message translates to:
  /// **'Use Celsius and Meters'**
  String get metricSystemSubtitle;

  /// Account section header
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get account;

  /// Edit profile action
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get editProfile;

  /// Change password action
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get changePassword;

  /// Subscription management action
  ///
  /// In en, this message translates to:
  /// **'Subscription Management'**
  String get subscriptionManagement;

  /// Premium badge label
  ///
  /// In en, this message translates to:
  /// **'Premium'**
  String get premium;

  /// Language setting label
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// Language setting subtitle
  ///
  /// In en, this message translates to:
  /// **'Change app language'**
  String get languageSubtitle;

  /// Bottom sheet title for language selection
  ///
  /// In en, this message translates to:
  /// **'Select Language'**
  String get selectLanguage;

  /// Option to follow device system language
  ///
  /// In en, this message translates to:
  /// **'System Language'**
  String get systemLanguage;

  /// English language option
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// Turkish language option
  ///
  /// In en, this message translates to:
  /// **'Türkçe'**
  String get turkish;

  /// Snackbar after changing language
  ///
  /// In en, this message translates to:
  /// **'Language changed successfully.'**
  String get languageChanged;

  /// No description provided for @settingsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Shape Botaniq around your own care rhythm.'**
  String get settingsSubtitle;

  /// No description provided for @settingsLocalPreference.
  ///
  /// In en, this message translates to:
  /// **'Saved on this device'**
  String get settingsLocalPreference;

  /// No description provided for @settingsDarkModeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'A calmer palette for low-light moments'**
  String get settingsDarkModeSubtitle;

  /// No description provided for @settingsAccountSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Identity, access and membership'**
  String get settingsAccountSubtitle;

  /// No description provided for @settingsEditProfileSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Name, location and care preferences'**
  String get settingsEditProfileSubtitle;

  /// No description provided for @settingsPasswordSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Send a secure reset link to your email'**
  String get settingsPasswordSubtitle;

  /// No description provided for @settingsSubscriptionSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Premium plan and billing details'**
  String get settingsSubscriptionSubtitle;

  /// No description provided for @settingsPasswordResetSent.
  ///
  /// In en, this message translates to:
  /// **'Password reset email sent.'**
  String get settingsPasswordResetSent;

  /// No description provided for @settingsComingSoon.
  ///
  /// In en, this message translates to:
  /// **'This space is still growing.'**
  String get settingsComingSoon;

  /// Hello text
  ///
  /// In en, this message translates to:
  /// **'Hello,'**
  String get homeGoodMorning;

  /// Empty garden text
  ///
  /// In en, this message translates to:
  /// **'Your garden is empty'**
  String get homeEmptyGarden;

  /// Empty garden detail description
  ///
  /// In en, this message translates to:
  /// **'Start building your green sanctuary\nby adding your first plant.'**
  String get homeEmptyGardenSubtitle;

  /// Hero button to add first plant
  ///
  /// In en, this message translates to:
  /// **'Add First Plant'**
  String get homeAddFirstPlant;

  /// My Plants title
  ///
  /// In en, this message translates to:
  /// **'My Plants'**
  String get homeMyPlants;

  /// View all plants label
  ///
  /// In en, this message translates to:
  /// **'View All'**
  String get homeViewAll;

  /// Smart Care Reminders section
  ///
  /// In en, this message translates to:
  /// **'Smart Care Reminders'**
  String get homeSmartCareReminders;

  /// Watering task label
  ///
  /// In en, this message translates to:
  /// **'Watering'**
  String get homeWatering;

  /// Watering details
  ///
  /// In en, this message translates to:
  /// **'Soil tracking'**
  String get homeWateringSubtitle;

  /// Fertilizing task label
  ///
  /// In en, this message translates to:
  /// **'Fertilizing'**
  String get homeFertilizing;

  /// Fertilizing details
  ///
  /// In en, this message translates to:
  /// **'Nutrient alerts'**
  String get homeFertilizingSubtitle;

  /// Garden title
  ///
  /// In en, this message translates to:
  /// **'My Garden'**
  String get gardenTitle;

  /// All Plants filter chip
  ///
  /// In en, this message translates to:
  /// **'All Plants'**
  String get gardenAllPlants;

  /// Needs Water filter chip
  ///
  /// In en, this message translates to:
  /// **'Needs Water'**
  String get gardenNeedsWater;

  /// Indoor plants filter chip
  ///
  /// In en, this message translates to:
  /// **'Indoor'**
  String get gardenIndoor;

  /// No plants in garden card message
  ///
  /// In en, this message translates to:
  /// **'No plants yet.\nTap + to add your first plant!'**
  String get gardenNoPlants;

  /// No plants in categorised filter message
  ///
  /// In en, this message translates to:
  /// **'No plants in this category.'**
  String get gardenNoPlantsCategory;

  /// Discover title
  ///
  /// In en, this message translates to:
  /// **'Discover'**
  String get discoverTitle;

  /// Discover tab search textfield hint
  ///
  /// In en, this message translates to:
  /// **'Search plants, articles, guides...'**
  String get discoverSearchHint;

  /// Discover latest articles header
  ///
  /// In en, this message translates to:
  /// **'Latest Articles'**
  String get discoverLatestArticles;

  /// Discover see all articles label
  ///
  /// In en, this message translates to:
  /// **'See all'**
  String get discoverSeeAll;

  /// Discover trending guides header
  ///
  /// In en, this message translates to:
  /// **'Trending Guides'**
  String get discoverTrendingGuides;

  /// Healthy tab header title
  ///
  /// In en, this message translates to:
  /// **'Care Center'**
  String get healthyTitle;

  /// Healthy tab status description
  ///
  /// In en, this message translates to:
  /// **'Touch the soul of your plants, talk to them.'**
  String get healthySubtitle;

  /// Tab item for Doctor
  ///
  /// In en, this message translates to:
  /// **'Doctor'**
  String get healthyTabDoctor;

  /// Tab item for Hospital
  ///
  /// In en, this message translates to:
  /// **'Hospital'**
  String get healthyTabHospital;

  /// Tab item for Discover
  ///
  /// In en, this message translates to:
  /// **'Discover'**
  String get healthyTabDiscover;

  /// Profile tab title
  ///
  /// In en, this message translates to:
  /// **'My Profile'**
  String get profileTitle;

  /// Edit profile details label
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get profileEditProfile;

  /// Profile overview submenu
  ///
  /// In en, this message translates to:
  /// **'Overview'**
  String get profileOverview;

  /// Profile settings submenu
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get profileSettingsTab;

  /// Profile level indicator
  ///
  /// In en, this message translates to:
  /// **'Gardener Level'**
  String get profileGardenerLevel;

  /// Total plants registered by user
  ///
  /// In en, this message translates to:
  /// **'Total Plants'**
  String get profileTotalPlants;

  /// Total completed tasks in care schedules
  ///
  /// In en, this message translates to:
  /// **'Completed Tasks'**
  String get profileCompletedTasks;

  /// Profile weekly activity section
  ///
  /// In en, this message translates to:
  /// **'Weekly Care Activity'**
  String get profileWeeklyActivity;

  /// General settings section
  ///
  /// In en, this message translates to:
  /// **'General'**
  String get profileGeneral;

  /// Profile app settings item
  ///
  /// In en, this message translates to:
  /// **'App Settings'**
  String get profileAppSettings;

  /// Profile notification settings item
  ///
  /// In en, this message translates to:
  /// **'Notification Preferences'**
  String get profileNotificationPrefs;

  /// Profile support and legal section header
  ///
  /// In en, this message translates to:
  /// **'Support & Legal'**
  String get profileSupportLegal;

  /// Profile help center menu item
  ///
  /// In en, this message translates to:
  /// **'Help Center'**
  String get profileHelpCenter;

  /// Profile terms of usage menu item
  ///
  /// In en, this message translates to:
  /// **'Terms of Use & Policies'**
  String get profileTerms;

  /// Sign out item text
  ///
  /// In en, this message translates to:
  /// **'Sign Out'**
  String get profileSignOut;

  /// Delete account item text
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get profileDeleteAccount;

  /// No description provided for @profileSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Your garden story, progress and personal space.'**
  String get profileSubtitle;

  /// No description provided for @profileGardenPassport.
  ///
  /// In en, this message translates to:
  /// **'GARDEN PASSPORT'**
  String get profileGardenPassport;

  /// No description provided for @profileThisWeek.
  ///
  /// In en, this message translates to:
  /// **'This week'**
  String get profileThisWeek;

  /// No description provided for @profileQuietWeek.
  ///
  /// In en, this message translates to:
  /// **'A quiet week — your next care moment will appear here.'**
  String get profileQuietWeek;

  /// No description provided for @profileActiveWeek.
  ///
  /// In en, this message translates to:
  /// **'Your care rhythm is alive and growing.'**
  String get profileActiveWeek;

  /// No description provided for @profileAppSettingsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Language, units and AI connection'**
  String get profileAppSettingsSubtitle;

  /// No description provided for @profileNotificationPrefsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Choose which care moments reach you'**
  String get profileNotificationPrefsSubtitle;

  /// No description provided for @profileHelpCenterSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Answers and quick guidance'**
  String get profileHelpCenterSubtitle;

  /// No description provided for @profileTermsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Privacy, terms and policies'**
  String get profileTermsSubtitle;

  /// No description provided for @profileAccountActions.
  ///
  /// In en, this message translates to:
  /// **'Account actions'**
  String get profileAccountActions;

  /// No description provided for @profileSignOutQuestion.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to sign out?'**
  String get profileSignOutQuestion;

  /// No description provided for @profileDeleteAccountWarning.
  ///
  /// In en, this message translates to:
  /// **'Account deletion needs a secure server-side confirmation. Your data has not been changed.'**
  String get profileDeleteAccountWarning;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @continueAction.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueAction;

  /// No description provided for @profileTitleNew.
  ///
  /// In en, this message translates to:
  /// **'New Gardener 🌱'**
  String get profileTitleNew;

  /// No description provided for @profileTitleSprout.
  ///
  /// In en, this message translates to:
  /// **'Sprout Friend 🌿'**
  String get profileTitleSprout;

  /// No description provided for @profileTitleLeaf.
  ///
  /// In en, this message translates to:
  /// **'Leaf Lover ☘️'**
  String get profileTitleLeaf;

  /// No description provided for @profileTitleSkilled.
  ///
  /// In en, this message translates to:
  /// **'Skilled Gardener 🏡'**
  String get profileTitleSkilled;

  /// No description provided for @profileTitleMaster.
  ///
  /// In en, this message translates to:
  /// **'Green Thumb Master 👑'**
  String get profileTitleMaster;

  /// No description provided for @profileNextLevelStart.
  ///
  /// In en, this message translates to:
  /// **'Add your first plant and start your gardening adventure!'**
  String get profileNextLevelStart;

  /// No description provided for @profileNextLevelLeaf.
  ///
  /// In en, this message translates to:
  /// **'Only {count} plants left to become Leaf Lover.'**
  String profileNextLevelLeaf(int count);

  /// No description provided for @profileNextLevelSkilled.
  ///
  /// In en, this message translates to:
  /// **'Only {count} plants left to become Skilled Gardener.'**
  String profileNextLevelSkilled(int count);

  /// No description provided for @profileNextLevelMaster.
  ///
  /// In en, this message translates to:
  /// **'Only {count} plants left to become Green Thumb Master.'**
  String profileNextLevelMaster(int count);

  /// No description provided for @profileNextLevelMax.
  ///
  /// In en, this message translates to:
  /// **'You are at the top of your garden, congratulations!'**
  String get profileNextLevelMax;

  /// No description provided for @navHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHome;

  /// No description provided for @navGarden.
  ///
  /// In en, this message translates to:
  /// **'Garden'**
  String get navGarden;

  /// No description provided for @navClinic.
  ///
  /// In en, this message translates to:
  /// **'Clinic'**
  String get navClinic;

  /// No description provided for @navProfile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get navProfile;

  /// No description provided for @scanPlant.
  ///
  /// In en, this message translates to:
  /// **'Scan Plant'**
  String get scanPlant;

  /// No description provided for @deletePlantTitle.
  ///
  /// In en, this message translates to:
  /// **'Remove this plant?'**
  String get deletePlantTitle;

  /// No description provided for @deletePlantMessage.
  ///
  /// In en, this message translates to:
  /// **'The plant, its care tasks and Clinic records will be permanently removed from your account.'**
  String get deletePlantMessage;

  /// No description provided for @deletePlantAction.
  ///
  /// In en, this message translates to:
  /// **'Remove Plant'**
  String get deletePlantAction;

  /// No description provided for @deletePlantNotFound.
  ///
  /// In en, this message translates to:
  /// **'The plant could not be found or has already been removed.'**
  String get deletePlantNotFound;

  /// No description provided for @deletePlantError.
  ///
  /// In en, this message translates to:
  /// **'The plant could not be removed: {error}'**
  String deletePlantError(String error);

  /// No description provided for @profileChoosePhoto.
  ///
  /// In en, this message translates to:
  /// **'Choose Profile Photo'**
  String get profileChoosePhoto;

  /// No description provided for @profileFullName.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get profileFullName;

  /// No description provided for @profileFullNameHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your full name'**
  String get profileFullNameHint;

  /// No description provided for @profileNickname.
  ///
  /// In en, this message translates to:
  /// **'Nickname'**
  String get profileNickname;

  /// No description provided for @profileNicknameHint.
  ///
  /// In en, this message translates to:
  /// **'How should we call you?'**
  String get profileNicknameHint;

  /// No description provided for @profileAge.
  ///
  /// In en, this message translates to:
  /// **'Age'**
  String get profileAge;

  /// No description provided for @profileAgeHint.
  ///
  /// In en, this message translates to:
  /// **'1–120'**
  String get profileAgeHint;

  /// No description provided for @profileAgeValidation.
  ///
  /// In en, this message translates to:
  /// **'Please enter an age between 1 and 120.'**
  String get profileAgeValidation;

  /// No description provided for @profileLoadError.
  ///
  /// In en, this message translates to:
  /// **'Could not load profile: {error}'**
  String profileLoadError(String error);

  /// No description provided for @languageEnglish.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get languageEnglish;

  /// No description provided for @languageTurkish.
  ///
  /// In en, this message translates to:
  /// **'Turkish'**
  String get languageTurkish;

  /// No description provided for @profileEmailReadOnly.
  ///
  /// In en, this message translates to:
  /// **'Email Address (Read Only)'**
  String get profileEmailReadOnly;

  /// No description provided for @profileEmailHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your email'**
  String get profileEmailHint;

  /// No description provided for @profileLocation.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get profileLocation;

  /// No description provided for @profileLocationHint.
  ///
  /// In en, this message translates to:
  /// **'City, Country'**
  String get profileLocationHint;

  /// No description provided for @profileSaveChanges.
  ///
  /// In en, this message translates to:
  /// **'Save Changes'**
  String get profileSaveChanges;

  /// No description provided for @profileUpdated.
  ///
  /// In en, this message translates to:
  /// **'Your profile has been updated.'**
  String get profileUpdated;

  /// No description provided for @profileSaveError.
  ///
  /// In en, this message translates to:
  /// **'Profile could not be saved: {error}'**
  String profileSaveError(String error);

  /// No description provided for @notificationWateringTitle.
  ///
  /// In en, this message translates to:
  /// **'Watering Reminders'**
  String get notificationWateringTitle;

  /// No description provided for @notificationWateringSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Get notified when it’s time to water'**
  String get notificationWateringSubtitle;

  /// No description provided for @notificationFertilizerTitle.
  ///
  /// In en, this message translates to:
  /// **'Fertilizer Reminders'**
  String get notificationFertilizerTitle;

  /// No description provided for @notificationFertilizerSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Seasonal feeding alerts for your plants'**
  String get notificationFertilizerSubtitle;

  /// No description provided for @notificationTitle.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notificationTitle;

  /// No description provided for @notificationPlantCareAlerts.
  ///
  /// In en, this message translates to:
  /// **'Plant Care Alerts'**
  String get notificationPlantCareAlerts;

  /// No description provided for @notificationOther.
  ///
  /// In en, this message translates to:
  /// **'Other Notifications'**
  String get notificationOther;

  /// No description provided for @notificationWeatherTitle.
  ///
  /// In en, this message translates to:
  /// **'Weather Alerts'**
  String get notificationWeatherTitle;

  /// No description provided for @notificationWeatherSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Extreme weather warnings'**
  String get notificationWeatherSubtitle;

  /// No description provided for @notificationArticlesTitle.
  ///
  /// In en, this message translates to:
  /// **'New Articles'**
  String get notificationArticlesTitle;

  /// No description provided for @notificationArticlesSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Tips and tricks for your garden'**
  String get notificationArticlesSubtitle;

  /// No description provided for @gardenMyPlantFallback.
  ///
  /// In en, this message translates to:
  /// **'My Plant'**
  String get gardenMyPlantFallback;

  /// No description provided for @gardenClinicBadge.
  ///
  /// In en, this message translates to:
  /// **'In Clinic'**
  String get gardenClinicBadge;

  /// No description provided for @wateringNever.
  ///
  /// In en, this message translates to:
  /// **'Last watered: Never'**
  String get wateringNever;

  /// No description provided for @wateringLastDate.
  ///
  /// In en, this message translates to:
  /// **'Last watered: {date}'**
  String wateringLastDate(String date);

  /// No description provided for @wateringInterval.
  ///
  /// In en, this message translates to:
  /// **'Every {days} days'**
  String wateringInterval(int days);

  /// No description provided for @wateringNeverDue.
  ///
  /// In en, this message translates to:
  /// **'Not watered yet • Water today'**
  String get wateringNeverDue;

  /// No description provided for @wateringOverdue.
  ///
  /// In en, this message translates to:
  /// **'{days} days overdue'**
  String wateringOverdue(int days);

  /// No description provided for @wateringDueToday.
  ///
  /// In en, this message translates to:
  /// **'Water today'**
  String get wateringDueToday;

  /// No description provided for @wateringDueTomorrow.
  ///
  /// In en, this message translates to:
  /// **'Water tomorrow'**
  String get wateringDueTomorrow;

  /// No description provided for @wateringDueInDays.
  ///
  /// In en, this message translates to:
  /// **'Water in {days} days'**
  String wateringDueInDays(int days);

  /// No description provided for @plantUnknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown Plant'**
  String get plantUnknown;

  /// No description provided for @plantSpeciesFallback.
  ///
  /// In en, this message translates to:
  /// **'Plant Species'**
  String get plantSpeciesFallback;

  /// No description provided for @plantDifficultyMedium.
  ///
  /// In en, this message translates to:
  /// **'Medium'**
  String get plantDifficultyMedium;

  /// No description provided for @plantAbout.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get plantAbout;

  /// No description provided for @plantLocationEnvironment.
  ///
  /// In en, this message translates to:
  /// **'Location & Environment'**
  String get plantLocationEnvironment;

  /// No description provided for @plantCareProtocol.
  ///
  /// In en, this message translates to:
  /// **'Care Protocol'**
  String get plantCareProtocol;

  /// No description provided for @plantCareHistory.
  ///
  /// In en, this message translates to:
  /// **'Last 10 Days Care History'**
  String get plantCareHistory;

  /// No description provided for @plantHealthy.
  ///
  /// In en, this message translates to:
  /// **'Healthy'**
  String get plantHealthy;

  /// No description provided for @plantInClinic.
  ///
  /// In en, this message translates to:
  /// **'In Clinic'**
  String get plantInClinic;

  /// No description provided for @plantDifficulty.
  ///
  /// In en, this message translates to:
  /// **'Difficulty'**
  String get plantDifficulty;

  /// No description provided for @plantToxicity.
  ///
  /// In en, this message translates to:
  /// **'Toxicity'**
  String get plantToxicity;

  /// No description provided for @plantEnvironment.
  ///
  /// In en, this message translates to:
  /// **'Environment'**
  String get plantEnvironment;

  /// No description provided for @plantLightNeed.
  ///
  /// In en, this message translates to:
  /// **'Light Need'**
  String get plantLightNeed;

  /// No description provided for @plantToxicPets.
  ///
  /// In en, this message translates to:
  /// **'Toxic to pets'**
  String get plantToxicPets;

  /// No description provided for @plantNonToxic.
  ///
  /// In en, this message translates to:
  /// **'Non-toxic'**
  String get plantNonToxic;

  /// No description provided for @plantIndoor.
  ///
  /// In en, this message translates to:
  /// **'Indoor'**
  String get plantIndoor;

  /// No description provided for @plantBrightIndirect.
  ///
  /// In en, this message translates to:
  /// **'Bright Indirect'**
  String get plantBrightIndirect;

  /// No description provided for @plantInfoUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Verified information is not available yet.'**
  String get plantInfoUnavailable;

  /// No description provided for @plantIdealClimate.
  ///
  /// In en, this message translates to:
  /// **'Ideal Climate'**
  String get plantIdealClimate;

  /// No description provided for @plantHumidity.
  ///
  /// In en, this message translates to:
  /// **'Humidity'**
  String get plantHumidity;

  /// No description provided for @plantTemperatureRange.
  ///
  /// In en, this message translates to:
  /// **'Temperature Range'**
  String get plantTemperatureRange;

  /// No description provided for @plantWateringFrequency.
  ///
  /// In en, this message translates to:
  /// **'Watering Frequency'**
  String get plantWateringFrequency;

  /// No description provided for @plantWateringFrequencyValue.
  ///
  /// In en, this message translates to:
  /// **'Water {interval}.'**
  String plantWateringFrequencyValue(String interval);

  /// No description provided for @plantNextWatering.
  ///
  /// In en, this message translates to:
  /// **'Next Watering'**
  String get plantNextWatering;

  /// No description provided for @plantWateringProtocol.
  ///
  /// In en, this message translates to:
  /// **'Watering Protocol'**
  String get plantWateringProtocol;

  /// No description provided for @plantSoilProtocol.
  ///
  /// In en, this message translates to:
  /// **'Soil'**
  String get plantSoilProtocol;

  /// No description provided for @plantFeedingProtocol.
  ///
  /// In en, this message translates to:
  /// **'Feeding Protocol'**
  String get plantFeedingProtocol;

  /// No description provided for @plantPruningCleaning.
  ///
  /// In en, this message translates to:
  /// **'Pruning & Cleaning'**
  String get plantPruningCleaning;

  /// No description provided for @plantPruningFallback.
  ///
  /// In en, this message translates to:
  /// **'Wipe leaves monthly. Prune dead or yellowing leaves to encourage growth.'**
  String get plantPruningFallback;

  /// No description provided for @plantHistoryEmpty.
  ///
  /// In en, this message translates to:
  /// **'No care history for the last 10 days.'**
  String get plantHistoryEmpty;

  /// No description provided for @plantWateringTask.
  ///
  /// In en, this message translates to:
  /// **'Watering'**
  String get plantWateringTask;

  /// No description provided for @plantFertilizingTask.
  ///
  /// In en, this message translates to:
  /// **'Fertilizing'**
  String get plantFertilizingTask;

  /// No description provided for @plantWateredAction.
  ///
  /// In en, this message translates to:
  /// **'Watered ✓'**
  String get plantWateredAction;

  /// No description provided for @plantWaterNowAction.
  ///
  /// In en, this message translates to:
  /// **'Water Now'**
  String get plantWaterNowAction;

  /// No description provided for @plantFertilizedAction.
  ///
  /// In en, this message translates to:
  /// **'Fertilized ✓'**
  String get plantFertilizedAction;

  /// No description provided for @plantFertilizeAction.
  ///
  /// In en, this message translates to:
  /// **'Fertilize'**
  String get plantFertilizeAction;

  /// No description provided for @plantAddGardenAction.
  ///
  /// In en, this message translates to:
  /// **'Add to My Garden'**
  String get plantAddGardenAction;

  /// No description provided for @plantWaterSuccess.
  ///
  /// In en, this message translates to:
  /// **'💧 You watered your plant! Great job!'**
  String get plantWaterSuccess;

  /// No description provided for @plantFertilizeSuccess.
  ///
  /// In en, this message translates to:
  /// **'🌱 Fertilizer added! Your plant says thanks!'**
  String get plantFertilizeSuccess;

  /// No description provided for @plantWaterError.
  ///
  /// In en, this message translates to:
  /// **'Watering could not be saved: {error}'**
  String plantWaterError(String error);

  /// No description provided for @plantFertilizeError.
  ///
  /// In en, this message translates to:
  /// **'Fertilizing could not be saved: {error}'**
  String plantFertilizeError(String error);

  /// No description provided for @clinicQuickTools.
  ///
  /// In en, this message translates to:
  /// **'Quick Tools'**
  String get clinicQuickTools;

  /// No description provided for @clinicDoctorHero.
  ///
  /// In en, this message translates to:
  /// **'AI Plant Doctor\nAt Your Service'**
  String get clinicDoctorHero;

  /// No description provided for @clinicStartConsultation.
  ///
  /// In en, this message translates to:
  /// **'Start Consultation'**
  String get clinicStartConsultation;

  /// No description provided for @clinicChoosePlant.
  ///
  /// In en, this message translates to:
  /// **'Which plant would you like to discuss?'**
  String get clinicChoosePlant;

  /// No description provided for @clinicChoosePlantSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Choose a plant from your garden or take a new photo.'**
  String get clinicChoosePlantSubtitle;

  /// No description provided for @clinicNoGardenPlants.
  ///
  /// In en, this message translates to:
  /// **'There are no plants in your garden yet.\nStart by taking a new photo.'**
  String get clinicNoGardenPlants;

  /// No description provided for @clinicNewPhoto.
  ///
  /// In en, this message translates to:
  /// **'Take a New Photo'**
  String get clinicNewPhoto;

  /// No description provided for @clinicNewPhotoSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Photograph the sick plant and get a diagnosis'**
  String get clinicNewPhotoSubtitle;

  /// No description provided for @clinicPestAnalysis.
  ///
  /// In en, this message translates to:
  /// **'Pest Analysis'**
  String get clinicPestAnalysis;

  /// No description provided for @clinicVisualDiagnosis.
  ///
  /// In en, this message translates to:
  /// **'Visual diagnosis'**
  String get clinicVisualDiagnosis;

  /// No description provided for @clinicLightMeter.
  ///
  /// In en, this message translates to:
  /// **'Light Meter'**
  String get clinicLightMeter;

  /// No description provided for @clinicSensorSimulation.
  ///
  /// In en, this message translates to:
  /// **'Sensor simulation'**
  String get clinicSensorSimulation;

  /// No description provided for @clinicTitle.
  ///
  /// In en, this message translates to:
  /// **'Plant Clinic'**
  String get clinicTitle;

  /// No description provided for @clinicSickCount.
  ///
  /// In en, this message translates to:
  /// **'{count} Sick'**
  String clinicSickCount(int count);

  /// No description provided for @clinicAllHealthy.
  ///
  /// In en, this message translates to:
  /// **'All Your Plants Are Healthy! 🌿'**
  String get clinicAllHealthy;

  /// No description provided for @clinicEmpty.
  ///
  /// In en, this message translates to:
  /// **'There are no sick plants in the Clinic.\nIf you are concerned about a plant,\nask from the Doctor tab.'**
  String get clinicEmpty;

  /// No description provided for @clinicUnknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get clinicUnknown;

  /// No description provided for @clinicPendingDiagnosis.
  ///
  /// In en, this message translates to:
  /// **'Waiting for diagnosis'**
  String get clinicPendingDiagnosis;

  /// No description provided for @clinicNoTreatment.
  ///
  /// In en, this message translates to:
  /// **'Treatment has not been determined'**
  String get clinicNoTreatment;

  /// No description provided for @clinicPrescription.
  ///
  /// In en, this message translates to:
  /// **'Prescription:'**
  String get clinicPrescription;

  /// No description provided for @clinicRecovery.
  ///
  /// In en, this message translates to:
  /// **'Recovery'**
  String get clinicRecovery;

  /// No description provided for @clinicRecovered.
  ///
  /// In en, this message translates to:
  /// **'Recovered'**
  String get clinicRecovered;

  /// No description provided for @clinicContinue.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get clinicContinue;

  /// No description provided for @clinicRecoveredSuccess.
  ///
  /// In en, this message translates to:
  /// **'🎉 Your plant is healthy again!'**
  String get clinicRecoveredSuccess;

  /// No description provided for @clinicUrgencyLow.
  ///
  /// In en, this message translates to:
  /// **'Low'**
  String get clinicUrgencyLow;

  /// No description provided for @clinicUrgencyMedium.
  ///
  /// In en, this message translates to:
  /// **'Medium'**
  String get clinicUrgencyMedium;

  /// No description provided for @clinicUrgencyCritical.
  ///
  /// In en, this message translates to:
  /// **'Critical'**
  String get clinicUrgencyCritical;

  /// No description provided for @healthTrendingTips.
  ///
  /// In en, this message translates to:
  /// **'Trending Health Tips'**
  String get healthTrendingTips;

  /// No description provided for @healthHumidityArticleTitle.
  ///
  /// In en, this message translates to:
  /// **'Winter Prep: Keeping Humidity Balanced'**
  String get healthHumidityArticleTitle;

  /// No description provided for @healthHumidityArticleSubtitle.
  ///
  /// In en, this message translates to:
  /// **'How to protect your plants from dry radiator air during cold months.'**
  String get healthHumidityArticleSubtitle;

  /// No description provided for @healthWeeklySpotlight.
  ///
  /// In en, this message translates to:
  /// **'Patient & Remedy of the Week'**
  String get healthWeeklySpotlight;

  /// No description provided for @healthAphidTitle.
  ///
  /// In en, this message translates to:
  /// **'Aphid Infestation'**
  String get healthAphidTitle;

  /// No description provided for @healthAphidSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Early intervention and a natural Neem Oil treatment.'**
  String get healthAphidSubtitle;

  /// No description provided for @lightMeterTitle.
  ///
  /// In en, this message translates to:
  /// **'Light Meter'**
  String get lightMeterTitle;

  /// No description provided for @lightMeterInstructionTitle.
  ///
  /// In en, this message translates to:
  /// **'To Measure Light'**
  String get lightMeterInstructionTitle;

  /// No description provided for @lightMeterInstruction.
  ///
  /// In en, this message translates to:
  /// **'Point the phone’s front camera toward\nthe plant’s position and light source.'**
  String get lightMeterInstruction;

  /// No description provided for @lightLow.
  ///
  /// In en, this message translates to:
  /// **'Low Light (Shade)'**
  String get lightLow;

  /// No description provided for @lightMedium.
  ///
  /// In en, this message translates to:
  /// **'Medium Light (Bright Room)'**
  String get lightMedium;

  /// No description provided for @lightHigh.
  ///
  /// In en, this message translates to:
  /// **'High Light (Near Window)'**
  String get lightHigh;

  /// No description provided for @lightVeryHigh.
  ///
  /// In en, this message translates to:
  /// **'Very High Light (Direct Sun)'**
  String get lightVeryHigh;

  /// No description provided for @lightLowRecommendation.
  ///
  /// In en, this message translates to:
  /// **'Suitable for Calathea, ferns or snake plants.'**
  String get lightLowRecommendation;

  /// No description provided for @lightMediumRecommendation.
  ///
  /// In en, this message translates to:
  /// **'Ideal for Monstera, Ficus and Anthurium.'**
  String get lightMediumRecommendation;

  /// No description provided for @lightHighRecommendation.
  ///
  /// In en, this message translates to:
  /// **'Suitable for sun-loving Aloe, cacti and geraniums.'**
  String get lightHighRecommendation;

  /// No description provided for @lightVeryHighRecommendation.
  ///
  /// In en, this message translates to:
  /// **'Best for outdoor plants and succulents.'**
  String get lightVeryHighRecommendation;

  /// No description provided for @homeLoadingPlants.
  ///
  /// In en, this message translates to:
  /// **'Loading plants...'**
  String get homeLoadingPlants;

  /// No description provided for @homeNotifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get homeNotifications;

  /// No description provided for @homeWateringTime.
  ///
  /// In en, this message translates to:
  /// **'Watering Time'**
  String get homeWateringTime;

  /// No description provided for @homeWateringNotification.
  ///
  /// In en, this message translates to:
  /// **'Your indoor plants need watering.'**
  String get homeWateringNotification;

  /// No description provided for @homeWelcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome!'**
  String get homeWelcome;

  /// No description provided for @homeWelcomeNotification.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Botaniq. Start by adding your first plant.'**
  String get homeWelcomeNotification;

  /// No description provided for @homeTenMinutesAgo.
  ///
  /// In en, this message translates to:
  /// **'10 min ago'**
  String get homeTenMinutesAgo;

  /// No description provided for @homeOneDayAgo.
  ///
  /// In en, this message translates to:
  /// **'1 day ago'**
  String get homeOneDayAgo;

  /// No description provided for @homeQuickActions.
  ///
  /// In en, this message translates to:
  /// **'Quick Actions'**
  String get homeQuickActions;

  /// No description provided for @homeIdentifyCamera.
  ///
  /// In en, this message translates to:
  /// **'Identify with your camera'**
  String get homeIdentifyCamera;

  /// No description provided for @homeTomorrow.
  ///
  /// In en, this message translates to:
  /// **'Tomorrow'**
  String get homeTomorrow;

  /// No description provided for @homeNoTasks.
  ///
  /// In en, this message translates to:
  /// **'No tasks for this day!'**
  String get homeNoTasks;

  /// No description provided for @homeAllCared.
  ///
  /// In en, this message translates to:
  /// **'Your plants are all taken care of 🌿'**
  String get homeAllCared;

  /// No description provided for @homeOverdue.
  ///
  /// In en, this message translates to:
  /// **'OVERDUE'**
  String get homeOverdue;

  /// No description provided for @homeInstructions.
  ///
  /// In en, this message translates to:
  /// **'Instructions'**
  String get homeInstructions;

  /// No description provided for @homeRequiredAmount.
  ///
  /// In en, this message translates to:
  /// **'Required: {amount}'**
  String homeRequiredAmount(String amount);

  /// No description provided for @homeLater.
  ///
  /// In en, this message translates to:
  /// **'Later'**
  String get homeLater;

  /// No description provided for @homeMarkDone.
  ///
  /// In en, this message translates to:
  /// **'Mark as Done'**
  String get homeMarkDone;

  /// No description provided for @homeSickPlants.
  ///
  /// In en, this message translates to:
  /// **'Plant Clinic'**
  String get homeSickPlants;

  /// No description provided for @homeSickCount.
  ///
  /// In en, this message translates to:
  /// **'{count} Sick'**
  String homeSickCount(int count);

  /// No description provided for @homeGreetingMorning.
  ///
  /// In en, this message translates to:
  /// **'Good Morning'**
  String get homeGreetingMorning;

  /// No description provided for @homeGreetingAfternoon.
  ///
  /// In en, this message translates to:
  /// **'Good Afternoon'**
  String get homeGreetingAfternoon;

  /// No description provided for @homeGreetingEvening.
  ///
  /// In en, this message translates to:
  /// **'Good Evening'**
  String get homeGreetingEvening;

  /// No description provided for @homeTodayTasks.
  ///
  /// In en, this message translates to:
  /// **'Today\'s Tasks'**
  String get homeTodayTasks;

  /// No description provided for @homeTomorrowTasks.
  ///
  /// In en, this message translates to:
  /// **'Tomorrow\'s Tasks'**
  String get homeTomorrowTasks;

  /// No description provided for @homeDateTasks.
  ///
  /// In en, this message translates to:
  /// **'{date} Tasks'**
  String homeDateTasks(String date);

  /// No description provided for @commonSkip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get commonSkip;

  /// No description provided for @commonContinue.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get commonContinue;

  /// No description provided for @commonClose.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get commonClose;

  /// No description provided for @commonDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get commonDelete;

  /// No description provided for @commonBack.
  ///
  /// In en, this message translates to:
  /// **'Go Back'**
  String get commonBack;

  /// No description provided for @commonUnknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get commonUnknown;

  /// No description provided for @wizardSaveGarden.
  ///
  /// In en, this message translates to:
  /// **'Save & Add to Garden'**
  String get wizardSaveGarden;

  /// No description provided for @wizardPlantAdded.
  ///
  /// In en, this message translates to:
  /// **'{name} was added to your garden! 🌿'**
  String wizardPlantAdded(String name);

  /// No description provided for @wizardRoomTitle.
  ///
  /// In en, this message translates to:
  /// **'Where is your plant?'**
  String get wizardRoomTitle;

  /// No description provided for @wizardRoomSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Categorize your plant by room to manage it easily.'**
  String get wizardRoomSubtitle;

  /// No description provided for @wizardLivingRoom.
  ///
  /// In en, this message translates to:
  /// **'Living Room'**
  String get wizardLivingRoom;

  /// No description provided for @wizardBedroom.
  ///
  /// In en, this message translates to:
  /// **'Bedroom'**
  String get wizardBedroom;

  /// No description provided for @wizardKitchen.
  ///
  /// In en, this message translates to:
  /// **'Kitchen'**
  String get wizardKitchen;

  /// No description provided for @wizardOffice.
  ///
  /// In en, this message translates to:
  /// **'Office'**
  String get wizardOffice;

  /// No description provided for @wizardBathroom.
  ///
  /// In en, this message translates to:
  /// **'Bathroom'**
  String get wizardBathroom;

  /// No description provided for @wizardBalcony.
  ///
  /// In en, this message translates to:
  /// **'Balcony'**
  String get wizardBalcony;

  /// No description provided for @wizardLightTitle.
  ///
  /// In en, this message translates to:
  /// **'How is the light in this spot?'**
  String get wizardLightTitle;

  /// No description provided for @wizardLightSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Light is one of the most important factors for your plant’s health.'**
  String get wizardLightSubtitle;

  /// No description provided for @wizardDirectSun.
  ///
  /// In en, this message translates to:
  /// **'Direct Sun'**
  String get wizardDirectSun;

  /// No description provided for @wizardDirectSunDescription.
  ///
  /// In en, this message translates to:
  /// **'Unfiltered sunlight directly on the plant'**
  String get wizardDirectSunDescription;

  /// No description provided for @wizardBrightIndirect.
  ///
  /// In en, this message translates to:
  /// **'Bright Indirect'**
  String get wizardBrightIndirect;

  /// No description provided for @wizardBrightIndirectDescription.
  ///
  /// In en, this message translates to:
  /// **'Close to an east- or west-facing window'**
  String get wizardBrightIndirectDescription;

  /// No description provided for @wizardMediumLight.
  ///
  /// In en, this message translates to:
  /// **'Medium Light'**
  String get wizardMediumLight;

  /// No description provided for @wizardMediumLightDescription.
  ///
  /// In en, this message translates to:
  /// **'A few feet away from a window'**
  String get wizardMediumLightDescription;

  /// No description provided for @wizardLowLight.
  ///
  /// In en, this message translates to:
  /// **'Low Light'**
  String get wizardLowLight;

  /// No description provided for @wizardLowLightDescription.
  ///
  /// In en, this message translates to:
  /// **'Far from windows or under artificial light'**
  String get wizardLowLightDescription;

  /// No description provided for @wizardDistanceTitle.
  ///
  /// In en, this message translates to:
  /// **'Distance to Window'**
  String get wizardDistanceTitle;

  /// No description provided for @wizardDistanceSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Select the approximate distance to the nearest window.'**
  String get wizardDistanceSubtitle;

  /// No description provided for @wizardMoreThanFiveMeters.
  ///
  /// In en, this message translates to:
  /// **'More than 5 m'**
  String get wizardMoreThanFiveMeters;

  /// No description provided for @wizardActiveHoursTitle.
  ///
  /// In en, this message translates to:
  /// **'Active Light Hours'**
  String get wizardActiveHoursTitle;

  /// No description provided for @wizardActiveHoursSubtitle.
  ///
  /// In en, this message translates to:
  /// **'How many hours of direct or bright light does this spot receive?'**
  String get wizardActiveHoursSubtitle;

  /// No description provided for @wizardHour.
  ///
  /// In en, this message translates to:
  /// **'{count} hour'**
  String wizardHour(int count);

  /// No description provided for @wizardHours.
  ///
  /// In en, this message translates to:
  /// **'{count} hours'**
  String wizardHours(int count);

  /// No description provided for @wizardSixPlusHours.
  ///
  /// In en, this message translates to:
  /// **'6+ hours'**
  String get wizardSixPlusHours;

  /// No description provided for @wizardRepottedTitle.
  ///
  /// In en, this message translates to:
  /// **'When was this plant last repotted?'**
  String get wizardRepottedTitle;

  /// No description provided for @wizardRepottedSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Fresh soil is crucial for a happy plant.'**
  String get wizardRepottedSubtitle;

  /// No description provided for @wizardRecently.
  ///
  /// In en, this message translates to:
  /// **'Recently (under 3 months)'**
  String get wizardRecently;

  /// No description provided for @wizardSixMonthsAgo.
  ///
  /// In en, this message translates to:
  /// **'6 months ago'**
  String get wizardSixMonthsAgo;

  /// No description provided for @wizardOneYearAgo.
  ///
  /// In en, this message translates to:
  /// **'1 year ago'**
  String get wizardOneYearAgo;

  /// No description provided for @wizardTwoYearsAgo.
  ///
  /// In en, this message translates to:
  /// **'2+ years ago'**
  String get wizardTwoYearsAgo;

  /// No description provided for @wizardDontKnow.
  ///
  /// In en, this message translates to:
  /// **'I don’t know'**
  String get wizardDontKnow;

  /// No description provided for @wizardPotTitle.
  ///
  /// In en, this message translates to:
  /// **'What material is the pot?'**
  String get wizardPotTitle;

  /// No description provided for @wizardPotSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Pot material affects how quickly the soil dries.'**
  String get wizardPotSubtitle;

  /// No description provided for @wizardPlasticPot.
  ///
  /// In en, this message translates to:
  /// **'Plastic / Nursery'**
  String get wizardPlasticPot;

  /// No description provided for @wizardTerracottaPot.
  ///
  /// In en, this message translates to:
  /// **'Terracotta'**
  String get wizardTerracottaPot;

  /// No description provided for @wizardCeramicPot.
  ///
  /// In en, this message translates to:
  /// **'Ceramic / Glazed'**
  String get wizardCeramicPot;

  /// No description provided for @wizardMetalPot.
  ///
  /// In en, this message translates to:
  /// **'Metal'**
  String get wizardMetalPot;

  /// No description provided for @wizardWateredTitle.
  ///
  /// In en, this message translates to:
  /// **'When did you last water this plant?'**
  String get wizardWateredTitle;

  /// No description provided for @wizardWateredSubtitle.
  ///
  /// In en, this message translates to:
  /// **'This helps calculate the exact next watering time.'**
  String get wizardWateredSubtitle;

  /// No description provided for @wizardToday.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get wizardToday;

  /// No description provided for @wizardYesterday.
  ///
  /// In en, this message translates to:
  /// **'Yesterday'**
  String get wizardYesterday;

  /// No description provided for @wizardFewDaysAgo.
  ///
  /// In en, this message translates to:
  /// **'A few days ago'**
  String get wizardFewDaysAgo;

  /// No description provided for @wizardWeekAgo.
  ///
  /// In en, this message translates to:
  /// **'A week ago'**
  String get wizardWeekAgo;

  /// No description provided for @wizardMoreWeekAgo.
  ///
  /// In en, this message translates to:
  /// **'More than a week ago'**
  String get wizardMoreWeekAgo;

  /// No description provided for @historyTitle.
  ///
  /// In en, this message translates to:
  /// **'Search History'**
  String get historyTitle;

  /// No description provided for @historyClearTitle.
  ///
  /// In en, this message translates to:
  /// **'Clear History'**
  String get historyClearTitle;

  /// No description provided for @historyClearMessage.
  ///
  /// In en, this message translates to:
  /// **'All search and scan history will be deleted. Are you sure?'**
  String get historyClearMessage;

  /// No description provided for @historyClearTooltip.
  ///
  /// In en, this message translates to:
  /// **'Clear History'**
  String get historyClearTooltip;

  /// No description provided for @historyEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No Search History'**
  String get historyEmptyTitle;

  /// No description provided for @historyEmptySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Plants scanned with the camera or searched for will appear here.'**
  String get historyEmptySubtitle;

  /// No description provided for @historyNoDetails.
  ///
  /// In en, this message translates to:
  /// **'Detailed information is not available.'**
  String get historyNoDetails;

  /// No description provided for @historyRegularWater.
  ///
  /// In en, this message translates to:
  /// **'Regular watering'**
  String get historyRegularWater;

  /// No description provided for @historyIndirectLight.
  ///
  /// In en, this message translates to:
  /// **'Indirect light'**
  String get historyIndirectLight;

  /// No description provided for @historyDescription.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get historyDescription;

  /// No description provided for @historyWatering.
  ///
  /// In en, this message translates to:
  /// **'Watering'**
  String get historyWatering;

  /// No description provided for @historyLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get historyLight;

  /// No description provided for @historyRecently.
  ///
  /// In en, this message translates to:
  /// **'Recently'**
  String get historyRecently;

  /// No description provided for @historyMinutesAgo.
  ///
  /// In en, this message translates to:
  /// **'{minutes} min ago'**
  String historyMinutesAgo(int minutes);

  /// No description provided for @historyHoursAgo.
  ///
  /// In en, this message translates to:
  /// **'{hours} hours ago'**
  String historyHoursAgo(int hours);

  /// No description provided for @historyYesterday.
  ///
  /// In en, this message translates to:
  /// **'Yesterday'**
  String get historyYesterday;

  /// No description provided for @historyPlantRecord.
  ///
  /// In en, this message translates to:
  /// **'Plant Search Record'**
  String get historyPlantRecord;

  /// No description provided for @photoWholeSpecimen.
  ///
  /// In en, this message translates to:
  /// **'Photo of the whole\nplant or mushroom'**
  String get photoWholeSpecimen;

  /// No description provided for @photoWholeSpecimenSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Keep the whole specimen centered in the frame for better identification.'**
  String get photoWholeSpecimenSubtitle;

  /// No description provided for @photoCorrect.
  ///
  /// In en, this message translates to:
  /// **'Correct'**
  String get photoCorrect;

  /// No description provided for @photoTooClose.
  ///
  /// In en, this message translates to:
  /// **'Too Close'**
  String get photoTooClose;

  /// No description provided for @photoInstructions.
  ///
  /// In en, this message translates to:
  /// **'Instructions'**
  String get photoInstructions;

  /// No description provided for @photoOpenCamera.
  ///
  /// In en, this message translates to:
  /// **'I Understand, Open Camera'**
  String get photoOpenCamera;

  /// No description provided for @scannerPlant.
  ///
  /// In en, this message translates to:
  /// **'Plant'**
  String get scannerPlant;

  /// No description provided for @scannerMushroom.
  ///
  /// In en, this message translates to:
  /// **'Mushroom'**
  String get scannerMushroom;

  /// No description provided for @scannerIdentifyingPlant.
  ///
  /// In en, this message translates to:
  /// **'Identifying Plant...'**
  String get scannerIdentifyingPlant;

  /// No description provided for @scannerIdentifyingMushroom.
  ///
  /// In en, this message translates to:
  /// **'Identifying Mushroom...'**
  String get scannerIdentifyingMushroom;

  /// No description provided for @scannerCapture.
  ///
  /// In en, this message translates to:
  /// **'Take Photo & Scan'**
  String get scannerCapture;

  /// No description provided for @scannerFailed.
  ///
  /// In en, this message translates to:
  /// **'Scanning failed. Please try again.'**
  String get scannerFailed;

  /// No description provided for @scannerError.
  ///
  /// In en, this message translates to:
  /// **'An error occurred: {error}'**
  String scannerError(String error);

  /// No description provided for @scannerUnknownPlant.
  ///
  /// In en, this message translates to:
  /// **'Unknown Plant'**
  String get scannerUnknownPlant;

  /// No description provided for @scannerUnknownMushroom.
  ///
  /// In en, this message translates to:
  /// **'Unknown Mushroom'**
  String get scannerUnknownMushroom;

  /// No description provided for @scheduleTitle.
  ///
  /// In en, this message translates to:
  /// **'Schedule'**
  String get scheduleTitle;

  /// No description provided for @scheduleTodayTask.
  ///
  /// In en, this message translates to:
  /// **'Today’s Tasks'**
  String get scheduleTodayTask;

  /// No description provided for @scheduleNoTasks.
  ///
  /// In en, this message translates to:
  /// **'No tasks for today!'**
  String get scheduleNoTasks;

  /// No description provided for @scheduleInstructions.
  ///
  /// In en, this message translates to:
  /// **'Instructions'**
  String get scheduleInstructions;

  /// No description provided for @scheduleRequired.
  ///
  /// In en, this message translates to:
  /// **'Required: {amount}'**
  String scheduleRequired(String amount);

  /// No description provided for @scheduleRemindLater.
  ///
  /// In en, this message translates to:
  /// **'Remind Later'**
  String get scheduleRemindLater;

  /// No description provided for @scheduleDone.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get scheduleDone;

  /// No description provided for @scheduleCareFallback.
  ///
  /// In en, this message translates to:
  /// **'Take care of your plant.'**
  String get scheduleCareFallback;

  /// No description provided for @chatDoctorTitle.
  ///
  /// In en, this message translates to:
  /// **'AI Plant Doctor'**
  String get chatDoctorTitle;

  /// No description provided for @chatPatient.
  ///
  /// In en, this message translates to:
  /// **'Patient: {name}'**
  String chatPatient(String name);

  /// No description provided for @chatAnalyzing.
  ///
  /// In en, this message translates to:
  /// **'Analyzing...'**
  String get chatAnalyzing;

  /// No description provided for @chatHint.
  ///
  /// In en, this message translates to:
  /// **'Ask about {name}...'**
  String chatHint(String name);

  /// No description provided for @chatWelcome.
  ///
  /// In en, this message translates to:
  /// **'Hello! 🌿 I’m your AI Plant Doctor. How can I help with {name}?\n\nI can diagnose a photo or answer your care questions.'**
  String chatWelcome(String name);

  /// No description provided for @chatContinueWelcome.
  ///
  /// In en, this message translates to:
  /// **'Hello! Let’s continue with {name}. 🌱'**
  String chatContinueWelcome(String name);

  /// No description provided for @chatQuestionYellowing.
  ///
  /// In en, this message translates to:
  /// **'What is causing the yellow leaves?'**
  String get chatQuestionYellowing;

  /// No description provided for @chatQuestionTreatment.
  ///
  /// In en, this message translates to:
  /// **'How can I treat this plant?'**
  String get chatQuestionTreatment;

  /// No description provided for @chatQuestionWatering.
  ///
  /// In en, this message translates to:
  /// **'Should I change the watering frequency?'**
  String get chatQuestionWatering;

  /// No description provided for @chatQuestionFertilizer.
  ///
  /// In en, this message translates to:
  /// **'Which fertilizer should I use?'**
  String get chatQuestionFertilizer;

  /// No description provided for @chatPhotoSent.
  ///
  /// In en, this message translates to:
  /// **'Photo sent'**
  String get chatPhotoSent;

  /// No description provided for @chatAnalyzePhoto.
  ///
  /// In en, this message translates to:
  /// **'Analyze the photo'**
  String get chatAnalyzePhoto;

  /// No description provided for @chatDiagnosisUnknown.
  ///
  /// In en, this message translates to:
  /// **'Diagnosis could not be determined'**
  String get chatDiagnosisUnknown;

  /// No description provided for @chatNoTreatment.
  ///
  /// In en, this message translates to:
  /// **'No treatment recommendation'**
  String get chatNoTreatment;

  /// No description provided for @chatRecoveryUnknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get chatRecoveryUnknown;

  /// No description provided for @chatUnableIdentify.
  ///
  /// In en, this message translates to:
  /// **'Unidentified Plant'**
  String get chatUnableIdentify;

  /// No description provided for @chatError.
  ///
  /// In en, this message translates to:
  /// **'Sorry, an error occurred: {error}. Please try again.'**
  String chatError(String error);

  /// No description provided for @chatCareTips.
  ///
  /// In en, this message translates to:
  /// **'Care Tips'**
  String get chatCareTips;

  /// No description provided for @chatPlantLabel.
  ///
  /// In en, this message translates to:
  /// **'Plant'**
  String get chatPlantLabel;

  /// No description provided for @chatDiagnosisLabel.
  ///
  /// In en, this message translates to:
  /// **'Diagnosis'**
  String get chatDiagnosisLabel;

  /// No description provided for @chatTreatmentLabel.
  ///
  /// In en, this message translates to:
  /// **'Treatment'**
  String get chatTreatmentLabel;

  /// No description provided for @chatUrgencyLabel.
  ///
  /// In en, this message translates to:
  /// **'Urgency'**
  String get chatUrgencyLabel;

  /// No description provided for @chatRecoveryLabel.
  ///
  /// In en, this message translates to:
  /// **'Estimated Recovery'**
  String get chatRecoveryLabel;

  /// No description provided for @discoverMonsteraTitle.
  ///
  /// In en, this message translates to:
  /// **'The Secret to Monstera Growth'**
  String get discoverMonsteraTitle;

  /// No description provided for @discoverIndoorPlants.
  ///
  /// In en, this message translates to:
  /// **'Indoor Plants'**
  String get discoverIndoorPlants;

  /// No description provided for @discoverSucculentWatering.
  ///
  /// In en, this message translates to:
  /// **'Watering Guide for Succulents'**
  String get discoverSucculentWatering;

  /// No description provided for @discoverCacti.
  ///
  /// In en, this message translates to:
  /// **'Cacti & Succulents'**
  String get discoverCacti;

  /// No description provided for @discoverHerbSoil.
  ///
  /// In en, this message translates to:
  /// **'Best Soil Types for Herbs'**
  String get discoverHerbSoil;

  /// No description provided for @discoverHerbs.
  ///
  /// In en, this message translates to:
  /// **'Herbs'**
  String get discoverHerbs;

  /// No description provided for @discoverPropagation.
  ///
  /// In en, this message translates to:
  /// **'Propagation 101: A Beginner’s Manual'**
  String get discoverPropagation;

  /// No description provided for @discoverPests.
  ///
  /// In en, this message translates to:
  /// **'Common Pests and How to Treat Them'**
  String get discoverPests;

  /// No description provided for @discoverRepotting.
  ///
  /// In en, this message translates to:
  /// **'Repotting: When and How?'**
  String get discoverRepotting;

  /// No description provided for @discoverMinutesRead.
  ///
  /// In en, this message translates to:
  /// **'{minutes} min read'**
  String discoverMinutesRead(int minutes);

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @skipForNow.
  ///
  /// In en, this message translates to:
  /// **'Skip for now'**
  String get skipForNow;

  /// No description provided for @continueLabel.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueLabel;

  /// No description provided for @getStarted.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get getStarted;

  /// No description provided for @nextStep.
  ///
  /// In en, this message translates to:
  /// **'Next Step'**
  String get nextStep;

  /// No description provided for @maybeLater.
  ///
  /// In en, this message translates to:
  /// **'Maybe Later'**
  String get maybeLater;

  /// No description provided for @emailAddress.
  ///
  /// In en, this message translates to:
  /// **'Email Address'**
  String get emailAddress;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @firstName.
  ///
  /// In en, this message translates to:
  /// **'First Name'**
  String get firstName;

  /// No description provided for @lastName.
  ///
  /// In en, this message translates to:
  /// **'Last Name'**
  String get lastName;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Log In'**
  String get login;

  /// No description provided for @signUp.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signUp;

  /// No description provided for @welcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome Back'**
  String get welcomeBack;

  /// No description provided for @loginSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Log in to continue caring for your garden.'**
  String get loginSubtitle;

  /// No description provided for @signUpSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Join us and start building your green sanctuary.'**
  String get signUpSubtitle;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get forgotPassword;

  /// No description provided for @enterEmailPassword.
  ///
  /// In en, this message translates to:
  /// **'Please enter your email and password.'**
  String get enterEmailPassword;

  /// No description provided for @fillAllFields.
  ///
  /// In en, this message translates to:
  /// **'Please fill all fields.'**
  String get fillAllFields;

  /// No description provided for @authError.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong: {error}'**
  String authError(String error);

  /// No description provided for @loginWith.
  ///
  /// In en, this message translates to:
  /// **'Or log in with'**
  String get loginWith;

  /// No description provided for @signUpWith.
  ///
  /// In en, this message translates to:
  /// **'Or sign up with'**
  String get signUpWith;

  /// No description provided for @noAccount.
  ///
  /// In en, this message translates to:
  /// **'Don’t have an account? '**
  String get noAccount;

  /// No description provided for @alreadyAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account? '**
  String get alreadyAccount;

  /// No description provided for @developerSession.
  ///
  /// In en, this message translates to:
  /// **'Create Developer Session'**
  String get developerSession;

  /// No description provided for @welcomeBotaniq.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Botaniq'**
  String get welcomeBotaniq;

  /// No description provided for @loginOptionsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Log in or sign up to back up your plants, schedules, and preferences.'**
  String get loginOptionsSubtitle;

  /// No description provided for @notificationAccessTitle.
  ///
  /// In en, this message translates to:
  /// **'Don’t miss a watering'**
  String get notificationAccessTitle;

  /// No description provided for @notificationAccessSubtitle.
  ///
  /// In en, this message translates to:
  /// **'We’ll gently remind you when it’s time to care for your green friends. Plant care made effortless and stress-free.'**
  String get notificationAccessSubtitle;

  /// No description provided for @notificationTurnOn.
  ///
  /// In en, this message translates to:
  /// **'Turn on Reminders'**
  String get notificationTurnOn;

  /// No description provided for @creatingClimate.
  ///
  /// In en, this message translates to:
  /// **'Analyzing your micro-climate...'**
  String get creatingClimate;

  /// No description provided for @creatingSchedules.
  ///
  /// In en, this message translates to:
  /// **'Customizing care schedules...'**
  String get creatingSchedules;

  /// No description provided for @creatingSanctuary.
  ///
  /// In en, this message translates to:
  /// **'Preparing your green sanctuary...'**
  String get creatingSanctuary;

  /// No description provided for @locationAccessTitle.
  ///
  /// In en, this message translates to:
  /// **'Location Access'**
  String get locationAccessTitle;

  /// No description provided for @locationAccessSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Personalize plant care based on your local micro-climate.'**
  String get locationAccessSubtitle;

  /// No description provided for @locationRecommendation.
  ///
  /// In en, this message translates to:
  /// **'Local Recommendations'**
  String get locationRecommendation;

  /// No description provided for @locationRecommendationSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Plants that thrive in your area’s climate'**
  String get locationRecommendationSubtitle;

  /// No description provided for @locationWeather.
  ///
  /// In en, this message translates to:
  /// **'Smart Weather Sync'**
  String get locationWeather;

  /// No description provided for @locationWeatherSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Schedules adjust to real-time local rain'**
  String get locationWeatherSubtitle;

  /// No description provided for @locationAlerts.
  ///
  /// In en, this message translates to:
  /// **'Frost & Heat Alerts'**
  String get locationAlerts;

  /// No description provided for @locationAlertsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Get notified before extreme weather hits'**
  String get locationAlertsSubtitle;

  /// No description provided for @locationEnable.
  ///
  /// In en, this message translates to:
  /// **'Enable Location Access'**
  String get locationEnable;

  /// No description provided for @wherePlantsTitle.
  ///
  /// In en, this message translates to:
  /// **'Where are your plants?'**
  String get wherePlantsTitle;

  /// No description provided for @wherePlantsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Select all that apply to customize your care schedules.'**
  String get wherePlantsSubtitle;

  /// No description provided for @locationIndoor.
  ///
  /// In en, this message translates to:
  /// **'Indoor'**
  String get locationIndoor;

  /// No description provided for @locationIndoorSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Living room, bedroom, office'**
  String get locationIndoorSubtitle;

  /// No description provided for @locationBalcony.
  ///
  /// In en, this message translates to:
  /// **'Balcony'**
  String get locationBalcony;

  /// No description provided for @locationBalconySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Potted plants on a deck or terrace'**
  String get locationBalconySubtitle;

  /// No description provided for @locationGarden.
  ///
  /// In en, this message translates to:
  /// **'Garden'**
  String get locationGarden;

  /// No description provided for @locationGardenSubtitle.
  ///
  /// In en, this message translates to:
  /// **'In-ground plants and flowerbeds'**
  String get locationGardenSubtitle;

  /// No description provided for @helpTitleBefore.
  ///
  /// In en, this message translates to:
  /// **'What can we\n'**
  String get helpTitleBefore;

  /// No description provided for @helpTitleHighlight.
  ///
  /// In en, this message translates to:
  /// **'help you '**
  String get helpTitleHighlight;

  /// No description provided for @helpTitleAfter.
  ///
  /// In en, this message translates to:
  /// **'with?'**
  String get helpTitleAfter;

  /// No description provided for @helpSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Select one or more goals to personalize your garden.'**
  String get helpSubtitle;

  /// No description provided for @helpHeal.
  ///
  /// In en, this message translates to:
  /// **'Heal sick\nplants'**
  String get helpHeal;

  /// No description provided for @helpCare.
  ///
  /// In en, this message translates to:
  /// **'Care\nreminders'**
  String get helpCare;

  /// No description provided for @helpIdentify.
  ///
  /// In en, this message translates to:
  /// **'Identify\nspecies'**
  String get helpIdentify;

  /// No description provided for @helpJournal.
  ///
  /// In en, this message translates to:
  /// **'Growth\njournal'**
  String get helpJournal;

  /// No description provided for @helpOther.
  ///
  /// In en, this message translates to:
  /// **'Something else'**
  String get helpOther;

  /// No description provided for @journeyTitle.
  ///
  /// In en, this message translates to:
  /// **'Your Green Journey'**
  String get journeyTitle;

  /// No description provided for @journeySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Select the level of care you wish to provide.'**
  String get journeySubtitle;

  /// No description provided for @journeyCasualLabel.
  ///
  /// In en, this message translates to:
  /// **'CASUAL'**
  String get journeyCasualLabel;

  /// No description provided for @journeyCasualTitle.
  ///
  /// In en, this message translates to:
  /// **'Low Maintenance'**
  String get journeyCasualTitle;

  /// No description provided for @journeyCasualSubtitle.
  ///
  /// In en, this message translates to:
  /// **'I just want to keep my simple plants alive and thriving.'**
  String get journeyCasualSubtitle;

  /// No description provided for @journeyEnthusiastLabel.
  ///
  /// In en, this message translates to:
  /// **'ENTHUSIAST'**
  String get journeyEnthusiastLabel;

  /// No description provided for @journeyEnthusiastTitle.
  ///
  /// In en, this message translates to:
  /// **'Balanced Care'**
  String get journeyEnthusiastTitle;

  /// No description provided for @journeyEnthusiastSubtitle.
  ///
  /// In en, this message translates to:
  /// **'I enjoy spending some weekly time with my growing collection.'**
  String get journeyEnthusiastSubtitle;

  /// No description provided for @journeyObsessedLabel.
  ///
  /// In en, this message translates to:
  /// **'OBSESSED'**
  String get journeyObsessedLabel;

  /// No description provided for @journeyObsessedTitle.
  ///
  /// In en, this message translates to:
  /// **'Plant Parent Extraordinaire'**
  String get journeyObsessedTitle;

  /// No description provided for @journeyObsessedSubtitle.
  ///
  /// In en, this message translates to:
  /// **'I live for my plants and want expert schedules for my indoor jungle.'**
  String get journeyObsessedSubtitle;

  /// No description provided for @masteryTitleBefore.
  ///
  /// In en, this message translates to:
  /// **'How’s your '**
  String get masteryTitleBefore;

  /// No description provided for @masteryTitleHighlight.
  ///
  /// In en, this message translates to:
  /// **'green\nthumb '**
  String get masteryTitleHighlight;

  /// No description provided for @masteryTitleAfter.
  ///
  /// In en, this message translates to:
  /// **'lately?'**
  String get masteryTitleAfter;

  /// No description provided for @masterySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Be honest—we’ve all been “The Serial Killer” at some point. Select your current mastery.'**
  String get masterySubtitle;

  /// No description provided for @masteryKiller.
  ///
  /// In en, this message translates to:
  /// **'The Serial Killer'**
  String get masteryKiller;

  /// No description provided for @masteryKillerSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Even my plastic plants look worried when I enter the room.'**
  String get masteryKillerSubtitle;

  /// No description provided for @masteryAccidental.
  ///
  /// In en, this message translates to:
  /// **'Accidental Parent'**
  String get masteryAccidental;

  /// No description provided for @masteryAccidentalSubtitle.
  ///
  /// In en, this message translates to:
  /// **'My cactus has survived two weeks. We’re still getting to know each other.'**
  String get masteryAccidentalSubtitle;

  /// No description provided for @masteryGrowth.
  ///
  /// In en, this message translates to:
  /// **'Growth Mindset'**
  String get masteryGrowth;

  /// No description provided for @masteryGrowthSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Most of my friends have leaves. I know my Monsteras from my Pothos.'**
  String get masteryGrowthSubtitle;

  /// No description provided for @masteryWhisperer.
  ///
  /// In en, this message translates to:
  /// **'Plant Whisperer'**
  String get masteryWhisperer;

  /// No description provided for @masteryWhispererSubtitle.
  ///
  /// In en, this message translates to:
  /// **'I propagate rare plants and speak fluent botanical Latin.'**
  String get masteryWhispererSubtitle;

  /// No description provided for @onboardingOneTitle.
  ///
  /// In en, this message translates to:
  /// **'Take Care\nof Your Plants\n'**
  String get onboardingOneTitle;

  /// No description provided for @onboardingOneHighlight.
  ///
  /// In en, this message translates to:
  /// **'Like a Pro'**
  String get onboardingOneHighlight;

  /// No description provided for @onboardingOneSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Smart schedules and instant identification for your urban jungle.'**
  String get onboardingOneSubtitle;

  /// No description provided for @onboardingOneBadge.
  ///
  /// In en, this message translates to:
  /// **'AI-POWERED CARE'**
  String get onboardingOneBadge;

  /// No description provided for @onboardingAiScan.
  ///
  /// In en, this message translates to:
  /// **'AI Scan'**
  String get onboardingAiScan;

  /// No description provided for @onboardingSmartWater.
  ///
  /// In en, this message translates to:
  /// **'Smart Water'**
  String get onboardingSmartWater;

  /// No description provided for @onboardingLightTracking.
  ///
  /// In en, this message translates to:
  /// **'Light Tracking'**
  String get onboardingLightTracking;

  /// No description provided for @onboardingTwoTitle.
  ///
  /// In en, this message translates to:
  /// **'Identify Any\nPlant in\n'**
  String get onboardingTwoTitle;

  /// No description provided for @onboardingTwoHighlight.
  ///
  /// In en, this message translates to:
  /// **'Seconds'**
  String get onboardingTwoHighlight;

  /// No description provided for @onboardingTwoSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Take a photo to learn its name, species, and care requirements.'**
  String get onboardingTwoSubtitle;

  /// No description provided for @onboardingTwoBadge.
  ///
  /// In en, this message translates to:
  /// **'BOTANICAL EXPERT'**
  String get onboardingTwoBadge;

  /// No description provided for @onboardingSnapPhoto.
  ///
  /// In en, this message translates to:
  /// **'Snap Photo'**
  String get onboardingSnapPhoto;

  /// No description provided for @onboardingAccurateResult.
  ///
  /// In en, this message translates to:
  /// **'Accurate Result'**
  String get onboardingAccurateResult;

  /// No description provided for @onboardingPlantWiki.
  ///
  /// In en, this message translates to:
  /// **'Plant Wiki'**
  String get onboardingPlantWiki;

  /// No description provided for @onboardingThreeTitle.
  ///
  /// In en, this message translates to:
  /// **'Never Forget\nTo Water\n'**
  String get onboardingThreeTitle;

  /// No description provided for @onboardingThreeHighlight.
  ///
  /// In en, this message translates to:
  /// **'Again'**
  String get onboardingThreeHighlight;

  /// No description provided for @onboardingThreeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Get reminders timed to your plant’s needs and environment.'**
  String get onboardingThreeSubtitle;

  /// No description provided for @onboardingThreeBadge.
  ///
  /// In en, this message translates to:
  /// **'SMART SCHEDULES'**
  String get onboardingThreeBadge;

  /// No description provided for @onboardingReminders.
  ///
  /// In en, this message translates to:
  /// **'Reminders'**
  String get onboardingReminders;

  /// No description provided for @onboardingClimateData.
  ///
  /// In en, this message translates to:
  /// **'Climate Data'**
  String get onboardingClimateData;

  /// No description provided for @onboardingHealthyGrowth.
  ///
  /// In en, this message translates to:
  /// **'Healthy Growth'**
  String get onboardingHealthyGrowth;

  /// No description provided for @onboardingCommunity.
  ///
  /// In en, this message translates to:
  /// **'Join 50,000+ plant parents'**
  String get onboardingCommunity;

  /// No description provided for @onboardingAgreement.
  ///
  /// In en, this message translates to:
  /// **'BY CONTINUING, YOU AGREE TO OUR TERMS & PRIVACY POLICY'**
  String get onboardingAgreement;

  /// No description provided for @termsTitle.
  ///
  /// In en, this message translates to:
  /// **'Terms & Policies'**
  String get termsTitle;

  /// No description provided for @termsUpdated.
  ///
  /// In en, this message translates to:
  /// **'Last updated: July 2026'**
  String get termsUpdated;

  /// No description provided for @termsUseTitle.
  ///
  /// In en, this message translates to:
  /// **'1. Terms of Use'**
  String get termsUseTitle;

  /// No description provided for @termsUseBody.
  ///
  /// In en, this message translates to:
  /// **'By accessing or using Botaniq, you agree to these Terms of Use and applicable laws. If you do not agree, you may not use the service.'**
  String get termsUseBody;

  /// No description provided for @termsPrivacyTitle.
  ///
  /// In en, this message translates to:
  /// **'2. User Privacy'**
  String get termsPrivacyTitle;

  /// No description provided for @termsPrivacyBody.
  ///
  /// In en, this message translates to:
  /// **'We collect only the personal data needed to provide tailored plant-care schedules. We do not sell your personal data to third parties.'**
  String get termsPrivacyBody;

  /// No description provided for @termsPlantTitle.
  ///
  /// In en, this message translates to:
  /// **'3. Plant Data'**
  String get termsPlantTitle;

  /// No description provided for @termsPlantBody.
  ///
  /// In en, this message translates to:
  /// **'Plant-care, identification, and diagnosis information is provided for informational purposes. AI results may not always be correct, so observe your plant and seek an expert for serious risks.'**
  String get termsPlantBody;

  /// No description provided for @termsPremiumTitle.
  ///
  /// In en, this message translates to:
  /// **'4. Premium Subscriptions'**
  String get termsPremiumTitle;

  /// No description provided for @termsPremiumBody.
  ///
  /// In en, this message translates to:
  /// **'Premium subscriptions are billed according to your app-store agreement. You may cancel at any time; partial billing periods are not refundable.'**
  String get termsPremiumBody;

  /// No description provided for @termsClosing.
  ///
  /// In en, this message translates to:
  /// **'Enjoy peace of mind and happier plants.'**
  String get termsClosing;

  /// No description provided for @weatherTitle.
  ///
  /// In en, this message translates to:
  /// **'Weather'**
  String get weatherTitle;

  /// No description provided for @weatherSunnyTip.
  ///
  /// In en, this message translates to:
  /// **'Sunny today—check the soil before watering.'**
  String get weatherSunnyTip;

  /// No description provided for @weatherCloudyTip.
  ///
  /// In en, this message translates to:
  /// **'Cloudy weather slows evaporation; water a little less.'**
  String get weatherCloudyTip;

  /// No description provided for @weatherRainyTip.
  ///
  /// In en, this message translates to:
  /// **'Rainy and humid—avoid overwatering outdoor plants.'**
  String get weatherRainyTip;

  /// No description provided for @weatherStormTip.
  ///
  /// In en, this message translates to:
  /// **'Stormy weather—move delicate pots to a sheltered spot.'**
  String get weatherStormTip;

  /// No description provided for @weatherSnowTip.
  ///
  /// In en, this message translates to:
  /// **'Cold and snowy—protect plants from temperature shock.'**
  String get weatherSnowTip;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'tr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'tr':
      return AppLocalizationsTr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
