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

  /// API settings section header
  ///
  /// In en, this message translates to:
  /// **'API Settings (AI)'**
  String get apiSettings;

  /// API key text field hint
  ///
  /// In en, this message translates to:
  /// **'sk-proj-... or sk-...'**
  String get apiKeyHint;

  /// API key explanation text
  ///
  /// In en, this message translates to:
  /// **'Enter your own OpenAI API Key to make API requests from your account. The API Key is stored locally on your device in encrypted form.'**
  String get apiKeyDescription;

  /// Snackbar message after saving API key
  ///
  /// In en, this message translates to:
  /// **'OpenAI API Key saved successfully.'**
  String get apiKeySaved;

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
