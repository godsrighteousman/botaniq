// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Botaniq';

  @override
  String get settings => 'Configuración';

  @override
  String get preferences => 'Preferencias';

  @override
  String get darkMode => 'Modo oscuro';

  @override
  String get metricSystem => 'Sistema métrico';

  @override
  String get metricSystemSubtitle => 'Utilice grados Celsius y metros';

  @override
  String get account => 'cuenta';

  @override
  String get editProfile => 'Editar perfil';

  @override
  String get changePassword => 'Cambiar contraseña';

  @override
  String get subscriptionManagement => 'Gestión de suscripciones';

  @override
  String get premium => 'Prémium';

  @override
  String get language => 'Idioma';

  @override
  String get languageSubtitle => 'Cambiar idioma de la aplicación';

  @override
  String get selectLanguage => 'Seleccionar idioma';

  @override
  String get systemLanguage => 'Idioma del sistema';

  @override
  String get english => 'ingles';

  @override
  String get turkish => 'turco';

  @override
  String get languageChanged => 'El idioma cambió correctamente.';

  @override
  String get languageSearchHint => 'Idiomas de búsqueda';

  @override
  String get languageRecommended => 'Recomendado';

  @override
  String get languageWelcomeTitle => 'Elige tu idioma';

  @override
  String get languageWelcomeSubtitle =>
      'Seleccione el idioma que desea utilizar en Botaniq. Puedes cambiarlo en cualquier momento.';

  @override
  String get languageUseSystem => 'Usar el idioma del dispositivo';

  @override
  String get preferenceSystem => 'Usar la configuración del sistema';

  @override
  String get themeLight => 'Luz';

  @override
  String get themeDark => 'oscuro';

  @override
  String get themeSelectionTitle => 'Elige apariencia';

  @override
  String get measurementMetric => 'Métrica';

  @override
  String get measurementImperial => 'Imperial';

  @override
  String get measurementSelectionTitle => 'Elija el sistema de medición';

  @override
  String get settingsSubtitle =>
      'Dale forma a Botaniq según tu propio ritmo de cuidado.';

  @override
  String get settingsLocalPreference => 'Guardado en este dispositivo';

  @override
  String get settingsDarkModeSubtitle =>
      'Una paleta más tranquila para momentos de poca luz.';

  @override
  String get settingsAccountSubtitle => 'Identidad, acceso y membresía';

  @override
  String get settingsEditProfileSubtitle =>
      'Nombre, ubicación y preferencias de atención.';

  @override
  String get settingsPasswordSubtitle =>
      'Envíe un enlace de reinicio seguro a su correo electrónico';

  @override
  String get settingsSubscriptionSubtitle =>
      'Plan premium y detalles de facturación';

  @override
  String get settingsPasswordResetSent =>
      'Correo electrónico de restablecimiento de contraseña enviado.';

  @override
  String get settingsComingSoon => 'Este espacio sigue creciendo.';

  @override
  String get subscriptionPageTitle => 'Membresía Premium';

  @override
  String get subscriptionHeroEyebrow => 'BOTANIQ PREMIUM';

  @override
  String get subscriptionHeroTitle =>
      'Cuidado más inteligente para cada planta';

  @override
  String get subscriptionHeroSubtitle =>
      'Desbloquee todas las herramientas de cuidado premium y haga crecer su espacio verde con confianza.';

  @override
  String get subscriptionBenefitsTitle => 'Todo en Premium';

  @override
  String get subscriptionBenefitIdentification =>
      'Identificación ilimitada de plantas y análisis de salud.';

  @override
  String get subscriptionBenefitCare =>
      'Planes de atención personalizados y recordatorios';

  @override
  String get subscriptionBenefitInsights =>
      'Contenido experto e información sobre cuidados avanzados';

  @override
  String get subscriptionMonthlyPlan => 'Mensual';

  @override
  String get subscriptionAnnualPlan => 'Anual';

  @override
  String subscriptionPerMonth(String price) {
    return '$price / mes';
  }

  @override
  String subscriptionPerYear(String price) {
    return '$price / año';
  }

  @override
  String get subscriptionBestValue => 'MEJOR VALOR';

  @override
  String subscriptionSavePercent(int percent) {
    return 'Ahorre $percent%';
  }

  @override
  String get subscriptionContinue => 'Desbloquear Premium';

  @override
  String get subscriptionRestorePurchases => 'Restaurar compras';

  @override
  String get subscriptionRestoring => 'Restaurando...';

  @override
  String get subscriptionManage => 'Administrar suscripción';

  @override
  String get subscriptionActiveTitle => 'Tu membresía Premium está activa';

  @override
  String get subscriptionActiveSubtitle =>
      'Tienes acceso a todas las funciones premium.';

  @override
  String subscriptionRenewsOn(String date) {
    return 'Renueva el $date';
  }

  @override
  String subscriptionExpiresOn(String date) {
    return 'Activo hasta $date';
  }

  @override
  String get subscriptionAutoRenewDisclosure =>
      'El pago se carga a su cuenta de Apple o Google. La suscripción se renueva automáticamente a menos que se cancele al menos 24 horas antes del final del período actual. Puede administrarlo o cancelarlo en cualquier momento en la configuración de su cuenta de tienda.';

  @override
  String get subscriptionTermsLink => 'Términos de uso';

  @override
  String get subscriptionPrivacyLink => 'Política de privacidad';

  @override
  String get subscriptionPurchaseSuccess =>
      'Su membresía Premium ya está activa.';

  @override
  String get subscriptionRestoreSuccess =>
      'Su membresía Premium fue restaurada.';

  @override
  String get subscriptionNothingToRestore =>
      'No se encontró ninguna membresía activa para esta cuenta de tienda.';

  @override
  String get subscriptionPaymentPending =>
      'El pago está pendiente de aprobación de la tienda. Su membresía se activará automáticamente una vez aprobada.';

  @override
  String get subscriptionErrorGeneric =>
      'La operación no se pudo completar. Por favor inténtalo de nuevo.';

  @override
  String get subscriptionErrorNetwork =>
      'Verifique su conexión a Internet e inténtelo nuevamente.';

  @override
  String get subscriptionErrorNotAllowed =>
      'Este dispositivo o cuenta de tienda no puede realizar compras.';

  @override
  String get subscriptionErrorStore =>
      'No se pudo llegar a la tienda. Inténtelo de nuevo en breve.';

  @override
  String get subscriptionMissingConfiguration =>
      'Falta la clave RevenueCat en esta compilación.';

  @override
  String get subscriptionUnsupported =>
      'Las suscripciones solo están disponibles en las aplicaciones de iOS y Android.';

  @override
  String get subscriptionProductsUnavailable =>
      'No se pudieron cargar productos mensuales y anuales. Verifique la configuración de la oferta de RevenueCat.';

  @override
  String get subscriptionRetry => 'Inténtalo de nuevo';

  @override
  String get subscriptionFree => 'Gratis';

  @override
  String get homeGoodMorning => 'Hola,';

  @override
  String homePersonalGreeting(String greeting, String name) {
    return '$greeting, $name 👋';
  }

  @override
  String get homeEmptyGarden => 'Tu jardín está vacío';

  @override
  String get homeEmptyGardenSubtitle =>
      'Comienza a construir tu santuario verde\nagregando su primera planta.';

  @override
  String get homeAddFirstPlant => 'Agregar primera planta';

  @override
  String get homeMyPlants => 'mis plantas';

  @override
  String get homeViewAll => 'Ver todo';

  @override
  String get homeSmartCareReminders => 'Recordatorios de atención inteligente';

  @override
  String get homeWatering => 'Riego';

  @override
  String get homeWateringSubtitle => 'Seguimiento del suelo';

  @override
  String get homeFertilizing => 'fertilizar';

  @override
  String get homeFertilizingSubtitle => 'Alertas de nutrientes';

  @override
  String get gardenTitle => 'mi jardin';

  @override
  String get gardenAllPlants => 'Todas las plantas';

  @override
  String get gardenNeedsWater => 'Necesita agua';

  @override
  String get gardenIndoor => 'interior';

  @override
  String get gardenNoPlants =>
      'Aún no hay plantas.\n¡Toca + para agregar tu primera planta!';

  @override
  String get gardenNoPlantsCategory => 'No hay plantas en esta categoría.';

  @override
  String get discoverTitle => 'Descubrir';

  @override
  String get discoverSearchHint => 'Busca plantas, artículos, guías...';

  @override
  String get discoverLatestArticles => 'Últimos artículos';

  @override
  String get discoverSeeAll => 'Ver todo';

  @override
  String get discoverTrendingGuides => 'Guías de tendencias';

  @override
  String get healthyTitle => 'Centro de atención';

  @override
  String get healthySubtitle => 'Toca el alma de tus plantas, habla con ellas.';

  @override
  String get healthyTabDoctor => 'medico';

  @override
  String get healthyTabHospital => 'hospitales';

  @override
  String get healthyTabDiscover => 'Descubrir';

  @override
  String get profileTitle => 'Mi perfil';

  @override
  String get profileEditProfile => 'Editar perfil';

  @override
  String get profileOverview => 'Descripción general';

  @override
  String get profileSettingsTab => 'Configuración';

  @override
  String get profileGardenerLevel => 'Nivel de jardinero';

  @override
  String get profileTotalPlants => 'Plantas totales';

  @override
  String get profileCompletedTasks => 'Tareas completadas';

  @override
  String get profileWeeklyActivity => 'Actividad de cuidado semanal';

  @override
  String get profileGeneral => 'generales';

  @override
  String get profileAppSettings => 'Configuración de la aplicación';

  @override
  String get profileNotificationPrefs => 'Preferencias de notificación';

  @override
  String get profileSupportLegal => 'Soporte y Legal';

  @override
  String get profileHelpCenter => 'Centro de ayuda';

  @override
  String get profileTerms => 'Términos de uso y políticas';

  @override
  String get profileSignOut => 'Cerrar sesión';

  @override
  String get profileDeleteAccount => 'Eliminar cuenta';

  @override
  String get profileSubtitle =>
      'La historia de tu jardín, tu progreso y tu espacio personal.';

  @override
  String get profileGardenPassport => 'PASAPORTE DEL JARDÍN';

  @override
  String get profileThisWeek => 'esta semana';

  @override
  String get profileQuietWeek =>
      'Una semana tranquila: tu próximo momento de atención aparecerá aquí.';

  @override
  String get profileActiveWeek => 'Su ritmo de atención está vivo y creciendo.';

  @override
  String get profileAppSettingsSubtitle => 'Idioma, unidades y conexión AI';

  @override
  String get profileNotificationPrefsSubtitle =>
      'Elige qué momentos de cuidado te llegan';

  @override
  String get profileHelpCenterSubtitle => 'Respuestas y orientación rápida.';

  @override
  String get profileTermsSubtitle => 'Privacidad, términos y políticas';

  @override
  String get profileAccountActions => 'Acciones de cuenta';

  @override
  String get profileSignOutQuestion =>
      '¿Estás seguro de que deseas cerrar sesión?';

  @override
  String get profileDeleteAccountWarning =>
      'La eliminación de una cuenta necesita una confirmación segura del lado del servidor. Tus datos no han sido modificados.';

  @override
  String get cancel => 'Cancelar';

  @override
  String get continueAction => 'Continuar';

  @override
  String get profileTitleNew => 'Nuevo jardinero 🌱';

  @override
  String get profileTitleSprout => 'Amigo Brote 🌿';

  @override
  String get profileTitleLeaf => 'Amante de las hojas ☘️';

  @override
  String get profileTitleSkilled => 'Jardinero experto 🏡';

  @override
  String get profileTitleMaster => 'Maestro del pulgar verde 👑';

  @override
  String get profileNextLevelStart =>
      '¡Agrega tu primera planta y comienza tu aventura de jardinería!';

  @override
  String profileNextLevelLeaf(int count) {
    return 'Solo quedan $count plantas para convertirse en Leaf Lover.';
  }

  @override
  String profileNextLevelSkilled(int count) {
    return 'Solo quedan $count plantas para convertirse en Jardinero experto.';
  }

  @override
  String profileNextLevelMaster(int count) {
    return 'Solo quedan $count plantas para convertirse en Green Thumb Master.';
  }

  @override
  String get profileNextLevelMax =>
      'Estás en la cima de tu jardín, ¡felicidades!';

  @override
  String get navHome => 'Inicio';

  @override
  String get navGarden => 'jardín';

  @override
  String get navClinic => 'clínica';

  @override
  String get navProfile => 'Perfil';

  @override
  String get scanPlant => 'Planta de escaneo';

  @override
  String get deletePlantTitle => '¿Quitar esta planta?';

  @override
  String get deletePlantMessage =>
      'La planta, sus tareas de cuidado y los registros de la Clínica se eliminarán permanentemente de su cuenta.';

  @override
  String get deletePlantAction => 'Quitar planta';

  @override
  String get deletePlantNotFound =>
      'La planta no se pudo encontrar o ya ha sido eliminada.';

  @override
  String deletePlantError(String error) {
    return 'La planta no se pudo eliminar: $error';
  }

  @override
  String get profileChoosePhoto => 'Elige foto de perfil';

  @override
  String get profileFullName => 'Nombre completo';

  @override
  String get profileFullNameHint => 'Introduce tu nombre completo';

  @override
  String get profileNickname => 'Apodo';

  @override
  String get profileNicknameHint => '¿Cómo deberíamos llamarte?';

  @override
  String get profileAge => 'edad';

  @override
  String get profileAgeHint => '1-120';

  @override
  String get profileAgeValidation =>
      'Por favor ingrese una edad entre 1 y 120.';

  @override
  String profileLoadError(String error) {
    return 'No se pudo cargar el perfil: $error';
  }

  @override
  String get languageEnglish => 'ingles';

  @override
  String get languageTurkish => 'turco';

  @override
  String get profileEmailReadOnly =>
      'Dirección de correo electrónico (solo lectura)';

  @override
  String get profileEmailHint => 'Introduce tu correo electrónico';

  @override
  String get profileLocation => 'Ubicación';

  @override
  String get profileLocationHint => 'Ciudad, País';

  @override
  String get profileSaveChanges => 'Guardar cambios';

  @override
  String get profileUpdated => 'Tu perfil ha sido actualizado.';

  @override
  String profileSaveError(String error) {
    return 'No se pudo guardar el perfil: $error';
  }

  @override
  String get notificationWateringTitle => 'Recordatorios de riego';

  @override
  String get notificationWateringSubtitle =>
      'Recibe una notificación cuando llegue el momento de regar';

  @override
  String get notificationFertilizerTitle => 'Recordatorios de fertilizantes';

  @override
  String get notificationFertilizerSubtitle =>
      'Alertas de alimentación estacional para tus plantas';

  @override
  String get notificationTitle => 'Notificaciones';

  @override
  String get notificationPlantCareAlerts => 'Alertas de cuidado de plantas';

  @override
  String get notificationOther => 'Otras notificaciones';

  @override
  String get notificationWeatherTitle => 'Alertas meteorológicas';

  @override
  String get notificationWeatherSubtitle => 'Advertencias de clima extremo';

  @override
  String get notificationArticlesTitle => 'Nuevos artículos';

  @override
  String get notificationArticlesSubtitle => 'Consejos y trucos para tu jardín';

  @override
  String get gardenMyPlantFallback => 'mi planta';

  @override
  String get gardenClinicBadge => 'En la clínica';

  @override
  String get wateringNever => 'Último regado: nunca';

  @override
  String wateringLastDate(String date) {
    return 'Último regado: $date';
  }

  @override
  String wateringInterval(int days) {
    return 'Cada $days días';
  }

  @override
  String get wateringNeverDue => 'Aún no regado • Riegue hoy';

  @override
  String wateringOverdue(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days días de retraso',
      one: '1 día de retraso',
      zero: 'Regar hoy',
    );
    return '$_temp0';
  }

  @override
  String get wateringDueToday => 'Agua hoy';

  @override
  String get wateringDueTomorrow => 'agua mañana';

  @override
  String wateringDueInDays(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'Regar en $days días',
      one: 'Regar en 1 día',
      zero: 'Regar hoy',
    );
    return '$_temp0';
  }

  @override
  String get plantUnknown => 'Planta desconocida';

  @override
  String get plantSpeciesFallback => 'Especies de plantas';

  @override
  String get plantDifficultyMedium => 'Medio';

  @override
  String get plantAbout => 'Acerca de';

  @override
  String get plantLocationEnvironment => 'Ubicación y entorno';

  @override
  String get plantCareProtocol => 'Protocolo de atención';

  @override
  String get plantCareHistory => 'Historial de atención de los últimos 10 días';

  @override
  String get plantHealthy => 'saludable';

  @override
  String get plantInClinic => 'En la clínica';

  @override
  String get plantDifficulty => 'dificultad';

  @override
  String get plantToxicity => 'Toxicidad';

  @override
  String get plantEnvironment => 'Medio ambiente';

  @override
  String get plantLightNeed => 'Necesidad de luz';

  @override
  String get plantToxicPets => 'Tóxico para las mascotas';

  @override
  String get plantNonToxic => 'No tóxico';

  @override
  String get plantIndoor => 'interior';

  @override
  String get plantBrightIndirect => 'Brillante indirecto';

  @override
  String get plantInfoUnavailable =>
      'La información verificada aún no está disponible.';

  @override
  String get plantIdealClimate => 'Clima Ideal';

  @override
  String get plantHumidity => 'Humedad';

  @override
  String get plantTemperatureRange => 'Rango de temperatura';

  @override
  String get plantWateringFrequency => 'Frecuencia de riego';

  @override
  String plantWateringFrequencyValue(String interval) {
    return 'Agua $interval.';
  }

  @override
  String get plantNextWatering => 'Siguiente riego';

  @override
  String get plantWateringProtocol => 'Protocolo de riego';

  @override
  String get plantSoilProtocol => 'suelo';

  @override
  String get plantFeedingProtocol => 'Protocolo de alimentación';

  @override
  String get plantPruningCleaning => 'Poda y limpieza';

  @override
  String get plantPruningFallback =>
      'Limpie las hojas mensualmente. Pode las hojas muertas o amarillentas para estimular el crecimiento.';

  @override
  String get plantHistoryEmpty =>
      'Sin historial de atención durante los últimos 10 días.';

  @override
  String get plantWateringTask => 'Riego';

  @override
  String get plantFertilizingTask => 'fertilizar';

  @override
  String get plantWateredAction => 'Regado ✓';

  @override
  String get plantWaterNowAction => 'Agua ahora';

  @override
  String get plantFertilizedAction => 'Fertilizado ✓';

  @override
  String get plantFertilizeAction => 'fertilizar';

  @override
  String get plantAddGardenAction => 'Añadir a mi jardín';

  @override
  String get plantWaterSuccess => '💧¡Regaste tu planta! ¡Buen trabajo!';

  @override
  String get plantFertilizeSuccess =>
      '🌱 ¡Se agregó fertilizante! ¡Tu planta dice gracias!';

  @override
  String plantWaterError(String error) {
    return 'No se pudo guardar el riego: $error';
  }

  @override
  String plantFertilizeError(String error) {
    return 'No se pudo guardar la fertilización: $error';
  }

  @override
  String get clinicQuickTools => 'Herramientas rápidas';

  @override
  String get clinicDoctorHero => 'Médico de plantas con IA\nA su servicio';

  @override
  String get clinicStartConsultation => 'Iniciar consulta';

  @override
  String get clinicChoosePlant => '¿De qué planta te gustaría hablar?';

  @override
  String get clinicChoosePlantSubtitle =>
      'Elige una planta de tu jardín o toma una nueva foto.';

  @override
  String get clinicNoGardenPlants =>
      'Aún no hay plantas en tu jardín.\nComience tomando una nueva foto.';

  @override
  String get clinicNewPhoto => 'Tomar una nueva foto';

  @override
  String get clinicNewPhotoSubtitle =>
      'Fotografíe la planta enferma y obtenga un diagnóstico.';

  @override
  String get clinicPestAnalysis => 'Análisis de plagas';

  @override
  String get clinicVisualDiagnosis => 'Diagnóstico visual';

  @override
  String get clinicLightMeter => 'Medidor de luz';

  @override
  String get clinicSensorSimulation => 'Simulación de sensores';

  @override
  String get clinicTitle => 'Clínica de plantas';

  @override
  String clinicSickCount(int count) {
    return '$count Enfermo';
  }

  @override
  String get clinicAllHealthy => '¡Todas tus plantas están sanas! 🌿';

  @override
  String get clinicEmpty =>
      'No hay plantas enfermas en la Clínica.\nSi te preocupa una planta,\npregunte desde la pestaña Doctor.';

  @override
  String get clinicUnknown => 'Desconocido';

  @override
  String get clinicPendingDiagnosis => 'Esperando diagnóstico';

  @override
  String get clinicNoTreatment => 'El tratamiento no ha sido determinado.';

  @override
  String get clinicPrescription => 'Prescripción:';

  @override
  String get clinicRecovery => 'Recuperación';

  @override
  String get clinicRecovered => 'Recuperado';

  @override
  String get clinicContinue => 'Continuar';

  @override
  String get clinicRecoveredSuccess => '🎉 ¡Tu planta vuelve a estar sana!';

  @override
  String get clinicUrgencyLow => 'Bajo';

  @override
  String get clinicUrgencyMedium => 'Medio';

  @override
  String get clinicUrgencyCritical => 'Crítico';

  @override
  String get healthTrendingTips => 'Consejos de salud de tendencia';

  @override
  String get healthHumidityArticleTitle =>
      'Preparación para el invierno: mantener la humedad equilibrada';

  @override
  String get healthHumidityArticleSubtitle =>
      'Cómo proteger tus plantas del aire seco del radiador durante los meses fríos.';

  @override
  String get healthWeeklySpotlight => 'Paciente y remedio de la semana';

  @override
  String get healthAphidTitle => 'Infestación de pulgones';

  @override
  String get healthAphidSubtitle =>
      'Intervención temprana y tratamiento natural con Aceite de Neem.';

  @override
  String get healthDiscoverLoadError =>
      'El contenido de Discover no se pudo cargar en este momento. Tire hacia abajo para intentarlo de nuevo.';

  @override
  String get healthDiscoverEmpty =>
      'Aún no hay contenido de descubrimiento publicado.';

  @override
  String get healthDiscoverRetry => 'Inténtalo de nuevo';

  @override
  String get lightMeterTitle => 'Medidor de luz';

  @override
  String get lightMeterInstructionTitle => 'Para medir la luz';

  @override
  String get lightMeterInstruction =>
      'Apunte la cámara frontal del teléfono hacia\nLa posición de la planta y la fuente de luz.';

  @override
  String get lightMeterCameraEstimate =>
      'Lux aproximado calculado a partir de los datos de la cámara';

  @override
  String get lightMeterStabilizing => 'Medición estabilizadora';

  @override
  String get lightMeterStabilizingRecommendation =>
      'Mantén el teléfono fijo durante unos segundos mientras se filtran los cambios bruscos de exposición.';

  @override
  String get lightMeterUnavailable => 'Medida no disponible';

  @override
  String get lightMeterUnavailableRecommendation =>
      'Habilite el permiso de la cámara y vuelva a intentar esta pantalla.';

  @override
  String get lightLow => 'Luz baja (sombra)';

  @override
  String get lightMedium => 'Luz media (habitación luminosa)';

  @override
  String get lightHigh => 'Luz alta (cerca de la ventana)';

  @override
  String get lightVeryHigh => 'Luz muy alta (sol directo)';

  @override
  String get lightLowRecommendation =>
      'Adecuado para Calathea, helechos o plantas de serpiente.';

  @override
  String get lightMediumRecommendation =>
      'Ideal para Monstera, Ficus y Anthurium.';

  @override
  String get lightHighRecommendation =>
      'Adecuado para aloe, cactus y geranios amantes del sol.';

  @override
  String get lightVeryHighRecommendation =>
      'Lo mejor para plantas de exterior y suculentas.';

  @override
  String get homeLoadingPlants => 'Cargando plantas...';

  @override
  String get homeNotifications => 'Notificaciones';

  @override
  String get homeWateringTime => 'Tiempo de riego';

  @override
  String get homeWateringNotification =>
      'Tus plantas de interior necesitan riego.';

  @override
  String get homeWelcome => '¡Bienvenido!';

  @override
  String get homeWelcomeNotification =>
      'Bienvenidos a Botaniq. Comience agregando su primera planta.';

  @override
  String get homeTenMinutesAgo => 'Hace 10 minutos';

  @override
  String get homeOneDayAgo => 'Hace 1 día';

  @override
  String get homeQuickActions => 'Acciones rápidas';

  @override
  String get homeIdentifyCamera => 'Identifícate con tu cámara';

  @override
  String get homeTomorrow => 'mañana';

  @override
  String get homeNoTasks => '¡No hay tareas para este día!';

  @override
  String get homeAllCared => 'Tus plantas están todas cuidadas 🌿';

  @override
  String get homeOverdue => 'VENCIDO';

  @override
  String get homeInstructions => 'Instrucciones';

  @override
  String homeRequiredAmount(String amount) {
    return 'Requerido: $amount';
  }

  @override
  String get homeLater => 'Más tarde';

  @override
  String get homeMarkDone => 'Marcar como hecho';

  @override
  String get homeSickPlants => 'Clínica de plantas';

  @override
  String homeSickCount(int count) {
    return '$count Enfermo';
  }

  @override
  String get homeGreetingMorning => 'Buenos dias';

  @override
  String get homeGreetingAfternoon => 'Buenas tardes';

  @override
  String get homeGreetingEvening => 'Buenas noches';

  @override
  String get homeTodayTasks => 'Las tareas de hoy';

  @override
  String get homeTomorrowTasks => 'Las tareas del mañana';

  @override
  String homeDateTasks(String date) {
    return '$date Tareas';
  }

  @override
  String get commonSkip => 'Saltar';

  @override
  String get commonContinue => 'Continuar';

  @override
  String get commonClose => 'Cerrar';

  @override
  String get commonDelete => 'Eliminar';

  @override
  String get commonBack => 'Volver';

  @override
  String get commonUnknown => 'Desconocido';

  @override
  String get wizardSaveGarden => 'Guardar y agregar al jardín';

  @override
  String wizardPlantAdded(String name) {
    return '¡$name fue agregado a tu jardín! 🌿';
  }

  @override
  String get wizardRoomTitle => '¿Dónde está tu planta?';

  @override
  String get wizardRoomSubtitle =>
      'Clasifique su planta por habitación para administrarla fácilmente.';

  @override
  String get wizardLivingRoom => 'Sala de estar';

  @override
  String get wizardBedroom => 'dormitorio';

  @override
  String get wizardKitchen => 'cocina';

  @override
  String get wizardOffice => 'Oficina';

  @override
  String get wizardBathroom => 'Cuarto de baño';

  @override
  String get wizardBalcony => 'Balcón';

  @override
  String get wizardLightTitle => '¿Cómo es la luz en este lugar?';

  @override
  String get wizardLightSubtitle =>
      'La luz es uno de los factores más importantes para la salud de tu planta.';

  @override
  String get wizardDirectSun => 'Sol directo';

  @override
  String get wizardDirectSunDescription =>
      'Luz solar sin filtrar directamente sobre la planta.';

  @override
  String get wizardBrightIndirect => 'Brillante indirecto';

  @override
  String get wizardBrightIndirectDescription =>
      'Cerca de una ventana orientada al este o al oeste';

  @override
  String get wizardMediumLight => 'Luz media';

  @override
  String get wizardMediumLightDescription => 'A unos metros de una ventana';

  @override
  String get wizardLowLight => 'Luz baja';

  @override
  String get wizardLowLightDescription =>
      'Lejos de ventanas o bajo luz artificial';

  @override
  String get wizardDistanceTitle => 'Distancia a la ventana';

  @override
  String get wizardDistanceSubtitle =>
      'Seleccione la distancia aproximada a la ventana más cercana.';

  @override
  String get wizardMoreThanFiveMeters => 'Más de 5 metros';

  @override
  String get wizardActiveHoursTitle => 'Horas de luz activa';

  @override
  String get wizardActiveHoursSubtitle =>
      '¿Cuántas horas de luz directa o brillante recibe este punto?';

  @override
  String wizardHour(int count) {
    return '$count hora';
  }

  @override
  String wizardHours(int count) {
    return '$count horas';
  }

  @override
  String get wizardSixPlusHours => '6+ horas';

  @override
  String get wizardRepottedTitle =>
      '¿Cuándo se trasplantó esta planta por última vez?';

  @override
  String get wizardRepottedSubtitle =>
      'La tierra fresca es crucial para una planta feliz.';

  @override
  String get wizardRecently => 'Recientemente (menos de 3 meses)';

  @override
  String get wizardSixMonthsAgo => 'hace 6 meses';

  @override
  String get wizardOneYearAgo => 'Hace 1 año';

  @override
  String get wizardTwoYearsAgo => 'Hace más de 2 años';

  @override
  String get wizardDontKnow => 'no lo sé';

  @override
  String get wizardPotTitle => '¿De qué material es la maceta?';

  @override
  String get wizardPotSubtitle =>
      'El material de la maceta afecta la rapidez con la que se seca la tierra.';

  @override
  String get wizardPlasticPot => 'Plástico / Guardería';

  @override
  String get wizardTerracottaPot => 'Terracota';

  @override
  String get wizardCeramicPot => 'Cerámica / Esmaltada';

  @override
  String get wizardMetalPot => 'metales';

  @override
  String get wizardWateredTitle =>
      '¿Cuándo regaste esta planta por última vez?';

  @override
  String get wizardWateredSubtitle =>
      'Esto ayuda a calcular el próximo tiempo exacto de riego.';

  @override
  String get wizardToday => 'hoy';

  @override
  String get wizardYesterday => 'ayer';

  @override
  String get wizardFewDaysAgo => 'Hace unos dias';

  @override
  String get wizardWeekAgo => 'hace una semana';

  @override
  String get wizardMoreWeekAgo => 'Hace más de una semana';

  @override
  String get historyTitle => 'Historial de búsqueda';

  @override
  String get historyClearTitle => 'Borrar historial';

  @override
  String get historyClearMessage =>
      'Se eliminará todo el historial de búsqueda y escaneo. ¿Está seguro?';

  @override
  String get historyClearTooltip => 'Borrar historial';

  @override
  String get historyEmptyTitle => 'Sin historial de búsqueda';

  @override
  String get historyEmptySubtitle =>
      'Aquí aparecerán las plantas escaneadas con la cámara o buscadas.';

  @override
  String get historyNoDetails => 'La información detallada no está disponible.';

  @override
  String get historyRegularWater => 'Riego regular';

  @override
  String get historyIndirectLight => 'Luz indirecta';

  @override
  String get historyDescription => 'Descripción';

  @override
  String get historyWatering => 'Riego';

  @override
  String get historyLight => 'Luz';

  @override
  String get historyRecently => 'Recientemente';

  @override
  String historyMinutesAgo(int minutes) {
    return '$minutes Hace minutos';
  }

  @override
  String historyHoursAgo(int hours) {
    return '$hours hace horas';
  }

  @override
  String get historyYesterday => 'ayer';

  @override
  String get historyPlantRecord => 'Registro de búsqueda de plantas';

  @override
  String get photoWholeSpecimen => 'foto del conjunto\nplanta o hongo';

  @override
  String get photoWholeSpecimenSubtitle =>
      'Mantenga toda la muestra centrada en el marco para una mejor identificación.';

  @override
  String get photoCorrect => 'Correcto';

  @override
  String get photoTooClose => 'Demasiado cerca';

  @override
  String get photoInstructions => 'Instrucciones';

  @override
  String get photoOpenCamera => 'Entiendo, abre la cámara';

  @override
  String get scannerPlant => 'planta';

  @override
  String get scannerMushroom => 'Hongo';

  @override
  String get scannerIdentifyingPlant => 'Identificando la planta...';

  @override
  String get scannerIdentifyingMushroom => 'Identificando hongos...';

  @override
  String get scannerCapture => 'Tomar fotos y escanear';

  @override
  String get scannerFailed => 'El escaneo falló. Por favor inténtalo de nuevo.';

  @override
  String scannerError(String error) {
    return 'Se produjo un error: $error';
  }

  @override
  String get scannerUnknownPlant => 'Planta desconocida';

  @override
  String get scannerUnknownMushroom => 'Hongo desconocido';

  @override
  String get scheduleTitle => 'Horario';

  @override
  String get scheduleTodayTask => 'Las tareas de hoy';

  @override
  String get scheduleNoTasks => '¡No hay tareas para hoy!';

  @override
  String get scheduleInstructions => 'Instrucciones';

  @override
  String scheduleRequired(String amount) {
    return 'Requerido: $amount';
  }

  @override
  String get scheduleRemindLater => 'Recordar más tarde';

  @override
  String get scheduleDone => 'hecho';

  @override
  String get scheduleCareFallback => 'Cuida tu planta.';

  @override
  String get chatDoctorTitle => 'Médico de plantas con IA';

  @override
  String chatPatient(String name) {
    return 'Paciente: $name';
  }

  @override
  String get chatAnalyzing => 'Analizando...';

  @override
  String chatHint(String name) {
    return 'Pregunte por $name...';
  }

  @override
  String chatWelcome(String name) {
    return '¡Hola! 🌿 Soy tu médico de plantas con IA. ¿Cómo puedo ayudar con $name?\n\nPuedo diagnosticar una foto o responder a sus preguntas sobre cuidados.';
  }

  @override
  String chatContinueWelcome(String name) {
    return '¡Hola! Sigamos con $name. 🌱';
  }

  @override
  String get chatQuestionYellowing => '¿Qué está causando las hojas amarillas?';

  @override
  String get chatQuestionTreatment => '¿Cómo puedo tratar esta planta?';

  @override
  String get chatQuestionWatering => '¿Debo cambiar la frecuencia de riego?';

  @override
  String get chatQuestionFertilizer => '¿Qué fertilizante debo utilizar?';

  @override
  String get chatPhotoSent => 'Foto enviada';

  @override
  String get chatAnalyzePhoto => 'analiza la foto';

  @override
  String get chatDiagnosisUnknown => 'No se pudo determinar el diagnóstico.';

  @override
  String get chatNoTreatment => 'Sin recomendación de tratamiento';

  @override
  String get chatRecoveryUnknown => 'Desconocido';

  @override
  String get chatUnableIdentify => 'Planta no identificada';

  @override
  String chatError(String error) {
    return 'Lo sentimos, ocurrió un error: $error. Por favor inténtalo de nuevo.';
  }

  @override
  String get chatCareTips => 'Consejos de cuidado';

  @override
  String get chatPlantLabel => 'planta';

  @override
  String get chatDiagnosisLabel => 'Diagnóstico';

  @override
  String get chatTreatmentLabel => 'Tratamiento';

  @override
  String get chatUrgencyLabel => 'Urgencia';

  @override
  String get chatRecoveryLabel => 'Recuperación estimada';

  @override
  String get discoverMonsteraTitle => 'El secreto del crecimiento de Monstera';

  @override
  String get discoverIndoorPlants => 'Plantas de interior';

  @override
  String get discoverSucculentWatering => 'Guía de riego para suculentas';

  @override
  String get discoverCacti => 'Cactus y suculentas';

  @override
  String get discoverHerbSoil => 'Los mejores tipos de suelo para hierbas';

  @override
  String get discoverHerbs => 'Hierbas';

  @override
  String get discoverPropagation =>
      'Propagación 101: un manual para principiantes';

  @override
  String get discoverPests => 'Plagas comunes y cómo tratarlas';

  @override
  String get discoverRepotting => 'Trasplante: ¿cuándo y cómo?';

  @override
  String discoverMinutesRead(int minutes) {
    return '$minutes lectura min';
  }

  @override
  String get skip => 'Saltar';

  @override
  String get skipForNow => 'Saltar por ahora';

  @override
  String get continueLabel => 'Continuar';

  @override
  String get getStarted => 'Empezar';

  @override
  String get nextStep => 'Siguiente paso';

  @override
  String get maybeLater => 'Quizás más tarde';

  @override
  String get emailAddress => 'Dirección de correo electrónico';

  @override
  String get password => 'Contraseña';

  @override
  String get firstName => 'Nombre';

  @override
  String get lastName => 'Apellido';

  @override
  String get login => 'Iniciar sesión';

  @override
  String get signUp => 'Regístrate';

  @override
  String get welcomeBack => 'Bienvenido de nuevo';

  @override
  String get loginSubtitle => 'Inicia sesión para seguir cuidando tu jardín.';

  @override
  String get signUpSubtitle =>
      'Únase a nosotros y comience a construir su santuario verde.';

  @override
  String get forgotPassword => '¿Olvidaste tu contraseña?';

  @override
  String get enterEmailPassword =>
      'Por favor ingrese su correo electrónico y contraseña.';

  @override
  String get fillAllFields => 'Por favor complete todos los campos.';

  @override
  String authError(String error) {
    return 'Algo salió mal: $error';
  }

  @override
  String get loginWith => 'O inicia sesión con';

  @override
  String get signUpWith => 'O regístrate con';

  @override
  String get noAccount => '¿No tienes una cuenta?';

  @override
  String get alreadyAccount => '¿Ya tienes una cuenta?';

  @override
  String get developerSession => 'Crear sesión de desarrollador';

  @override
  String get welcomeBotaniq => 'Bienvenido a Botaniq';

  @override
  String get loginOptionsSubtitle =>
      'Inicie sesión o regístrese para hacer una copia de seguridad de sus plantas, horarios y preferencias.';

  @override
  String get notificationAccessTitle => 'No te pierdas un riego';

  @override
  String get notificationAccessSubtitle =>
      'Le recordaremos amablemente cuándo es el momento de cuidar a sus amigos ecológicos. El cuidado de las plantas se realiza sin esfuerzo y sin estrés.';

  @override
  String get notificationTurnOn => 'Activar recordatorios';

  @override
  String get creatingClimate => 'Analizando su microclima...';

  @override
  String get creatingSchedules => 'Personalizando los horarios de atención...';

  @override
  String get creatingSanctuary => 'Preparando tu santuario verde...';

  @override
  String get locationAccessTitle => 'Acceso a la ubicación';

  @override
  String get locationAccessSubtitle =>
      'Personalice el cuidado de las plantas según su microclima local.';

  @override
  String get locationRecommendation => 'Recomendaciones locales';

  @override
  String get locationRecommendationSubtitle =>
      'Plantas que prosperan en el clima de su área';

  @override
  String get locationWeather => 'Sincronización meteorológica inteligente';

  @override
  String get locationWeatherSubtitle =>
      'Los horarios se ajustan a la lluvia local en tiempo real';

  @override
  String get locationAlerts => 'Alertas de heladas y calor';

  @override
  String get locationAlertsSubtitle =>
      'Reciba notificaciones antes de que llegue el clima extremo';

  @override
  String get locationEnable => 'Habilitar acceso a la ubicación';

  @override
  String get wherePlantsTitle => '¿Dónde están tus plantas?';

  @override
  String get wherePlantsSubtitle =>
      'Seleccione todo lo que corresponda para personalizar sus horarios de atención.';

  @override
  String get locationIndoor => 'interior';

  @override
  String get locationIndoorSubtitle => 'Salón, dormitorio, oficina.';

  @override
  String get locationBalcony => 'Balcón';

  @override
  String get locationBalconySubtitle =>
      'Plantas en macetas en una terraza o terraza.';

  @override
  String get locationGarden => 'jardín';

  @override
  String get locationGardenSubtitle =>
      'Plantas y macizos de flores enterrados.';

  @override
  String get helpTitleBefore => '¿Qué podemos';

  @override
  String get helpTitleHighlight => 'ayudarte';

  @override
  String get helpTitleAfter => 'con?';

  @override
  String get helpSubtitle =>
      'Seleccione una o más porterías para personalizar su jardín.';

  @override
  String get helpHeal => 'sanar enfermo\nplantas';

  @override
  String get helpCare => 'cuidado\nrecordatorios';

  @override
  String get helpIdentify => 'Identificar\nespecie';

  @override
  String get helpJournal => 'Crecimiento\ndiario';

  @override
  String get helpOther => 'algo mas';

  @override
  String get journeyTitle => 'Tu viaje ecológico';

  @override
  String get journeySubtitle =>
      'Seleccione el nivel de atención que desea brindar.';

  @override
  String get journeyCasualLabel => 'CASUAL';

  @override
  String get journeyCasualTitle => 'Bajo mantenimiento';

  @override
  String get journeyCasualSubtitle =>
      'Sólo quiero mantener mis plantas simples vivas y prósperas.';

  @override
  String get journeyEnthusiastLabel => 'ENTUSIASTA';

  @override
  String get journeyEnthusiastTitle => 'Cuidado equilibrado';

  @override
  String get journeyEnthusiastSubtitle =>
      'Disfruto pasar un tiempo semanal con mi creciente colección.';

  @override
  String get journeyObsessedLabel => 'OBSESIONADO';

  @override
  String get journeyObsessedTitle => 'Padre de planta extraordinario';

  @override
  String get journeyObsessedSubtitle =>
      'Vivo para mis plantas y quiero horarios expertos para mi jungla interior.';

  @override
  String get masteryTitleBefore => '¿Cómo está tu';

  @override
  String get masteryTitleHighlight => 'verde\npulgar';

  @override
  String get masteryTitleAfter => 'últimamente?';

  @override
  String get masterySubtitle =>
      'Sea honesto: todos hemos sido \"el asesino en serie\" en algún momento. Selecciona tu dominio actual.';

  @override
  String get masteryKiller => 'El asesino en serie';

  @override
  String get masteryKillerSubtitle =>
      'Incluso mis plantas de plástico parecen preocupadas cuando entro en la habitación.';

  @override
  String get masteryAccidental => 'Padre accidental';

  @override
  String get masteryAccidentalSubtitle =>
      'Mi cactus ha sobrevivido dos semanas. Todavía nos estamos conociendo.';

  @override
  String get masteryGrowth => 'Mentalidad de crecimiento';

  @override
  String get masteryGrowthSubtitle =>
      'La mayoría de mis amigos tienen hojas. Conozco mis Monsteras de mis Pothos.';

  @override
  String get masteryWhisperer => 'Susurrador de plantas';

  @override
  String get masteryWhispererSubtitle =>
      'Propago plantas raras y hablo latín botánico con fluidez.';

  @override
  String get onboardingOneTitle => 'Cuídate\nde tus plantas';

  @override
  String get onboardingOneHighlight => 'Como un profesional';

  @override
  String get onboardingOneSubtitle =>
      'Horarios inteligentes e identificación instantánea para tu jungla urbana.';

  @override
  String get onboardingOneBadge => 'CUIDADO IMPULSADO POR IA';

  @override
  String get onboardingAiScan => 'Escaneo AI';

  @override
  String get onboardingSmartWater => 'Agua inteligente';

  @override
  String get onboardingLightTracking => 'Seguimiento de luz';

  @override
  String get onboardingTwoTitle => 'Identificar Cualquiera\nplantar en';

  @override
  String get onboardingTwoHighlight => 'Segundos';

  @override
  String get onboardingTwoSubtitle =>
      'Tome una fotografía para conocer su nombre, especie y requisitos de cuidado.';

  @override
  String get onboardingTwoBadge => 'EXPERTO EN BOTÁNICA';

  @override
  String get onboardingSnapPhoto => 'Tomar foto';

  @override
  String get onboardingAccurateResult => 'Resultado preciso';

  @override
  String get onboardingPlantWiki => 'Wiki Plantas';

  @override
  String get onboardingThreeTitle => 'Nunca olvides\nal agua';

  @override
  String get onboardingThreeHighlight => 'otra vez';

  @override
  String get onboardingThreeSubtitle =>
      'Reciba recordatorios sincronizados con las necesidades y el entorno de su planta.';

  @override
  String get onboardingThreeBadge => 'HORARIOS INTELIGENTES';

  @override
  String get onboardingReminders => 'Recordatorios';

  @override
  String get onboardingClimateData => 'Datos climáticos';

  @override
  String get onboardingHealthyGrowth => 'Crecimiento saludable';

  @override
  String get onboardingCommunity => 'Únase a más de 50 000 padres de plantas';

  @override
  String get onboardingAgreement =>
      'AL CONTINUAR, ACEPTA NUESTROS TÉRMINOS Y POLÍTICA DE PRIVACIDAD';

  @override
  String get termsTitle => 'Términos y políticas';

  @override
  String get termsUpdated => 'Última actualización: julio de 2026';

  @override
  String get termsUseTitle => '1. Términos de uso';

  @override
  String get termsUseBody =>
      'Al acceder o utilizar Botaniq, usted acepta estos Términos de uso y las leyes aplicables. Si no está de acuerdo, no podrá utilizar el servicio.';

  @override
  String get termsPrivacyTitle => '2. Privacidad del usuario';

  @override
  String get termsPrivacyBody =>
      'Solo recopilamos los datos personales necesarios para proporcionar programas personalizados de cuidado de las plantas. No vendemos sus datos personales a terceros.';

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
  String get termsPlantTitle => '3. Datos de la planta';

  @override
  String get termsPlantBody =>
      'La información sobre el cuidado, la identificación y el diagnóstico de las plantas se proporciona con fines informativos. Es posible que los resultados de la IA no siempre sean correctos, así que observe su planta y busque un experto para detectar riesgos graves.';

  @override
  String get termsLiabilityTitle => '6. Disclaimers, Liability, and Indemnity';

  @override
  String get termsLiabilityBody =>
      'Botaniq is provided \"as is\" and \"as available,\" without warranties of any kind, express or implied, including accuracy, reliability, or fitness for a particular purpose. To the fullest extent permitted by law, we and our service providers are not liable for any indirect, incidental, special, or consequential damages, or for any loss of data, plants, or property arising from your use of the service, and our total liability for any claim is limited to the amount you paid us, if any, in the twelve months before the claim. You agree to indemnify and hold us harmless from claims arising from your use of the service, your content, or your violation of these Terms or applicable law.';

  @override
  String get termsPremiumTitle => '4. Suscripciones premium';

  @override
  String get termsPremiumBody =>
      'Su suscripción Premium mensual o anual se carga a su cuenta de Apple o Google después de la confirmación de la compra. Se renueva automáticamente a menos que se cancele al menos 24 horas antes de que finalice el período actual. Puedes gestionarlo o cancelarlo en la configuración de tu cuenta de tienda. Las solicitudes de reembolso se manejan según la política de la tienda aplicable.';

  @override
  String get termsLawTitle => '8. Governing Law and Changes';

  @override
  String get termsLawBody =>
      'These Terms are governed by the laws of the jurisdiction in which we operate, without regard to conflict-of-law principles, and any dispute will be resolved under that jurisdiction\'s applicable procedures to the fullest extent permitted by law. We may update these Terms and our data practices at any time by posting the revised version in the app.';

  @override
  String get termsClosing => 'Disfrute de tranquilidad y plantas más felices.';

  @override
  String get weatherTitle => 'El tiempo';

  @override
  String get weatherSunnyTip =>
      'Hoy hace sol: revise la tierra antes de regar.';

  @override
  String get weatherCloudyTip =>
      'El tiempo nublado ralentiza la evaporación; regar un poco menos.';

  @override
  String get weatherRainyTip =>
      'Lluvioso y húmedo: evite regar en exceso las plantas de exterior.';

  @override
  String get weatherStormTip =>
      'Clima tormentoso: traslade las macetas delicadas a un lugar protegido.';

  @override
  String get weatherSnowTip =>
      'Frío y nieve: proteja las plantas de los cambios de temperatura.';
}
