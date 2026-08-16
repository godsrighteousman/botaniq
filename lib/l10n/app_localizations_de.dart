// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'Botaniq';

  @override
  String get settings => 'Einstellungen';

  @override
  String get preferences => 'Präferenzen';

  @override
  String get darkMode => 'Dunkler Modus';

  @override
  String get metricSystem => 'Metrisches System';

  @override
  String get metricSystemSubtitle => 'Verwenden Sie Celsius und Meter';

  @override
  String get account => 'Konto';

  @override
  String get editProfile => 'Profil bearbeiten';

  @override
  String get changePassword => 'Passwort ändern';

  @override
  String get subscriptionManagement => 'Abonnementverwaltung';

  @override
  String get premium => 'Premium';

  @override
  String get language => 'Sprache';

  @override
  String get languageSubtitle => 'App-Sprache ändern';

  @override
  String get selectLanguage => 'Wählen Sie Sprache aus';

  @override
  String get systemLanguage => 'Systemsprache';

  @override
  String get english => 'Englisch';

  @override
  String get turkish => 'Türkçe';

  @override
  String get languageChanged => 'Die Sprache wurde erfolgreich geändert.';

  @override
  String get languageSearchHint => 'Sprachen suchen';

  @override
  String get languageRecommended => 'Empfohlen';

  @override
  String get languageWelcomeTitle => 'Wählen Sie Ihre Sprache';

  @override
  String get languageWelcomeSubtitle =>
      'Wählen Sie die Sprache aus, die Sie in Botaniq verwenden möchten. Sie können es jederzeit ändern.';

  @override
  String get languageUseSystem => 'Verwenden Sie die Gerätesprache';

  @override
  String get preferenceSystem => 'Systemeinstellung verwenden';

  @override
  String get themeLight => 'Licht';

  @override
  String get themeDark => 'Dunkel';

  @override
  String get themeSelectionTitle => 'Aussehen wählen';

  @override
  String get measurementMetric => 'Metrisch';

  @override
  String get measurementImperial => 'Kaiserlich';

  @override
  String get measurementSelectionTitle => 'Messsystem wählen';

  @override
  String get settingsSubtitle =>
      'Gestalten Sie Botaniq nach Ihrem eigenen Pflegerhythmus.';

  @override
  String get settingsLocalPreference => 'Auf diesem Gerät gespeichert';

  @override
  String get settingsDarkModeSubtitle =>
      'Eine ruhigere Palette für Momente bei wenig Licht';

  @override
  String get settingsAccountSubtitle => 'Identität, Zugang und Mitgliedschaft';

  @override
  String get settingsEditProfileSubtitle =>
      'Name, Standort und Pflegepräferenzen';

  @override
  String get settingsPasswordSubtitle =>
      'Senden Sie einen Link zum sicheren Zurücksetzen an Ihre E-Mail';

  @override
  String get settingsSubscriptionSubtitle =>
      'Premium-Plan und Rechnungsdetails';

  @override
  String get settingsPasswordResetSent =>
      'E-Mail zum Zurücksetzen des Passworts gesendet.';

  @override
  String get settingsComingSoon => 'Dieser Raum wächst immer noch.';

  @override
  String get subscriptionPageTitle => 'Premium-Mitgliedschaft';

  @override
  String get subscriptionHeroEyebrow => 'BOTANIQ PREMIUM';

  @override
  String get subscriptionHeroTitle => 'Intelligentere Pflege für jede Pflanze';

  @override
  String get subscriptionHeroSubtitle =>
      'Schalten Sie alle Premium-Pflegetools frei und vergrößern Sie Ihre Grünfläche mit Zuversicht.';

  @override
  String get subscriptionBenefitsTitle => 'Alles in Premium';

  @override
  String get subscriptionBenefitIdentification =>
      'Unbegrenzte Pflanzenidentifizierung und Gesundheitsanalyse';

  @override
  String get subscriptionBenefitCare =>
      'Personalisierte Pflegepläne und Erinnerungen';

  @override
  String get subscriptionBenefitInsights =>
      'Experteninhalte und erweiterte Einblicke in die Pflege';

  @override
  String get subscriptionMonthlyPlan => 'Monatlich';

  @override
  String get subscriptionAnnualPlan => 'Jährlich';

  @override
  String subscriptionPerMonth(String price) {
    return '$price / Monat';
  }

  @override
  String subscriptionPerYear(String price) {
    return '$price / Jahr';
  }

  @override
  String get subscriptionBestValue => 'Das beste Preis-Leistungs-Verhältnis';

  @override
  String subscriptionSavePercent(int percent) {
    return 'Sparen Sie $percent%';
  }

  @override
  String get subscriptionContinue => 'Premium freischalten';

  @override
  String get subscriptionRestorePurchases => 'Einkäufe wiederherstellen';

  @override
  String get subscriptionRestoring => 'Wiederherstellung...';

  @override
  String get subscriptionManage => 'Abonnement verwalten';

  @override
  String get subscriptionActiveTitle => 'Ihre Premium-Mitgliedschaft ist aktiv';

  @override
  String get subscriptionActiveSubtitle =>
      'Sie haben Zugriff auf alle Premium-Funktionen.';

  @override
  String subscriptionRenewsOn(String date) {
    return 'Verlängert am $date';
  }

  @override
  String subscriptionExpiresOn(String date) {
    return 'Aktiv bis $date';
  }

  @override
  String get subscriptionAutoRenewDisclosure =>
      'Die Zahlung erfolgt über Ihr Apple- oder Google-Konto. Das Abonnement verlängert sich automatisch, sofern es nicht mindestens 24 Stunden vor Ablauf des aktuellen Zeitraums gekündigt wird. Sie können es jederzeit in den Einstellungen Ihres Shop-Kontos verwalten oder kündigen.';

  @override
  String get subscriptionTermsLink => 'Nutzungsbedingungen';

  @override
  String get subscriptionPrivacyLink => 'Datenschutzrichtlinie';

  @override
  String get subscriptionPurchaseSuccess =>
      'Ihre Premium-Mitgliedschaft ist jetzt aktiv.';

  @override
  String get subscriptionRestoreSuccess =>
      'Ihre Premium-Mitgliedschaft wurde wiederhergestellt.';

  @override
  String get subscriptionNothingToRestore =>
      'Für dieses Shop-Konto wurde keine aktive Mitgliedschaft gefunden.';

  @override
  String get subscriptionPaymentPending =>
      'Die Zahlung wartet auf die Genehmigung durch das Geschäft. Ihre Mitgliedschaft wird nach der Genehmigung automatisch aktiviert.';

  @override
  String get subscriptionErrorGeneric =>
      'Der Vorgang konnte nicht abgeschlossen werden. Bitte versuchen Sie es erneut.';

  @override
  String get subscriptionErrorNetwork =>
      'Überprüfen Sie Ihre Internetverbindung und versuchen Sie es erneut.';

  @override
  String get subscriptionErrorNotAllowed =>
      'Mit diesem Gerät oder Shop-Konto dürfen keine Einkäufe getätigt werden.';

  @override
  String get subscriptionErrorStore =>
      'Der Laden war nicht erreichbar. Bitte versuchen Sie es in Kürze noch einmal.';

  @override
  String get subscriptionMissingConfiguration =>
      'Der RevenueCat-Schlüssel fehlt in diesem Build.';

  @override
  String get subscriptionUnsupported =>
      'Abonnements sind nur in den iOS- und Android-Apps verfügbar.';

  @override
  String get subscriptionProductsUnavailable =>
      'Monats- und Jahresprodukte konnten nicht geladen werden. Überprüfen Sie die Konfiguration des RevenueCat-Angebots.';

  @override
  String get subscriptionRetry => 'Versuchen Sie es erneut';

  @override
  String get subscriptionFree => 'Kostenlos';

  @override
  String get homeGoodMorning => 'Hallo,';

  @override
  String homePersonalGreeting(String greeting, String name) {
    return '$greeting, $name 👋';
  }

  @override
  String get homeEmptyGarden => 'Dein Garten ist leer';

  @override
  String get homeEmptyGardenSubtitle =>
      'Beginnen Sie mit dem Bau Ihres grünen Zufluchtsortes\nindem Sie Ihre erste Pflanze hinzufügen.';

  @override
  String get homeAddFirstPlant => 'Erste Pflanze hinzufügen';

  @override
  String get homeMyPlants => 'Meine Pflanzen';

  @override
  String get homeViewAll => 'Alle anzeigen';

  @override
  String get homeSmartCareReminders => 'Smart Care-Erinnerungen';

  @override
  String get homeWatering => 'Bewässerung';

  @override
  String get homeWateringSubtitle => 'Bodenverfolgung';

  @override
  String get homeFertilizing => 'Düngen';

  @override
  String get homeFertilizingSubtitle => 'Nährstoffwarnungen';

  @override
  String get gardenTitle => 'Mein Garten';

  @override
  String get gardenAllPlants => 'Alle Pflanzen';

  @override
  String get gardenNeedsWater => 'Benötigt Wasser';

  @override
  String get gardenIndoor => 'Drinnen';

  @override
  String get gardenNoPlants =>
      'Noch keine Pflanzen.\nTippen Sie auf +, um Ihre erste Pflanze hinzuzufügen!';

  @override
  String get gardenNoPlantsCategory => 'Keine Pflanzen in dieser Kategorie.';

  @override
  String get discoverTitle => 'Entdecken';

  @override
  String get discoverSearchHint =>
      'Suchen Sie nach Pflanzen, Artikeln, Leitfäden...';

  @override
  String get discoverLatestArticles => 'Neueste Artikel';

  @override
  String get discoverSeeAll => 'Alle anzeigen';

  @override
  String get discoverTrendingGuides => 'Trendführer';

  @override
  String get healthyTitle => 'Pflegezentrum';

  @override
  String get healthySubtitle =>
      'Berühren Sie die Seele Ihrer Pflanzen, sprechen Sie mit ihnen.';

  @override
  String get healthyTabDoctor => 'Doktor';

  @override
  String get healthyTabHospital => 'Krankenhaus';

  @override
  String get healthyTabDiscover => 'Entdecken';

  @override
  String get profileTitle => 'Mein Profil';

  @override
  String get profileEditProfile => 'Profil bearbeiten';

  @override
  String get profileOverview => 'Übersicht';

  @override
  String get profileSettingsTab => 'Einstellungen';

  @override
  String get profileGardenerLevel => 'Gärtnerniveau';

  @override
  String get profileTotalPlants => 'Gesamtpflanzen';

  @override
  String get profileCompletedTasks => 'Abgeschlossene Aufgaben';

  @override
  String get profileWeeklyActivity => 'Wöchentliche Pflegeaktivität';

  @override
  String get profileGeneral => 'Allgemein';

  @override
  String get profileAppSettings => 'App-Einstellungen';

  @override
  String get profileNotificationPrefs => 'Benachrichtigungseinstellungen';

  @override
  String get profileSupportLegal => 'Support & Recht';

  @override
  String get profileHelpCenter => 'Hilfecenter';

  @override
  String get profileTerms => 'Nutzungsbedingungen und Richtlinien';

  @override
  String get profileSignOut => 'Abmelden';

  @override
  String get profileDeleteAccount => 'Konto löschen';

  @override
  String get profileSubtitle =>
      'Ihre Gartengeschichte, Ihr Fortschritt und Ihr persönlicher Raum.';

  @override
  String get profileGardenPassport => 'GARTENPASS';

  @override
  String get profileThisWeek => 'Diese Woche';

  @override
  String get profileQuietWeek =>
      'Eine ruhige Woche – Ihr nächster Pflegemoment erscheint hier.';

  @override
  String get profileActiveWeek => 'Ihr Pflegerhythmus lebt und wächst.';

  @override
  String get profileAppSettingsSubtitle =>
      'Sprache, Einheiten und KI-Verbindung';

  @override
  String get profileNotificationPrefsSubtitle =>
      'Wählen Sie, welche Pflegemomente Sie erreichen';

  @override
  String get profileHelpCenterSubtitle => 'Antworten und schnelle Anleitung';

  @override
  String get profileTermsSubtitle => 'Datenschutz, Bedingungen und Richtlinien';

  @override
  String get profileAccountActions => 'Kontoaktionen';

  @override
  String get profileSignOutQuestion =>
      'Sind Sie sicher, dass Sie sich abmelden möchten?';

  @override
  String get profileDeleteAccountWarning =>
      'Das Löschen des Kontos erfordert eine sichere serverseitige Bestätigung. Ihre Daten wurden nicht geändert.';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get continueAction => 'Weiter';

  @override
  String get profileTitleNew => 'Neuer Gärtner 🌱';

  @override
  String get profileTitleSprout => 'Sprout-Freund 🌿';

  @override
  String get profileTitleLeaf => 'Blattliebhaber ☘️';

  @override
  String get profileTitleSkilled => 'Erfahrener Gärtner 🏡';

  @override
  String get profileTitleMaster => 'Grüner-Daumen-Meister 👑';

  @override
  String get profileNextLevelStart =>
      'Fügen Sie Ihre erste Pflanze hinzu und beginnen Sie Ihr Gartenabenteuer!';

  @override
  String profileNextLevelLeaf(int count) {
    return 'Nur noch $count Pflanzen sind übrig, um Leaf Lover zu werden.';
  }

  @override
  String profileNextLevelSkilled(int count) {
    return 'Es sind nur noch $count Pflanzen übrig, um den Beruf des erfahrenen Gärtners auszuüben.';
  }

  @override
  String profileNextLevelMaster(int count) {
    return 'Es sind nur noch $count Pflanzen übrig, um Green Thumb Master zu werden.';
  }

  @override
  String get profileNextLevelMax =>
      'Sie sind ganz oben in Ihrem Garten, herzlichen Glückwunsch!';

  @override
  String get navHome => 'Zuhause';

  @override
  String get navGarden => 'Garten';

  @override
  String get navClinic => 'Klinik';

  @override
  String get navProfile => 'Profil';

  @override
  String get scanPlant => 'Pflanze scannen';

  @override
  String get deletePlantTitle => 'Diese Pflanze entfernen?';

  @override
  String get deletePlantMessage =>
      'Die Anlage, ihre Pflegeaufgaben und Klinikunterlagen werden dauerhaft aus Ihrem Konto entfernt.';

  @override
  String get deletePlantAction => 'Pflanze entfernen';

  @override
  String get deletePlantNotFound =>
      'Die Pflanze konnte nicht gefunden werden oder wurde bereits entfernt.';

  @override
  String deletePlantError(String error) {
    return 'Die Pflanze konnte nicht entfernt werden: $error';
  }

  @override
  String get profileChoosePhoto => 'Wählen Sie Profilfoto';

  @override
  String get profileFullName => 'Vollständiger Name';

  @override
  String get profileFullNameHint => 'Geben Sie Ihren vollständigen Namen ein';

  @override
  String get profileNickname => 'Spitzname';

  @override
  String get profileNicknameHint => 'Wie sollen wir Sie nennen?';

  @override
  String get profileAge => 'Alter';

  @override
  String get profileAgeHint => '1–120';

  @override
  String get profileAgeValidation =>
      'Bitte geben Sie ein Alter zwischen 1 und 120 Jahren ein.';

  @override
  String profileLoadError(String error) {
    return 'Profil konnte nicht geladen werden: $error';
  }

  @override
  String get languageEnglish => 'Englisch';

  @override
  String get languageTurkish => 'Türkisch';

  @override
  String get profileEmailReadOnly => 'E-Mail-Adresse (schreibgeschützt)';

  @override
  String get profileEmailHint => 'Geben Sie Ihre E-Mail-Adresse ein';

  @override
  String get profileLocation => 'Standort';

  @override
  String get profileLocationHint => 'Stadt, Land';

  @override
  String get profileSaveChanges => 'Änderungen speichern';

  @override
  String get profileUpdated => 'Ihr Profil wurde aktualisiert.';

  @override
  String profileSaveError(String error) {
    return 'Profil konnte nicht gespeichert werden: $error';
  }

  @override
  String get notificationWateringTitle => 'Bewässerungserinnerungen';

  @override
  String get notificationWateringSubtitle =>
      'Lassen Sie sich benachrichtigen, wenn es Zeit zum Gießen ist';

  @override
  String get notificationFertilizerTitle => 'Düngemittel-Erinnerungen';

  @override
  String get notificationFertilizerSubtitle =>
      'Saisonale Fütterungswarnungen für Ihre Pflanzen';

  @override
  String get notificationTitle => 'Benachrichtigungen';

  @override
  String get notificationPlantCareAlerts => 'Pflanzenpflegewarnungen';

  @override
  String get notificationOther => 'Andere Benachrichtigungen';

  @override
  String get notificationWeatherTitle => 'Wetterwarnungen';

  @override
  String get notificationWeatherSubtitle => 'Extreme Wetterwarnungen';

  @override
  String get notificationArticlesTitle => 'Neue Artikel';

  @override
  String get notificationArticlesSubtitle =>
      'Tipps und Tricks für Ihren Garten';

  @override
  String get gardenMyPlantFallback => 'Meine Pflanze';

  @override
  String get gardenClinicBadge => 'In der Klinik';

  @override
  String get wateringNever => 'Zuletzt gegossen: Nie';

  @override
  String wateringLastDate(String date) {
    return 'Zuletzt bewässert: $date';
  }

  @override
  String wateringInterval(int days) {
    return 'Alle $days Tage';
  }

  @override
  String get wateringNeverDue => 'Noch nicht bewässert • Heute gießen';

  @override
  String wateringOverdue(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days Tage überfällig',
      one: '1 Tag überfällig',
      zero: 'Heute gießen',
    );
    return '$_temp0';
  }

  @override
  String get wateringDueToday => 'Heute Wasser';

  @override
  String get wateringDueTomorrow => 'Morgen Wasser geben';

  @override
  String wateringDueInDays(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'In $days Tagen gießen',
      one: 'In 1 Tag gießen',
      zero: 'Heute gießen',
    );
    return '$_temp0';
  }

  @override
  String get plantUnknown => 'Unbekannte Pflanze';

  @override
  String get plantSpeciesFallback => 'Pflanzenarten';

  @override
  String get plantDifficultyMedium => 'Mittel';

  @override
  String get plantAbout => 'Über';

  @override
  String get plantLocationEnvironment => 'Standort und Umgebung';

  @override
  String get plantCareProtocol => 'Pflegeprotokoll';

  @override
  String get plantCareHistory => 'Pflegegeschichte der letzten 10 Tage';

  @override
  String get plantHealthy => 'Gesund';

  @override
  String get plantInClinic => 'In der Klinik';

  @override
  String get plantDifficulty => 'Schwierigkeit';

  @override
  String get plantToxicity => 'Toxizität';

  @override
  String get plantEnvironment => 'Umwelt';

  @override
  String get plantLightNeed => 'Lichtbedarf';

  @override
  String get plantToxicPets => 'Giftig für Haustiere';

  @override
  String get plantNonToxic => 'Ungiftig';

  @override
  String get plantIndoor => 'Drinnen';

  @override
  String get plantBrightIndirect => 'Hell Indirekt';

  @override
  String get plantInfoUnavailable =>
      'Verifizierte Informationen sind noch nicht verfügbar.';

  @override
  String get plantIdealClimate => 'Ideales Klima';

  @override
  String get plantHumidity => 'Luftfeuchtigkeit';

  @override
  String get plantTemperatureRange => 'Temperaturbereich';

  @override
  String get plantWateringFrequency => 'Bewässerungshäufigkeit';

  @override
  String plantWateringFrequencyValue(String interval) {
    return 'Wasser $interval.';
  }

  @override
  String get plantNextWatering => 'Nächste Bewässerung';

  @override
  String get plantWateringProtocol => 'Bewässerungsprotokoll';

  @override
  String get plantSoilProtocol => 'Boden';

  @override
  String get plantFeedingProtocol => 'Fütterungsprotokoll';

  @override
  String get plantPruningCleaning => 'Beschneiden und Reinigen';

  @override
  String get plantPruningFallback =>
      'Wischen Sie die Blätter monatlich ab. Beschneiden Sie abgestorbene oder vergilbte Blätter, um das Wachstum zu fördern.';

  @override
  String get plantHistoryEmpty =>
      'Keine Pflegegeschichte in den letzten 10 Tagen.';

  @override
  String get plantWateringTask => 'Bewässerung';

  @override
  String get plantFertilizingTask => 'Düngen';

  @override
  String get plantWateredAction => 'Bewässert ✓';

  @override
  String get plantWaterNowAction => 'Jetzt gießen';

  @override
  String get plantFertilizedAction => 'Befruchtet ✓';

  @override
  String get plantFertilizeAction => 'Düngen';

  @override
  String get plantAddGardenAction => 'Zu „Mein Garten“ hinzufügen';

  @override
  String get plantWaterSuccess =>
      '💧 Du hast deine Pflanze gegossen! Tolle Arbeit!';

  @override
  String get plantFertilizeSuccess =>
      '🌱 Dünger hinzugefügt! Ihre Pflanze sagt Danke!';

  @override
  String plantWaterError(String error) {
    return 'Bewässerung konnte nicht gespeichert werden: $error';
  }

  @override
  String plantFertilizeError(String error) {
    return 'Düngung konnte nicht gespeichert werden: $error';
  }

  @override
  String get clinicQuickTools => 'Schnelle Tools';

  @override
  String get clinicDoctorHero => 'KI-Pflanzendoktor\nZu Ihren Diensten';

  @override
  String get clinicStartConsultation => 'Beratung starten';

  @override
  String get clinicChoosePlant => 'Über welche Pflanze möchten Sie sprechen?';

  @override
  String get clinicChoosePlantSubtitle =>
      'Wählen Sie eine Pflanze aus Ihrem Garten oder machen Sie ein neues Foto.';

  @override
  String get clinicNoGardenPlants =>
      'Es gibt noch keine Pflanzen in Ihrem Garten.\nBeginnen Sie mit der Aufnahme eines neuen Fotos.';

  @override
  String get clinicNewPhoto => 'Machen Sie ein neues Foto';

  @override
  String get clinicNewPhotoSubtitle =>
      'Fotografieren Sie die kranke Pflanze und stellen Sie eine Diagnose';

  @override
  String get clinicPestAnalysis => 'Schädlingsanalyse';

  @override
  String get clinicVisualDiagnosis => 'Visuelle Diagnose';

  @override
  String get clinicLightMeter => 'Lichtmesser';

  @override
  String get clinicSensorSimulation => 'Sensorsimulation';

  @override
  String get clinicTitle => 'Pflanzenklinik';

  @override
  String clinicSickCount(int count) {
    return '$count Krank';
  }

  @override
  String get clinicAllHealthy => 'Alle Ihre Pflanzen sind gesund! 🌿';

  @override
  String get clinicEmpty =>
      'In der Klinik gibt es keine kranken Pflanzen.\nWenn Sie sich Sorgen um eine Pflanze machen,\nFragen Sie auf der Registerkarte „Arzt“.';

  @override
  String get clinicUnknown => 'Unbekannt';

  @override
  String get clinicPendingDiagnosis => 'Warten auf die Diagnose';

  @override
  String get clinicNoTreatment => 'Die Behandlung wurde nicht festgelegt';

  @override
  String get clinicPrescription => 'Rezept:';

  @override
  String get clinicRecovery => 'Erholung';

  @override
  String get clinicRecovered => 'Wiederhergestellt';

  @override
  String get clinicContinue => 'Weiter';

  @override
  String get clinicRecoveredSuccess => '🎉 Deine Pflanze ist wieder gesund!';

  @override
  String get clinicUrgencyLow => 'Niedrig';

  @override
  String get clinicUrgencyMedium => 'Mittel';

  @override
  String get clinicUrgencyCritical => 'Kritisch';

  @override
  String get healthTrendingTips => 'Trendige Gesundheitstipps';

  @override
  String get healthHumidityArticleTitle =>
      'Wintervorbereitung: Die Luftfeuchtigkeit im Gleichgewicht halten';

  @override
  String get healthHumidityArticleSubtitle =>
      'So schützen Sie Ihre Pflanzen in den kalten Monaten vor trockener Heizungsluft.';

  @override
  String get healthWeeklySpotlight => 'Patient und Heilmittel der Woche';

  @override
  String get healthAphidTitle => 'Blattlausbefall';

  @override
  String get healthAphidSubtitle =>
      'Frühzeitiges Eingreifen und eine natürliche Neemöl-Behandlung.';

  @override
  String get healthDiscoverLoadError =>
      'Der Discover-Inhalt konnte derzeit nicht geladen werden. Ziehen Sie nach unten, um es erneut zu versuchen.';

  @override
  String get healthDiscoverEmpty =>
      'Es gibt noch keine veröffentlichten Entdeckungsinhalte.';

  @override
  String get healthDiscoverRetry => 'Versuchen Sie es erneut';

  @override
  String get lightMeterTitle => 'Lichtmesser';

  @override
  String get lightMeterInstructionTitle => 'Licht messen';

  @override
  String get lightMeterInstruction =>
      'Richten Sie die Frontkamera des Telefons darauf\ndie Position und Lichtquelle der Pflanze.';

  @override
  String get lightMeterCameraEstimate =>
      'Ungefährer Lux-Wert, berechnet aus Kameradaten';

  @override
  String get lightMeterStabilizing => 'Stabilisierende Messung';

  @override
  String get lightMeterStabilizingRecommendation =>
      'Halten Sie das Telefon einige Sekunden lang ruhig, während plötzliche Belichtungsänderungen gefiltert werden.';

  @override
  String get lightMeterUnavailable => 'Messung nicht verfügbar';

  @override
  String get lightMeterUnavailableRecommendation =>
      'Aktivieren Sie die Kameraberechtigung und versuchen Sie es erneut mit diesem Bildschirm.';

  @override
  String get lightLow => 'Schwaches Licht (Schatten)';

  @override
  String get lightMedium => 'Mittleres Licht (heller Raum)';

  @override
  String get lightHigh => 'Starkes Licht (in der Nähe des Fensters)';

  @override
  String get lightVeryHigh => 'Sehr starkes Licht (direkte Sonne)';

  @override
  String get lightLowRecommendation =>
      'Geeignet für Calathea, Farne oder Schlangenpflanzen.';

  @override
  String get lightMediumRecommendation =>
      'Ideal für Monstera, Ficus und Anthurium.';

  @override
  String get lightHighRecommendation =>
      'Geeignet für sonnenliebende Aloe, Kakteen und Geranien.';

  @override
  String get lightVeryHighRecommendation =>
      'Am besten für Pflanzen und Sukkulenten im Freien geeignet.';

  @override
  String get homeLoadingPlants => 'Pflanzen werden geladen...';

  @override
  String get homeNotifications => 'Benachrichtigungen';

  @override
  String get homeWateringTime => 'Bewässerungszeit';

  @override
  String get homeWateringNotification => 'Ihre Zimmerpflanzen brauchen Wasser.';

  @override
  String get homeWelcome => 'Willkommen!';

  @override
  String get homeWelcomeNotification =>
      'Willkommen bei Botaniq. Beginnen Sie mit dem Hinzufügen Ihrer ersten Pflanze.';

  @override
  String get homeTenMinutesAgo => 'Vor 10 Minuten';

  @override
  String get homeOneDayAgo => 'Vor 1 Tag';

  @override
  String get homeQuickActions => 'Schnelle Aktionen';

  @override
  String get homeIdentifyCamera => 'Identifizieren Sie sich mit Ihrer Kamera';

  @override
  String get homeTomorrow => 'Morgen';

  @override
  String get homeNoTasks => 'Keine Aufgaben für diesen Tag!';

  @override
  String get homeAllCared => 'Für Ihre Pflanzen ist bestens gesorgt 🌿';

  @override
  String get homeOverdue => 'ÜBERFÄLLIG';

  @override
  String get homeInstructions => 'Anweisungen';

  @override
  String homeRequiredAmount(String amount) {
    return 'Erforderlich: $amount';
  }

  @override
  String get homeLater => 'Später';

  @override
  String get homeMarkDone => 'Als erledigt markieren';

  @override
  String get homeSickPlants => 'Pflanzenklinik';

  @override
  String homeSickCount(int count) {
    return '$count Krank';
  }

  @override
  String get homeGreetingMorning => 'Guten Morgen';

  @override
  String get homeGreetingAfternoon => 'Guten Tag';

  @override
  String get homeGreetingEvening => 'Guten Abend';

  @override
  String get homeTodayTasks => 'Heutige Aufgaben';

  @override
  String get homeTomorrowTasks => 'Die Aufgaben von morgen';

  @override
  String homeDateTasks(String date) {
    return '$date Aufgaben';
  }

  @override
  String get commonSkip => 'Überspringen';

  @override
  String get commonContinue => 'Weiter';

  @override
  String get commonClose => 'Schließen';

  @override
  String get commonDelete => 'Löschen';

  @override
  String get commonBack => 'Geh zurück';

  @override
  String get commonUnknown => 'Unbekannt';

  @override
  String get wizardSaveGarden => 'Speichern und zum Garten hinzufügen';

  @override
  String wizardPlantAdded(String name) {
    return '$name wurde zu Ihrem Garten hinzugefügt! 🌿';
  }

  @override
  String get wizardRoomTitle => 'Wo steht Ihre Anlage?';

  @override
  String get wizardRoomSubtitle =>
      'Kategorisieren Sie Ihre Anlage nach Raum, um sie einfacher verwalten zu können.';

  @override
  String get wizardLivingRoom => 'Wohnzimmer';

  @override
  String get wizardBedroom => 'Schlafzimmer';

  @override
  String get wizardKitchen => 'Küche';

  @override
  String get wizardOffice => 'Büro';

  @override
  String get wizardBathroom => 'Badezimmer';

  @override
  String get wizardBalcony => 'Balkon';

  @override
  String get wizardLightTitle => 'Wie ist das Licht an dieser Stelle?';

  @override
  String get wizardLightSubtitle =>
      'Licht ist einer der wichtigsten Faktoren für die Gesundheit Ihrer Pflanze.';

  @override
  String get wizardDirectSun => 'Direkte Sonne';

  @override
  String get wizardDirectSunDescription =>
      'Ungefiltertes Sonnenlicht direkt auf die Pflanze';

  @override
  String get wizardBrightIndirect => 'Hell Indirekt';

  @override
  String get wizardBrightIndirectDescription =>
      'In der Nähe eines Ost- oder Westfensters';

  @override
  String get wizardMediumLight => 'Mittleres Licht';

  @override
  String get wizardMediumLightDescription =>
      'Ein paar Meter von einem Fenster entfernt';

  @override
  String get wizardLowLight => 'Schwaches Licht';

  @override
  String get wizardLowLightDescription =>
      'Fernab von Fenstern oder künstlichem Licht';

  @override
  String get wizardDistanceTitle => 'Abstand zum Fenster';

  @override
  String get wizardDistanceSubtitle =>
      'Wählen Sie den ungefähren Abstand zum nächsten Fenster.';

  @override
  String get wizardMoreThanFiveMeters => 'Mehr als 5 m';

  @override
  String get wizardActiveHoursTitle => 'Aktive Lichtstunden';

  @override
  String get wizardActiveHoursSubtitle =>
      'Wie viele Stunden direktes oder helles Licht erhält dieser Spot?';

  @override
  String wizardHour(int count) {
    return '$count Stunde';
  }

  @override
  String wizardHours(int count) {
    return '$count Stunden';
  }

  @override
  String get wizardSixPlusHours => '6+ Stunden';

  @override
  String get wizardRepottedTitle =>
      'Wann wurde diese Pflanze zuletzt umgetopft?';

  @override
  String get wizardRepottedSubtitle =>
      'Frischer Boden ist entscheidend für eine glückliche Pflanze.';

  @override
  String get wizardRecently => 'Kürzlich (unter 3 Monaten)';

  @override
  String get wizardSixMonthsAgo => 'Vor 6 Monaten';

  @override
  String get wizardOneYearAgo => 'Vor 1 Jahr';

  @override
  String get wizardTwoYearsAgo => 'Vor 2+ Jahren';

  @override
  String get wizardDontKnow => 'Ich weiß es nicht';

  @override
  String get wizardPotTitle => 'Aus welchem Material besteht der Topf?';

  @override
  String get wizardPotSubtitle =>
      'Das Topfmaterial beeinflusst, wie schnell die Erde trocknet.';

  @override
  String get wizardPlasticPot => 'Kunststoff / Kindergarten';

  @override
  String get wizardTerracottaPot => 'Terrakotta';

  @override
  String get wizardCeramicPot => 'Keramik / Glasiert';

  @override
  String get wizardMetalPot => 'Metall';

  @override
  String get wizardWateredTitle =>
      'Wann haben Sie diese Pflanze das letzte Mal gegossen?';

  @override
  String get wizardWateredSubtitle =>
      'Dies hilft, den genauen nächsten Bewässerungszeitpunkt zu berechnen.';

  @override
  String get wizardToday => 'Heute';

  @override
  String get wizardYesterday => 'Gestern';

  @override
  String get wizardFewDaysAgo => 'Vor ein paar Tagen';

  @override
  String get wizardWeekAgo => 'Vor einer Woche';

  @override
  String get wizardMoreWeekAgo => 'Vor mehr als einer Woche';

  @override
  String get historyTitle => 'Suchverlauf';

  @override
  String get historyClearTitle => 'Verlauf löschen';

  @override
  String get historyClearMessage =>
      'Der gesamte Such- und Scanverlauf wird gelöscht. Bist du sicher?';

  @override
  String get historyClearTooltip => 'Verlauf löschen';

  @override
  String get historyEmptyTitle => 'Kein Suchverlauf';

  @override
  String get historyEmptySubtitle =>
      'Hier erscheinen mit der Kamera gescannte oder gesuchte Pflanzen.';

  @override
  String get historyNoDetails => 'Detaillierte Informationen liegen nicht vor.';

  @override
  String get historyRegularWater => 'Regelmäßiges Gießen';

  @override
  String get historyIndirectLight => 'Indirektes Licht';

  @override
  String get historyDescription => 'Beschreibung';

  @override
  String get historyWatering => 'Bewässerung';

  @override
  String get historyLight => 'Licht';

  @override
  String get historyRecently => 'Kürzlich';

  @override
  String historyMinutesAgo(int minutes) {
    return 'Vor $minutes Min';
  }

  @override
  String historyHoursAgo(int hours) {
    return '$hours vor Stunden';
  }

  @override
  String get historyYesterday => 'Gestern';

  @override
  String get historyPlantRecord => 'Pflanzensuchdatensatz';

  @override
  String get photoWholeSpecimen => 'Foto des Ganzen\nPflanze oder Pilz';

  @override
  String get photoWholeSpecimenSubtitle =>
      'Halten Sie die gesamte Probe zur besseren Identifizierung zentriert im Rahmen.';

  @override
  String get photoCorrect => 'Richtig';

  @override
  String get photoTooClose => 'Zu nah';

  @override
  String get photoInstructions => 'Anweisungen';

  @override
  String get photoOpenCamera => 'Ich verstehe, öffne die Kamera';

  @override
  String get scannerPlant => 'Pflanze';

  @override
  String get scannerMushroom => 'Pilz';

  @override
  String get scannerIdentifyingPlant => 'Pflanze identifizieren...';

  @override
  String get scannerIdentifyingMushroom => 'Pilze identifizieren...';

  @override
  String get scannerCapture => 'Machen Sie ein Foto und scannen Sie es';

  @override
  String get scannerFailed =>
      'Der Scanvorgang ist fehlgeschlagen. Bitte versuchen Sie es erneut.';

  @override
  String scannerError(String error) {
    return 'Es ist ein Fehler aufgetreten: $error';
  }

  @override
  String get scannerUnknownPlant => 'Unbekannte Pflanze';

  @override
  String get scannerUnknownMushroom => 'Unbekannter Pilz';

  @override
  String get scheduleTitle => 'Zeitplan';

  @override
  String get scheduleTodayTask => 'Heutige Aufgaben';

  @override
  String get scheduleNoTasks => 'Keine Aufgaben für heute!';

  @override
  String get scheduleInstructions => 'Anweisungen';

  @override
  String scheduleRequired(String amount) {
    return 'Erforderlich: $amount';
  }

  @override
  String get scheduleRemindLater => 'Später erinnern';

  @override
  String get scheduleDone => 'Fertig';

  @override
  String get scheduleCareFallback => 'Kümmere dich um deine Pflanze.';

  @override
  String get chatDoctorTitle => 'KI-Pflanzendoktor';

  @override
  String chatPatient(String name) {
    return 'Patient: $name';
  }

  @override
  String get chatAnalyzing => 'Analysieren...';

  @override
  String chatHint(String name) {
    return 'Fragen Sie nach $name...';
  }

  @override
  String chatWelcome(String name) {
    return 'Hallo! 🌿 Ich bin Ihr KI-Pflanzendoktor. Wie kann ich bei $name helfen?\n\nIch kann ein Foto diagnostizieren oder Ihre Pflegefragen beantworten.';
  }

  @override
  String chatContinueWelcome(String name) {
    return 'Hallo! Machen wir weiter mit $name. 🌱';
  }

  @override
  String get chatQuestionYellowing => 'Was verursacht die gelben Blätter?';

  @override
  String get chatQuestionTreatment => 'Wie kann ich diese Pflanze behandeln?';

  @override
  String get chatQuestionWatering =>
      'Sollte ich die Bewässerungshäufigkeit ändern?';

  @override
  String get chatQuestionFertilizer => 'Welchen Dünger soll ich verwenden?';

  @override
  String get chatPhotoSent => 'Foto gesendet';

  @override
  String get chatAnalyzePhoto => 'Analysieren Sie das Foto';

  @override
  String get chatDiagnosisUnknown =>
      'Die Diagnose konnte nicht ermittelt werden';

  @override
  String get chatNoTreatment => 'Keine Behandlungsempfehlung';

  @override
  String get chatRecoveryUnknown => 'Unbekannt';

  @override
  String get chatUnableIdentify => 'Unbekannte Pflanze';

  @override
  String chatError(String error) {
    return 'Leider ist ein Fehler aufgetreten: $error. Bitte versuchen Sie es erneut.';
  }

  @override
  String get chatCareTips => 'Pflegetipps';

  @override
  String get chatPlantLabel => 'Pflanze';

  @override
  String get chatDiagnosisLabel => 'Diagnose';

  @override
  String get chatTreatmentLabel => 'Behandlung';

  @override
  String get chatUrgencyLabel => 'Dringlichkeit';

  @override
  String get chatRecoveryLabel => 'Geschätzte Erholung';

  @override
  String get discoverMonsteraTitle => 'Das Geheimnis des Monstera-Wachstums';

  @override
  String get discoverIndoorPlants => 'Zimmerpflanzen';

  @override
  String get discoverSucculentWatering =>
      'Bewässerungsanleitung für Sukkulenten';

  @override
  String get discoverCacti => 'Kakteen und Sukkulenten';

  @override
  String get discoverHerbSoil => 'Beste Bodentypen für Kräuter';

  @override
  String get discoverHerbs => 'Kräuter';

  @override
  String get discoverPropagation =>
      'Propagation 101: Ein Handbuch für Anfänger';

  @override
  String get discoverPests => 'Häufige Schädlinge und wie man sie behandelt';

  @override
  String get discoverRepotting => 'Umtopfen: Wann und wie?';

  @override
  String discoverMinutesRead(int minutes) {
    return '$minutes Minuten Lesezeit';
  }

  @override
  String get skip => 'Überspringen';

  @override
  String get skipForNow => 'Überspringen Sie es vorerst';

  @override
  String get continueLabel => 'Weiter';

  @override
  String get getStarted => 'Legen Sie los';

  @override
  String get nextStep => 'Nächster Schritt';

  @override
  String get maybeLater => 'Vielleicht später';

  @override
  String get emailAddress => 'E-Mail-Adresse';

  @override
  String get password => 'Passwort';

  @override
  String get firstName => 'Vorname';

  @override
  String get lastName => 'Nachname';

  @override
  String get login => 'Anmelden';

  @override
  String get signUp => 'Melden Sie sich an';

  @override
  String get welcomeBack => 'Willkommen zurück';

  @override
  String get loginSubtitle =>
      'Melden Sie sich an, um sich weiter um Ihren Garten zu kümmern.';

  @override
  String get signUpSubtitle =>
      'Machen Sie mit und beginnen Sie mit dem Bau Ihres grünen Zufluchtsortes.';

  @override
  String get forgotPassword => 'Passwort vergessen?';

  @override
  String get enterEmailPassword =>
      'Bitte geben Sie Ihre E-Mail-Adresse und Ihr Passwort ein.';

  @override
  String get fillAllFields => 'Bitte füllen Sie alle Felder aus.';

  @override
  String authError(String error) {
    return 'Etwas ist schief gelaufen: $error';
  }

  @override
  String get loginWith => 'Oder loggen Sie sich mit ein';

  @override
  String get signUpWith => 'Oder melden Sie sich an';

  @override
  String get noAccount => 'Sie haben noch kein Konto?';

  @override
  String get alreadyAccount => 'Sie haben bereits ein Konto?';

  @override
  String get developerSession => 'Erstellen Sie eine Entwicklersitzung';

  @override
  String get welcomeBotaniq => 'Willkommen bei Botaniq';

  @override
  String get loginOptionsSubtitle =>
      'Melden Sie sich an oder registrieren Sie sich, um Ihre Anlagen, Zeitpläne und Präferenzen zu sichern.';

  @override
  String get notificationAccessTitle => 'Verpassen Sie keine Bewässerung';

  @override
  String get notificationAccessSubtitle =>
      'Wir erinnern Sie sanft daran, wann es Zeit ist, sich um Ihre grünen Freunde zu kümmern. Pflanzenpflege mühelos und stressfrei.';

  @override
  String get notificationTurnOn => 'Aktivieren Sie Erinnerungen';

  @override
  String get creatingClimate => 'Analyse Ihres Mikroklimas...';

  @override
  String get creatingSchedules => 'Pflegepläne individuell anpassen...';

  @override
  String get creatingSanctuary => 'Bereiten Sie Ihr grünes Refugium vor ...';

  @override
  String get locationAccessTitle => 'Standortzugriff';

  @override
  String get locationAccessSubtitle =>
      'Personalisieren Sie die Pflanzenpflege basierend auf Ihrem lokalen Mikroklima.';

  @override
  String get locationRecommendation => 'Lokale Empfehlungen';

  @override
  String get locationRecommendationSubtitle =>
      'Pflanzen, die im Klima Ihrer Region gedeihen';

  @override
  String get locationWeather => 'Intelligente Wettersynchronisierung';

  @override
  String get locationWeatherSubtitle =>
      'Die Zeitpläne passen sich dem lokalen Regen in Echtzeit an';

  @override
  String get locationAlerts => 'Frost- und Hitzewarnungen';

  @override
  String get locationAlertsSubtitle =>
      'Lassen Sie sich benachrichtigen, bevor extremes Wetter eintritt';

  @override
  String get locationEnable => 'Aktivieren Sie den Standortzugriff';

  @override
  String get wherePlantsTitle => 'Wo sind deine Pflanzen?';

  @override
  String get wherePlantsSubtitle =>
      'Wählen Sie alles aus, was zutrifft, um Ihre Pflegepläne anzupassen.';

  @override
  String get locationIndoor => 'Drinnen';

  @override
  String get locationIndoorSubtitle => 'Wohnzimmer, Schlafzimmer, Büro';

  @override
  String get locationBalcony => 'Balkon';

  @override
  String get locationBalconySubtitle =>
      'Topfpflanzen auf einer Veranda oder Terrasse';

  @override
  String get locationGarden => 'Garten';

  @override
  String get locationGardenSubtitle => 'Bodeneinpflanzungen und Blumenbeete';

  @override
  String get helpTitleBefore => 'Was können wir';

  @override
  String get helpTitleHighlight => 'Dir helfen';

  @override
  String get helpTitleAfter => 'mit?';

  @override
  String get helpSubtitle =>
      'Wählen Sie ein oder mehrere Ziele aus, um Ihren Garten zu personalisieren.';

  @override
  String get helpHeal => 'Kranke heilen\nPflanzen';

  @override
  String get helpCare => 'Pflege\nErinnerungen';

  @override
  String get helpIdentify => 'Identifizieren\nArten';

  @override
  String get helpJournal => 'Wachstum\nTagebuch';

  @override
  String get helpOther => 'Etwas anderes';

  @override
  String get journeyTitle => 'Ihre grüne Reise';

  @override
  String get journeySubtitle =>
      'Wählen Sie den Pflegegrad aus, den Sie anbieten möchten.';

  @override
  String get journeyCasualLabel => 'LÄSSIG';

  @override
  String get journeyCasualTitle => 'Geringer Wartungsaufwand';

  @override
  String get journeyCasualSubtitle =>
      'Ich möchte nur, dass meine einfachen Pflanzen am Leben und gedeihen.';

  @override
  String get journeyEnthusiastLabel => 'ENTHUSIASTEN';

  @override
  String get journeyEnthusiastTitle => 'Ausgewogene Pflege';

  @override
  String get journeyEnthusiastSubtitle =>
      'Ich genieße es, wöchentlich etwas Zeit mit meiner wachsenden Sammlung zu verbringen.';

  @override
  String get journeyObsessedLabel => 'BESESSEN';

  @override
  String get journeyObsessedTitle => 'Pflanzeneltern der Extraklasse';

  @override
  String get journeyObsessedSubtitle =>
      'Ich lebe für meine Pflanzen und möchte professionelle Zeitpläne für meinen Indoor-Dschungel.';

  @override
  String get masteryTitleBefore => 'Wie geht es dir?';

  @override
  String get masteryTitleHighlight => 'grün\nDaumen';

  @override
  String get masteryTitleAfter => 'in letzter Zeit?';

  @override
  String get masterySubtitle =>
      'Seien Sie ehrlich – wir alle waren schon einmal „Serienmörder“. Wählen Sie Ihre aktuelle Meisterschaft aus.';

  @override
  String get masteryKiller => 'Der Serienmörder';

  @override
  String get masteryKillerSubtitle =>
      'Sogar meine Plastikpflanzen sehen besorgt aus, als ich den Raum betrete.';

  @override
  String get masteryAccidental => 'Zufälliger Elternteil';

  @override
  String get masteryAccidentalSubtitle =>
      'Mein Kaktus hat zwei Wochen überlebt. Wir lernen uns immer noch kennen.';

  @override
  String get masteryGrowth => 'Wachstumsmentalität';

  @override
  String get masteryGrowthSubtitle =>
      'Die meisten meiner Freunde haben Blätter. Ich kenne meine Monsteras von meinen Pothos.';

  @override
  String get masteryWhisperer => 'Pflanzenflüsterer';

  @override
  String get masteryWhispererSubtitle =>
      'Ich vermehre seltene Pflanzen und spreche fließend botanisches Latein.';

  @override
  String get onboardingOneTitle => 'Passen Sie auf sich auf\nIhrer Pflanzen';

  @override
  String get onboardingOneHighlight => 'Wie ein Profi';

  @override
  String get onboardingOneSubtitle =>
      'Intelligente Zeitpläne und sofortige Identifizierung für Ihren Großstadtdschungel.';

  @override
  String get onboardingOneBadge => 'KI-gestützte Pflege';

  @override
  String get onboardingAiScan => 'KI-Scan';

  @override
  String get onboardingSmartWater => 'Intelligentes Wasser';

  @override
  String get onboardingLightTracking => 'Lichtverfolgung';

  @override
  String get onboardingTwoTitle => 'Identifizieren Sie alle\nEinpflanzen';

  @override
  String get onboardingTwoHighlight => 'Sekunden';

  @override
  String get onboardingTwoSubtitle =>
      'Machen Sie ein Foto, um den Namen, die Art und die Pflegeanforderungen zu erfahren.';

  @override
  String get onboardingTwoBadge => 'BOTANISCHER EXPERTE';

  @override
  String get onboardingSnapPhoto => 'Schnappfoto';

  @override
  String get onboardingAccurateResult => 'Genaues Ergebnis';

  @override
  String get onboardingPlantWiki => 'Pflanzen-Wiki';

  @override
  String get onboardingThreeTitle => 'Niemals vergessen\nZum Gießen';

  @override
  String get onboardingThreeHighlight => 'Schon wieder';

  @override
  String get onboardingThreeSubtitle =>
      'Erhalten Sie Erinnerungen, die auf die Bedürfnisse und die Umgebung Ihrer Anlage abgestimmt sind.';

  @override
  String get onboardingThreeBadge => 'Intelligente Zeitpläne';

  @override
  String get onboardingReminders => 'Erinnerungen';

  @override
  String get onboardingClimateData => 'Klimadaten';

  @override
  String get onboardingHealthyGrowth => 'Gesundes Wachstum';

  @override
  String get onboardingCommunity =>
      'Schließen Sie sich über 50.000 Pflanzeneltern an';

  @override
  String get onboardingAgreement =>
      'INDEM SIE FORTFAHREN, STIMMEN SIE UNSEREN GESCHÄFTSBEDINGUNGEN UND DATENSCHUTZRICHTLINIEN ZU';

  @override
  String get termsTitle => 'Allgemeine Geschäftsbedingungen und Richtlinien';

  @override
  String get termsUpdated => 'Letzte Aktualisierung: Juli 2026';

  @override
  String get termsUseTitle => '1. Nutzungsbedingungen';

  @override
  String get termsUseBody =>
      'Durch den Zugriff auf oder die Nutzung von Botaniq stimmen Sie diesen Nutzungsbedingungen und den geltenden Gesetzen zu. Wenn Sie nicht einverstanden sind, dürfen Sie den Dienst nicht nutzen.';

  @override
  String get termsPrivacyTitle => '2. Privatsphäre des Benutzers';

  @override
  String get termsPrivacyBody =>
      'Wir erfassen nur die personenbezogenen Daten, die für die Bereitstellung maßgeschneiderter Pflanzenpflegepläne erforderlich sind. Wir verkaufen Ihre personenbezogenen Daten nicht an Dritte.';

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
  String get termsPlantTitle => '3. Pflanzendaten';

  @override
  String get termsPlantBody =>
      'Informationen zur Pflanzenpflege, Identifizierung und Diagnose werden zu Informationszwecken bereitgestellt. KI-Ergebnisse sind möglicherweise nicht immer korrekt. Beobachten Sie daher Ihre Anlage und suchen Sie bei schwerwiegenden Risiken einen Experten auf.';

  @override
  String get termsLiabilityTitle => '6. Disclaimers, Liability, and Indemnity';

  @override
  String get termsLiabilityBody =>
      'Botaniq is provided \"as is\" and \"as available,\" without warranties of any kind, express or implied, including accuracy, reliability, or fitness for a particular purpose. To the fullest extent permitted by law, we and our service providers are not liable for any indirect, incidental, special, or consequential damages, or for any loss of data, plants, or property arising from your use of the service, and our total liability for any claim is limited to the amount you paid us, if any, in the twelve months before the claim. You agree to indemnify and hold us harmless from claims arising from your use of the service, your content, or your violation of these Terms or applicable law.';

  @override
  String get termsPremiumTitle => '4. Premium-Abonnements';

  @override
  String get termsPremiumBody =>
      'Ihr monatliches oder jährliches Premium-Abonnement wird nach der Kaufbestätigung Ihrem Apple- oder Google-Konto belastet. Es verlängert sich automatisch, sofern es nicht mindestens 24 Stunden vor Ablauf des aktuellen Zeitraums gekündigt wird. Sie können es in den Einstellungen Ihres Shop-Kontos verwalten oder kündigen. Rückerstattungsanfragen werden gemäß den geltenden Shop-Richtlinien bearbeitet.';

  @override
  String get termsLawTitle => '8. Governing Law and Changes';

  @override
  String get termsLawBody =>
      'These Terms are governed by the laws of the jurisdiction in which we operate, without regard to conflict-of-law principles, and any dispute will be resolved under that jurisdiction\'s applicable procedures to the fullest extent permitted by law. We may update these Terms and our data practices at any time by posting the revised version in the app.';

  @override
  String get termsClosing =>
      'Genießen Sie Seelenfrieden und glücklichere Pflanzen.';

  @override
  String get weatherTitle => 'Wetter';

  @override
  String get weatherSunnyTip =>
      'Heute sonnig – prüfen Sie den Boden vor dem Gießen.';

  @override
  String get weatherCloudyTip =>
      'Bewölktes Wetter verlangsamt die Verdunstung; etwas weniger gießen.';

  @override
  String get weatherRainyTip =>
      'Regnerisch und feucht – vermeiden Sie eine Überwässerung der Pflanzen im Freien.';

  @override
  String get weatherStormTip =>
      'Bei stürmischem Wetter stellen Sie empfindliche Töpfe an einen geschützten Ort.';

  @override
  String get weatherSnowTip =>
      'Kälte und Schnee – schützen Sie die Pflanzen vor Temperaturschocks.';
}
