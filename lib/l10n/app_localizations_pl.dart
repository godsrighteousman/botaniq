// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Polish (`pl`).
class AppLocalizationsPl extends AppLocalizations {
  AppLocalizationsPl([String locale = 'pl']) : super(locale);

  @override
  String get appTitle => 'Botaniq';

  @override
  String get settings => 'Ustawienia';

  @override
  String get preferences => 'Preferencje';

  @override
  String get darkMode => 'Tryb ciemny';

  @override
  String get metricSystem => 'System metryczny';

  @override
  String get metricSystemSubtitle => 'Użyj stopni Celsjusza i metrów';

  @override
  String get account => 'Konto';

  @override
  String get editProfile => 'Edytuj profil';

  @override
  String get changePassword => 'Zmień hasło';

  @override
  String get subscriptionManagement => 'Zarządzanie subskrypcjami';

  @override
  String get premium => 'Premium';

  @override
  String get language => 'Język';

  @override
  String get languageSubtitle => 'Zmień język aplikacji';

  @override
  String get selectLanguage => 'Wybierz Język';

  @override
  String get systemLanguage => 'Język systemu';

  @override
  String get english => 'Angielski';

  @override
  String get turkish => 'turecki';

  @override
  String get languageChanged => 'Język został pomyślnie zmieniony.';

  @override
  String get languageSearchHint => 'Wyszukaj języki';

  @override
  String get languageRecommended => 'Zalecane';

  @override
  String get languageWelcomeTitle => 'Wybierz swój język';

  @override
  String get languageWelcomeSubtitle =>
      'Wybierz język, którego chcesz używać w Botaniq. Możesz to zmienić w dowolnym momencie.';

  @override
  String get languageUseSystem => 'Użyj języka urządzenia';

  @override
  String get preferenceSystem => 'Użyj ustawień systemowych';

  @override
  String get themeLight => 'Światło';

  @override
  String get themeDark => 'Ciemny';

  @override
  String get themeSelectionTitle => 'Wybierz wygląd';

  @override
  String get measurementMetric => 'Metryczne';

  @override
  String get measurementImperial => 'Imperialny';

  @override
  String get measurementSelectionTitle => 'Wybierz system pomiarowy';

  @override
  String get settingsSubtitle =>
      'Kształtuj Botaniq według własnego rytmu pielęgnacji.';

  @override
  String get settingsLocalPreference => 'Zapisano na tym urządzeniu';

  @override
  String get settingsDarkModeSubtitle =>
      'Spokojniejsza paleta do chwil przy słabym oświetleniu';

  @override
  String get settingsAccountSubtitle => 'Tożsamość, dostęp i członkostwo';

  @override
  String get settingsEditProfileSubtitle =>
      'Imię i nazwisko, lokalizacja i preferencje dotyczące opieki';

  @override
  String get settingsPasswordSubtitle =>
      'Wyślij link do bezpiecznego resetowania na swój adres e-mail';

  @override
  String get settingsSubscriptionSubtitle =>
      'Plan premium i szczegóły rozliczeniowe';

  @override
  String get settingsPasswordResetSent =>
      'Wysłano wiadomość e-mail dotyczącą resetowania hasła.';

  @override
  String get settingsComingSoon => 'Ta przestrzeń wciąż się rozwija.';

  @override
  String get subscriptionPageTitle => 'Członkostwo premium';

  @override
  String get subscriptionHeroEyebrow => 'BOTANIQ PREMIUM';

  @override
  String get subscriptionHeroTitle => 'Mądrzejsza pielęgnacja każdej rośliny';

  @override
  String get subscriptionHeroSubtitle =>
      'Odblokuj każde narzędzie do pielęgnacji premium i bez obaw rozwijaj swoją zieloną przestrzeń.';

  @override
  String get subscriptionBenefitsTitle => 'Wszystko w Premium';

  @override
  String get subscriptionBenefitIdentification =>
      'Nieograniczona identyfikacja i analiza zdrowia roślin';

  @override
  String get subscriptionBenefitCare =>
      'Spersonalizowane plany opieki i przypomnienia';

  @override
  String get subscriptionBenefitInsights =>
      'Treści eksperckie i zaawansowane spostrzeżenia dotyczące opieki';

  @override
  String get subscriptionMonthlyPlan => 'Miesięcznie';

  @override
  String get subscriptionAnnualPlan => 'Roczne';

  @override
  String subscriptionPerMonth(String price) {
    return '$price / miesiąc';
  }

  @override
  String subscriptionPerYear(String price) {
    return '$price / rok';
  }

  @override
  String get subscriptionBestValue => 'NAJLEPSZA WARTOŚĆ';

  @override
  String subscriptionSavePercent(int percent) {
    return 'Zaoszczędź $percent%';
  }

  @override
  String get subscriptionContinue => 'Odblokuj Premium';

  @override
  String get subscriptionRestorePurchases => 'Przywróć zakupy';

  @override
  String get subscriptionRestoring => 'Przywracam...';

  @override
  String get subscriptionManage => 'Zarządzaj subskrypcją';

  @override
  String get subscriptionActiveTitle =>
      'Twoje członkostwo Premium jest aktywne';

  @override
  String get subscriptionActiveSubtitle =>
      'Masz dostęp do każdej funkcji premium.';

  @override
  String subscriptionRenewsOn(String date) {
    return 'Odnawia się w dniu $date';
  }

  @override
  String subscriptionExpiresOn(String date) {
    return 'Aktywny do $date';
  }

  @override
  String get subscriptionAutoRenewDisclosure =>
      'Płatność zostanie pobrana z Twojego konta Apple lub Google. Subskrypcja odnawia się automatycznie, chyba że zostanie anulowana co najmniej 24 godziny przed końcem bieżącego okresu. Możesz nim zarządzać lub anulować go w dowolnym momencie w ustawieniach swojego konta sklepowego.';

  @override
  String get subscriptionTermsLink => 'Warunki użytkowania';

  @override
  String get subscriptionPrivacyLink => 'Polityka prywatności';

  @override
  String get subscriptionPurchaseSuccess =>
      'Twoje członkostwo Premium jest teraz aktywne.';

  @override
  String get subscriptionRestoreSuccess =>
      'Twoje członkostwo Premium zostało przywrócone.';

  @override
  String get subscriptionNothingToRestore =>
      'Nie znaleziono aktywnego członkostwa dla tego konta sklepu.';

  @override
  String get subscriptionPaymentPending =>
      'Płatność oczekuje na zatwierdzenie przez sklep. Twoje członkostwo zostanie aktywowane automatycznie po zatwierdzeniu.';

