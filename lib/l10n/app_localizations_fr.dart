// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Botaniq';

  @override
  String get settings => 'Paramètres';

  @override
  String get preferences => 'Préférences';

  @override
  String get darkMode => 'Mode sombre';

  @override
  String get metricSystem => 'Système métrique';

  @override
  String get metricSystemSubtitle =>
      'Utiliser des degrés Celsius et des mètres';

  @override
  String get account => 'Compte';

  @override
  String get editProfile => 'Modifier le profil';

  @override
  String get changePassword => 'Changer le mot de passe';

  @override
  String get subscriptionManagement => 'Gestion des abonnements';

  @override
  String get premium => 'Prime';

  @override
  String get language => 'Langue';

  @override
  String get languageSubtitle => 'Changer la langue de l\'application';

  @override
  String get selectLanguage => 'Sélectionnez la langue';

  @override
  String get systemLanguage => 'Langue du système';

  @override
  String get english => 'Anglais';

  @override
  String get turkish => 'Turc';

  @override
  String get languageChanged => 'La langue a changé avec succès.';

  @override
  String get languageSearchHint => 'Langues de recherche';

  @override
  String get languageRecommended => 'Recommandé';

  @override
  String get languageWelcomeTitle => 'Choisissez votre langue';

  @override
  String get languageWelcomeSubtitle =>
      'Sélectionnez la langue que vous souhaitez utiliser dans Botaniq. Vous pouvez le modifier à tout moment.';

  @override
  String get languageUseSystem => 'Utiliser la langue de l\'appareil';

  @override
  String get preferenceSystem => 'Utiliser les paramètres du système';

  @override
  String get themeLight => 'Lumière';

  @override
  String get themeDark => 'Sombre';

  @override
  String get themeSelectionTitle => 'Choisissez l\'apparence';

  @override
  String get measurementMetric => 'Métrique';

  @override
  String get measurementImperial => 'Impérial';

  @override
  String get measurementSelectionTitle => 'Choisissez le système de mesure';

  @override
  String get settingsSubtitle =>
      'Façonnez Botaniq selon votre propre rythme de soins.';

  @override
  String get settingsLocalPreference => 'Enregistré sur cet appareil';

  @override
  String get settingsDarkModeSubtitle =>
      'Une palette plus calme pour les moments de faible luminosité';

  @override
  String get settingsAccountSubtitle => 'Identité, accès et adhésion';

  @override
  String get settingsEditProfileSubtitle =>
      'Nom, emplacement et préférences de soins';

  @override
  String get settingsPasswordSubtitle =>
      'Envoyez un lien de réinitialisation sécurisé à votre adresse e-mail';

  @override
  String get settingsSubscriptionSubtitle =>
      'Forfait Premium et détails de facturation';

  @override
  String get settingsPasswordResetSent =>
      'E-mail de réinitialisation du mot de passe envoyé.';

  @override
  String get settingsComingSoon => 'Cet espace continue de croître.';

  @override
  String get subscriptionPageTitle => 'Abonnement Premium';

  @override
  String get subscriptionHeroEyebrow => 'BOTANIQ PREMIUM';

  @override
  String get subscriptionHeroTitle =>
      'Des soins plus intelligents pour chaque plante';

  @override
  String get subscriptionHeroSubtitle =>
      'Débloquez tous les outils d\'entretien haut de gamme et développez votre espace vert en toute confiance.';

  @override
  String get subscriptionBenefitsTitle => 'Tout en Premium';

  @override
  String get subscriptionBenefitIdentification =>
      'Identification illimitée des plantes et analyse de leur état de santé';

  @override
  String get subscriptionBenefitCare =>
      'Plans de soins personnalisés et rappels';

  @override
  String get subscriptionBenefitInsights =>
      'Contenu expert et informations avancées sur les soins';

  @override
  String get subscriptionMonthlyPlan => 'Mensuel';

  @override
  String get subscriptionAnnualPlan => 'Annuel';

  @override
  String subscriptionPerMonth(String price) {
    return '$price / mois';
  }

  @override
  String subscriptionPerYear(String price) {
    return '$price / an';
  }

  @override
  String get subscriptionBestValue => 'MEILLEURE VALEUR';

  @override
  String subscriptionSavePercent(int percent) {
    return 'Économisez $percent%';
  }

  @override
  String get subscriptionContinue => 'Débloquez la prime';

  @override
  String get subscriptionRestorePurchases => 'Restaurer les achats';

  @override
  String get subscriptionRestoring => 'Restauration...';

  @override
  String get subscriptionManage => 'Gérer l\'abonnement';

  @override
  String get subscriptionActiveTitle => 'Votre abonnement Premium est actif';

  @override
  String get subscriptionActiveSubtitle =>
      'Vous avez accès à toutes les fonctionnalités premium.';

  @override
  String subscriptionRenewsOn(String date) {
    return 'Renouvelle le $date';
  }

  @override
  String subscriptionExpiresOn(String date) {
    return 'Actif jusqu\'au $date';
  }

  @override
  String get subscriptionAutoRenewDisclosure =>
      'Le paiement est débité de votre compte Apple ou Google. L\'abonnement se renouvelle automatiquement sauf annulation au moins 24 heures avant la fin de la période en cours. Vous pouvez le gérer ou l\'annuler à tout moment dans les paramètres de votre compte de boutique.';

  @override
  String get subscriptionTermsLink => 'Conditions d\'utilisation';

  @override
  String get subscriptionPrivacyLink => 'Politique de confidentialité';

  @override
  String get subscriptionPurchaseSuccess =>
      'Votre abonnement Premium est désormais actif.';

  @override
  String get subscriptionRestoreSuccess =>
      'Votre abonnement Premium a été restauré.';

  @override
  String get subscriptionNothingToRestore =>
      'Aucun abonnement actif n\'a été trouvé pour ce compte de magasin.';

  @override
  String get subscriptionPaymentPending =>
      'Le paiement est en attente de l\'approbation du magasin. Votre adhésion s\'activera automatiquement une fois approuvée.';

  @override
  String get subscriptionErrorGeneric =>
      'L\'opération n\'a pas pu être complétée. Veuillez réessayer.';

  @override
  String get subscriptionErrorNetwork =>
      'Vérifiez votre connexion Internet et réessayez.';

  @override
  String get subscriptionErrorNotAllowed =>
      'Cet appareil ou ce compte de magasin n\'est pas autorisé à effectuer des achats.';

  @override
  String get subscriptionErrorStore =>
      'Le magasin n\'a pas pu être atteint. Veuillez réessayer sous peu.';

  @override
  String get subscriptionMissingConfiguration =>
      'La clé RevenueCat est absente de cette version.';

  @override
  String get subscriptionUnsupported =>
      'Les abonnements sont disponibles uniquement dans les applications iOS et Android.';

  @override
  String get subscriptionProductsUnavailable =>
      'Les produits mensuels et annuels n\'ont pas pu être chargés. Vérifiez la configuration de l’offre RevenueCat.';

  @override
  String get subscriptionRetry => 'Réessayez';

  @override
  String get subscriptionFree => 'Gratuit';

  @override
  String get homeGoodMorning => 'Bonjour,';

  @override
  String homePersonalGreeting(String greeting, String name) {
    return '$greeting, $name 👋';
  }

  @override
  String get homeEmptyGarden => 'Votre jardin est vide';

  @override
  String get homeEmptyGardenSubtitle =>
      'Commencez à construire votre sanctuaire vert\nen ajoutant votre première plante.';

  @override
  String get homeAddFirstPlant => 'Ajouter la première plante';

  @override
  String get homeMyPlants => 'Mes plantes';

  @override
  String get homeViewAll => 'Tout afficher';

  @override
  String get homeSmartCareReminders => 'Rappels de soins intelligents';

  @override
  String get homeWatering => 'Arrosage';

  @override
  String get homeWateringSubtitle => 'Suivi du sol';

  @override
  String get homeFertilizing => 'Fertilisation';

  @override
  String get homeFertilizingSubtitle => 'Alertes nutritionnelles';

  @override
  String get gardenTitle => 'Mon jardin';

  @override
  String get gardenAllPlants => 'Toutes les plantes';

  @override
  String get gardenNeedsWater => 'A besoin d\'eau';

  @override
  String get gardenIndoor => 'Intérieur';

  @override
  String get gardenNoPlants =>
      'Pas encore de plantes.\nAppuyez sur + pour ajouter votre première plante !';

  @override
  String get gardenNoPlantsCategory => 'Aucune plante dans cette catégorie.';

  @override
  String get discoverTitle => 'Découvrez';

  @override
  String get discoverSearchHint =>
      'Rechercher des plantes, des articles, des guides...';

  @override
  String get discoverLatestArticles => 'Derniers articles';

  @override
  String get discoverSeeAll => 'Voir tout';

  @override
  String get discoverTrendingGuides => 'Guides des tendances';

  @override
  String get healthyTitle => 'Centre de soins';

  @override
  String get healthySubtitle => 'Touchez l\'âme de vos plantes, parlez-leur.';

  @override
  String get healthyTabDoctor => 'Docteur';

  @override
  String get healthyTabHospital => 'Hôpital';

  @override
  String get healthyTabDiscover => 'Découvrez';

  @override
  String get profileTitle => 'Mon profil';

  @override
  String get profileEditProfile => 'Modifier le profil';

  @override
  String get profileOverview => 'Aperçu';

  @override
  String get profileSettingsTab => 'Paramètres';

  @override
  String get profileGardenerLevel => 'Niveau Jardinier';

  @override
  String get profileTotalPlants => 'Total des usines';

  @override
  String get profileCompletedTasks => 'Tâches terminées';

  @override
  String get profileWeeklyActivity => 'Activité de soins hebdomadaire';

  @override
  String get profileGeneral => 'Général';

  @override
  String get profileAppSettings => 'Paramètres de l\'application';

  @override
  String get profileNotificationPrefs => 'Préférences de notifications';

  @override
  String get profileSupportLegal => 'Assistance et informations juridiques';

  @override
  String get profileHelpCenter => 'Centre d\'aide';

  @override
  String get profileTerms => 'Conditions d\'utilisation et politiques';

  @override
  String get profileSignOut => 'Se déconnecter';

  @override
  String get profileDeleteAccount => 'Supprimer le compte';

  @override
  String get profileSubtitle =>
      'L\'histoire de votre jardin, vos progrès et votre espace personnel.';

  @override
  String get profileGardenPassport => 'PASSEPORT JARDIN';

  @override
  String get profileThisWeek => 'Cette semaine';

  @override
  String get profileQuietWeek =>
      'Une semaine tranquille – votre prochain moment de soins apparaîtra ici.';

  @override
  String get profileActiveWeek =>
      'Votre rythme de soins est vivant et en croissance.';

  @override
  String get profileAppSettingsSubtitle => 'Langue, unités et connexion IA';

  @override
  String get profileNotificationPrefsSubtitle =>
      'Choisissez les moments de soins qui vous parviennent';

  @override
  String get profileHelpCenterSubtitle => 'Réponses et conseils rapides';

  @override
  String get profileTermsSubtitle =>
      'Confidentialité, conditions et politiques';

  @override
  String get profileAccountActions => 'Actions du compte';

  @override
  String get profileSignOutQuestion =>
      'Êtes-vous sûr de vouloir vous déconnecter ?';

  @override
  String get profileDeleteAccountWarning =>
      'La suppression du compte nécessite une confirmation sécurisée côté serveur. Vos données n\'ont pas été modifiées.';

  @override
  String get cancel => 'Annuler';

  @override
  String get continueAction => 'Continuer';

  @override
  String get profileTitleNew => 'Nouveau jardinier 🌱';

  @override
  String get profileTitleSprout => 'Ami germe 🌿';

  @override
  String get profileTitleLeaf => 'Amoureux des feuilles ☘️';

  @override
  String get profileTitleSkilled => 'Jardinier qualifié 🏡';

  @override
  String get profileTitleMaster => 'Maître à la main verte 👑';

  @override
  String get profileNextLevelStart =>
      'Ajoutez votre première plante et commencez votre aventure de jardinage !';

  @override
  String profileNextLevelLeaf(int count) {
    return 'Il ne reste plus que les plantes $count pour devenir Leaf Lover.';
  }

  @override
  String profileNextLevelSkilled(int count) {
    return 'Il ne reste plus que les plantes $count pour devenir jardinier qualifié.';
  }

  @override
  String profileNextLevelMaster(int count) {
    return 'Il ne reste plus que les plantes $count pour devenir Green Thumb Master.';
  }

  @override
  String get profileNextLevelMax =>
      'Vous êtes au sommet de votre jardin, félicitations !';

  @override
  String get navHome => 'Accueil';

  @override
  String get navGarden => 'Jardin';

  @override
  String get navClinic => 'Clinique';

  @override
  String get navProfile => 'Profil';

  @override
  String get scanPlant => 'Usine de numérisation';

  @override
  String get deletePlantTitle => 'Supprimer cette plante ?';

  @override
  String get deletePlantMessage =>
      'L\'usine, ses tâches de soins et les dossiers de la clinique seront définitivement supprimés de votre compte.';

  @override
  String get deletePlantAction => 'Supprimer la plante';

  @override
  String get deletePlantNotFound =>
      'La plante est introuvable ou a déjà été supprimée.';

  @override
  String deletePlantError(String error) {
    return 'La plante n\'a pas pu être supprimée : $error';
  }

  @override
  String get profileChoosePhoto => 'Choisissez une photo de profil';

  @override
  String get profileFullName => 'Nom complet';

  @override
  String get profileFullNameHint => 'Entrez votre nom complet';

  @override
  String get profileNickname => 'Surnom';

  @override
  String get profileNicknameHint => 'Comment devrions-nous vous appeler ?';

  @override
  String get profileAge => 'Âge';

  @override
  String get profileAgeHint => '1 à 120';

  @override
  String get profileAgeValidation =>
      'Veuillez saisir un âge compris entre 1 et 120.';

  @override
  String profileLoadError(String error) {
    return 'Impossible de charger le profil : $error';
  }

  @override
  String get languageEnglish => 'Anglais';

  @override
  String get languageTurkish => 'Turc';

  @override
  String get profileEmailReadOnly => 'Adresse e-mail (lecture seule)';

  @override
  String get profileEmailHint => 'Entrez votre email';

  @override
  String get profileLocation => 'Emplacement';

  @override
  String get profileLocationHint => 'Ville, Pays';

  @override
  String get profileSaveChanges => 'Enregistrer les modifications';

  @override
  String get profileUpdated => 'Votre profil a été mis à jour.';

  @override
  String profileSaveError(String error) {
    return 'Le profil n\'a pas pu être enregistré : $error';
  }

  @override
  String get notificationWateringTitle => 'Rappels d\'arrosage';

  @override
  String get notificationWateringSubtitle =>
      'Soyez averti quand il est temps d’arroser';

  @override
  String get notificationFertilizerTitle => 'Rappels d\'engrais';

  @override
  String get notificationFertilizerSubtitle =>
      'Alertes d\'alimentation saisonnières pour vos plantes';

  @override
  String get notificationTitle => 'Notifications';

  @override
  String get notificationPlantCareAlerts =>
      'Alertes relatives à l\'entretien des plantes';

  @override
  String get notificationOther => 'Autres notifications';

  @override
  String get notificationWeatherTitle => 'Alertes météo';

  @override
  String get notificationWeatherSubtitle =>
      'Avertissements de conditions météorologiques extrêmes';

  @override
  String get notificationArticlesTitle => 'Nouveaux articles';

  @override
  String get notificationArticlesSubtitle =>
      'Trucs et astuces pour votre jardin';

  @override
  String get gardenMyPlantFallback => 'Ma plante';

  @override
  String get gardenClinicBadge => 'En clinique';

  @override
  String get wateringNever => 'Dernier arrosage : Jamais';

  @override
  String wateringLastDate(String date) {
    return 'Dernier arrosage : $date';
  }

  @override
  String wateringInterval(int days) {
    return 'Tous les $days jours';
  }

  @override
  String get wateringNeverDue => 'Pas encore arrosé • Arroser aujourd\'hui';

  @override
  String wateringOverdue(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days jours de retard',
      one: '1 jour de retard',
      zero: 'Arroser aujourd’hui',
    );
    return '$_temp0';
  }

  @override
  String get wateringDueToday => 'L\'eau aujourd\'hui';

  @override
  String get wateringDueTomorrow => 'Arroser demain';

  @override
  String wateringDueInDays(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'Arroser dans $days jours',
      one: 'Arroser dans 1 jour',
      zero: 'Arroser aujourd’hui',
    );
    return '$_temp0';
  }

  @override
  String get plantUnknown => 'Plante inconnue';

  @override
  String get plantSpeciesFallback => 'Espèces végétales';

  @override
  String get plantDifficultyMedium => 'Moyen';

  @override
  String get plantAbout => 'À propos';

  @override
  String get plantLocationEnvironment => 'Emplacement et environnement';

  @override
  String get plantCareProtocol => 'Protocole de soins';

  @override
  String get plantCareHistory => 'Historique de soins des 10 derniers jours';

  @override
  String get plantHealthy => 'Sain';

  @override
  String get plantInClinic => 'En clinique';

  @override
  String get plantDifficulty => 'Difficulté';

  @override
  String get plantToxicity => 'Toxicité';

  @override
  String get plantEnvironment => 'Environnement';

  @override
  String get plantLightNeed => 'Besoin de lumière';

  @override
  String get plantToxicPets => 'Toxique pour les animaux de compagnie';

  @override
  String get plantNonToxic => 'Non toxique';

  @override
  String get plantIndoor => 'Intérieur';

  @override
  String get plantBrightIndirect => 'Lumineux indirect';

  @override
  String get plantInfoUnavailable =>
      'Les informations vérifiées ne sont pas encore disponibles.';

  @override
  String get plantIdealClimate => 'Climat idéal';

  @override
  String get plantHumidity => 'Humidité';

  @override
  String get plantTemperatureRange => 'Plage de température';

  @override
  String get plantWateringFrequency => 'Fréquence d\'arrosage';

  @override
  String plantWateringFrequencyValue(String interval) {
    return 'Eau $interval.';
  }

  @override
  String get plantNextWatering => 'Arrosage suivant';

  @override
  String get plantWateringProtocol => 'Protocole d\'arrosage';

  @override
  String get plantSoilProtocol => 'Sol';

  @override
  String get plantFeedingProtocol => 'Protocole d\'alimentation';

  @override
  String get plantPruningCleaning => 'Taille et nettoyage';

  @override
  String get plantPruningFallback =>
      'Essuyez les feuilles mensuellement. Taillez les feuilles mortes ou jaunies pour favoriser la croissance.';

  @override
  String get plantHistoryEmpty =>
      'Aucun historique de soins au cours des 10 derniers jours.';

  @override
  String get plantWateringTask => 'Arrosage';

  @override
  String get plantFertilizingTask => 'Fertilisation';

  @override
  String get plantWateredAction => 'Arrosé ✓';

  @override
  String get plantWaterNowAction => 'Arrosez maintenant';

  @override
  String get plantFertilizedAction => 'Fertilisé ✓';

  @override
  String get plantFertilizeAction => 'Fertiliser';

  @override
  String get plantAddGardenAction => 'Ajouter à mon jardin';

  @override
  String get plantWaterSuccess =>
      '💧 Vous avez arrosé votre plante ! Super travail !';

  @override
  String get plantFertilizeSuccess =>
      '🌱 Engrais ajouté ! Votre plante vous dit merci !';

  @override
  String plantWaterError(String error) {
    return 'L\'arrosage n\'a pas pu être enregistré : $error';
  }

  @override
  String plantFertilizeError(String error) {
    return 'La fertilisation n\'a pas pu être enregistrée : $error';
  }

  @override
  String get clinicQuickTools => 'Outils rapides';

  @override
  String get clinicDoctorHero => 'Médecin des plantes IA\nÀ votre service';

  @override
  String get clinicStartConsultation => 'Commencer la consultation';

  @override
  String get clinicChoosePlant => 'De quelle plante souhaiteriez-vous parler ?';

  @override
  String get clinicChoosePlantSubtitle =>
      'Choisissez une plante de votre jardin ou prenez une nouvelle photo.';

  @override
  String get clinicNoGardenPlants =>
      'Il n\'y a pas encore de plantes dans votre jardin.\nCommencez par prendre une nouvelle photo.';

  @override
  String get clinicNewPhoto => 'Prendre une nouvelle photo';

  @override
  String get clinicNewPhotoSubtitle =>
      'Photographiez la plante malade et obtenez un diagnostic';

  @override
  String get clinicPestAnalysis => 'Analyse des ravageurs';

  @override
  String get clinicVisualDiagnosis => 'Diagnostic visuel';

  @override
  String get clinicLightMeter => 'Photomètre';

  @override
  String get clinicSensorSimulation => 'Simulation de capteur';

  @override
  String get clinicTitle => 'Clinique des Plantes';

  @override
  String clinicSickCount(int count) {
    return '$count Malade';
  }

  @override
  String get clinicAllHealthy => 'Toutes vos plantes sont en bonne santé ! 🌿';

  @override
  String get clinicEmpty =>
      'Il n’y a aucune plante malade à la Clinique.\nSi vous êtes préoccupé par une plante,\ndemandez depuis l’onglet Médecin.';

  @override
  String get clinicUnknown => 'Inconnu';

  @override
  String get clinicPendingDiagnosis => 'En attente du diagnostic';

  @override
  String get clinicNoTreatment => 'Le traitement n\'a pas été déterminé';

  @override
  String get clinicPrescription => 'Ordonnance :';

  @override
  String get clinicRecovery => 'Récupération';

  @override
  String get clinicRecovered => 'Récupéré';

  @override
  String get clinicContinue => 'Continuer';

  @override
  String get clinicRecoveredSuccess =>
      '🎉Votre plante est à nouveau en bonne santé !';

  @override
  String get clinicUrgencyLow => 'Faible';

  @override
  String get clinicUrgencyMedium => 'Moyen';

  @override
  String get clinicUrgencyCritical => 'Critique';

  @override
  String get healthTrendingTips => 'Conseils de santé tendance';

  @override
  String get healthHumidityArticleTitle =>
      'Préparation hivernale : maintenir un taux d\'humidité équilibré';

  @override
  String get healthHumidityArticleSubtitle =>
      'Comment protéger vos plantes de l’air sec des radiateurs pendant les mois froids.';

  @override
  String get healthWeeklySpotlight => 'Patient et remède de la semaine';

  @override
  String get healthAphidTitle => 'Infestation de pucerons';

  @override
  String get healthAphidSubtitle =>
      'Intervention précoce et traitement naturel à l\'huile de Neem.';

  @override
  String get healthDiscoverLoadError =>
      'Le contenu de découverte n\'a pas pu être chargé pour le moment. Tirez vers le bas pour réessayer.';

  @override
  String get healthDiscoverEmpty =>
      'Il n’y a pas encore de contenu de découverte publié.';

  @override
  String get healthDiscoverRetry => 'Réessayez';

  @override
  String get lightMeterTitle => 'Photomètre';

  @override
  String get lightMeterInstructionTitle => 'Pour mesurer la lumière';

  @override
  String get lightMeterInstruction =>
      'Pointez la caméra avant du téléphone vers\nla position de la plante et la source de lumière.';

  @override
  String get lightMeterCameraEstimate =>
      'Lux approximatif calculé à partir des données de la caméra';

  @override
  String get lightMeterStabilizing => 'Mesure stabilisante';

  @override
  String get lightMeterStabilizingRecommendation =>
      'Maintenez le téléphone stable pendant quelques secondes pendant que les changements brusques d\'exposition sont filtrés.';

  @override
  String get lightMeterUnavailable => 'Mesure indisponible';

  @override
  String get lightMeterUnavailableRecommendation =>
      'Activez l\'autorisation de la caméra et réessayez cet écran.';

  @override
  String get lightLow => 'Faible luminosité (ombre)';

  @override
  String get lightMedium => 'Lumière moyenne (pièce lumineuse)';

  @override
  String get lightHigh => 'Lumière élevée (près de la fenêtre)';

  @override
  String get lightVeryHigh => 'Très haute luminosité (soleil direct)';

  @override
  String get lightLowRecommendation =>
      'Convient aux Calathea, aux fougères ou aux plantes serpent.';

  @override
  String get lightMediumRecommendation =>
      'Idéal pour Monstera, Ficus et Anthurium.';

  @override
  String get lightHighRecommendation =>
      'Convient aux aloès, cactus et géraniums qui aiment le soleil.';

  @override
  String get lightVeryHighRecommendation =>
      'Idéal pour les plantes d’extérieur et les plantes succulentes.';

  @override
  String get homeLoadingPlants => 'Chargement des plantes...';

  @override
  String get homeNotifications => 'Notifications';

  @override
  String get homeWateringTime => 'Temps d\'arrosage';

  @override
  String get homeWateringNotification =>
      'Vos plantes d\'intérieur ont besoin d\'être arrosées.';

  @override
  String get homeWelcome => 'Bienvenue !';

  @override
  String get homeWelcomeNotification =>
      'Bienvenue chez Botaniq. Commencez par ajouter votre première plante.';

  @override
  String get homeTenMinutesAgo => 'il y a 10 minutes';

  @override
  String get homeOneDayAgo => 'il y a 1 jour';

  @override
  String get homeQuickActions => 'Actions rapides';

  @override
  String get homeIdentifyCamera => 'Identifiez-vous avec votre caméra';

  @override
  String get homeTomorrow => 'Demain';

  @override
  String get homeNoTasks => 'Aucune tâche pour cette journée !';

  @override
  String get homeAllCared => 'Vos plantes sont toutes prises en charge 🌿';

  @override
  String get homeOverdue => 'EN RETARD';

  @override
  String get homeInstructions => 'Instructions';

  @override
  String homeRequiredAmount(String amount) {
    return 'Obligatoire : $amount';
  }

  @override
  String get homeLater => 'Plus tard';

  @override
  String get homeMarkDone => 'Marquer comme terminé';

  @override
  String get homeSickPlants => 'Clinique des Plantes';

  @override
  String homeSickCount(int count) {
    return '$count Malade';
  }

  @override
  String get homeGreetingMorning => 'Bonjour';

  @override
  String get homeGreetingAfternoon => 'Bon après-midi';

  @override
  String get homeGreetingEvening => 'Bonsoir';

  @override
  String get homeTodayTasks => 'Les tâches du jour';

  @override
  String get homeTomorrowTasks => 'Les tâches de demain';

  @override
  String homeDateTasks(String date) {
    return '$date Tâches';
  }

  @override
  String get commonSkip => 'Sauter';

  @override
  String get commonContinue => 'Continuer';

  @override
  String get commonClose => 'Fermer';

  @override
  String get commonDelete => 'Supprimer';

  @override
  String get commonBack => 'Retourner';

  @override
  String get commonUnknown => 'Inconnu';

  @override
  String get wizardSaveGarden => 'Enregistrer et ajouter au jardin';

  @override
  String wizardPlantAdded(String name) {
    return '$name a été ajouté à votre jardin ! 🌿';
  }

  @override
  String get wizardRoomTitle => 'Où est ta plante ?';

  @override
  String get wizardRoomSubtitle =>
      'Classez votre plante par pièce pour la gérer facilement.';

  @override
  String get wizardLivingRoom => 'Salon';

  @override
  String get wizardBedroom => 'Chambre à coucher';

  @override
  String get wizardKitchen => 'Cuisine';

  @override
  String get wizardOffice => 'Bureau';

  @override
  String get wizardBathroom => 'Salle de bain';

  @override
  String get wizardBalcony => 'Balcon';

  @override
  String get wizardLightTitle => 'Comment est la lumière à cet endroit ?';

  @override
  String get wizardLightSubtitle =>
      'La lumière est l’un des facteurs les plus importants pour la santé de vos plantes.';

  @override
  String get wizardDirectSun => 'Soleil Direct';

  @override
  String get wizardDirectSunDescription =>
      'Lumière du soleil non filtrée directement sur la plante';

  @override
  String get wizardBrightIndirect => 'Lumineux indirect';

  @override
  String get wizardBrightIndirectDescription =>
      'Près d\'une fenêtre orientée à l\'est ou à l\'ouest';

  @override
  String get wizardMediumLight => 'Lumière moyenne';

  @override
  String get wizardMediumLightDescription => 'A quelques mètres d\'une fenêtre';

  @override
  String get wizardLowLight => 'Faible luminosité';

  @override
  String get wizardLowLightDescription =>
      'Loin des fenêtres ou sous une lumière artificielle';

  @override
  String get wizardDistanceTitle => 'Distance à la fenêtre';

  @override
  String get wizardDistanceSubtitle =>
      'Sélectionnez la distance approximative jusqu\'à la fenêtre la plus proche.';

  @override
  String get wizardMoreThanFiveMeters => 'Plus de 5 m';

  @override
  String get wizardActiveHoursTitle => 'Heures de lumière active';

  @override
  String get wizardActiveHoursSubtitle =>
      'Combien d\'heures de lumière directe ou vive ce spot reçoit-il ?';

  @override
  String wizardHour(int count) {
    return '$count heure';
  }

  @override
  String wizardHours(int count) {
    return '$count heures';
  }

  @override
  String get wizardSixPlusHours => '6+ heures';

  @override
  String get wizardRepottedTitle =>
      'Quand cette plante a-t-elle été rempotée pour la dernière fois ?';

  @override
  String get wizardRepottedSubtitle =>
      'Un sol frais est crucial pour une plante heureuse.';

  @override
  String get wizardRecently => 'Récemment (moins de 3 mois)';

  @override
  String get wizardSixMonthsAgo => 'il y a 6 mois';

  @override
  String get wizardOneYearAgo => 'il y a 1 an';

  @override
  String get wizardTwoYearsAgo => 'il y a + de 2 ans';

  @override
  String get wizardDontKnow => 'je ne sais pas';

  @override
  String get wizardPotTitle => 'De quelle matière est le pot ?';

  @override
  String get wizardPotSubtitle =>
      'Le matériau du pot affecte la rapidité avec laquelle le sol sèche.';

  @override
  String get wizardPlasticPot => 'Plastique / Pépinière';

  @override
  String get wizardTerracottaPot => 'Terre cuite';

  @override
  String get wizardCeramicPot => 'Céramique / Vitrée';

  @override
  String get wizardMetalPot => 'Métal';

  @override
  String get wizardWateredTitle =>
      'Quand avez-vous arrosé cette plante pour la dernière fois ?';

  @override
  String get wizardWateredSubtitle =>
      'Cela permet de calculer exactement la prochaine heure d’arrosage.';

  @override
  String get wizardToday => 'Aujourd\'hui';

  @override
  String get wizardYesterday => 'Hier';

  @override
  String get wizardFewDaysAgo => 'Il y a quelques jours';

  @override
  String get wizardWeekAgo => 'Il y a une semaine';

  @override
  String get wizardMoreWeekAgo => 'Il y a plus d\'une semaine';

  @override
  String get historyTitle => 'Historique de recherche';

  @override
  String get historyClearTitle => 'Effacer l\'historique';

  @override
  String get historyClearMessage =>
      'Tout l’historique de recherche et d’analyse sera supprimé. Es-tu sûr?';

  @override
  String get historyClearTooltip => 'Effacer l\'historique';

  @override
  String get historyEmptyTitle => 'Aucun historique de recherche';

  @override
  String get historyEmptySubtitle =>
      'Les plantes scannées avec l\'appareil photo ou recherchées apparaîtront ici.';

  @override
  String get historyNoDetails =>
      'Les informations détaillées ne sont pas disponibles.';

  @override
  String get historyRegularWater => 'Arrosage régulier';

  @override
  String get historyIndirectLight => 'Lumière indirecte';

  @override
  String get historyDescription => 'Descriptif';

  @override
  String get historyWatering => 'Arrosage';

  @override
  String get historyLight => 'Lumière';

  @override
  String get historyRecently => 'Récemment';

  @override
  String historyMinutesAgo(int minutes) {
    return 'il y a $minutes min';
  }

  @override
  String historyHoursAgo(int hours) {
    return 'Il y a $hours heures';
  }

  @override
  String get historyYesterday => 'Hier';

  @override
  String get historyPlantRecord => 'Enregistrement de recherche de plantes';

  @override
  String get photoWholeSpecimen => 'Photo de l\'ensemble\nplante ou champignon';

  @override
  String get photoWholeSpecimenSubtitle =>
      'Gardez l’ensemble du spécimen centré dans le cadre pour une meilleure identification.';

  @override
  String get photoCorrect => 'Correct';

  @override
  String get photoTooClose => 'Trop proche';

  @override
  String get photoInstructions => 'Instructions';

  @override
  String get photoOpenCamera => 'Je comprends, ouvre la caméra';

  @override
  String get scannerPlant => 'Plante';

  @override
  String get scannerMushroom => 'Champignon';

  @override
  String get scannerIdentifyingPlant => 'Identifier une plante...';

  @override
  String get scannerIdentifyingMushroom => 'Identifier les champignons...';

  @override
  String get scannerCapture => 'Prendre une photo et numériser';

  @override
  String get scannerFailed => 'L\'analyse a échoué. Veuillez réessayer.';

  @override
  String scannerError(String error) {
    return 'Une erreur s\'est produite : $error';
  }

  @override
  String get scannerUnknownPlant => 'Plante inconnue';

  @override
  String get scannerUnknownMushroom => 'Champignon inconnu';

  @override
  String get scheduleTitle => 'Calendrier';

  @override
  String get scheduleTodayTask => 'Les tâches du jour';

  @override
  String get scheduleNoTasks => 'Aucune tâche pour aujourd\'hui !';

  @override
  String get scheduleInstructions => 'Instructions';

  @override
  String scheduleRequired(String amount) {
    return 'Obligatoire : $amount';
  }

  @override
  String get scheduleRemindLater => 'Rappeler plus tard';

  @override
  String get scheduleDone => 'Terminé';

  @override
  String get scheduleCareFallback => 'Prenez soin de votre plante.';

  @override
  String get chatDoctorTitle => 'Médecin des plantes IA';

  @override
  String chatPatient(String name) {
    return 'Patient : $name';
  }

  @override
  String get chatAnalyzing => 'Analyser...';

  @override
  String chatHint(String name) {
    return 'Renseignez-vous sur $name...';
  }

  @override
  String chatWelcome(String name) {
    return 'Bonjour ! 🌿 Je suis votre IA Plant Doctor. Comment puis-je aider avec $name ?\n\nJe peux diagnostiquer une photo ou répondre à vos questions de soins.';
  }

  @override
  String chatContinueWelcome(String name) {
    return 'Bonjour ! Continuons avec $name. 🌱';
  }

  @override
  String get chatQuestionYellowing =>
      'Quelle est la cause des feuilles jaunes ?';

  @override
  String get chatQuestionTreatment => 'Comment puis-je traiter cette plante ?';

  @override
  String get chatQuestionWatering =>
      'Dois-je changer la fréquence d’arrosage ?';

  @override
  String get chatQuestionFertilizer => 'Quel engrais dois-je utiliser ?';

  @override
  String get chatPhotoSent => 'Photo envoyée';

  @override
  String get chatAnalyzePhoto => 'Analyser la photo';

  @override
  String get chatDiagnosisUnknown => 'Le diagnostic n\'a pas pu être déterminé';

  @override
  String get chatNoTreatment => 'Aucune recommandation de traitement';

  @override
  String get chatRecoveryUnknown => 'Inconnu';

  @override
  String get chatUnableIdentify => 'Plante non identifiée';

  @override
  String chatError(String error) {
    return 'Désolé, une erreur s\'est produite : $error. Veuillez réessayer.';
  }

  @override
  String get chatCareTips => 'Conseils d\'entretien';

  @override
  String get chatPlantLabel => 'Plante';

  @override
  String get chatDiagnosisLabel => 'Diagnostic';

  @override
  String get chatTreatmentLabel => 'Traitement';

  @override
  String get chatUrgencyLabel => 'Urgence';

  @override
  String get chatRecoveryLabel => 'Récupération estimée';

  @override
  String get discoverMonsteraTitle => 'Le secret de la croissance du Monstera';

  @override
  String get discoverIndoorPlants => 'Plantes d\'intérieur';

  @override
  String get discoverSucculentWatering =>
      'Guide d\'arrosage pour les plantes succulentes';

  @override
  String get discoverCacti => 'Cactus et plantes succulentes';

  @override
  String get discoverHerbSoil => 'Meilleurs types de sol pour les herbes';

  @override
  String get discoverHerbs => 'Herbes';

  @override
  String get discoverPropagation => 'Propagation 101 : un manuel du débutant';

  @override
  String get discoverPests => 'Ravageurs courants et comment les traiter';

  @override
  String get discoverRepotting => 'Rempotage : quand et comment ?';

  @override
  String discoverMinutesRead(int minutes) {
    return '$minutes minutes de lecture';
  }

  @override
  String get skip => 'Sauter';

  @override
  String get skipForNow => 'Passer pour l\'instant';

  @override
  String get continueLabel => 'Continuer';

  @override
  String get getStarted => 'Commencer';

  @override
  String get nextStep => 'Étape suivante';

  @override
  String get maybeLater => 'Peut-être plus tard';

  @override
  String get emailAddress => 'Adresse e-mail';

  @override
  String get password => 'Mot de passe';

  @override
  String get firstName => 'Prénom';

  @override
  String get lastName => 'Nom de famille';

  @override
  String get login => 'Connectez-vous';

  @override
  String get signUp => 'S\'inscrire';

  @override
  String get welcomeBack => 'Bienvenue à nouveau';

  @override
  String get loginSubtitle =>
      'Connectez-vous pour continuer à prendre soin de votre jardin.';

  @override
  String get signUpSubtitle =>
      'Rejoignez-nous et commencez à construire votre sanctuaire vert.';

  @override
  String get forgotPassword => 'Mot de passe oublié ?';

  @override
  String get enterEmailPassword =>
      'Veuillez entrer votre email et votre mot de passe.';

  @override
  String get fillAllFields => 'Veuillez remplir tous les champs.';

  @override
  String authError(String error) {
    return 'Quelque chose s\'est mal passé : $error';
  }

  @override
  String get loginWith => 'Ou connectez-vous avec';

  @override
  String get signUpWith => 'Ou inscrivez-vous avec';

  @override
  String get noAccount => 'Vous n\'avez pas de compte ?';

  @override
  String get alreadyAccount => 'Vous avez déjà un compte ?';

  @override
  String get developerSession => 'Créer une session de développeur';

  @override
  String get welcomeBotaniq => 'Bienvenue chez Botaniq';

  @override
  String get loginOptionsSubtitle =>
      'Connectez-vous ou inscrivez-vous pour sauvegarder vos usines, vos horaires et vos préférences.';

  @override
  String get notificationAccessTitle => 'Ne manquez pas un arrosage';

  @override
  String get notificationAccessSubtitle =>
      'Nous vous rappellerons gentiment quand il sera temps de prendre soin de vos amis verts. Entretien des plantes sans effort et sans stress.';

  @override
  String get notificationTurnOn => 'Activer les rappels';

  @override
  String get creatingClimate => 'Analyser votre microclimat...';

  @override
  String get creatingSchedules => 'Personnalisation des plannings de soins...';

  @override
  String get creatingSanctuary => 'Préparer votre sanctuaire vert...';

  @override
  String get locationAccessTitle => 'Accès à la localisation';

  @override
  String get locationAccessSubtitle =>
      'Personnalisez l’entretien des plantes en fonction de votre microclimat local.';

  @override
  String get locationRecommendation => 'Recommandations locales';

  @override
  String get locationRecommendationSubtitle =>
      'Des plantes qui prospèrent dans le climat de votre région';

  @override
  String get locationWeather => 'Synchronisation météo intelligente';

  @override
  String get locationWeatherSubtitle =>
      'Les horaires s\'adaptent à la pluie locale en temps réel';

  @override
  String get locationAlerts => 'Alertes de gel et de chaleur';

  @override
  String get locationAlertsSubtitle =>
      'Soyez averti avant que des conditions météorologiques extrêmes n\'arrivent';

  @override
  String get locationEnable => 'Activer l\'accès à l\'emplacement';

  @override
  String get wherePlantsTitle => 'Où sont tes plantes ?';

  @override
  String get wherePlantsSubtitle =>
      'Sélectionnez tout ce qui s’applique pour personnaliser vos horaires de soins.';

  @override
  String get locationIndoor => 'Intérieur';

  @override
  String get locationIndoorSubtitle => 'Salon, chambre, bureau';

  @override
  String get locationBalcony => 'Balcon';

  @override
  String get locationBalconySubtitle =>
      'Plantes en pot sur une terrasse ou une terrasse';

  @override
  String get locationGarden => 'Jardin';

  @override
  String get locationGardenSubtitle =>
      'Plantes enterrées et parterres de fleurs';

  @override
  String get helpTitleBefore => 'Que pouvons-nous';

  @override
  String get helpTitleHighlight => 't\'aider';

  @override
  String get helpTitleAfter => 'avec ?';

  @override
  String get helpSubtitle =>
      'Sélectionnez un ou plusieurs objectifs pour personnaliser votre jardin.';

  @override
  String get helpHeal => 'Guérir les malades\nplantes';

  @override
  String get helpCare => 'Soins\nrappels';

  @override
  String get helpIdentify => 'Identifier\nespèce';

  @override
  String get helpJournal => 'Croissance\njournal';

  @override
  String get helpOther => 'Quelque chose d\'autre';

  @override
  String get journeyTitle => 'Votre voyage vert';

  @override
  String get journeySubtitle =>
      'Sélectionnez le niveau de soins que vous souhaitez prodiguer.';

  @override
  String get journeyCasualLabel => 'DÉCONTRACTÉ';

  @override
  String get journeyCasualTitle => 'Faible entretien';

  @override
  String get journeyCasualSubtitle =>
      'Je veux juste garder mes plantes simples vivantes et prospères.';

  @override
  String get journeyEnthusiastLabel => 'ENTHOUSIASME';

  @override
  String get journeyEnthusiastTitle => 'Soins équilibrés';

  @override
  String get journeyEnthusiastSubtitle =>
      'J\'aime passer du temps hebdomadaire avec ma collection grandissante.';

  @override
  String get journeyObsessedLabel => 'OBSÉDÉ';

  @override
  String get journeyObsessedTitle => 'Parent végétal extraordinaire';

  @override
  String get journeyObsessedSubtitle =>
      'Je vis pour mes plantes et je veux des horaires experts pour ma jungle intérieure.';

  @override
  String get masteryTitleBefore => 'Comment va ton';

  @override
  String get masteryTitleHighlight => 'vert\npouce';

  @override
  String get masteryTitleAfter => 'dernièrement ?';

  @override
  String get masterySubtitle =>
      'Soyez honnête : nous avons tous été « le tueur en série » à un moment donné. Sélectionnez votre maîtrise actuelle.';

  @override
  String get masteryKiller => 'Le tueur en série';

  @override
  String get masteryKillerSubtitle =>
      'Même mes plantes en plastique ont l’air inquiètes lorsque j’entre dans la pièce.';

  @override
  String get masteryAccidental => 'Parent accidentel';

  @override
  String get masteryAccidentalSubtitle =>
      'Mon cactus a survécu deux semaines. Nous apprenons encore à nous connaître.';

  @override
  String get masteryGrowth => 'Esprit de croissance';

  @override
  String get masteryGrowthSubtitle =>
      'La plupart de mes amis ont des feuilles. Je connais mes Monsteras de mes Pothos.';

  @override
  String get masteryWhisperer => 'Chuchoteur de plantes';

  @override
  String get masteryWhispererSubtitle =>
      'Je cultive des plantes rares et parle couramment le latin botanique.';

  @override
  String get onboardingOneTitle => 'Prenez soin de vous\nde vos plantes';

  @override
  String get onboardingOneHighlight => 'Comme un pro';

  @override
  String get onboardingOneSubtitle =>
      'Horaires intelligents et identification instantanée pour votre jungle urbaine.';

  @override
  String get onboardingOneBadge => 'SOINS ALIMENTÉS PAR L\'IA';

  @override
  String get onboardingAiScan => 'Analyse IA';

  @override
  String get onboardingSmartWater => 'Eau intelligente';

  @override
  String get onboardingLightTracking => 'Suivi de la lumière';

  @override
  String get onboardingTwoTitle => 'Identifier n\'importe quel\nPlanter dans';

  @override
  String get onboardingTwoHighlight => 'Secondes';

  @override
  String get onboardingTwoSubtitle =>
      'Prenez une photo pour connaître son nom, son espèce et ses exigences en matière de soins.';

  @override
  String get onboardingTwoBadge => 'EXPERT BOTANIQUE';

  @override
  String get onboardingSnapPhoto => 'Prendre une photo';

  @override
  String get onboardingAccurateResult => 'Résultat précis';

  @override
  String get onboardingPlantWiki => 'Wiki Plantes';

  @override
  String get onboardingThreeTitle => 'Ne jamais oublier\nArroser';

  @override
  String get onboardingThreeHighlight => 'Encore une fois';

  @override
  String get onboardingThreeSubtitle =>
      'Recevez des rappels programmés en fonction des besoins et de l’environnement de votre usine.';

  @override
  String get onboardingThreeBadge => 'HORAIRES INTELLIGENTS';

  @override
  String get onboardingReminders => 'Rappels';

  @override
  String get onboardingClimateData => 'Données climatiques';

  @override
  String get onboardingHealthyGrowth => 'Croissance saine';

  @override
  String get onboardingCommunity =>
      'Rejoignez plus de 50 000 parents de plantes';

  @override
  String get onboardingAgreement =>
      'EN CONTINUANT, VOUS ACCEPTEZ NOS CONDITIONS ET POLITIQUE DE CONFIDENTIALITÉ';

  @override
  String get termsTitle => 'Conditions et politiques';

  @override
  String get termsUpdated => 'Dernière mise à jour : juillet 2026';

  @override
  String get termsUseTitle => '1. Conditions d\'utilisation';

  @override
  String get termsUseBody =>
      'En accédant ou en utilisant Botaniq, vous acceptez les présentes conditions d\'utilisation et les lois applicables. Si vous n\'êtes pas d\'accord, vous ne pouvez pas utiliser le service.';

  @override
  String get termsPrivacyTitle => '2. Confidentialité des utilisateurs';

  @override
  String get termsPrivacyBody =>
      'Nous collectons uniquement les données personnelles nécessaires pour fournir des programmes d\'entretien des plantes sur mesure. Nous ne vendons pas vos données personnelles à des tiers.';

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
  String get termsPlantTitle => '3. Données sur l\'usine';

  @override
  String get termsPlantBody =>
      'Les informations sur l’entretien des plantes, l’identification et le diagnostic sont fournies à titre informatif. Les résultats de l\'IA peuvent ne pas toujours être corrects, alors observez votre usine et recherchez un expert en cas de risques sérieux.';

  @override
  String get termsLiabilityTitle => '6. Disclaimers, Liability, and Indemnity';

  @override
  String get termsLiabilityBody =>
      'Botaniq is provided \"as is\" and \"as available,\" without warranties of any kind, express or implied, including accuracy, reliability, or fitness for a particular purpose. To the fullest extent permitted by law, we and our service providers are not liable for any indirect, incidental, special, or consequential damages, or for any loss of data, plants, or property arising from your use of the service, and our total liability for any claim is limited to the amount you paid us, if any, in the twelve months before the claim. You agree to indemnify and hold us harmless from claims arising from your use of the service, your content, or your violation of these Terms or applicable law.';

  @override
  String get termsPremiumTitle => '4. Abonnements Premium';

  @override
  String get termsPremiumBody =>
      'Votre abonnement Premium mensuel ou annuel est facturé sur votre compte Apple ou Google après confirmation d\'achat. Il se renouvelle automatiquement sauf annulation au moins 24 heures avant la fin de la période en cours. Vous pouvez le gérer ou l\'annuler dans les paramètres de votre compte de boutique. Les demandes de remboursement sont traitées conformément à la politique du magasin applicable.';

  @override
  String get termsLawTitle => '8. Governing Law and Changes';

  @override
  String get termsLawBody =>
      'These Terms are governed by the laws of the jurisdiction in which we operate, without regard to conflict-of-law principles, and any dispute will be resolved under that jurisdiction\'s applicable procedures to the fullest extent permitted by law. We may update these Terms and our data practices at any time by posting the revised version in the app.';

  @override
  String get termsClosing =>
      'Profitez d\'une tranquillité d\'esprit et de plantes plus heureuses.';

  @override
  String get weatherTitle => 'Météo';

  @override
  String get weatherSunnyTip =>
      'Ensoleillé aujourd\'hui : vérifiez le sol avant d\'arroser.';

  @override
  String get weatherCloudyTip =>
      'Le temps nuageux ralentit l\'évaporation ; arroser un peu moins.';

  @override
  String get weatherRainyTip =>
      'Pluvieux et humide : évitez de trop arroser les plantes d’extérieur.';

  @override
  String get weatherStormTip =>
      'Temps orageux : déplacez les pots délicats dans un endroit abrité.';

  @override
  String get weatherSnowTip =>
      'Froid et neigeux : protégez les plantes des chocs thermiques.';
}
