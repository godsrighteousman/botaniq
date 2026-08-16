// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Dutch Flemish (`nl`).
class AppLocalizationsNl extends AppLocalizations {
  AppLocalizationsNl([String locale = 'nl']) : super(locale);

  @override
  String get appTitle => 'Botaniq';

  @override
  String get settings => 'Instellingen';

  @override
  String get preferences => 'Voorkeuren';

  @override
  String get darkMode => 'Donkere modus';

  @override
  String get metricSystem => 'Metrisch systeem';

  @override
  String get metricSystemSubtitle => 'Gebruik Celsius en Meters';

  @override
  String get account => 'Rekening';

  @override
  String get editProfile => 'Profiel bewerken';

  @override
  String get changePassword => 'Wachtwoord wijzigen';

  @override
  String get subscriptionManagement => 'Abonnementenbeheer';

  @override
  String get premium => 'Premie';

  @override
  String get language => 'Taal';

  @override
  String get languageSubtitle => 'Wijzig de app-taal';

  @override
  String get selectLanguage => 'Selecteer Taal';

  @override
  String get systemLanguage => 'Systeemtaal';

  @override
  String get english => 'Engels';

  @override
  String get turkish => 'Turkçe';

  @override
  String get languageChanged => 'Taal is succesvol gewijzigd.';

  @override
  String get languageSearchHint => 'Zoek talen';

  @override
  String get languageRecommended => 'Aanbevolen';

  @override
  String get languageWelcomeTitle => 'Kies uw taal';

  @override
  String get languageWelcomeSubtitle =>
      'Selecteer de taal die u in Botaniq wilt gebruiken. Je kunt het op elk moment wijzigen.';

  @override
  String get languageUseSystem => 'Gebruik apparaattaal';

  @override
  String get preferenceSystem => 'Gebruik systeeminstellingen';

  @override
  String get themeLight => 'Licht';

  @override
  String get themeDark => 'Donker';

  @override
  String get themeSelectionTitle => 'Kies uiterlijk';

  @override
  String get measurementMetric => 'Metrisch';

  @override
  String get measurementImperial => 'Imperiaal';

  @override
  String get measurementSelectionTitle => 'Kies meetsysteem';

  @override
  String get settingsSubtitle =>
      'Vorm Botaniq rond jouw eigen verzorgingsritme.';

  @override
  String get settingsLocalPreference => 'Opgeslagen op dit apparaat';

  @override
  String get settingsDarkModeSubtitle =>
      'Een rustiger palet voor momenten met weinig licht';

  @override
  String get settingsAccountSubtitle => 'Identiteit, toegang en lidmaatschap';

  @override
  String get settingsEditProfileSubtitle => 'Naam, locatie en zorgvoorkeuren';

  @override
  String get settingsPasswordSubtitle =>
      'Stuur een beveiligde resetlink naar uw e-mailadres';

  @override
  String get settingsSubscriptionSubtitle =>
      'Premium abonnement en factuurgegevens';

  @override
  String get settingsPasswordResetSent =>
      'E-mail voor wachtwoordherstel verzonden.';

  @override
  String get settingsComingSoon => 'Deze ruimte groeit nog steeds.';

  @override
  String get subscriptionPageTitle => 'Premium-lidmaatschap';

  @override
  String get subscriptionHeroEyebrow => 'BOTANIQ PREMIUM';

  @override
  String get subscriptionHeroTitle => 'Slimmere verzorging voor elke plant';

  @override
  String get subscriptionHeroSubtitle =>
      'Ontgrendel elk premium onderhoudshulpmiddel en laat uw groene ruimte met vertrouwen groeien.';

  @override
  String get subscriptionBenefitsTitle => 'Alles in Premium';

  @override
  String get subscriptionBenefitIdentification =>
      'Onbeperkte plantenidentificatie en gezondheidsanalyse';

  @override
  String get subscriptionBenefitCare =>
      'Gepersonaliseerde zorgplannen en herinneringen';

  @override
  String get subscriptionBenefitInsights =>
      'Deskundige inhoud en geavanceerde zorginzichten';

  @override
  String get subscriptionMonthlyPlan => 'Maandelijks';

  @override
  String get subscriptionAnnualPlan => 'Jaarlijks';

  @override
  String subscriptionPerMonth(String price) {
    return '$price / maand';
  }

  @override
  String subscriptionPerYear(String price) {
    return '$price / jaar';
  }

  @override
  String get subscriptionBestValue => 'BESTE WAARDE';

  @override
  String subscriptionSavePercent(int percent) {
    return 'Bespaar $percent%';
  }

  @override
  String get subscriptionContinue => 'Ontgrendel Premium';

  @override
  String get subscriptionRestorePurchases => 'Aankopen herstellen';

  @override
  String get subscriptionRestoring => 'Herstellen...';

  @override
  String get subscriptionManage => 'Beheer abonnement';

  @override
  String get subscriptionActiveTitle => 'Je Premium-lidmaatschap is actief';

  @override
  String get subscriptionActiveSubtitle =>
      'Je hebt toegang tot elke premiumfunctie.';

  @override
  String subscriptionRenewsOn(String date) {
    return 'Wordt verlengd op $date';
  }

  @override
  String subscriptionExpiresOn(String date) {
    return 'Actief tot $date';
  }

  @override
  String get subscriptionAutoRenewDisclosure =>
      'De betaling wordt in rekening gebracht op uw Apple- of Google-account. Het abonnement wordt automatisch verlengd, tenzij het minimaal 24 uur voor het einde van de lopende periode wordt opgezegd. Je kunt het op elk gewenst moment beheren of annuleren in de instellingen van je winkelaccount.';

  @override
  String get subscriptionTermsLink => 'Gebruiksvoorwaarden';

  @override
  String get subscriptionPrivacyLink => 'Privacybeleid';

  @override
  String get subscriptionPurchaseSuccess =>
      'Je Premium-lidmaatschap is nu actief.';

  @override
  String get subscriptionRestoreSuccess =>
      'Je Premium-lidmaatschap is hersteld.';

  @override
  String get subscriptionNothingToRestore =>
      'Er is geen actief lidmaatschap gevonden voor dit winkelaccount.';

  @override
  String get subscriptionPaymentPending =>
      'De betaling wacht op goedkeuring door de winkel. Uw lidmaatschap wordt automatisch geactiveerd zodra het is goedgekeurd.';