  @override
  String get subscriptionErrorGeneric =>
      'Nie można ukończyć operacji. Spróbuj ponownie.';

  @override
  String get subscriptionErrorNetwork =>
      'Sprawdź swoje połączenie internetowe i spróbuj ponownie.';

  @override
  String get subscriptionErrorNotAllowed =>
      'Na tym urządzeniu lub koncie sklepu nie można dokonywać zakupów.';

  @override
  String get subscriptionErrorStore =>
      'Do sklepu nie można było dotrzeć. Spróbuj ponownie wkrótce.';

  @override
  String get subscriptionMissingConfiguration =>
      'W tej kompilacji brakuje klucza RevenueCat.';

  @override
  String get subscriptionUnsupported =>
      'Subskrypcje są dostępne tylko w aplikacjach na iOS i Androida.';

  @override
  String get subscriptionProductsUnavailable =>
      'Nie można załadować produktów miesięcznych i rocznych. Sprawdź konfigurację oferty RevenueCat.';

  @override
  String get subscriptionRetry => 'Spróbuj ponownie';

  @override
  String get subscriptionFree => 'Bezpłatny';

  @override
  String get homeGoodMorning => 'Witam,';

  @override
  String homePersonalGreeting(String greeting, String name) {
    return '$greeting, $name 👋';
  }

  @override
  String get homeEmptyGarden => 'Twój ogród jest pusty';

  @override
  String get homeEmptyGardenSubtitle =>
      'Zacznij budować swoje zielone sanktuarium\ndodając pierwszą roślinę.';

  @override
  String get homeAddFirstPlant => 'Dodaj pierwszą roślinę';

  @override
  String get homeMyPlants => 'Moje Rośliny';

  @override
  String get homeViewAll => 'Zobacz wszystko';

  @override
  String get homeSmartCareReminders =>
      'Inteligentne przypomnienia o pielęgnacji';

  @override
  String get homeWatering => 'Podlewanie';

  @override
  String get homeWateringSubtitle => 'Śledzenie gleby';

  @override
  String get homeFertilizing => 'Nawożenie';

  @override
  String get homeFertilizingSubtitle =>
      'Alerty dotyczące składników odżywczych';

  @override
  String get gardenTitle => 'Mój Ogród';

  @override
  String get gardenAllPlants => 'Wszystkie rośliny';

  @override
  String get gardenNeedsWater => 'Potrzebuje wody';

  @override
  String get gardenIndoor => 'Wewnątrz';

  @override
  String get gardenNoPlants =>
      'Nie ma jeszcze roślin.\nStuknij +, aby dodać swoją pierwszą roślinę!';

  @override
  String get gardenNoPlantsCategory => 'Brak roślin w tej kategorii.';

  @override
  String get discoverTitle => 'Odkryj';

  @override
  String get discoverSearchHint => 'Wyszukaj rośliny, artykuły, przewodniki...';

  @override
  String get discoverLatestArticles => 'Najnowsze artykuły';

  @override
  String get discoverSeeAll => 'Zobacz wszystko';

  @override
  String get discoverTrendingGuides => 'Przewodniki po trendach';

  @override
  String get healthyTitle => 'Centrum Opieki';

  @override
  String get healthySubtitle =>
      'Dotknij duszy swoich roślin, porozmawiaj z nimi.';

  @override
  String get healthyTabDoctor => 'Doktor';

  @override
  String get healthyTabHospital => 'Szpital';

  @override
  String get healthyTabDiscover => 'Odkryj';

  @override
  String get profileTitle => 'Mój profil';

  @override
  String get profileEditProfile => 'Edytuj profil';

  @override
  String get profileOverview => 'Przegląd';

  @override
  String get profileSettingsTab => 'Ustawienia';

  @override
  String get profileGardenerLevel => 'Poziom ogrodnika';

  @override
  String get profileTotalPlants => 'Razem rośliny';

  @override
  String get profileCompletedTasks => 'Ukończone zadania';

  @override
  String get profileWeeklyActivity => 'Cotygodniowe zajęcia opiekuńcze';

  @override
  String get profileGeneral => 'Generał';

  @override
  String get profileAppSettings => 'Ustawienia aplikacji';

  @override
  String get profileNotificationPrefs => 'Preferencje powiadomień';

  @override
  String get profileSupportLegal => 'Wsparcie i kwestie prawne';

  @override
  String get profileHelpCenter => 'Centrum pomocy';

  @override
  String get profileTerms => 'Warunki użytkowania i zasady';

  @override
  String get profileSignOut => 'Wyloguj się';

  @override
  String get profileDeleteAccount => 'Usuń konto';

  @override
  String get profileSubtitle =>
      'Twoja historia ogrodu, postęp i przestrzeń osobista.';

  @override
  String get profileGardenPassport => 'PASZPORT OGRODOWY';

  @override
  String get profileThisWeek => 'W tym tygodniu';

  @override
  String get profileQuietWeek =>
      'Spokojnego tygodnia — tutaj pojawi się Twój kolejny moment pielęgnacji.';

  @override
  String get profileActiveWeek => 'Twój rytm opieki jest żywy i rośnie.';

  @override
  String get profileAppSettingsSubtitle => 'Język, jednostki i połączenie AI';

  @override
  String get profileNotificationPrefsSubtitle =>
      'Wybierz, które chwile opieki dotrą do Ciebie';

  @override
  String get profileHelpCenterSubtitle => 'Odpowiedzi i szybkie wskazówki';

  @override
  String get profileTermsSubtitle => 'Prywatność, warunki i zasady';

  @override
  String get profileAccountActions => 'Działania na koncie';

  @override
  String get profileSignOutQuestion => 'Czy na pewno chcesz się wylogować?';

  @override
  String get profileDeleteAccountWarning =>
      'Usunięcie konta wymaga bezpiecznego potwierdzenia po stronie serwera. Twoje dane nie zostały zmienione.';

  @override
  String get cancel => 'Anuluj';

  @override
  String get continueAction => 'Kontynuuj';

  @override
  String get profileTitleNew => 'Nowy Ogrodnik 🌱';

  @override
  String get profileTitleSprout => 'Kiełkujący przyjaciel 🌿';

  @override
  String get profileTitleLeaf => 'Miłośnik liści ☘️';

  @override
  String get profileTitleSkilled => 'Uzdolniony ogrodnik 🏡';

  @override
  String get profileTitleMaster => 'Mistrz Zielonego Kciuka 👑';

  @override
  String get profileNextLevelStart =>
      'Dodaj swoją pierwszą roślinę i rozpocznij swoją ogrodniczą przygodę!';

  @override
  String profileNextLevelLeaf(int count) {
    return 'Zostało już tylko $count roślin, które staną się Miłośnikami Liści.';
  }

