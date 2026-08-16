// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get appTitle => 'Botaniq';

  @override
  String get settings => 'Impostazioni';

  @override
  String get preferences => 'Preferenze';

  @override
  String get darkMode => 'Modalità oscura';

  @override
  String get metricSystem => 'Sistema metrico';

  @override
  String get metricSystemSubtitle => 'Usa Celsius e Metri';

  @override
  String get account => 'Conto';

  @override
  String get editProfile => 'Modifica profilo';

  @override
  String get changePassword => 'Cambia password';

  @override
  String get subscriptionManagement => 'Gestione degli abbonamenti';

  @override
  String get premium => 'Premio';

  @override
  String get language => 'Lingua';

  @override
  String get languageSubtitle => 'Cambia la lingua dell\'app';

  @override
  String get selectLanguage => 'Seleziona lingua';

  @override
  String get systemLanguage => 'Lingua del sistema';

  @override
  String get english => 'Inglese';

  @override
  String get turkish => 'Türkçe';

  @override
  String get languageChanged => 'La lingua è stata modificata con successo.';

  @override
  String get languageSearchHint => 'Cerca lingue';

  @override
  String get languageRecommended => 'Consigliato';

  @override
  String get languageWelcomeTitle => 'Scegli la tua lingua';

  @override
  String get languageWelcomeSubtitle =>
      'Seleziona la lingua che desideri utilizzare in Botaniq. Puoi cambiarlo in qualsiasi momento.';

  @override
  String get languageUseSystem => 'Utilizza la lingua del dispositivo';

  @override
  String get preferenceSystem => 'Utilizza le impostazioni di sistema';

  @override
  String get themeLight => 'Luce';

  @override
  String get themeDark => 'Buio';

  @override
  String get themeSelectionTitle => 'Scegli l\'aspetto';

  @override
  String get measurementMetric => 'Metrico';

  @override
  String get measurementImperial => 'Imperiale';

  @override
  String get measurementSelectionTitle => 'Scegli il sistema di misurazione';

  @override
  String get settingsSubtitle =>
      'Modella Botaniq secondo il tuo ritmo di cura.';

  @override
  String get settingsLocalPreference => 'Salvato su questo dispositivo';

  @override
  String get settingsDarkModeSubtitle =>
      'Una tavolozza più calma per i momenti di scarsa illuminazione';

  @override
  String get settingsAccountSubtitle => 'Identità, accesso e appartenenza';

  @override
  String get settingsEditProfileSubtitle =>
      'Nome, posizione e preferenze di cura';

  @override
  String get settingsPasswordSubtitle =>
      'Invia un collegamento di ripristino sicuro alla tua email';

  @override
  String get settingsSubscriptionSubtitle =>
      'Piano Premium e dettagli di fatturazione';

  @override
  String get settingsPasswordResetSent =>
      'E-mail di reimpostazione della password inviata.';

  @override
  String get settingsComingSoon => 'Questo spazio è ancora in crescita.';

  @override
  String get subscriptionPageTitle => 'Abbonamento Premium';

  @override
  String get subscriptionHeroEyebrow => 'BOTANIQ PREMIUM';

  @override
  String get subscriptionHeroTitle => 'Cura più intelligente per ogni pianta';

  @override
  String get subscriptionHeroSubtitle =>
      'Sblocca tutti gli strumenti di cura premium e fai crescere il tuo spazio verde in tutta sicurezza.';

  @override
  String get subscriptionBenefitsTitle => 'Tutto in Premium';

  @override
  String get subscriptionBenefitIdentification =>
      'Identificazione illimitata delle piante e analisi sanitarie';

  @override
  String get subscriptionBenefitCare =>
      'Piani di assistenza e promemoria personalizzati';

  @override
  String get subscriptionBenefitInsights =>
      'Contenuti esperti e approfondimenti terapeutici avanzati';

  @override
  String get subscriptionMonthlyPlan => 'Mensile';

  @override
  String get subscriptionAnnualPlan => 'Annuale';

  @override
  String subscriptionPerMonth(String price) {
    return '$price /mese';
  }

  @override
  String subscriptionPerYear(String price) {
    return '$price /anno';
  }

  @override
  String get subscriptionBestValue => 'MIGLIOR VALORE';

  @override
  String subscriptionSavePercent(int percent) {
    return 'Risparmia $percent%';
  }

  @override
  String get subscriptionContinue => 'Sblocca Premium';

  @override
  String get subscriptionRestorePurchases => 'Ripristina gli acquisti';

  @override
  String get subscriptionRestoring => 'Ripristino...';

  @override
  String get subscriptionManage => 'Gestisci abbonamento';

  @override
  String get subscriptionActiveTitle => 'Il tuo abbonamento Premium è attivo';

  @override
  String get subscriptionActiveSubtitle =>
      'Hai accesso a tutte le funzionalità premium.';

  @override
  String subscriptionRenewsOn(String date) {
    return 'Si rinnova il $date';
  }

  @override
  String subscriptionExpiresOn(String date) {
    return 'Attivo fino al $date';
  }

  @override
  String get subscriptionAutoRenewDisclosure =>
      'Il pagamento viene addebitato sul tuo account Apple o Google. L\'abbonamento si rinnova automaticamente salvo disdetta almeno 24 ore prima della fine del periodo in corso. Puoi gestirlo o annullarlo in qualsiasi momento nelle impostazioni dell\'account del tuo negozio.';

  @override
  String get subscriptionTermsLink => 'Condizioni d\'uso';

  @override
  String get subscriptionPrivacyLink => 'Informativa sulla privacy';

  @override
  String get subscriptionPurchaseSuccess =>
      'Il tuo abbonamento Premium è ora attivo.';

  @override
  String get subscriptionRestoreSuccess =>
      'Il tuo abbonamento Premium è stato ripristinato.';

  @override
  String get subscriptionNothingToRestore =>
      'Non è stata trovata alcuna iscrizione attiva per questo account del negozio.';

  @override
  String get subscriptionPaymentPending =>
      'Il pagamento è in attesa di approvazione da parte del negozio. La tua iscrizione si attiverà automaticamente una volta approvata.';

  @override
  String get subscriptionErrorGeneric =>
      'Impossibile completare l\'operazione. Per favore riprova.';

  @override
  String get subscriptionErrorNetwork =>
      'Controlla la connessione Internet e riprova.';

  @override
  String get subscriptionErrorNotAllowed =>
      'Questo dispositivo o account del negozio non è autorizzato a effettuare acquisti.';

  @override
  String get subscriptionErrorStore =>
      'Non è stato possibile raggiungere il negozio. Per favore riprova a breve.';

  @override
  String get subscriptionMissingConfiguration =>
      'In questa build manca la chiave RevenueCat.';

  @override
  String get subscriptionUnsupported =>
      'Gli abbonamenti sono disponibili solo nelle app iOS e Android.';

  @override
  String get subscriptionProductsUnavailable =>
      'Impossibile caricare i prodotti mensili e annuali. Controlla la configurazione dell\'offerta RevenueCat.';

  @override
  String get subscriptionRetry => 'Riprova';

  @override
  String get subscriptionFree => 'Gratuito';

  @override
  String get homeGoodMorning => 'Ciao,';

  @override
  String homePersonalGreeting(String greeting, String name) {
    return '$greeting, $name 👋';
  }

  @override
  String get homeEmptyGarden => 'Il tuo giardino è vuoto';

  @override
  String get homeEmptyGardenSubtitle =>
      'Inizia a costruire il tuo santuario verde\naggiungendo la tua prima pianta.';

  @override
  String get homeAddFirstPlant => 'Aggiungi la prima pianta';

  @override
  String get homeMyPlants => 'Le mie piante';

  @override
  String get homeViewAll => 'Visualizza tutto';

  @override
  String get homeSmartCareReminders => 'Promemoria Smart Care';

  @override
  String get homeWatering => 'Irrigazione';

  @override
  String get homeWateringSubtitle => 'Tracciamento del suolo';

  @override
  String get homeFertilizing => 'Fertilizzante';

  @override
  String get homeFertilizingSubtitle => 'Avvisi sui nutrienti';

  @override
  String get gardenTitle => 'Il mio giardino';

  @override
  String get gardenAllPlants => 'Tutte le piante';

  @override
  String get gardenNeedsWater => 'Ha bisogno di acqua';

  @override
  String get gardenIndoor => 'Al coperto';

  @override
  String get gardenNoPlants =>
      'Nessuna pianta ancora.\nTocca + per aggiungere la tua prima pianta!';

  @override
  String get gardenNoPlantsCategory => 'Nessuna pianta in questa categoria.';

  @override
  String get discoverTitle => 'Scopri';

  @override
  String get discoverSearchHint => 'Cerca piante, articoli, guide...';

  @override
  String get discoverLatestArticles => 'Ultimi articoli';

  @override
  String get discoverSeeAll => 'Vedi tutto';

  @override
  String get discoverTrendingGuides => 'Guide di tendenza';

  @override
  String get healthyTitle => 'Centro di cura';

  @override
  String get healthySubtitle =>
      'Tocca l\'anima delle tue piante, parla con loro.';

  @override
  String get healthyTabDoctor => 'Dottore';

  @override
  String get healthyTabHospital => 'Ospedale';

  @override
  String get healthyTabDiscover => 'Scopri';

  @override
  String get profileTitle => 'Il mio profilo';

  @override
  String get profileEditProfile => 'Modifica profilo';

  @override
  String get profileOverview => 'Panoramica';

  @override
  String get profileSettingsTab => 'Impostazioni';

  @override
  String get profileGardenerLevel => 'Livello giardiniere';

  @override
  String get profileTotalPlants => 'Piante totali';

  @override
  String get profileCompletedTasks => 'Attività completate';

  @override
  String get profileWeeklyActivity => 'Attività di cura settimanale';

  @override
  String get profileGeneral => 'Generale';

  @override
  String get profileAppSettings => 'Impostazioni dell\'app';

  @override
  String get profileNotificationPrefs => 'Preferenze di notifica';

  @override
  String get profileSupportLegal => 'Supporto e legale';

  @override
  String get profileHelpCenter => 'Centro assistenza';

  @override
  String get profileTerms => 'Termini di utilizzo e politiche';

  @override
  String get profileSignOut => 'Esci';

  @override
  String get profileDeleteAccount => 'Elimina account';

  @override
  String get profileSubtitle =>
      'La storia del tuo giardino, il progresso e lo spazio personale.';

  @override
  String get profileGardenPassport => 'PASSAPORTO GIARDINO';

  @override
  String get profileThisWeek => 'Questa settimana';

  @override
  String get profileQuietWeek =>
      'Una settimana tranquilla: il tuo prossimo momento di cura apparirà qui.';

  @override
  String get profileActiveWeek => 'Il tuo ritmo di cura è vivo e in crescita.';

  @override
  String get profileAppSettingsSubtitle => 'Lingua, unità e connessione AI';

  @override
  String get profileNotificationPrefsSubtitle =>
      'Scegli quali momenti di cura ti raggiungono';

  @override
  String get profileHelpCenterSubtitle => 'Risposte e indicazioni rapide';

  @override
  String get profileTermsSubtitle => 'Privacy, termini e politiche';

  @override
  String get profileAccountActions => 'Azioni dell\'account';

  @override
  String get profileSignOutQuestion => 'Sei sicuro di voler uscire?';

  @override
  String get profileDeleteAccountWarning =>
      'La cancellazione dell\'account richiede una conferma sicura sul lato server. I tuoi dati non sono stati modificati.';

  @override
  String get cancel => 'Annulla';

  @override
  String get continueAction => 'Continua';

  @override
  String get profileTitleNew => 'Nuovo Giardiniere 🌱';

  @override
  String get profileTitleSprout => 'Amico Germoglio 🌿';

  @override
  String get profileTitleLeaf => 'Amante delle foglie ☘️';

  @override
  String get profileTitleSkilled => 'Giardiniere esperto 🏡';

  @override
  String get profileTitleMaster => 'Maestro del Pollice Verde 👑';

  @override
  String get profileNextLevelStart =>
      'Aggiungi la tua prima pianta e inizia la tua avventura di giardinaggio!';

  @override
  String profileNextLevelLeaf(int count) {
    return 'Sono rimaste solo le piante $count per diventare Leaf Lover.';
  }

  @override
  String profileNextLevelSkilled(int count) {
    return 'Sono rimaste solo $count piante per diventare giardiniere esperto.';
  }

  @override
  String profileNextLevelMaster(int count) {
    return 'Sono rimaste solo le piante $count per diventare Green Thumb Master.';
  }

  @override
  String get profileNextLevelMax =>
      'Sei al top del tuo giardino, congratulazioni!';

  @override
  String get navHome => 'Casa';

  @override
  String get navGarden => 'Giardino';

  @override
  String get navClinic => 'Clinica';

  @override
  String get navProfile => 'Profilo';

  @override
  String get scanPlant => 'Scansione impianto';

  @override
  String get deletePlantTitle => 'Rimuovere questa pianta?';

  @override
  String get deletePlantMessage =>
      'La pianta, le sue attività di cura e i registri della clinica verranno rimossi definitivamente dal tuo account.';

  @override
  String get deletePlantAction => 'Rimuovi pianta';

  @override
  String get deletePlantNotFound =>
      'La pianta non è stata trovata o è già stata rimossa.';

  @override
  String deletePlantError(String error) {
    return 'Impossibile rimuovere la pianta: $error';
  }

  @override
  String get profileChoosePhoto => 'Scegli Foto del profilo';

  @override
  String get profileFullName => 'Nome completo';

  @override
  String get profileFullNameHint => 'Inserisci il tuo nome completo';

  @override
  String get profileNickname => 'Soprannome';

  @override
  String get profileNicknameHint => 'Come dovremmo chiamarti?';

  @override
  String get profileAge => 'Età';

  @override
  String get profileAgeHint => '1–120';

  @override
  String get profileAgeValidation =>
      'Inserisci un\'età compresa tra 1 e 120 anni.';

  @override
  String profileLoadError(String error) {
    return 'Impossibile caricare il profilo: $error';
  }

  @override
  String get languageEnglish => 'Inglese';

  @override
  String get languageTurkish => 'Turco';

  @override
  String get profileEmailReadOnly => 'Indirizzo e-mail (sola lettura)';

  @override
  String get profileEmailHint => 'Inserisci la tua email';

  @override
  String get profileLocation => 'Posizione';

  @override
  String get profileLocationHint => 'Città, Paese';

  @override
  String get profileSaveChanges => 'Salva modifiche';

  @override
  String get profileUpdated => 'Il tuo profilo è stato aggiornato.';

  @override
  String profileSaveError(String error) {
    return 'Impossibile salvare il profilo: $error';
  }

  @override
  String get notificationWateringTitle => 'Promemoria di irrigazione';

  @override
  String get notificationWateringSubtitle =>
      'Ricevi una notifica quando è il momento di irrigare';

  @override
  String get notificationFertilizerTitle => 'Promemoria sui fertilizzanti';

  @override
  String get notificationFertilizerSubtitle =>
      'Avvisi di alimentazione stagionale per le tue piante';

  @override
  String get notificationTitle => 'Notifiche';

  @override
  String get notificationPlantCareAlerts => 'Avvisi sulla cura delle piante';

  @override
  String get notificationOther => 'Altre notifiche';

  @override
  String get notificationWeatherTitle => 'Avvisi meteorologici';

  @override
  String get notificationWeatherSubtitle => 'Allerte meteo estreme';

  @override
  String get notificationArticlesTitle => 'Nuovi articoli';

  @override
  String get notificationArticlesSubtitle =>
      'Consigli e trucchi per il tuo giardino';

  @override
  String get gardenMyPlantFallback => 'La mia pianta';

  @override
  String get gardenClinicBadge => 'In Clinica';

  @override
  String get wateringNever => 'Ultima irrigazione: mai';

  @override
  String wateringLastDate(String date) {
    return 'Ultima irrigazione: $date';
  }

  @override
  String wateringInterval(int days) {
    return 'Ogni $days giorni';
  }

  @override
  String get wateringNeverDue => 'Non ancora irrigato • Innaffiare oggi';

  @override
  String wateringOverdue(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days giorni di ritardo',
      one: '1 giorno di ritardo',
      zero: 'Annaffia oggi',
    );
    return '$_temp0';
  }

  @override
  String get wateringDueToday => 'Acqua oggi';

  @override
  String get wateringDueTomorrow => 'Domani annaffiare';

  @override
  String wateringDueInDays(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'Annaffia tra $days giorni',
      one: 'Annaffia tra 1 giorno',
      zero: 'Annaffia oggi',
    );
    return '$_temp0';
  }

  @override
  String get plantUnknown => 'Pianta sconosciuta';

  @override
  String get plantSpeciesFallback => 'Specie vegetali';

  @override
  String get plantDifficultyMedium => 'Medio';

  @override
  String get plantAbout => 'Circa';

  @override
  String get plantLocationEnvironment => 'Posizione e ambiente';

  @override
  String get plantCareProtocol => 'Protocollo di cura';

  @override
  String get plantCareHistory => 'Cronologia delle cure degli ultimi 10 giorni';

  @override
  String get plantHealthy => 'Sano';

  @override
  String get plantInClinic => 'In Clinica';

  @override
  String get plantDifficulty => 'Difficoltà';

  @override
  String get plantToxicity => 'Tossicità';

  @override
  String get plantEnvironment => 'Ambiente';

  @override
  String get plantLightNeed => 'Necessità di luce';

  @override
  String get plantToxicPets => 'Tossico per gli animali domestici';

  @override
  String get plantNonToxic => 'Non tossico';

  @override
  String get plantIndoor => 'Al coperto';

  @override
  String get plantBrightIndirect => 'Indiretto brillante';

  @override
  String get plantInfoUnavailable =>
      'Le informazioni verificate non sono ancora disponibili.';

  @override
  String get plantIdealClimate => 'Clima ideale';

  @override
  String get plantHumidity => 'Umidità';

  @override
  String get plantTemperatureRange => 'Intervallo di temperatura';

  @override
  String get plantWateringFrequency => 'Frequenza di irrigazione';

  @override
  String plantWateringFrequencyValue(String interval) {
    return 'Acqua $interval.';
  }

  @override
  String get plantNextWatering => 'Prossima irrigazione';

  @override
  String get plantWateringProtocol => 'Protocollo di irrigazione';

  @override
  String get plantSoilProtocol => 'Suolo';

  @override
  String get plantFeedingProtocol => 'Protocollo di alimentazione';

  @override
  String get plantPruningCleaning => 'Potatura e pulizia';

  @override
  String get plantPruningFallback =>
      'Pulisci le foglie mensilmente. Pota le foglie morte o ingiallite per incoraggiare la crescita.';

  @override
  String get plantHistoryEmpty =>
      'Nessuna storia di cure negli ultimi 10 giorni.';

  @override
  String get plantWateringTask => 'Irrigazione';

  @override
  String get plantFertilizingTask => 'Fertilizzante';

  @override
  String get plantWateredAction => 'Innaffiato ✓';

  @override
  String get plantWaterNowAction => 'Innaffia adesso';

  @override
  String get plantFertilizedAction => 'Fecondato ✓';

  @override
  String get plantFertilizeAction => 'Fertilizzare';

  @override
  String get plantAddGardenAction => 'Aggiungi al mio giardino';

  @override
  String get plantWaterSuccess =>
      '💧 Hai annaffiato la tua pianta! Ottimo lavoro!';

  @override
  String get plantFertilizeSuccess =>
      '🌱 Aggiunto fertilizzante! La tua pianta ringrazia!';

  @override
  String plantWaterError(String error) {
    return 'Impossibile salvare l\'irrigazione: $error';
  }

  @override
  String plantFertilizeError(String error) {
    return 'Impossibile salvare la fertilizzazione: $error';
  }

  @override
  String get clinicQuickTools => 'Strumenti rapidi';

  @override
  String get clinicDoctorHero => 'Dottore delle piante AI\nAl tuo servizio';

  @override
  String get clinicStartConsultation => 'Inizia la consultazione';

  @override
  String get clinicChoosePlant => 'Di quale pianta vorresti parlare?';

  @override
  String get clinicChoosePlantSubtitle =>
      'Scegli una pianta dal tuo giardino o scatta una nuova foto.';

  @override
  String get clinicNoGardenPlants =>
      'Non ci sono ancora piante nel tuo giardino.\nInizia scattando una nuova foto.';

  @override
  String get clinicNewPhoto => 'Scatta una nuova foto';

  @override
  String get clinicNewPhotoSubtitle =>
      'Fotografa la pianta malata e ottieni una diagnosi';

  @override
  String get clinicPestAnalysis => 'Analisi dei parassiti';

  @override
  String get clinicVisualDiagnosis => 'Diagnosi visiva';

  @override
  String get clinicLightMeter => 'Misuratore di luce';

  @override
  String get clinicSensorSimulation => 'Simulazione del sensore';

  @override
  String get clinicTitle => 'Clinica vegetale';

  @override
  String clinicSickCount(int count) {
    return '$count Malato';
  }

  @override
  String get clinicAllHealthy => 'Tutte le tue piante sono sane! 🌿';

  @override
  String get clinicEmpty =>
      'Nella Clinica non sono presenti piante malate.\nSe sei preoccupato per una pianta,\nchiedi dalla scheda Dottore.';

  @override
  String get clinicUnknown => 'Sconosciuto';

  @override
  String get clinicPendingDiagnosis => 'In attesa della diagnosi';

  @override
  String get clinicNoTreatment => 'Il trattamento non è stato determinato';

  @override
  String get clinicPrescription => 'Prescrizione:';

  @override
  String get clinicRecovery => 'Recupero';

  @override
  String get clinicRecovered => 'Recuperato';

  @override
  String get clinicContinue => 'Continua';

  @override
  String get clinicRecoveredSuccess => '🎉 La tua pianta è di nuovo sana!';

  @override
  String get clinicUrgencyLow => 'Basso';

  @override
  String get clinicUrgencyMedium => 'Medio';

  @override
  String get clinicUrgencyCritical => 'Critico';

  @override
  String get healthTrendingTips => 'Suggerimenti per la salute di tendenza';

  @override
  String get healthHumidityArticleTitle =>
      'Preparazione invernale: mantenere l\'umidità equilibrata';

  @override
  String get healthHumidityArticleSubtitle =>
      'Come proteggere le tue piante dall\'aria secca dei radiatori durante i mesi freddi.';

  @override
  String get healthWeeklySpotlight => 'Paziente e rimedio della settimana';

  @override
  String get healthAphidTitle => 'Infestazione da afidi';

  @override
  String get healthAphidSubtitle =>
      'Intervento precoce e trattamento naturale con Olio di Neem.';

  @override
  String get healthDiscoverLoadError =>
      'Impossibile caricare il contenuto di Discover in questo momento. Tirare verso il basso per riprovare.';

  @override
  String get healthDiscoverEmpty =>
      'Non è stato ancora pubblicato alcun contenuto di scoperta.';

  @override
  String get healthDiscoverRetry => 'Riprova';

  @override
  String get lightMeterTitle => 'Misuratore di luce';

  @override
  String get lightMeterInstructionTitle => 'Per misurare la luce';

  @override
  String get lightMeterInstruction =>
      'Punta la fotocamera anteriore del telefono verso\nla posizione della pianta e la fonte di luce.';

  @override
  String get lightMeterCameraEstimate =>
      'Lux approssimativi calcolati dai dati della fotocamera';

  @override
  String get lightMeterStabilizing => 'Misurazione stabilizzante';

  @override
  String get lightMeterStabilizingRecommendation =>
      'Tieni il telefono fermo per alcuni secondi mentre i cambiamenti improvvisi dell\'esposizione vengono filtrati.';

  @override
  String get lightMeterUnavailable => 'Misura non disponibile';

  @override
  String get lightMeterUnavailableRecommendation =>
      'Abilita l\'autorizzazione della fotocamera e riprova questa schermata.';

  @override
  String get lightLow => 'Luce scarsa (ombra)';

  @override
  String get lightMedium => 'Luce media (stanza luminosa)';

  @override
  String get lightHigh => 'Luce alta (vicino alla finestra)';

  @override
  String get lightVeryHigh => 'Luce molto elevata (sole diretto)';

  @override
  String get lightLowRecommendation =>
      'Adatto per Calathea, felci o piante di serpente.';

  @override
  String get lightMediumRecommendation =>
      'Ideale per Monstera, Ficus e Anthurium.';

  @override
  String get lightHighRecommendation =>
      'Adatto per aloe, cactus e gerani amanti del sole.';

  @override
  String get lightVeryHighRecommendation =>
      'Ideale per piante da esterno e piante grasse.';

  @override
  String get homeLoadingPlants => 'Caricamento piante...';

  @override
  String get homeNotifications => 'Notifiche';

  @override
  String get homeWateringTime => 'Tempo di irrigazione';

  @override
  String get homeWateringNotification =>
      'Le tue piante da interno hanno bisogno di essere annaffiate.';

  @override
  String get homeWelcome => 'Benvenuto!';

  @override
  String get homeWelcomeNotification =>
      'Benvenuti a Botaniq. Inizia aggiungendo la tua prima pianta.';

  @override
  String get homeTenMinutesAgo => '10 minuti fa';

  @override
  String get homeOneDayAgo => '1 giorno fa';

  @override
  String get homeQuickActions => 'Azioni rapide';

  @override
  String get homeIdentifyCamera => 'Identificati con la tua fotocamera';

  @override
  String get homeTomorrow => 'Domani';

  @override
  String get homeNoTasks => 'Nessuna attività per questo giorno!';

  @override
  String get homeAllCared => 'Le tue piante sono tutte curate 🌿';

  @override
  String get homeOverdue => 'IN RITARDO';

  @override
  String get homeInstructions => 'Istruzioni';

  @override
  String homeRequiredAmount(String amount) {
    return 'Richiesto: $amount';
  }

  @override
  String get homeLater => 'Più tardi';

  @override
  String get homeMarkDone => 'Segna come fatto';

  @override
  String get homeSickPlants => 'Clinica vegetale';

  @override
  String homeSickCount(int count) {
    return '$count Malato';
  }

  @override
  String get homeGreetingMorning => 'Buongiorno';

  @override
  String get homeGreetingAfternoon => 'Buon pomeriggio';

  @override
  String get homeGreetingEvening => 'Buonasera';

  @override
  String get homeTodayTasks => 'I compiti di oggi';

  @override
  String get homeTomorrowTasks => 'I compiti di domani';

  @override
  String homeDateTasks(String date) {
    return '$date Compiti';
  }

  @override
  String get commonSkip => 'Salta';

  @override
  String get commonContinue => 'Continua';

  @override
  String get commonClose => 'Chiudi';

  @override
  String get commonDelete => 'Elimina';

  @override
  String get commonBack => 'Torna indietro';

  @override
  String get commonUnknown => 'Sconosciuto';

  @override
  String get wizardSaveGarden => 'Salva e aggiungi al giardino';

  @override
  String wizardPlantAdded(String name) {
    return '$name è stato aggiunto al tuo giardino! 🌿';
  }

  @override
  String get wizardRoomTitle => 'Dov\'è la tua pianta?';

  @override
  String get wizardRoomSubtitle =>
      'Classifica il tuo impianto per stanza per gestirlo facilmente.';

  @override
  String get wizardLivingRoom => 'Soggiorno';

  @override
  String get wizardBedroom => 'Camera da letto';

  @override
  String get wizardKitchen => 'Cucina';

  @override
  String get wizardOffice => 'Ufficio';

  @override
  String get wizardBathroom => 'Bagno';

  @override
  String get wizardBalcony => 'Balcone';

  @override
  String get wizardLightTitle => 'Com\'è la luce in questo punto?';

  @override
  String get wizardLightSubtitle =>
      'La luce è uno dei fattori più importanti per la salute della tua pianta.';

  @override
  String get wizardDirectSun => 'Sole diretto';

  @override
  String get wizardDirectSunDescription =>
      'Luce solare non filtrata direttamente sulla pianta';

  @override
  String get wizardBrightIndirect => 'Indiretto brillante';

  @override
  String get wizardBrightIndirectDescription =>
      'Vicino a una finestra rivolta a est o ovest';

  @override
  String get wizardMediumLight => 'Medio leggero';

  @override
  String get wizardMediumLightDescription => 'A pochi metri da una finestra';

  @override
  String get wizardLowLight => 'Luce scarsa';

  @override
  String get wizardLowLightDescription =>
      'Lontano dalle finestre o sotto la luce artificiale';

  @override
  String get wizardDistanceTitle => 'Distanza dalla finestra';

  @override
  String get wizardDistanceSubtitle =>
      'Seleziona la distanza approssimativa dalla finestra più vicina.';

  @override
  String get wizardMoreThanFiveMeters => 'Più di 5 metri';

  @override
  String get wizardActiveHoursTitle => 'Ore di luce attive';

  @override
  String get wizardActiveHoursSubtitle =>
      'Quante ore di luce diretta o intensa riceve questo spot?';

  @override
  String wizardHour(int count) {
    return '$count ora';
  }

  @override
  String wizardHours(int count) {
    return '$count ore';
  }

  @override
  String get wizardSixPlusHours => '6+ ore';

  @override
  String get wizardRepottedTitle =>
      'Quando è stata rinvasata l\'ultima volta questa pianta?';

  @override
  String get wizardRepottedSubtitle =>
      'Il terreno fresco è fondamentale per una pianta felice.';

  @override
  String get wizardRecently => 'Recentemente (meno di 3 mesi)';

  @override
  String get wizardSixMonthsAgo => '6 mesi fa';

  @override
  String get wizardOneYearAgo => '1 anno fa';

  @override
  String get wizardTwoYearsAgo => '2+ anni fa';

  @override
  String get wizardDontKnow => 'Non lo so';

  @override
  String get wizardPotTitle => 'Di che materiale è il vaso?';

  @override
  String get wizardPotSubtitle =>
      'Il materiale del vaso influisce sulla velocità con cui il terreno si asciuga.';

  @override
  String get wizardPlasticPot => 'Plastica/Asilo nido';

  @override
  String get wizardTerracottaPot => 'Terracotta';

  @override
  String get wizardCeramicPot => 'Ceramica/Smaltata';

  @override
  String get wizardMetalPot => 'Metallo';

  @override
  String get wizardWateredTitle =>
      'Quando hai annaffiato questa pianta l\'ultima volta?';

  @override
  String get wizardWateredSubtitle =>
      'Questo aiuta a calcolare l\'orario esatto della prossima irrigazione.';

  @override
  String get wizardToday => 'Oggi';

  @override
  String get wizardYesterday => 'Ieri';

  @override
  String get wizardFewDaysAgo => 'Qualche giorno fa';

  @override
  String get wizardWeekAgo => 'Una settimana fa';

  @override
  String get wizardMoreWeekAgo => 'Più di una settimana fa';

  @override
  String get historyTitle => 'Cronologia delle ricerche';

  @override
  String get historyClearTitle => 'Cancella cronologia';

  @override
  String get historyClearMessage =>
      'Tutta la cronologia delle ricerche e delle scansioni verrà eliminata. Sei sicuro?';

  @override
  String get historyClearTooltip => 'Cancella cronologia';

  @override
  String get historyEmptyTitle => 'Nessuna cronologia delle ricerche';

  @override
  String get historyEmptySubtitle =>
      'Le piante scansionate con la fotocamera o cercate appariranno qui.';

  @override
  String get historyNoDetails =>
      'Non sono disponibili informazioni dettagliate.';

  @override
  String get historyRegularWater => 'Irrigazione regolare';

  @override
  String get historyIndirectLight => 'Luce indiretta';

  @override
  String get historyDescription => 'Descrizione';

  @override
  String get historyWatering => 'Irrigazione';

  @override
  String get historyLight => 'Luce';

  @override
  String get historyRecently => 'Recentemente';

  @override
  String historyMinutesAgo(int minutes) {
    return '$minutes minuti fa';
  }

  @override
  String historyHoursAgo(int hours) {
    return '$hours ore fa';
  }

  @override
  String get historyYesterday => 'Ieri';

  @override
  String get historyPlantRecord => 'Registro di ricerca delle piante';

  @override
  String get photoWholeSpecimen => 'Foto d\'insieme\npianta o fungo';

  @override
  String get photoWholeSpecimenSubtitle =>
      'Mantenere l\'intero campione centrato nell\'inquadratura per una migliore identificazione.';

  @override
  String get photoCorrect => 'Corretto';

  @override
  String get photoTooClose => 'Troppo vicino';

  @override
  String get photoInstructions => 'Istruzioni';

  @override
  String get photoOpenCamera => 'Ho capito, apri la fotocamera';

  @override
  String get scannerPlant => 'Pianta';

  @override
  String get scannerMushroom => 'Fungo';

  @override
  String get scannerIdentifyingPlant => 'Identificazione della pianta...';

  @override
  String get scannerIdentifyingMushroom => 'Identificazione dei funghi...';

  @override
  String get scannerCapture => 'Scatta foto e scansiona';

  @override
  String get scannerFailed => 'Scansione non riuscita. Per favore riprova.';

  @override
  String scannerError(String error) {
    return 'Si è verificato un errore: $error';
  }

  @override
  String get scannerUnknownPlant => 'Pianta sconosciuta';

  @override
  String get scannerUnknownMushroom => 'Fungo sconosciuto';

  @override
  String get scheduleTitle => 'Programma';

  @override
  String get scheduleTodayTask => 'I compiti di oggi';

  @override
  String get scheduleNoTasks => 'Nessun compito per oggi!';

  @override
  String get scheduleInstructions => 'Istruzioni';

  @override
  String scheduleRequired(String amount) {
    return 'Richiesto: $amount';
  }

  @override
  String get scheduleRemindLater => 'Ricordalo più tardi';

  @override
  String get scheduleDone => 'Fatto';

  @override
  String get scheduleCareFallback => 'Prenditi cura della tua pianta.';

  @override
  String get chatDoctorTitle => 'Dottore delle piante AI';

  @override
  String chatPatient(String name) {
    return 'Paziente: $name';
  }

  @override
  String get chatAnalyzing => 'Analizzando...';

  @override
  String chatHint(String name) {
    return 'Chiedi informazioni su $name...';
  }

  @override
  String chatWelcome(String name) {
    return 'Ciao! 🌿 Sono il tuo Plant Doctor AI. Come posso aiutare con $name?\n\nPosso diagnosticare una foto o rispondere alle tue domande sulla cura.';
  }

  @override
  String chatContinueWelcome(String name) {
    return 'Ciao! Continuiamo con $name. 🌱';
  }

  @override
  String get chatQuestionYellowing => 'Cosa causa le foglie gialle?';

  @override
  String get chatQuestionTreatment => 'Come posso trattare questa pianta?';

  @override
  String get chatQuestionWatering =>
      'Dovrei cambiare la frequenza di irrigazione?';

  @override
  String get chatQuestionFertilizer => 'Quale fertilizzante dovrei usare?';

  @override
  String get chatPhotoSent => 'Foto inviata';

  @override
  String get chatAnalyzePhoto => 'Analizza la foto';

  @override
  String get chatDiagnosisUnknown =>
      'Non è stato possibile determinare la diagnosi';

  @override
  String get chatNoTreatment => 'Nessuna raccomandazione terapeutica';

  @override
  String get chatRecoveryUnknown => 'Sconosciuto';

  @override
  String get chatUnableIdentify => 'Pianta non identificata';

  @override
  String chatError(String error) {
    return 'Spiacenti, si è verificato un errore: $error. Per favore riprova.';
  }

  @override
  String get chatCareTips => 'Consigli per la cura';

  @override
  String get chatPlantLabel => 'Pianta';

  @override
  String get chatDiagnosisLabel => 'Diagnosi';

  @override
  String get chatTreatmentLabel => 'Trattamento';

  @override
  String get chatUrgencyLabel => 'Urgenza';

  @override
  String get chatRecoveryLabel => 'Recupero stimato';

  @override
  String get discoverMonsteraTitle =>
      'Il segreto della crescita della Monstera';

  @override
  String get discoverIndoorPlants => 'Piante da interno';

  @override
  String get discoverSucculentWatering =>
      'Guida all\'irrigazione delle piante grasse';

  @override
  String get discoverCacti => 'Cactus e piante grasse';

  @override
  String get discoverHerbSoil => 'I migliori tipi di terreno per le erbe';

  @override
  String get discoverHerbs => 'Erbe';

  @override
  String get discoverPropagation =>
      'Propagazione 101: un manuale per principianti';

  @override
  String get discoverPests => 'Parassiti comuni e come trattarli';

  @override
  String get discoverRepotting => 'Rinvaso: quando e come?';

  @override
  String discoverMinutesRead(int minutes) {
    return '$minutes lettura minima';
  }

  @override
  String get skip => 'Salta';

  @override
  String get skipForNow => 'Salta per ora';

  @override
  String get continueLabel => 'Continua';

  @override
  String get getStarted => 'Inizia';

  @override
  String get nextStep => 'Passaggio successivo';

  @override
  String get maybeLater => 'Forse più tardi';

  @override
  String get emailAddress => 'Indirizzo e-mail';

  @override
  String get password => 'Parola d\'ordine';

  @override
  String get firstName => 'Nome';

  @override
  String get lastName => 'Cognome';

  @override
  String get login => 'Accedi';

  @override
  String get signUp => 'Iscriviti';

  @override
  String get welcomeBack => 'Bentornato';

  @override
  String get loginSubtitle =>
      'Accedi per continuare a prenderti cura del tuo giardino.';

  @override
  String get signUpSubtitle =>
      'Unisciti a noi e inizia a costruire il tuo santuario verde.';

  @override
  String get forgotPassword => 'Password dimenticata?';

  @override
  String get enterEmailPassword => 'Inserisci la tua email e la password.';

  @override
  String get fillAllFields => 'Si prega di compilare tutti i campi.';

  @override
  String authError(String error) {
    return 'Qualcosa è andato storto: $error';
  }

  @override
  String get loginWith => 'Oppure accedi con';

  @override
  String get signUpWith => 'Oppure registrati con';

  @override
  String get noAccount => 'Non hai un account?';

  @override
  String get alreadyAccount => 'Hai già un account?';

  @override
  String get developerSession => 'Crea sessione sviluppatore';

  @override
  String get welcomeBotaniq => 'Benvenuti a Botaniq';

  @override
  String get loginOptionsSubtitle =>
      'Accedi o registrati per eseguire il backup dei tuoi impianti, orari e preferenze.';

  @override
  String get notificationAccessTitle => 'Da non perdere un\'annaffiatura';

  @override
  String get notificationAccessSubtitle =>
      'Ti ricorderemo dolcemente quando è il momento di prenderti cura dei tuoi amici verdi. La cura delle piante diventa semplice e senza stress.';

  @override
  String get notificationTurnOn => 'Attiva Promemoria';

  @override
  String get creatingClimate => 'Analizzando il tuo microclima...';

  @override
  String get creatingSchedules =>
      'Personalizzazione dei programmi di assistenza...';

  @override
  String get creatingSanctuary => 'Preparare il vostro santuario verde...';

  @override
  String get locationAccessTitle => 'Accesso alla posizione';

  @override
  String get locationAccessSubtitle =>
      'Personalizza la cura delle piante in base al microclima locale.';

  @override
  String get locationRecommendation => 'Raccomandazioni locali';

  @override
  String get locationRecommendationSubtitle =>
      'Piante che prosperano nel clima della tua zona';

  @override
  String get locationWeather => 'Sincronizzazione meteo intelligente';

  @override
  String get locationWeatherSubtitle =>
      'Gli orari si adattano alla pioggia locale in tempo reale';

  @override
  String get locationAlerts => 'Avvisi di gelo e calore';

  @override
  String get locationAlertsSubtitle =>
      'Ricevi una notifica prima che arrivino condizioni meteorologiche estreme';

  @override
  String get locationEnable => 'Abilita l\'accesso alla posizione';

  @override
  String get wherePlantsTitle => 'Dove sono le tue piante?';

  @override
  String get wherePlantsSubtitle =>
      'Seleziona tutto ciò che si applica per personalizzare i tuoi programmi di assistenza.';

  @override
  String get locationIndoor => 'Al coperto';

  @override
  String get locationIndoorSubtitle => 'Soggiorno, camera da letto, ufficio';

  @override
  String get locationBalcony => 'Balcone';

  @override
  String get locationBalconySubtitle =>
      'Piante in vaso su una terrazza o un terrazzo';

  @override
  String get locationGarden => 'Giardino';

  @override
  String get locationGardenSubtitle => 'Piante e aiuole interrate';

  @override
  String get helpTitleBefore => 'Cosa possiamo';

  @override
  String get helpTitleHighlight => 'aiutarti';

  @override
  String get helpTitleAfter => 'con?';

  @override
  String get helpSubtitle =>
      'Seleziona uno o più obiettivi per personalizzare il tuo giardino.';

  @override
  String get helpHeal => 'Guarisci malato\npiante';

  @override
  String get helpCare => 'Cura\npromemoria';

  @override
  String get helpIdentify => 'Identificare\nspecie';

  @override
  String get helpJournal => 'Crescita\ndiario';

  @override
  String get helpOther => 'Qualcos\'altro';

  @override
  String get journeyTitle => 'Il tuo viaggio verde';

  @override
  String get journeySubtitle =>
      'Seleziona il livello di assistenza che desideri fornire.';

  @override
  String get journeyCasualLabel => 'CASUALE';

  @override
  String get journeyCasualTitle => 'Manutenzione ridotta';

  @override
  String get journeyCasualSubtitle =>
      'Voglio solo mantenere vive e prospere le mie piante semplici.';

  @override
  String get journeyEnthusiastLabel => 'ENTUSIASTA';

  @override
  String get journeyEnthusiastTitle => 'Cura equilibrata';

  @override
  String get journeyEnthusiastSubtitle =>
      'Mi piace trascorrere del tempo settimanale con la mia collezione in crescita.';

  @override
  String get journeyObsessedLabel => 'OSSESSIONATO';

  @override
  String get journeyObsessedTitle => 'Straordinario genitore vegetale';

  @override
  String get journeyObsessedSubtitle =>
      'Vivo per le mie piante e desidero programmi esperti per la mia giungla indoor.';

  @override
  String get masteryTitleBefore => 'Come va?';

  @override
  String get masteryTitleHighlight => 'verde\npollice';

  @override
  String get masteryTitleAfter => 'ultimamente?';

  @override
  String get masterySubtitle =>
      'Sii onesto: prima o poi siamo stati tutti \"il serial killer\". Seleziona la tua maestria attuale.';

  @override
  String get masteryKiller => 'Il serial killer';

  @override
  String get masteryKillerSubtitle =>
      'Anche le mie piante di plastica sembrano preoccupate quando entro nella stanza.';

  @override
  String get masteryAccidental => 'Genitore accidentale';

  @override
  String get masteryAccidentalSubtitle =>
      'Il mio cactus è sopravvissuto due settimane. Ci stiamo ancora conoscendo.';

  @override
  String get masteryGrowth => 'Mentalità di crescita';

  @override
  String get masteryGrowthSubtitle =>
      'La maggior parte dei miei amici ha le foglie. Conosco i miei Monsteras dai miei Pothos.';

  @override
  String get masteryWhisperer => 'Sussurratore di piante';

  @override
  String get masteryWhispererSubtitle =>
      'Propago piante rare e parlo fluentemente latino botanico.';

  @override
  String get onboardingOneTitle => 'Abbi cura di te\ndelle tue piante';

  @override
  String get onboardingOneHighlight => 'Come un professionista';

  @override
  String get onboardingOneSubtitle =>
      'Orari intelligenti e identificazione istantanea per la tua giungla urbana.';

  @override
  String get onboardingOneBadge => 'CURA BASATA SULL\'AI';

  @override
  String get onboardingAiScan => 'Scansione AI';

  @override
  String get onboardingSmartWater => 'Acqua intelligente';

  @override
  String get onboardingLightTracking => 'Tracciamento della luce';

  @override
  String get onboardingTwoTitle => 'Identificare qualsiasi\nPianta dentro';

  @override
  String get onboardingTwoHighlight => 'Secondi';

  @override
  String get onboardingTwoSubtitle =>
      'Scatta una foto per conoscerne il nome, la specie e i requisiti di cura.';

  @override
  String get onboardingTwoBadge => 'ESPERTO BOTANICO';

  @override
  String get onboardingSnapPhoto => 'Scatta foto';

  @override
  String get onboardingAccurateResult => 'Risultato accurato';

  @override
  String get onboardingPlantWiki => 'Wiki delle piante';

  @override
  String get onboardingThreeTitle => 'Non dimenticare mai\nAll\'acqua';

  @override
  String get onboardingThreeHighlight => 'Ancora una volta';

  @override
  String get onboardingThreeSubtitle =>
      'Ricevi promemoria programmati in base alle esigenze e all\'ambiente della tua pianta.';

  @override
  String get onboardingThreeBadge => 'PROGRAMMI INTELLIGENTI';

  @override
  String get onboardingReminders => 'Promemoria';

  @override
  String get onboardingClimateData => 'Dati climatici';

  @override
  String get onboardingHealthyGrowth => 'Crescita sana';

  @override
  String get onboardingCommunity =>
      'Unisciti a oltre 50.000 genitori di piante';

  @override
  String get onboardingAgreement =>
      'CONTINUANDO, ACCETTI I NOSTRI TERMINI E LA POLITICA SULLA PRIVACY';

  @override
  String get termsTitle => 'Termini e politiche';

  @override
  String get termsUpdated => 'Ultimo aggiornamento: luglio 2026';

  @override
  String get termsUseTitle => '1. Condizioni d\'uso';

  @override
  String get termsUseBody =>
      'Accedendo o utilizzando Botaniq, accetti le presenti Condizioni d\'uso e le leggi applicabili. Se non sei d\'accordo non potrai utilizzare il servizio.';

  @override
  String get termsPrivacyTitle => '2. Privacy dell\'utente';

  @override
  String get termsPrivacyBody =>
      'Raccogliamo solo i dati personali necessari per fornire programmi di cura delle piante su misura. Non vendiamo i tuoi dati personali a terzi.';

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
  String get termsPlantTitle => '3. Dati dell\'impianto';

  @override
  String get termsPlantBody =>
      'Le informazioni sulla cura, l\'identificazione e la diagnosi delle piante vengono fornite a scopo informativo. I risultati dell\'intelligenza artificiale potrebbero non essere sempre corretti, quindi osserva la tua pianta e cerca un esperto per rischi gravi.';

  @override
  String get termsLiabilityTitle => '6. Disclaimers, Liability, and Indemnity';

  @override
  String get termsLiabilityBody =>
      'Botaniq is provided \"as is\" and \"as available,\" without warranties of any kind, express or implied, including accuracy, reliability, or fitness for a particular purpose. To the fullest extent permitted by law, we and our service providers are not liable for any indirect, incidental, special, or consequential damages, or for any loss of data, plants, or property arising from your use of the service, and our total liability for any claim is limited to the amount you paid us, if any, in the twelve months before the claim. You agree to indemnify and hold us harmless from claims arising from your use of the service, your content, or your violation of these Terms or applicable law.';

  @override
  String get termsPremiumTitle => '4. Abbonamenti Premium';

  @override
  String get termsPremiumBody =>
      'Il tuo abbonamento Premium mensile o annuale viene addebitato sul tuo account Apple o Google dopo la conferma dell\'acquisto. Si rinnova automaticamente salvo disdetta almeno 24 ore prima della fine del periodo corrente. Puoi gestirlo o annullarlo nelle impostazioni dell\'account del tuo negozio. Le richieste di rimborso vengono gestite in base alla politica del negozio applicabile.';

  @override
  String get termsLawTitle => '8. Governing Law and Changes';

  @override
  String get termsLawBody =>
      'These Terms are governed by the laws of the jurisdiction in which we operate, without regard to conflict-of-law principles, and any dispute will be resolved under that jurisdiction\'s applicable procedures to the fullest extent permitted by law. We may update these Terms and our data practices at any time by posting the revised version in the app.';

  @override
  String get termsClosing => 'Goditi la tranquillità e piante più felici.';

  @override
  String get weatherTitle => 'Meteo';

  @override
  String get weatherSunnyTip =>
      'Oggi c\'è il sole: controlla il terreno prima di annaffiare.';

  @override
  String get weatherCloudyTip =>
      'Il tempo nuvoloso rallenta l\'evaporazione; annaffiare un po\' meno.';

  @override
  String get weatherRainyTip =>
      'Piovoso e umido: evita di annaffiare eccessivamente le piante da esterno.';

  @override
  String get weatherStormTip =>
      'Tempo tempestoso: sposta i vasi delicati in un luogo riparato.';

  @override
  String get weatherSnowTip =>
      'Freddo e neve: proteggi le piante dagli shock termici.';
}