  @override
  String get subscriptionErrorGeneric =>
      'De operatie kon niet worden voltooid. Probeer het opnieuw.';

  @override
  String get subscriptionErrorNetwork =>
      'Controleer uw internetverbinding en probeer het opnieuw.';

  @override
  String get subscriptionErrorNotAllowed =>
      'Met dit apparaat of winkelaccount mogen geen aankopen worden gedaan.';

  @override
  String get subscriptionErrorStore =>
      'De winkel was niet bereikbaar. Probeer het binnenkort opnieuw.';

  @override
  String get subscriptionMissingConfiguration =>
      'De RevenueCat-sleutel ontbreekt in deze build.';

  @override
  String get subscriptionUnsupported =>
      'Abonnementen zijn alleen beschikbaar in de iOS- en Android-apps.';

  @override
  String get subscriptionProductsUnavailable =>
      'Maand- en jaarproducten konden niet worden geladen. Controleer de RevenueCat-aanbodconfiguratie.';

  @override
  String get subscriptionRetry => 'Probeer het opnieuw';

  @override
  String get subscriptionFree => 'Gratis';

  @override
  String get homeGoodMorning => 'Hallo,';

  @override
  String homePersonalGreeting(String greeting, String name) {
    return '$greeting, $name 👋';
  }

  @override
  String get homeEmptyGarden => 'Je tuin is leeg';

  @override
  String get homeEmptyGardenSubtitle =>
      'Begin met het bouwen van uw groene toevluchtsoord\ndoor je eerste plant toe te voegen.';

  @override
  String get homeAddFirstPlant => 'Voeg de eerste plant toe';

  @override
  String get homeMyPlants => 'Mijn planten';

  @override
  String get homeViewAll => 'Bekijk alles';

  @override
  String get homeSmartCareReminders => 'Slimme zorgherinneringen';

  @override
  String get homeWatering => 'Water geven';

  @override
  String get homeWateringSubtitle => 'Bodem volgen';

  @override
  String get homeFertilizing => 'Bemesten';

  @override
  String get homeFertilizingSubtitle => 'Voedingswaarschuwingen';

  @override
  String get gardenTitle => 'Mijn tuin';

  @override
  String get gardenAllPlants => 'Alle planten';

  @override
  String get gardenNeedsWater => 'Heeft water nodig';

  @override
  String get gardenIndoor => 'Binnen';

  @override
  String get gardenNoPlants =>
      'Nog geen planten.\nTik op + om je eerste plant toe te voegen!';

  @override
  String get gardenNoPlantsCategory => 'Geen planten in deze categorie.';

  @override
  String get discoverTitle => 'Ontdek';

  @override
  String get discoverSearchHint => 'Zoek planten, artikelen, gidsen...';

  @override
  String get discoverLatestArticles => 'Laatste artikelen';

  @override
  String get discoverSeeAll => 'Bekijk alles';

  @override
  String get discoverTrendingGuides => 'Trendgidsen';

  @override
  String get healthyTitle => 'Zorg Centrum';

  @override
  String get healthySubtitle =>
      'Raak de ziel van je planten aan, praat met ze.';

  @override
  String get healthyTabDoctor => 'Dokter';

  @override
  String get healthyTabHospital => 'Ziekenhuis';

  @override
  String get healthyTabDiscover => 'Ontdek';

  @override
  String get profileTitle => 'Mijn profiel';

  @override
  String get profileEditProfile => 'Profiel bewerken';

  @override
  String get profileOverview => 'Overzicht';

  @override
  String get profileSettingsTab => 'Instellingen';

  @override
  String get profileGardenerLevel => 'Niveau tuinman';

  @override
  String get profileTotalPlants => 'Totaal planten';

  @override
  String get profileCompletedTasks => 'Voltooide taken';

  @override
  String get profileWeeklyActivity => 'Wekelijkse zorgactiviteit';

  @override
  String get profileGeneral => 'Algemeen';

  @override
  String get profileAppSettings => 'App-instellingen';

  @override
  String get profileNotificationPrefs => 'Meldingsvoorkeuren';

  @override
  String get profileSupportLegal => 'Ondersteuning en juridisch';

  @override
  String get profileHelpCenter => 'Helpcentrum';

  @override
  String get profileTerms => 'Gebruiksvoorwaarden en beleid';

  @override
  String get profileSignOut => 'Uitloggen';

  @override
  String get profileDeleteAccount => 'Account verwijderen';

  @override
  String get profileSubtitle =>
      'Jouw tuinverhaal, voortgang en persoonlijke ruimte.';

  @override
  String get profileGardenPassport => 'TUIN PASPOORT';

  @override
  String get profileThisWeek => 'Deze week';

  @override
  String get profileQuietWeek =>
      'Een rustige week — hier verschijnt uw volgende verzorgingsmoment.';

  @override
  String get profileActiveWeek => 'Jouw zorgritme leeft en groeit.';

  @override
  String get profileAppSettingsSubtitle => 'Taal, eenheden en AI-verbinding';

  @override
  String get profileNotificationPrefsSubtitle =>
      'Kies welke zorgmomenten jou bereiken';

  @override
  String get profileHelpCenterSubtitle => 'Antwoorden en snelle begeleiding';

  @override
  String get profileTermsSubtitle => 'Privacy, voorwaarden en beleid';

  @override
  String get profileAccountActions => 'Accountacties';

  @override
  String get profileSignOutQuestion => 'Weet u zeker dat u zich wilt afmelden?';

  @override
  String get profileDeleteAccountWarning =>
      'Voor het verwijderen van een account is een veilige bevestiging aan de serverzijde vereist. Uw gegevens zijn niet gewijzigd.';

  @override
  String get cancel => 'Annuleer';

  @override
  String get continueAction => 'Ga door';

  @override
  String get profileTitleNew => 'Nieuwe Tuinman 🌱';

  @override
  String get profileTitleSprout => 'Spruit Vriend 🌿';

  @override
  String get profileTitleLeaf => 'Bladliefhebber ☘️';

  @override
  String get profileTitleSkilled => 'Vaardige hovenier 🏡';

  @override
  String get profileTitleMaster => 'Groene Duim Meester👑';

  @override
  String get profileNextLevelStart =>
      'Voeg je eerste plant toe en begin je tuinavontuur!';

  @override
  String profileNextLevelLeaf(int count) {
    return 'Er zijn nog maar $count planten over om Leaf Lover te worden.';
  }