  @override
  String profileNextLevelSkilled(int count) {
    return 'Zostało tylko $count roślin, aby zostać Wykwalifikowanym Ogrodnikiem.';
  }

  @override
  String profileNextLevelMaster(int count) {
    return 'Zostało tylko $count roślin, aby zostać Mistrzem Zielonego Kciuka.';
  }

  @override
  String get profileNextLevelMax =>
      'Jesteś na szczycie swojego ogrodu, gratulacje!';

  @override
  String get navHome => 'Dom';

  @override
  String get navGarden => 'Ogród';

  @override
  String get navClinic => 'Klinika';

  @override
  String get navProfile => 'Profil';

  @override
  String get scanPlant => 'Skanuj fabrykę';

  @override
  String get deletePlantTitle => 'Usunąć tę roślinę?';

  @override
  String get deletePlantMessage =>
      'Roślina, jej zadania pielęgnacyjne i dokumentacja Kliniki zostaną trwale usunięte z Twojego konta.';

  @override
  String get deletePlantAction => 'Usuń roślinę';

  @override
  String get deletePlantNotFound =>
      'Nie udało się znaleźć rośliny lub została już usunięta.';

  @override
  String deletePlantError(String error) {
    return 'Nie można usunąć rośliny: $error';
  }

  @override
  String get profileChoosePhoto => 'Wybierz Zdjęcie profilowe';

  @override
  String get profileFullName => 'Pełne imię i nazwisko';

  @override
  String get profileFullNameHint => 'Wpisz swoje pełne imię i nazwisko';

  @override
  String get profileNickname => 'Pseudonim';

  @override
  String get profileNicknameHint => 'Jak mamy do ciebie dzwonić?';

  @override
  String get profileAge => 'Wiek';

  @override
  String get profileAgeHint => '1–120';

  @override
  String get profileAgeValidation => 'Podaj wiek od 1 do 120 lat.';

  @override
  String profileLoadError(String error) {
    return 'Nie można załadować profilu: $error';
  }

  @override
  String get languageEnglish => 'Angielski';

  @override
  String get languageTurkish => 'turecki';

  @override
  String get profileEmailReadOnly => 'Adres e-mail (tylko do odczytu)';

  @override
  String get profileEmailHint => 'Wpisz swój adres e-mail';

  @override
  String get profileLocation => 'Lokalizacja';

  @override
  String get profileLocationHint => 'Miasto, kraj';

  @override
  String get profileSaveChanges => 'Zapisz zmiany';

  @override
  String get profileUpdated => 'Twój profil został zaktualizowany.';

  @override
  String profileSaveError(String error) {
    return 'Nie można zapisać profilu: $error';
  }

  @override
  String get notificationWateringTitle => 'Przypomnienia o podlewaniu';

  @override
  String get notificationWateringSubtitle =>
      'Otrzymuj powiadomienia, kiedy nadejdzie czas podlewania';

  @override
  String get notificationFertilizerTitle => 'Przypomnienia o nawozach';

  @override
  String get notificationFertilizerSubtitle =>
      'Sezonowe alerty dotyczące karmienia Twoich roślin';

  @override
  String get notificationTitle => 'Powiadomienia';

  @override
  String get notificationPlantCareAlerts =>
      'Alerty dotyczące pielęgnacji roślin';

  @override
  String get notificationOther => 'Inne powiadomienia';

  @override
  String get notificationWeatherTitle => 'Alerty pogodowe';

  @override
  String get notificationWeatherSubtitle =>
      'Ostrzeżenia dotyczące ekstremalnych warunków pogodowych';

  @override
  String get notificationArticlesTitle => 'Nowe artykuły';

  @override
  String get notificationArticlesSubtitle =>
      'Wskazówki i porady dotyczące Twojego ogrodu';

  @override
  String get gardenMyPlantFallback => 'Moja roślina';

  @override
  String get gardenClinicBadge => 'W klinice';

  @override
  String get wateringNever => 'Ostatnio podlewane: Nigdy';

  @override
  String wateringLastDate(String date) {
    return 'Ostatnie podlewanie: $date';
  }

  @override
  String wateringInterval(int days) {
    return 'Co $days dni';
  }

  @override
  String get wateringNeverDue => 'Jeszcze nie podlane • Podlej dzisiaj';