  @override
  String profileNextLevelSkilled(int count) {
    return 'Er zijn nog maar $count planten over om een ervaren tuinman te worden.';
  }

  @override
  String profileNextLevelMaster(int count) {
    return 'Er zijn nog maar $count planten over om Groene Duimmeester te worden.';
  }

  @override
  String get profileNextLevelMax =>
      'Je staat op de top van je tuin, gefeliciteerd!';

  @override
  String get navHome => 'Thuis';

  @override
  String get navGarden => 'Tuin';

  @override
  String get navClinic => 'Kliniek';

  @override
  String get navProfile => 'Profiel';

  @override
  String get scanPlant => 'Scanfabriek';

  @override
  String get deletePlantTitle => 'Deze plant verwijderen?';

  @override
  String get deletePlantMessage =>
      'De fabriek, haar zorgtaken en kliniekgegevens worden definitief uit uw account verwijderd.';

  @override
  String get deletePlantAction => 'Installatie verwijderen';

  @override
  String get deletePlantNotFound =>
      'De plant kon niet worden gevonden of is al verwijderd.';

  @override
  String deletePlantError(String error) {
    return 'De plant kon niet worden verwijderd: $error';
  }

  @override
  String get profileChoosePhoto => 'Kies Profielfoto';

  @override
  String get profileFullName => 'Volledige naam';

  @override
  String get profileFullNameHint => 'Voer uw volledige naam in';

  @override
  String get profileNickname => 'Bijnaam';

  @override
  String get profileNicknameHint => 'Hoe moeten we je bellen?';

  @override
  String get profileAge => 'Leeftijd';

  @override
  String get profileAgeHint => '1–120';

  @override
  String get profileAgeValidation =>
      'Voer een leeftijd in tussen 1 en 120 jaar.';

  @override
  String profileLoadError(String error) {
    return 'Kan profiel niet laden: $error';
  }

  @override
  String get languageEnglish => 'Engels';

  @override
  String get languageTurkish => 'Turks';

  @override
  String get profileEmailReadOnly => 'E-mailadres (alleen-lezen)';

  @override
  String get profileEmailHint => 'Voer uw e-mailadres in';

  @override
  String get profileLocation => 'Locatie';

  @override
  String get profileLocationHint => 'Stad, land';

  @override
  String get profileSaveChanges => 'Wijzigingen opslaan';

  @override
  String get profileUpdated => 'Je profiel is bijgewerkt.';

  @override
  String profileSaveError(String error) {
    return 'Profiel kon niet worden opgeslagen: $error';
  }

  @override
  String get notificationWateringTitle => 'Herinneringen voor water geven';

  @override
  String get notificationWateringSubtitle =>
      'Ontvang een melding wanneer het tijd is om water te geven';

  @override
  String get notificationFertilizerTitle => 'Herinneringen aan meststoffen';

  @override
  String get notificationFertilizerSubtitle =>
      'Seizoensgebonden voedingswaarschuwingen voor uw planten';

  @override
  String get notificationTitle => 'Meldingen';

  @override
  String get notificationPlantCareAlerts =>
      'Waarschuwingen voor plantenverzorging';

  @override
  String get notificationOther => 'Andere meldingen';

  @override
  String get notificationWeatherTitle => 'Weerwaarschuwingen';

  @override
  String get notificationWeatherSubtitle => 'Waarschuwingen voor extreem weer';

  @override
  String get notificationArticlesTitle => 'Nieuwe artikelen';

  @override
  String get notificationArticlesSubtitle => 'Tips en trucs voor uw tuin';

  @override
  String get gardenMyPlantFallback => 'Mijn plant';

  @override
  String get gardenClinicBadge => 'In Kliniek';

  @override
  String get wateringNever => 'Laatst bewaterd: Nooit';

  @override
  String wateringLastDate(String date) {
    return 'Laatst bewaterd: $date';
  }

  @override
  String wateringInterval(int days) {
    return 'Elke $days dagen';
  }

  @override
  String get wateringNeverDue => 'Nog geen water gegeven • Geef vandaag water';

  @override
  String wateringOverdue(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days dagen te laat',
      one: '1 dag te laat',
      zero: 'Vandaag water geven',
    );
    return '$_temp0';
  }

  @override
  String get wateringDueToday => 'Water vandaag';

  @override
  String get wateringDueTomorrow => 'Morgen water';

  @override
  String wateringDueInDays(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'Over $days dagen water geven',
      one: 'Over 1 dag water geven',
      zero: 'Vandaag water geven',
    );
    return '$_temp0';
  }

  @override
  String get plantUnknown => 'Onbekende plant';

  @override
  String get plantSpeciesFallback => 'Plantensoorten';

  @override
  String get plantDifficultyMedium => 'Middelmatig';

  @override
  String get plantAbout => 'Over';

  @override
  String get plantLocationEnvironment => 'Locatie & Omgeving';

  @override
  String get plantCareProtocol => 'Zorgprotocol';

  @override
  String get plantCareHistory => 'Zorggeschiedenis van de afgelopen 10 dagen';

  @override
  String get plantHealthy => 'Gezond';

  @override
  String get plantInClinic => 'In Kliniek';

  @override
  String get plantDifficulty => 'Moeilijkheidsgraad';

  @override
  String get plantToxicity => 'Toxiciteit';

  @override
  String get plantEnvironment => 'Milieu';

  @override
  String get plantLightNeed => 'Lichte behoefte';

  @override
  String get plantToxicPets => 'Giftig voor huisdieren';

  @override
  String get plantNonToxic => 'Niet giftig';

  @override
  String get plantIndoor => 'Binnen';

  @override
  String get plantBrightIndirect => 'Helder indirect';

  @override
  String get plantInfoUnavailable =>
      'Geverifieerde informatie is nog niet beschikbaar.';

  @override
  String get plantIdealClimate => 'Ideaal klimaat';

  @override
  String get plantHumidity => 'Vochtigheid';

  @override
  String get plantTemperatureRange => 'Temperatuurbereik';

  @override
  String get plantWateringFrequency => 'Waterfrequentie';

  @override
  String plantWateringFrequencyValue(String interval) {
    return 'Water $interval.';
  }

  @override
  String get plantNextWatering => 'Volgende watergift';

  @override
  String get plantWateringProtocol => 'Bewateringsprotocol';

  @override
  String get plantSoilProtocol => 'Bodem';

  @override
  String get plantFeedingProtocol => 'Voedingsprotocol';

  @override
  String get plantPruningCleaning => 'Snoeien en schoonmaken';

  @override
  String get plantPruningFallback =>
      'Veeg de bladeren maandelijks af. Snoei dode of vergelende bladeren om de groei te stimuleren.';

  @override
  String get plantHistoryEmpty =>
      'Geen zorggeschiedenis gedurende de afgelopen 10 dagen.';

  @override
  String get plantWateringTask => 'Water geven';

  @override
  String get plantFertilizingTask => 'Bemesten';

  @override
  String get plantWateredAction => 'Bewaterd ✓';

  @override
  String get plantWaterNowAction => 'Geef nu water';

  @override
  String get plantFertilizedAction => 'Bevrucht ✓';

  @override
  String get plantFertilizeAction => 'Bemesten';

  @override
  String get plantAddGardenAction => 'Voeg toe aan Mijn tuin';

  @override
  String get plantWaterSuccess =>
      '💧Je hebt je plant water gegeven! Geweldig werk!';

  @override
  String get plantFertilizeSuccess =>
      '🌱Meststof toegevoegd! Je plant zegt bedankt!';

  @override
  String plantWaterError(String error) {
    return 'Watergift kon niet worden opgeslagen: $error';
  }

  @override
  String plantFertilizeError(String error) {
    return 'Bemesting kon niet worden opgeslagen: $error';
  }

  @override
  String get clinicQuickTools => 'Snelle hulpmiddelen';

  @override
  String get clinicDoctorHero => 'AI Plantdokter\nTot uw dienst';

  @override
  String get clinicStartConsultation => 'Overleg starten';

  @override
  String get clinicChoosePlant => 'Welke plant wil jij bespreken?';

  @override
  String get clinicChoosePlantSubtitle =>
      'Kies een plant uit je tuin of maak een nieuwe foto.';

  @override
  String get clinicNoGardenPlants =>
      'Er staan nog geen planten in uw tuin.\nBegin met het maken van een nieuwe foto.';

  @override
  String get clinicNewPhoto => 'Maak een nieuwe foto';

  @override
  String get clinicNewPhotoSubtitle =>
      'Fotografeer de zieke plant en stel een diagnose';

  @override
  String get clinicPestAnalysis => 'Analyse van ongedierte';

  @override
  String get clinicVisualDiagnosis => 'Visuele diagnose';

  @override
  String get clinicLightMeter => 'Lichtmeter';

  @override
  String get clinicSensorSimulation => 'Sensorsimulatie';

  @override
  String get clinicTitle => 'Plantenkliniek';

  @override
  String clinicSickCount(int count) {
    return '$count Ziek';
  }

  @override
  String get clinicAllHealthy => 'Al je planten zijn gezond! 🌿';

  @override
  String get clinicEmpty =>
      'Er zijn geen zieke planten in de kliniek.\nAls u zich zorgen maakt over een plant,\nvraag het op het tabblad Dokter.';

  @override
  String get clinicUnknown => 'Onbekend';

  @override
  String get clinicPendingDiagnosis => 'Wachten op diagnose';

  @override
  String get clinicNoTreatment => 'De behandeling is niet vastgesteld';

  @override
  String get clinicPrescription => 'Recept:';

  @override
  String get clinicRecovery => 'Herstel';

  @override
  String get clinicRecovered => 'Hersteld';

  @override
  String get clinicContinue => 'Ga door';

  @override
  String get clinicRecoveredSuccess => '🎉Je plant is weer gezond!';

  @override
  String get clinicUrgencyLow => 'Laag';

  @override
  String get clinicUrgencyMedium => 'Middelmatig';

  @override
  String get clinicUrgencyCritical => 'Kritisch';

  @override
  String get healthTrendingTips => 'Populaire gezondheidstips';

  @override
  String get healthHumidityArticleTitle =>
      'Wintervoorbereiding: de luchtvochtigheid in balans houden';

  @override
  String get healthHumidityArticleSubtitle =>
      'Zo bescherm je je planten tegen droge radiatorlucht tijdens koude maanden.';

  @override
  String get healthWeeklySpotlight => 'Patiënt en remedie van de week';

  @override
  String get healthAphidTitle => 'Bladluisbesmetting';

  @override
  String get healthAphidSubtitle =>
      'Vroegtijdige interventie en een natuurlijke Neemoliebehandeling.';

  @override
  String get healthDiscoverLoadError =>
      'Ontdek inhoud kan momenteel niet worden geladen. Trek naar beneden om het opnieuw te proberen.';

  @override
  String get healthDiscoverEmpty =>
      'Er is nog geen gepubliceerde ontdekkingsinhoud.';

  @override
  String get healthDiscoverRetry => 'Probeer het opnieuw';

  @override
  String get lightMeterTitle => 'Lichtmeter';

  @override
  String get lightMeterInstructionTitle => 'Om licht te meten';

  @override
  String get lightMeterInstruction =>
      'Richt de camera aan de voorkant van de telefoon naar\nde positie en lichtbron van de plant.';

  @override
  String get lightMeterCameraEstimate =>
      'Geschatte lux berekend op basis van cameragegevens';

  @override
  String get lightMeterStabilizing => 'Stabiliserende meting';

  @override
  String get lightMeterStabilizingRecommendation =>
      'Houd de telefoon een paar seconden stil terwijl plotselinge blootstellingsveranderingen worden gefilterd.';

  @override
  String get lightMeterUnavailable => 'Meting niet beschikbaar';

  @override
  String get lightMeterUnavailableRecommendation =>
      'Schakel cameratoestemming in en probeer dit scherm opnieuw.';

  @override
  String get lightLow => 'Weinig licht (schaduw)';

  @override
  String get lightMedium => 'Middelmatig licht (heldere kamer)';

  @override
  String get lightHigh => 'Veel licht (bij raam)';

  @override
  String get lightVeryHigh => 'Zeer veel licht (directe zon)';

  @override
  String get lightLowRecommendation =>
      'Geschikt voor Calathea, varens of slangenplanten.';

  @override
  String get lightMediumRecommendation =>
      'Ideaal voor Monstera, Ficus en Anthurium.';

  @override
  String get lightHighRecommendation =>
      'Geschikt voor zonminnende Aloë, cactussen en geraniums.';

  @override
  String get lightVeryHighRecommendation =>
      'Het beste voor buitenplanten en vetplanten.';

  @override
  String get homeLoadingPlants => 'Planten laden...';

  @override
  String get homeNotifications => 'Meldingen';

  @override
  String get homeWateringTime => 'Watertijd';

  @override
  String get homeWateringNotification => 'Je kamerplanten hebben water nodig.';

  @override
  String get homeWelcome => 'Welkom!';

  @override
  String get homeWelcomeNotification =>
      'Welkom bij Botaniq. Begin met het toevoegen van je eerste plant.';

  @override
  String get homeTenMinutesAgo => '10 minuten geleden';

  @override
  String get homeOneDayAgo => '1 dag geleden';

  @override
  String get homeQuickActions => 'Snelle acties';

  @override
  String get homeIdentifyCamera => 'Identificeer je met je camera';

  @override
  String get homeTomorrow => 'Morgen';

  @override
  String get homeNoTasks => 'Geen taken voor deze dag!';

  @override
  String get homeAllCared => 'Je planten worden allemaal verzorgd 🌿';

  @override
  String get homeOverdue => 'TE LAAT';

  @override
  String get homeInstructions => 'Instructies';

  @override
  String homeRequiredAmount(String amount) {
    return 'Vereist: $amount';
  }

  @override
  String get homeLater => 'Later';

  @override
  String get homeMarkDone => 'Markeer als gereed';

  @override
  String get homeSickPlants => 'Plantenkliniek';

  @override
  String homeSickCount(int count) {
    return '$count Ziek';
  }

  @override
  String get homeGreetingMorning => 'Goedemorgen';

  @override
  String get homeGreetingAfternoon => 'Goedemiddag';

  @override
  String get homeGreetingEvening => 'Goede avond';

  @override
  String get homeTodayTasks => 'De taken van vandaag';

  @override
  String get homeTomorrowTasks => 'De taken van morgen';

  @override
  String homeDateTasks(String date) {
    return '$date Taken';
  }

  @override
  String get commonSkip => 'Overslaan';

  @override
  String get commonContinue => 'Ga door';

  @override
  String get commonClose => 'Sluiten';

  @override
  String get commonDelete => 'Verwijderen';

  @override
  String get commonBack => 'Ga terug';

  @override
  String get commonUnknown => 'Onbekend';

  @override
  String get wizardSaveGarden => 'Opslaan en toevoegen aan tuin';

  @override
  String wizardPlantAdded(String name) {
    return '$name is aan je tuin toegevoegd! 🌿';
  }

  @override
  String get wizardRoomTitle => 'Waar is je plant?';

  @override
  String get wizardRoomSubtitle =>
      'Categoriseer uw plant per kamer om hem gemakkelijk te beheren.';

  @override
  String get wizardLivingRoom => 'Woonkamer';

  @override
  String get wizardBedroom => 'Slaapkamer';

  @override
  String get wizardKitchen => 'Keuken';

  @override
  String get wizardOffice => 'Kantoor';

  @override
  String get wizardBathroom => 'Badkamer';

  @override
  String get wizardBalcony => 'Balkon';

  @override
  String get wizardLightTitle => 'Hoe is het licht op deze plek?';

  @override
  String get wizardLightSubtitle =>
      'Licht is een van de belangrijkste factoren voor de gezondheid van uw plant.';

  @override
  String get wizardDirectSun => 'Directe zon';

  @override
  String get wizardDirectSunDescription =>
      'Ongefilterd zonlicht direct op de plant';

  @override
  String get wizardBrightIndirect => 'Helder indirect';

  @override
  String get wizardBrightIndirectDescription =>
      'Dicht bij een raam op het oosten of westen';

  @override
  String get wizardMediumLight => 'Middelmatig licht';

  @override
  String get wizardMediumLightDescription =>
      'Op een paar meter afstand van een raam';

  @override
  String get wizardLowLight => 'Weinig licht';

  @override
  String get wizardLowLightDescription => 'Ver van ramen of onder kunstlicht';

  @override
  String get wizardDistanceTitle => 'Afstand tot raam';

  @override
  String get wizardDistanceSubtitle =>
      'Selecteer de geschatte afstand tot het dichtstbijzijnde raam.';

  @override
  String get wizardMoreThanFiveMeters => 'Ruim 5 meter';

  @override
  String get wizardActiveHoursTitle => 'Actieve lichturen';

  @override
  String get wizardActiveHoursSubtitle =>
      'Hoeveel uur direct of fel licht krijgt deze spot?';

  @override
  String wizardHour(int count) {
    return '$count uur';
  }

  @override
  String wizardHours(int count) {
    return '$count uur';
  }

  @override
  String get wizardSixPlusHours => '6+ uur';

  @override
  String get wizardRepottedTitle =>
      'Wanneer is deze plant voor het laatst verpot?';

  @override
  String get wizardRepottedSubtitle =>
      'Verse grond is cruciaal voor een gelukkige plant.';

  @override
  String get wizardRecently => 'Recent (minder dan 3 maanden)';

  @override
  String get wizardSixMonthsAgo => '6 maanden geleden';

  @override
  String get wizardOneYearAgo => '1 jaar geleden';

  @override
  String get wizardTwoYearsAgo => '2+ jaar geleden';

  @override
  String get wizardDontKnow => 'Ik weet het niet';

  @override
  String get wizardPotTitle => 'Van welk materiaal is de pot?';

  @override
  String get wizardPotSubtitle =>
      'Potmateriaal heeft invloed op hoe snel de grond droogt.';

  @override
  String get wizardPlasticPot => 'Kunststof / Kinderkamer';

  @override
  String get wizardTerracottaPot => 'Terracotta';

  @override
  String get wizardCeramicPot => 'Keramiek / geglazuurd';

  @override
  String get wizardMetalPot => 'Metaal';

  @override
  String get wizardWateredTitle =>
      'Wanneer heb je deze plant voor het laatst water gegeven?';

  @override
  String get wizardWateredSubtitle =>
      'Dit helpt bij het berekenen van de exacte volgende bewateringstijd.';

  @override
  String get wizardToday => 'Vandaag';

  @override
  String get wizardYesterday => 'Gisteren';

  @override
  String get wizardFewDaysAgo => 'Een paar dagen geleden';

  @override
  String get wizardWeekAgo => 'Een week geleden';

  @override
  String get wizardMoreWeekAgo => 'Ruim een week geleden';

  @override
  String get historyTitle => 'Zoekgeschiedenis';

  @override
  String get historyClearTitle => 'Geschiedenis wissen';

  @override
  String get historyClearMessage =>
      'Alle zoek- en scangeschiedenis wordt verwijderd. Weet je het zeker?';

  @override
  String get historyClearTooltip => 'Geschiedenis wissen';

  @override
  String get historyEmptyTitle => 'Geen zoekgeschiedenis';

  @override
  String get historyEmptySubtitle =>
      'Planten die met de camera zijn gescand of gezocht, verschijnen hier.';

  @override
  String get historyNoDetails =>
      'Gedetailleerde informatie is niet beschikbaar.';

  @override
  String get historyRegularWater => 'Regelmatig water geven';

  @override
  String get historyIndirectLight => 'Indirect licht';

  @override
  String get historyDescription => 'Beschrijving';

  @override
  String get historyWatering => 'Water geven';

  @override
  String get historyLight => 'Licht';

  @override
  String get historyRecently => 'Onlangs';

  @override
  String historyMinutesAgo(int minutes) {
    return '$minutes min geleden';
  }

  @override
  String historyHoursAgo(int hours) {
    return '$hours uur geleden';
  }

  @override
  String get historyYesterday => 'Gisteren';

  @override
  String get historyPlantRecord => 'Zoekrecord fabriek';

  @override
  String get photoWholeSpecimen => 'Foto van het geheel\nplant of paddenstoel';

  @override
  String get photoWholeSpecimenSubtitle =>
      'Houd het hele exemplaar gecentreerd in het frame voor een betere identificatie.';

  @override
  String get photoCorrect => 'Juist';

  @override
  String get photoTooClose => 'Te dichtbij';

  @override
  String get photoInstructions => 'Instructies';

  @override
  String get photoOpenCamera => 'Ik begrijp het, open camera';

  @override
  String get scannerPlant => 'Plant';

  @override
  String get scannerMushroom => 'Paddestoel';

  @override
  String get scannerIdentifyingPlant => 'Plant identificeren...';

  @override
  String get scannerIdentifyingMushroom => 'Paddestoel identificeren...';

  @override
  String get scannerCapture => 'Foto maken en scannen';

  @override
  String get scannerFailed => 'Scannen is mislukt. Probeer het opnieuw.';

  @override
  String scannerError(String error) {
    return 'Er is een fout opgetreden: $error';
  }

  @override
  String get scannerUnknownPlant => 'Onbekende plant';

  @override
  String get scannerUnknownMushroom => 'Onbekende paddenstoel';

  @override
  String get scheduleTitle => 'Schema';

  @override
  String get scheduleTodayTask => 'De taken van vandaag';

  @override
  String get scheduleNoTasks => 'Geen taken voor vandaag!';

  @override
  String get scheduleInstructions => 'Instructies';

  @override
  String scheduleRequired(String amount) {
    return 'Vereist: $amount';
  }

  @override
  String get scheduleRemindLater => 'Herinner het later';

  @override
  String get scheduleDone => 'Klaar';

  @override
  String get scheduleCareFallback => 'Zorg goed voor je plant.';

  @override
  String get chatDoctorTitle => 'AI Plantdokter';

  @override
  String chatPatient(String name) {
    return 'Patiënt: $name';
  }

  @override
  String get chatAnalyzing => 'Analyseren...';

  @override
  String chatHint(String name) {
    return 'Vraag naar $name...';
  }

  @override
  String chatWelcome(String name) {
    return 'Hallo! 🌿Ik ben jouw AI Plant Doctor. Hoe kan ik helpen met $name?\n\nIk kan een foto diagnosticeren of uw zorgvragen beantwoorden.';
  }

  @override
  String chatContinueWelcome(String name) {
    return 'Hallo! Laten we doorgaan met $name. 🌱';
  }

  @override
  String get chatQuestionYellowing => 'Wat veroorzaakt de gele bladeren?';

  @override
  String get chatQuestionTreatment => 'Hoe kan ik deze plant behandelen?';

  @override
  String get chatQuestionWatering =>
      'Moet ik de bewateringsfrequentie wijzigen?';

  @override
  String get chatQuestionFertilizer => 'Welke meststof moet ik gebruiken?';

  @override
  String get chatPhotoSent => 'Foto verzonden';

  @override
  String get chatAnalyzePhoto => 'Analyseer de foto';

  @override
  String get chatDiagnosisUnknown => 'De diagnose kon niet worden vastgesteld';

  @override
  String get chatNoTreatment => 'Geen behandeladvies';

  @override
  String get chatRecoveryUnknown => 'Onbekend';

  @override
  String get chatUnableIdentify => 'Onbekende fabriek';

  @override
  String chatError(String error) {
    return 'Sorry, er is een fout opgetreden: $error. Probeer het opnieuw.';
  }

  @override
  String get chatCareTips => 'Verzorgingstips';

  @override
  String get chatPlantLabel => 'Plant';

  @override
  String get chatDiagnosisLabel => 'Diagnose';

  @override
  String get chatTreatmentLabel => 'Behandeling';

  @override
  String get chatUrgencyLabel => 'Urgentie';

  @override
  String get chatRecoveryLabel => 'Geschat herstel';

  @override
  String get discoverMonsteraTitle => 'Het geheim van Monstera-groei';

  @override
  String get discoverIndoorPlants => 'Kamerplanten';

  @override
  String get discoverSucculentWatering => 'Bewateringsgids voor vetplanten';

  @override
  String get discoverCacti => 'Cactussen & Vetplanten';

  @override
  String get discoverHerbSoil => 'Beste grondsoorten voor kruiden';

  @override
  String get discoverHerbs => 'Kruiden';

  @override
  String get discoverPropagation =>
      'Voortplanting 101: een beginnershandleiding';

  @override
  String get discoverPests =>
      'Veel voorkomende plagen en hoe u ze kunt behandelen';

  @override
  String get discoverRepotting => 'Verpotten: wanneer en hoe?';

  @override
  String discoverMinutesRead(int minutes) {
    return '$minutes min gelezen';
  }

  @override
  String get skip => 'Overslaan';

  @override
  String get skipForNow => 'Overslaan voor nu';

  @override
  String get continueLabel => 'Ga door';

  @override
  String get getStarted => 'Aan de slag';

  @override
  String get nextStep => 'Volgende stap';

  @override
  String get maybeLater => 'Misschien later';

  @override
  String get emailAddress => 'E-mailadres';

  @override
  String get password => 'Wachtwoord';

  @override
  String get firstName => 'Voornaam';

  @override
  String get lastName => 'Achternaam';

  @override
  String get login => 'Inloggen';

  @override
  String get signUp => 'Aanmelden';

  @override
  String get welcomeBack => 'Welkom terug';

  @override
  String get loginSubtitle =>
      'Log in om door te gaan met het onderhoud van uw tuin.';

  @override
  String get signUpSubtitle =>
      'Doe met ons mee en begin met het bouwen van uw groene toevluchtsoord.';

  @override
  String get forgotPassword => 'Wachtwoord vergeten?';

  @override
  String get enterEmailPassword => 'Voer uw e-mailadres en wachtwoord in.';

  @override
  String get fillAllFields => 'Vul alle velden in.';

  @override
  String authError(String error) {
    return 'Er is iets misgegaan: $error';
  }

  @override
  String get loginWith => 'Of log in met';

  @override
  String get signUpWith => 'Of meld je aan bij';

  @override
  String get noAccount => 'Heeft u geen account?';

  @override
  String get alreadyAccount => 'Heeft u al een account?';

  @override
  String get developerSession => 'Ontwikkelaarssessie maken';

  @override
  String get welcomeBotaniq => 'Welkom bij Botaniq';

  @override
  String get loginOptionsSubtitle =>
      'Log in of meld u aan om een back-up te maken van uw planten, schema\'s en voorkeuren.';

  @override
  String get notificationAccessTitle => 'Mis geen watergift';

  @override
  String get notificationAccessSubtitle =>
      'We herinneren je er zachtjes aan wanneer het tijd is om voor je groene vrienden te zorgen. Plantenverzorging moeiteloos en stressvrij.';

  @override
  String get notificationTurnOn => 'Schakel Herinneringen in';

  @override
  String get creatingClimate => 'Analyseer uw microklimaat...';

  @override
  String get creatingSchedules => 'Zorgschema\'s aanpassen...';

  @override
  String get creatingSanctuary => 'Uw groene toevluchtsoord voorbereiden...';

  @override
  String get locationAccessTitle => 'Toegang tot locatie';

  @override
  String get locationAccessSubtitle =>
      'Personaliseer de plantenverzorging op basis van uw plaatselijke microklimaat.';

  @override
  String get locationRecommendation => 'Lokale aanbevelingen';

  @override
  String get locationRecommendationSubtitle =>
      'Planten die gedijen in het klimaat van uw regio';

  @override
  String get locationWeather => 'Slimme weersynchronisatie';

  @override
  String get locationWeatherSubtitle =>
      'Schema\'s worden aangepast aan realtime lokale regen';

  @override
  String get locationAlerts => 'Vorst- en hittewaarschuwingen';

  @override
  String get locationAlertsSubtitle =>
      'Ontvang een melding voordat extreem weer toeslaat';

  @override
  String get locationEnable => 'Locatietoegang inschakelen';

  @override
  String get wherePlantsTitle => 'Waar zijn je planten?';

  @override
  String get wherePlantsSubtitle =>
      'Selecteer alles wat van toepassing is om uw zorgschema\'s aan te passen.';

  @override
  String get locationIndoor => 'Binnen';

  @override
  String get locationIndoorSubtitle => 'Woonkamer, slaapkamer, kantoor';

  @override
  String get locationBalcony => 'Balkon';

  @override
  String get locationBalconySubtitle => 'Potplanten op een vlonder of terras';

  @override
  String get locationGarden => 'Tuin';

  @override
  String get locationGardenSubtitle => 'Planten en bloembedden in de grond';

  @override
  String get helpTitleBefore => 'Wat kunnen wij';

  @override
  String get helpTitleHighlight => 'je helpen';

  @override
  String get helpTitleAfter => 'met?';

  @override
  String get helpSubtitle =>
      'Selecteer één of meerdere doelen om uw tuin te personaliseren.';

  @override
  String get helpHeal => 'Genees zieken\nplanten';

  @override
  String get helpCare => 'Zorg\nherinneringen';

  @override
  String get helpIdentify => 'Identificeer\nsoort';

  @override
  String get helpJournal => 'Groei\ndagboek';

  @override
  String get helpOther => 'Iets anders';

  @override
  String get journeyTitle => 'Jouw groene reis';

  @override
  String get journeySubtitle => 'Selecteer het zorgniveau dat u wilt bieden.';

  @override
  String get journeyCasualLabel => 'CASUAL';

  @override
  String get journeyCasualTitle => 'Weinig onderhoud';

  @override
  String get journeyCasualSubtitle =>
      'Ik wil gewoon mijn eenvoudige planten levend en bloeiend houden.';

  @override
  String get journeyEnthusiastLabel => 'ENTHOUSIASTE';

  @override
  String get journeyEnthusiastTitle => 'Evenwichtige zorg';

  @override
  String get journeyEnthusiastSubtitle =>
      'Ik geniet ervan om wekelijks tijd door te brengen met mijn groeiende collectie.';

  @override
  String get journeyObsessedLabel => 'GEOBSESSEERD';

  @override
  String get journeyObsessedTitle => 'Plantenouder Extraordinaire';

  @override
  String get journeyObsessedSubtitle =>
      'Ik leef voor mijn planten en wil deskundige schema\'s voor mijn binnenjungle.';

  @override
  String get masteryTitleBefore => 'Hoe gaat het met jou?';

  @override
  String get masteryTitleHighlight => 'groen\nduim';

  @override
  String get masteryTitleAfter => 'de laatste tijd?';

  @override
  String get masterySubtitle =>
      'Wees eerlijk: we zijn allemaal wel eens ‘de seriemoordenaar’ geweest. Selecteer uw huidige beheersing.';

  @override
  String get masteryKiller => 'De seriemoordenaar';

  @override
  String get masteryKillerSubtitle =>
      'Zelfs mijn plastic planten kijken bezorgd als ik de kamer binnenkom.';

  @override
  String get masteryAccidental => 'Toevallige ouder';

  @override
  String get masteryAccidentalSubtitle =>
      'Mijn cactus heeft twee weken overleefd. We leren elkaar nog steeds kennen.';

  @override
  String get masteryGrowth => 'Groeimindset';

  @override
  String get masteryGrowthSubtitle =>
      'De meeste van mijn vrienden hebben bladeren. Ik ken mijn Monstera\'s van mijn Pothos.';

  @override
  String get masteryWhisperer => 'Plantenfluisteraar';

  @override
  String get masteryWhispererSubtitle =>
      'Ik kweek zeldzame planten en spreek vloeiend botanisch Latijn.';

  @override
  String get onboardingOneTitle => 'Wees voorzichtig\nvan uw planten';

  @override
  String get onboardingOneHighlight => 'Als een professional';

  @override
  String get onboardingOneSubtitle =>
      'Slimme schema\'s en onmiddellijke identificatie voor uw stadsjungle.';

  @override
  String get onboardingOneBadge => 'AI-AANGEDREVEN ZORG';

  @override
  String get onboardingAiScan => 'AI-scan';

  @override
  String get onboardingSmartWater => 'Slim water';

  @override
  String get onboardingLightTracking => 'Licht volgen';

  @override
  String get onboardingTwoTitle => 'Identificeer elke\nPlant erin';

  @override
  String get onboardingTwoHighlight => 'Seconden';

  @override
  String get onboardingTwoSubtitle =>
      'Maak een foto om de naam, soort en verzorgingsvereisten te achterhalen.';

  @override
  String get onboardingTwoBadge => 'BOTANISCHE EXPERT';

  @override
  String get onboardingSnapPhoto => 'Maak een foto';

  @override
  String get onboardingAccurateResult => 'Nauwkeurig resultaat';

  @override
  String get onboardingPlantWiki => 'Plant-wiki';

  @override
  String get onboardingThreeTitle => 'Nooit vergeten\nNaar water';

  @override
  String get onboardingThreeHighlight => 'Nogmaals';

  @override
  String get onboardingThreeSubtitle =>
      'Ontvang herinneringen die zijn afgestemd op de behoeften en omgeving van uw fabriek.';

  @override
  String get onboardingThreeBadge => 'SLIMME SCHEMA’S';

  @override
  String get onboardingReminders => 'Herinneringen';

  @override
  String get onboardingClimateData => 'Klimaatgegevens';

  @override
  String get onboardingHealthyGrowth => 'Gezonde groei';

  @override
  String get onboardingCommunity =>
      'Sluit je aan bij meer dan 50.000 plantenouders';

  @override
  String get onboardingAgreement =>
      'DOOR DOOR TE GAAN, GAAT U AKKOORD MET ONZE VOORWAARDEN EN PRIVACYBELEID';

  @override
  String get termsTitle => 'Voorwaarden en beleid';

  @override
  String get termsUpdated => 'Laatst bijgewerkt: juli 2026';

  @override
  String get termsUseTitle => '1. Gebruiksvoorwaarden';

  @override
  String get termsUseBody =>
      'Door Botaniq te openen of te gebruiken, gaat u akkoord met deze Gebruiksvoorwaarden en de toepasselijke wetgeving. Als u het er niet mee eens bent, mag u de dienst niet gebruiken.';

  @override
  String get termsPrivacyTitle => '2. Gebruikersprivacy';

  @override
  String get termsPrivacyBody =>
      'We verzamelen alleen de persoonlijke gegevens die nodig zijn om op maat gemaakte plantverzorgingsschema\'s te bieden. Wij verkopen uw persoonlijke gegevens niet aan derden.';

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
  String get termsPlantTitle => '3. Installatiegegevens';

  @override
  String get termsPlantBody =>
      'Informatie over de verzorging, identificatie en diagnose van planten wordt ter informatie verstrekt. AI-resultaten zijn mogelijk niet altijd correct, dus observeer uw plant en zoek een expert op ernstige risico\'s.';

  @override
  String get termsLiabilityTitle => '6. Disclaimers, Liability, and Indemnity';

  @override
  String get termsLiabilityBody =>
      'Botaniq is provided \"as is\" and \"as available,\" without warranties of any kind, express or implied, including accuracy, reliability, or fitness for a particular purpose. To the fullest extent permitted by law, we and our service providers are not liable for any indirect, incidental, special, or consequential damages, or for any loss of data, plants, or property arising from your use of the service, and our total liability for any claim is limited to the amount you paid us, if any, in the twelve months before the claim. You agree to indemnify and hold us harmless from claims arising from your use of the service, your content, or your violation of these Terms or applicable law.';

  @override
  String get termsPremiumTitle => '4. Premium-abonnementen';

  @override
  String get termsPremiumBody =>
      'Uw maandelijkse of jaarlijkse Premium-abonnement wordt na aankoopbevestiging in rekening gebracht op uw Apple- of Google-account. Het wordt automatisch verlengd, tenzij het ten minste 24 uur vóór het einde van de huidige periode wordt geannuleerd. U kunt het beheren of annuleren in uw winkelaccountinstellingen. Terugbetalingsverzoeken worden afgehandeld volgens het toepasselijke winkelbeleid.';

  @override
  String get termsLawTitle => '8. Governing Law and Changes';

  @override
  String get termsLawBody =>
      'These Terms are governed by the laws of the jurisdiction in which we operate, without regard to conflict-of-law principles, and any dispute will be resolved under that jurisdiction\'s applicable procedures to the fullest extent permitted by law. We may update these Terms and our data practices at any time by posting the revised version in the app.';

  @override
  String get termsClosing => 'Geniet van gemoedsrust en gelukkigere planten.';

  @override
  String get weatherTitle => 'Weer';

  @override
  String get weatherSunnyTip =>
      'Zonnig vandaag: controleer de grond voordat u water geeft.';

  @override
  String get weatherCloudyTip =>
      'Bewolkt weer vertraagt de verdamping; iets minder water geven.';

  @override
  String get weatherRainyTip =>
      'Regenachtig en vochtig – vermijd het teveel water geven van buitenplanten.';

  @override
  String get weatherStormTip =>
      'Stormachtig weer: verplaats kwetsbare potten naar een beschutte plek.';

  @override
  String get weatherSnowTip =>
      'Koud en sneeuwachtig: bescherm planten tegen temperatuurschokken.';
}

/// The translations for Dutch Flemish, as used in Belgium (`nl_BE`).
class AppLocalizationsNlBe extends AppLocalizationsNl {
  AppLocalizationsNlBe() : super('nl_BE');
}

/// The translations for Dutch Flemish, as used in Netherlands (`nl_NL`).
class AppLocalizationsNlNl extends AppLocalizationsNl {
  AppLocalizationsNlNl() : super('nl_NL');
}