  @override
  String wateringOverdue(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days dnia opóźnienia',
      many: '$days dni opóźnienia',
      few: '$days dni opóźnienia',
      one: '1 dzień opóźnienia',
      zero: 'Podlej dzisiaj',
    );
    return '$_temp0';
  }

  @override
  String get wateringDueToday => 'Woda dzisiaj';

  @override
  String get wateringDueTomorrow => 'Jutro woda';

  @override
  String wateringDueInDays(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'Podlej za $days dnia',
      many: 'Podlej za $days dni',
      few: 'Podlej za $days dni',
      one: 'Podlej za 1 dzień',
      zero: 'Podlej dzisiaj',
    );
    return '$_temp0';
  }

  @override
  String get plantUnknown => 'Nieznana roślina';

  @override
  String get plantSpeciesFallback => 'Gatunki roślin';

  @override
  String get plantDifficultyMedium => 'Średni';

  @override
  String get plantAbout => 'O';

  @override
  String get plantLocationEnvironment => 'Lokalizacja i środowisko';

  @override
  String get plantCareProtocol => 'Protokół opieki';

  @override
  String get plantCareHistory => 'Historia opieki z ostatnich 10 dni';

  @override
  String get plantHealthy => 'Zdrowy';

  @override
  String get plantInClinic => 'W klinice';

  @override
  String get plantDifficulty => 'Trudność';

  @override
  String get plantToxicity => 'Toksyczność';

  @override
  String get plantEnvironment => 'Środowisko';

  @override
  String get plantLightNeed => 'Potrzeba światła';

  @override
  String get plantToxicPets => 'Toksyczny dla zwierząt domowych';

  @override
  String get plantNonToxic => 'Nietoksyczny';

  @override
  String get plantIndoor => 'Wewnątrz';

  @override
  String get plantBrightIndirect => 'Jasny pośredni';

  @override
  String get plantInfoUnavailable =>
      'Zweryfikowane informacje nie są jeszcze dostępne.';

  @override
  String get plantIdealClimate => 'Idealny klimat';

  @override
  String get plantHumidity => 'Wilgotność';

  @override
  String get plantTemperatureRange => 'Zakres temperatur';

  @override
  String get plantWateringFrequency => 'Częstotliwość podlewania';

  @override
  String plantWateringFrequencyValue(String interval) {
    return 'Woda $interval.';
  }

  @override
  String get plantNextWatering => 'Następne podlewanie';

  @override
  String get plantWateringProtocol => 'Protokół podlewania';

  @override
  String get plantSoilProtocol => 'Gleba';

  @override
  String get plantFeedingProtocol => 'Protokół karmienia';

  @override
  String get plantPruningCleaning => 'Przycinanie i czyszczenie';

  @override
  String get plantPruningFallback =>
      'Wycieraj liście co miesiąc. Przycinaj martwe lub pożółkłe liście, aby pobudzić wzrost.';

  @override
  String get plantHistoryEmpty => 'Brak historii opieki przez ostatnie 10 dni.';

  @override
  String get plantWateringTask => 'Podlewanie';

  @override
  String get plantFertilizingTask => 'Nawożenie';

  @override
  String get plantWateredAction => 'Podlewane ✓';

  @override
  String get plantWaterNowAction => 'Woda teraz';

  @override
  String get plantFertilizedAction => 'Nawożone ✓';

  @override
  String get plantFertilizeAction => 'Nawozić';

  @override
  String get plantAddGardenAction => 'Dodaj do mojego ogrodu';

  @override
  String get plantWaterSuccess => '💧 Podlałeś swoją roślinkę! Świetna robota!';

  @override
  String get plantFertilizeSuccess =>
      '🌱 Dodano nawóz! Twoja roślina dziękuje!';

  @override
  String plantWaterError(String error) {
    return 'Nie można zapisać nawadniania: $error';
  }

  @override
  String plantFertilizeError(String error) {
    return 'Nie można zapisać nawożenia: $error';
  }

  @override
  String get clinicQuickTools => 'Szybkie narzędzia';

  @override
  String get clinicDoctorHero => 'Doktor Roślin AI\nDo Twoich usług';

  @override
  String get clinicStartConsultation => 'Rozpocznij konsultację';

  @override
  String get clinicChoosePlant => 'O której roślinie chciałbyś porozmawiać?';

  @override
  String get clinicChoosePlantSubtitle =>
      'Wybierz roślinę ze swojego ogrodu lub zrób nowe zdjęcie.';

  @override
  String get clinicNoGardenPlants =>
      'W Twoim ogrodzie nie ma jeszcze żadnych roślin.\nZacznij od zrobienia nowego zdjęcia.';

  @override
  String get clinicNewPhoto => 'Zrób nowe zdjęcie';

  @override
  String get clinicNewPhotoSubtitle =>
      'Sfotografuj chorą roślinę i uzyskaj diagnozę';

  @override
  String get clinicPestAnalysis => 'Analiza szkodników';

  @override
  String get clinicVisualDiagnosis => 'Diagnoza wizualna';

  @override
  String get clinicLightMeter => 'Miernik światła';

  @override
  String get clinicSensorSimulation => 'Symulacja czujnika';

  @override
  String get clinicTitle => 'Klinika Roślin';

  @override
  String clinicSickCount(int count) {
    return '$count Chory';
  }

  @override
  String get clinicAllHealthy => 'Wszystkie Twoje rośliny są zdrowe! 🌿';

  @override
  String get clinicEmpty =>
      'W Klinice nie ma chorych roślin.\nJeśli martwisz się o roślinę,\nzapytaj w zakładce Lekarz.';

  @override
  String get clinicUnknown => 'Nieznany';

  @override
  String get clinicPendingDiagnosis => 'Czekam na diagnozę';

  @override
  String get clinicNoTreatment => 'Leczenie nie zostało ustalone';

  @override
  String get clinicPrescription => 'Recepta:';

  @override
  String get clinicRecovery => 'Odzyskiwanie';

  @override
  String get clinicRecovered => 'Odzyskany';

  @override
  String get clinicContinue => 'Kontynuuj';

  @override
  String get clinicRecoveredSuccess => '🎉 Twoja roślina znów jest zdrowa!';

  @override
  String get clinicUrgencyLow => 'Niski';

  @override
  String get clinicUrgencyMedium => 'Średni';

  @override
  String get clinicUrgencyCritical => 'Krytyczny';

  @override
  String get healthTrendingTips => 'Popularne porady zdrowotne';

  @override
  String get healthHumidityArticleTitle =>
      'Przygotowanie do zimy: utrzymywanie równowagi wilgotności';

  @override
  String get healthHumidityArticleSubtitle =>
      'Jak chronić rośliny przed suchym powietrzem z grzejników podczas zimnych miesięcy.';

  @override
  String get healthWeeklySpotlight => 'Pacjent i lekarstwo tygodnia';

  @override
  String get healthAphidTitle => 'Inwazja mszyc';

  @override
  String get healthAphidSubtitle =>
      'Wczesna interwencja i naturalna kuracja olejem Neem.';

  @override
  String get healthDiscoverLoadError =>
      'Nie można teraz załadować treści Discover. Pociągnij w dół, aby spróbować ponownie.';

  @override
  String get healthDiscoverEmpty =>
      'Nie ma jeszcze opublikowanych treści do odkrywania.';

  @override
  String get healthDiscoverRetry => 'Spróbuj ponownie';

  @override
  String get lightMeterTitle => 'Miernik światła';

  @override
  String get lightMeterInstructionTitle => 'Mierzyć Światło';

  @override
  String get lightMeterInstruction =>
      'Skieruj przedni aparat telefonu w stronę\npołożenie rośliny i źródło światła.';

  @override
  String get lightMeterCameraEstimate =>
      'Przybliżony luks obliczony na podstawie danych z kamery';

  @override
  String get lightMeterStabilizing => 'Pomiar stabilizujący';

  @override
  String get lightMeterStabilizingRecommendation =>
      'Przytrzymaj telefon nieruchomo przez kilka sekund, aż nagłe zmiany ekspozycji zostaną odfiltrowane.';

  @override
  String get lightMeterUnavailable => 'Pomiar niedostępny';

  @override
  String get lightMeterUnavailableRecommendation =>
      'Włącz uprawnienia aparatu i spróbuj ponownie wyświetlić ten ekran.';

  @override
  String get lightLow => 'Słabe oświetlenie (cień)';

  @override
  String get lightMedium => 'Średnio jasne (jasny pokój)';

  @override
  String get lightHigh => 'Silne światło (w pobliżu okna)';

  @override
  String get lightVeryHigh => 'Bardzo mocne światło (bezpośrednie słońce)';

  @override
  String get lightLowRecommendation =>
      'Nadaje się do kalatei, paproci lub roślin wężowych.';

  @override
  String get lightMediumRecommendation =>
      'Idealny do Monstery, Figowca i Anturium.';

  @override
  String get lightHighRecommendation =>
      'Nadaje się do kochających słońce aloesów, kaktusów i pelargonii.';

  @override
  String get lightVeryHighRecommendation =>
      'Najlepsze do roślin zewnętrznych i sukulentów.';

  @override
  String get homeLoadingPlants => 'Ładowanie roślin...';

  @override
  String get homeNotifications => 'Powiadomienia';

  @override
  String get homeWateringTime => 'Czas podlewania';

  @override
  String get homeWateringNotification =>
      'Twoje rośliny domowe wymagają podlewania.';

  @override
  String get homeWelcome => 'Witamy!';

  @override
  String get homeWelcomeNotification =>
      'Witamy w Botaniq. Zacznij od dodania pierwszej rośliny.';

  @override
  String get homeTenMinutesAgo => '10 minut temu';

  @override
  String get homeOneDayAgo => '1 dzień temu';

  @override
  String get homeQuickActions => 'Szybkie działania';

  @override
  String get homeIdentifyCamera => 'Identyfikuj się ze swoim aparatem';

  @override
  String get homeTomorrow => 'Jutro';

  @override
  String get homeNoTasks => 'Brak zadań na ten dzień!';

  @override
  String get homeAllCared => 'Zadbano o wszystkie Twoje rośliny 🌿';

  @override
  String get homeOverdue => 'SPÓŹNIONE';

  @override
  String get homeInstructions => 'Instrukcje';

  @override
  String homeRequiredAmount(String amount) {
    return 'Wymagane: $amount';
  }

  @override
  String get homeLater => 'Później';

  @override
  String get homeMarkDone => 'Oznacz jako gotowe';

  @override
  String get homeSickPlants => 'Klinika Roślin';

  @override
  String homeSickCount(int count) {
    return '$count Chory';
  }

  @override
  String get homeGreetingMorning => 'Dzień dobry';

  @override
  String get homeGreetingAfternoon => 'Dzień dobry';

  @override
  String get homeGreetingEvening => 'Dobry wieczór';

  @override
  String get homeTodayTasks => 'Dzisiejsze Zadania';

  @override
  String get homeTomorrowTasks => 'Zadania na jutro';

  @override
  String homeDateTasks(String date) {
    return '$date Zadania';
  }

  @override
  String get commonSkip => 'Pomiń';

  @override
  String get commonContinue => 'Kontynuuj';

  @override
  String get commonClose => 'Zamknij';

  @override
  String get commonDelete => 'Usuń';

  @override
  String get commonBack => 'Wróć';

  @override
  String get commonUnknown => 'Nieznany';

  @override
  String get wizardSaveGarden => 'Zapisz i dodaj do ogrodu';

  @override
  String wizardPlantAdded(String name) {
    return '$name został dodany do Twojego ogrodu! 🌿';
  }

  @override
  String get wizardRoomTitle => 'Gdzie jest Twoja roślina?';

  @override
  String get wizardRoomSubtitle =>
      'Kategoryzuj swoją instalację według pomieszczeń, aby łatwo nią zarządzać.';

  @override
  String get wizardLivingRoom => 'Pokój dzienny';

  @override
  String get wizardBedroom => 'Sypialnia';

  @override
  String get wizardKitchen => 'Kuchnia';

  @override
  String get wizardOffice => 'Biuro';

  @override
  String get wizardBathroom => 'Łazienka';

  @override
  String get wizardBalcony => 'Balkon';

  @override
  String get wizardLightTitle => 'Jakie jest światło w tym miejscu?';

  @override
  String get wizardLightSubtitle =>
      'Światło jest jednym z najważniejszych czynników wpływających na zdrowie roślin.';

  @override
  String get wizardDirectSun => 'Bezpośrednie słońce';

  @override
  String get wizardDirectSunDescription =>
      'Niefiltrowane światło słoneczne bezpośrednio na roślinę';

  @override
  String get wizardBrightIndirect => 'Jasny pośredni';

  @override
  String get wizardBrightIndirectDescription =>
      'Blisko okna wychodzącego na wschód lub zachód';

  @override
  String get wizardMediumLight => 'Średnie światło';

  @override
  String get wizardMediumLightDescription => 'Kilka metrów od okna';

  @override
  String get wizardLowLight => 'Słabe światło';

  @override
  String get wizardLowLightDescription =>
      'Z dala od okien lub przy sztucznym świetle';

  @override
  String get wizardDistanceTitle => 'Odległość do okna';

  @override
  String get wizardDistanceSubtitle =>
      'Wybierz przybliżoną odległość do najbliższego okna.';

  @override
  String get wizardMoreThanFiveMeters => 'Ponad 5 m';

  @override
  String get wizardActiveHoursTitle => 'Aktywne godziny świetlne';

  @override
  String get wizardActiveHoursSubtitle =>
      'Ile godzin bezpośredniego lub jasnego światła otrzymuje to miejsce?';

  @override
  String wizardHour(int count) {
    return '$count godz';
  }

  @override
  String wizardHours(int count) {
    return '$count godz';
  }

  @override
  String get wizardSixPlusHours => 'ponad 6 godzin';

  @override
  String get wizardRepottedTitle =>
      'Kiedy ta roślina była ostatnio przesadzana?';

  @override
  String get wizardRepottedSubtitle =>
      'Świeża gleba jest kluczowa dla szczęśliwej rośliny.';

  @override
  String get wizardRecently => 'Niedawno (poniżej 3 miesięcy)';

  @override
  String get wizardSixMonthsAgo => '6 miesięcy temu';

  @override
  String get wizardOneYearAgo => '1 rok temu';

  @override
  String get wizardTwoYearsAgo => 'ponad 2 lata temu';

  @override
  String get wizardDontKnow => 'nie wiem';

  @override
  String get wizardPotTitle => 'Z jakiego materiału jest doniczka?';

  @override
  String get wizardPotSubtitle =>
      'Materiał doniczki wpływa na szybkość wysychania gleby.';

  @override
  String get wizardPlasticPot => 'Plastik / Przedszkole';

  @override
  String get wizardTerracottaPot => 'Terakota';

  @override
  String get wizardCeramicPot => 'Ceramika / Szkliwiona';

  @override
  String get wizardMetalPot => 'Metalowe';

  @override
  String get wizardWateredTitle => 'Kiedy ostatni raz podlewałeś tę roślinę?';

  @override
  String get wizardWateredSubtitle =>
      'Pomaga to obliczyć dokładny czas następnego podlewania.';

  @override
  String get wizardToday => 'Dzisiaj';

  @override
  String get wizardYesterday => 'Wczoraj';

  @override
  String get wizardFewDaysAgo => 'Kilka dni temu';

  @override
  String get wizardWeekAgo => 'Tydzień temu';

  @override
  String get wizardMoreWeekAgo => 'Ponad tydzień temu';

  @override
  String get historyTitle => 'Historia wyszukiwania';

  @override
  String get historyClearTitle => 'Wyczyść historię';

  @override
  String get historyClearMessage =>
      'Cała historia wyszukiwania i skanowania zostanie usunięta. Czy jesteś pewien?';

  @override
  String get historyClearTooltip => 'Wyczyść historię';

  @override
  String get historyEmptyTitle => 'Brak historii wyszukiwania';

  @override
  String get historyEmptySubtitle =>
      'Tutaj pojawią się rośliny zeskanowane kamerą lub wyszukiwane.';

  @override
  String get historyNoDetails => 'Szczegółowe informacje nie są dostępne.';

  @override
  String get historyRegularWater => 'Regularne podlewanie';

  @override
  String get historyIndirectLight => 'Światło pośrednie';

  @override
  String get historyDescription => 'Opis';

  @override
  String get historyWatering => 'Podlewanie';

  @override
  String get historyLight => 'Światło';

  @override
  String get historyRecently => 'Niedawno';

  @override
  String historyMinutesAgo(int minutes) {
    return '$minutes min temu';
  }

  @override
  String historyHoursAgo(int hours) {
    return '$hours godzin temu';
  }

  @override
  String get historyYesterday => 'Wczoraj';

  @override
  String get historyPlantRecord => 'Rekord wyszukiwania roślin';

  @override
  String get photoWholeSpecimen => 'Zdjęcie całości\nroślina lub grzyb';

  @override
  String get photoWholeSpecimenSubtitle =>
      'Trzymaj cały okaz wyśrodkowany w ramce, aby zapewnić lepszą identyfikację.';

  @override
  String get photoCorrect => 'Poprawne';

  @override
  String get photoTooClose => 'Za blisko';

  @override
  String get photoInstructions => 'Instrukcje';

  @override
  String get photoOpenCamera => 'Rozumiem, otwórz kamerę';

  @override
  String get scannerPlant => 'Roślina';

  @override
  String get scannerMushroom => 'Grzyb';

  @override
  String get scannerIdentifyingPlant => 'Identyfikacja rośliny...';

  @override
  String get scannerIdentifyingMushroom => 'Identyfikacja grzybów...';

  @override
  String get scannerCapture => 'Zrób zdjęcie i zeskanuj';

  @override
  String get scannerFailed => 'Skanowanie nie powiodło się. Spróbuj ponownie.';

  @override
  String scannerError(String error) {
    return 'Wystąpił błąd: $error';
  }

  @override
  String get scannerUnknownPlant => 'Nieznana roślina';

  @override
  String get scannerUnknownMushroom => 'Nieznany grzyb';

  @override
  String get scheduleTitle => 'Harmonogram';

  @override
  String get scheduleTodayTask => 'Dzisiejsze zadania';

  @override
  String get scheduleNoTasks => 'Brak zadań na dziś!';

  @override
  String get scheduleInstructions => 'Instrukcje';

  @override
  String scheduleRequired(String amount) {
    return 'Wymagane: $amount';
  }

  @override
  String get scheduleRemindLater => 'Przypomnij później';

  @override
  String get scheduleDone => 'Gotowe';

  @override
  String get scheduleCareFallback => 'Zadbaj o swoją roślinę.';

  @override
  String get chatDoctorTitle => 'Doktor Roślin AI';

  @override
  String chatPatient(String name) {
    return 'Pacjent: $name';
  }

  @override
  String get chatAnalyzing => 'Analizuję...';

  @override
  String chatHint(String name) {
    return 'Zapytaj o $name...';
  }

  @override
  String chatWelcome(String name) {
    return 'Witam! 🌿 Jestem Twoim lekarzem roślin AI. Jak mogę pomóc z $name?\n\nMogę zdiagnozować zdjęcie lub odpowiedzieć na Twoje pytania pielęgnacyjne.';
  }

  @override
  String chatContinueWelcome(String name) {
    return 'Witam! Kontynuujmy $name. 🌱';
  }

  @override
  String get chatQuestionYellowing => 'Co jest przyczyną żółtych liści?';

  @override
  String get chatQuestionTreatment => 'Jak leczyć tę roślinę?';

  @override
  String get chatQuestionWatering =>
      'Czy powinienem zmienić częstotliwość podlewania?';

  @override
  String get chatQuestionFertilizer => 'Jakiego nawozu powinienem użyć?';

  @override
  String get chatPhotoSent => 'Zdjęcie wysłane';

  @override
  String get chatAnalyzePhoto => 'Przeanalizuj zdjęcie';

  @override
  String get chatDiagnosisUnknown => 'Nie udało się ustalić diagnozy';

  @override
  String get chatNoTreatment => 'Brak zaleceń dotyczących leczenia';

  @override
  String get chatRecoveryUnknown => 'Nieznany';

  @override
  String get chatUnableIdentify => 'Niezidentyfikowana roślina';

  @override
  String chatError(String error) {
    return 'Przepraszamy, wystąpił błąd: $error. Spróbuj ponownie.';
  }

  @override
  String get chatCareTips => 'Wskazówki dotyczące pielęgnacji';

  @override
  String get chatPlantLabel => 'Roślina';

  @override
  String get chatDiagnosisLabel => 'Diagnoza';

  @override
  String get chatTreatmentLabel => 'Leczenie';

  @override
  String get chatUrgencyLabel => 'Pilność';

  @override
  String get chatRecoveryLabel => 'Szacowany odzysk';

  @override
  String get discoverMonsteraTitle => 'Sekret wzrostu Monstery';

  @override
  String get discoverIndoorPlants => 'Rośliny domowe';

  @override
  String get discoverSucculentWatering => 'Przewodnik podlewania sukulentów';

  @override
  String get discoverCacti => 'Kaktusy i sukulenty';

  @override
  String get discoverHerbSoil => 'Najlepsze rodzaje gleby dla ziół';

  @override
  String get discoverHerbs => 'Zioła';

  @override
  String get discoverPropagation =>
      'Propagacja 101: Podręcznik dla początkujących';

  @override
  String get discoverPests => 'Powszechne szkodniki i sposoby ich leczenia';

  @override
  String get discoverRepotting => 'Przesadzanie: kiedy i jak?';

  @override
  String discoverMinutesRead(int minutes) {
    return '$minutes min czytania';
  }

  @override
  String get skip => 'Pomiń';

  @override
  String get skipForNow => 'Pomiń na razie';

  @override
  String get continueLabel => 'Kontynuuj';

  @override
  String get getStarted => 'Rozpocznij';

  @override
  String get nextStep => 'Następny krok';

  @override
  String get maybeLater => 'Może później';

  @override
  String get emailAddress => 'Adres e-mail';

  @override
  String get password => 'Hasło';

  @override
  String get firstName => 'Imię';

  @override
  String get lastName => 'Nazwisko';

  @override
  String get login => 'Zaloguj się';

  @override
  String get signUp => 'Zarejestruj się';

  @override
  String get welcomeBack => 'Witamy z powrotem';

  @override
  String get loginSubtitle => 'Zaloguj się, aby dalej dbać o swój ogród.';

  @override
  String get signUpSubtitle =>
      'Dołącz do nas i zacznij budować swoje zielone sanktuarium.';

  @override
  String get forgotPassword => 'Zapomniałeś hasła?';

  @override
  String get enterEmailPassword => 'Proszę podać swój adres e-mail i hasło.';

  @override
  String get fillAllFields => 'Proszę wypełnić wszystkie pola.';

  @override
  String authError(String error) {
    return 'Coś poszło nie tak: $error';
  }

  @override
  String get loginWith => 'Lub zaloguj się za pomocą';

  @override
  String get signUpWith => 'Lub zarejestruj się za pomocą';

  @override
  String get noAccount => 'Nie masz konta?';

  @override
  String get alreadyAccount => 'Masz już konto?';

  @override
  String get developerSession => 'Utwórz sesję programisty';

  @override
  String get welcomeBotaniq => 'Witamy w Botaniq';

  @override
  String get loginOptionsSubtitle =>
      'Zaloguj się lub zarejestruj, aby utworzyć kopię zapasową swoich roślin, harmonogramów i preferencji.';

  @override
  String get notificationAccessTitle => 'Nie przegap podlewania';

  @override
  String get notificationAccessSubtitle =>
      'Delikatnie przypomnimy Ci, kiedy należy zadbać o swoich zielonych przyjaciół. Pielęgnacja roślin łatwa i bezstresowa.';

  @override
  String get notificationTurnOn => 'Włącz Przypomnienia';

  @override
  String get creatingClimate => 'Analizując Twój mikroklimat...';

  @override
  String get creatingSchedules => 'Dostosowywanie harmonogramów opieki...';

  @override
  String get creatingSanctuary => 'Przygotowanie zielonego sanktuarium...';

  @override
  String get locationAccessTitle => 'Dostęp do lokalizacji';

  @override
  String get locationAccessSubtitle =>
      'Spersonalizuj pielęgnację roślin w oparciu o lokalny mikroklimat.';

  @override
  String get locationRecommendation => 'Lokalne rekomendacje';

  @override
  String get locationRecommendationSubtitle =>
      'Rośliny, które dobrze rosną w klimacie Twojego obszaru';

  @override
  String get locationWeather => 'Inteligentna synchronizacja pogody';

  @override
  String get locationWeatherSubtitle =>
      'Harmonogramy dostosowują się do lokalnych opadów w czasie rzeczywistym';

  @override
  String get locationAlerts => 'Alerty o mrozie i upale';

  @override
  String get locationAlertsSubtitle =>
      'Otrzymuj powiadomienia, zanim nadejdą ekstremalne warunki pogodowe';

  @override
  String get locationEnable => 'Włącz dostęp do lokalizacji';

  @override
  String get wherePlantsTitle => 'Gdzie są Twoje rośliny?';

  @override
  String get wherePlantsSubtitle =>
      'Wybierz wszystkie, które mają zastosowanie, aby dostosować harmonogramy opieki.';

  @override
  String get locationIndoor => 'Wewnątrz';

  @override
  String get locationIndoorSubtitle => 'Pokój dzienny, sypialnia, biuro';

  @override
  String get locationBalcony => 'Balkon';

  @override
  String get locationBalconySubtitle =>
      'Rośliny doniczkowe na tarasie lub tarasie';

  @override
  String get locationGarden => 'Ogród';

  @override
  String get locationGardenSubtitle => 'Rośliny doniczkowe i rabaty kwiatowe';

  @override
  String get helpTitleBefore => 'Co możemy';

  @override
  String get helpTitleHighlight => 'ci pomóc';

  @override
  String get helpTitleAfter => 'z?';

  @override
  String get helpSubtitle =>
      'Wybierz jeden lub więcej celów, aby spersonalizować swój ogród.';

  @override
  String get helpHeal => 'Uzdrawiaj chorych\nrośliny';

  @override
  String get helpCare => 'Opieka\nprzypomnienia';

  @override
  String get helpIdentify => 'Zidentyfikuj\ngatunek';

  @override
  String get helpJournal => 'Wzrost\ndziennik';

  @override
  String get helpOther => 'Coś innego';

  @override
  String get journeyTitle => 'Twoja zielona podróż';

  @override
  String get journeySubtitle => 'Wybierz poziom opieki, jaki chcesz zapewnić.';

  @override
  String get journeyCasualLabel => 'CASUAL';

  @override
  String get journeyCasualTitle => 'Niskie koszty utrzymania';

  @override
  String get journeyCasualSubtitle =>
      'Chcę tylko, żeby moje proste rośliny żyły i kwitły.';

  @override
  String get journeyEnthusiastLabel => 'ENTUZJASTA';

  @override
  String get journeyEnthusiastTitle => 'Zrównoważona pielęgnacja';

  @override
  String get journeyEnthusiastSubtitle =>
      'Lubię spędzać trochę czasu w tygodniu z moją rosnącą kolekcją.';

  @override
  String get journeyObsessedLabel => 'obsesja';

  @override
  String get journeyObsessedTitle => 'Nadzwyczajny rodzic rośliny';

  @override
  String get journeyObsessedSubtitle =>
      'Żyję dla moich roślin i potrzebuję specjalistycznych harmonogramów dla mojej wewnętrznej dżungli.';

  @override
  String get masteryTitleBefore => 'Jak się masz';

  @override
  String get masteryTitleHighlight => 'zielony\nkciuk';

  @override
  String get masteryTitleAfter => 'ostatnio?';

  @override
  String get masterySubtitle =>
      'Bądźmy szczerzy – wszyscy byliśmy w pewnym momencie „seryjnym mordercą”. Wybierz swoje obecne mistrzostwo.';

  @override
  String get masteryKiller => 'Seryjny morderca';

  @override
  String get masteryKillerSubtitle =>
      'Nawet moje plastikowe rośliny wyglądają na zmartwione, kiedy wchodzę do pokoju.';

  @override
  String get masteryAccidental => 'Przypadkowy rodzic';

  @override
  String get masteryAccidentalSubtitle =>
      'Mój kaktus przetrwał dwa tygodnie. Wciąż się poznajemy.';

  @override
  String get masteryGrowth => 'Nastawienie na rozwój';

  @override
  String get masteryGrowthSubtitle =>
      'Większość moich znajomych ma liście. Znam moje Monstery z mojego Pothos.';

  @override
  String get masteryWhisperer => 'Zaklinacz roślin';

  @override
  String get masteryWhispererSubtitle =>
      'Rozmnażam rzadkie rośliny i biegle władam botaniczną łaciną.';

  @override
  String get onboardingOneTitle => 'Uważaj\nTwoich Roślin';

  @override
  String get onboardingOneHighlight => 'Jak profesjonalista';

  @override
  String get onboardingOneSubtitle =>
      'Inteligentne harmonogramy i natychmiastowa identyfikacja Twojej miejskiej dżungli.';

  @override
  String get onboardingOneBadge => 'OPIEKA OPARTA NA AI';

  @override
  String get onboardingAiScan => 'Skanowanie AI';

  @override
  String get onboardingSmartWater => 'Inteligentna woda';

  @override
  String get onboardingLightTracking => 'Śledzenie światła';

  @override
  String get onboardingTwoTitle => 'Zidentyfikuj dowolne\nZasadzić';

  @override
  String get onboardingTwoHighlight => 'Sekundy';

  @override
  String get onboardingTwoSubtitle =>
      'Zrób zdjęcie, aby poznać jego nazwę, gatunek i wymagania pielęgnacyjne.';

  @override
  String get onboardingTwoBadge => 'EKSPERT BOTANICZNY';

  @override
  String get onboardingSnapPhoto => 'Zrób zdjęcie';

  @override
  String get onboardingAccurateResult => 'Dokładny wynik';

  @override
  String get onboardingPlantWiki => 'Roślinna Wiki';

  @override
  String get onboardingThreeTitle => 'Nigdy nie zapomnij\nDo wody';

  @override
  String get onboardingThreeHighlight => 'Znowu';

  @override
  String get onboardingThreeSubtitle =>
      'Otrzymuj przypomnienia dostosowane do potrzeb i środowiska Twojego zakładu.';

  @override
  String get onboardingThreeBadge => 'INTELIGENTNE HARMONOGRAMY';

  @override
  String get onboardingReminders => 'Przypomnienia';

  @override
  String get onboardingClimateData => 'Dane klimatyczne';

  @override
  String get onboardingHealthyGrowth => 'Zdrowy wzrost';

  @override
  String get onboardingCommunity => 'Dołącz do ponad 50 000 rodziców roślin';

  @override
  String get onboardingAgreement =>
      'KONTYNUUJĄC, ZGADZASZ SIĘ NA NASZE WARUNKI I POLITYKĘ PRYWATNOŚCI';

  @override
  String get termsTitle => 'Warunki i zasady';

  @override
  String get termsUpdated => 'Ostatnia aktualizacja: lipiec 2026 r';

  @override
  String get termsUseTitle => '1. Warunki korzystania';

  @override
  String get termsUseBody =>
      'Uzyskując dostęp do Botaniq lub korzystając z niego, wyrażasz zgodę na niniejsze Warunki użytkowania i obowiązujące przepisy. Jeśli nie wyrażasz zgody, nie możesz korzystać z usługi.';

  @override
  String get termsPrivacyTitle => '2. Prywatność użytkownika';

  @override
  String get termsPrivacyBody =>
      'Gromadzimy wyłącznie dane osobowe potrzebne do zapewnienia dostosowanych harmonogramów pielęgnacji roślin. Nie sprzedajemy Twoich danych osobowych podmiotom trzecim.';

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
  String get termsPlantTitle => '3. Dane roślin';

  @override
  String get termsPlantBody =>
      'Informacje dotyczące pielęgnacji, identyfikacji i diagnostyki roślin służą celom informacyjnym. Wyniki sztucznej inteligencji mogą nie zawsze być prawidłowe, dlatego obserwuj swoją roślinę i zasięgnij porady eksperta pod kątem poważnych zagrożeń.';

  @override
  String get termsLiabilityTitle => '6. Disclaimers, Liability, and Indemnity';

  @override
  String get termsLiabilityBody =>
      'Botaniq is provided \"as is\" and \"as available,\" without warranties of any kind, express or implied, including accuracy, reliability, or fitness for a particular purpose. To the fullest extent permitted by law, we and our service providers are not liable for any indirect, incidental, special, or consequential damages, or for any loss of data, plants, or property arising from your use of the service, and our total liability for any claim is limited to the amount you paid us, if any, in the twelve months before the claim. You agree to indemnify and hold us harmless from claims arising from your use of the service, your content, or your violation of these Terms or applicable law.';

  @override
  String get termsPremiumTitle => '4. Subskrypcje Premium';

  @override
  String get termsPremiumBody =>
      'Twoja miesięczna lub roczna subskrypcja Premium zostanie obciążona Twoim kontem Apple lub Google po potwierdzeniu zakupu. Odnawia się automatycznie, chyba że zostanie anulowany co najmniej 24 godziny przed końcem bieżącego okresu. Możesz nim zarządzać lub anulować go w ustawieniach swojego konta sklepowego. Żądania zwrotu pieniędzy są rozpatrywane zgodnie z obowiązującymi zasadami sklepu.';

  @override
  String get termsLawTitle => '8. Governing Law and Changes';

  @override
  String get termsLawBody =>
      'These Terms are governed by the laws of the jurisdiction in which we operate, without regard to conflict-of-law principles, and any dispute will be resolved under that jurisdiction\'s applicable procedures to the fullest extent permitted by law. We may update these Terms and our data practices at any time by posting the revised version in the app.';

  @override
  String get termsClosing =>
      'Ciesz się spokojem ducha i szczęśliwszymi roślinami.';

  @override
  String get weatherTitle => 'Pogoda';

  @override
  String get weatherSunnyTip =>
      'Dziś słonecznie – sprawdź glebę przed podlaniem.';

  @override
  String get weatherCloudyTip =>
      'Pochmurna pogoda spowalnia parowanie; wody trochę mniej.';

  @override
  String get weatherRainyTip =>
      'Deszczowo i wilgotno – unikaj nadmiernego podlewania roślin na zewnątrz.';

  @override
  String get weatherStormTip =>
      'Sztormowa pogoda – przenieś delikatne doniczki w osłonięte miejsce.';

  @override
  String get weatherSnowTip =>
      'Zimno i śnieg – chroń rośliny przed szokiem temperaturowym.';
}
