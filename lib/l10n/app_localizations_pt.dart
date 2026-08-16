// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appTitle => 'Botaniq';

  @override
  String get settings => 'Configurações';

  @override
  String get preferences => 'Preferências';

  @override
  String get darkMode => 'Modo escuro';

  @override
  String get metricSystem => 'Sistema Métrico';

  @override
  String get metricSystemSubtitle => 'Use Celsius e Metros';

  @override
  String get account => 'Conta';

  @override
  String get editProfile => 'Editar perfil';

  @override
  String get changePassword => 'Alterar palavra-passe';

  @override
  String get subscriptionManagement => 'Gestão de assinaturas';

  @override
  String get premium => 'Prémio';

  @override
  String get language => 'Idioma';

  @override
  String get languageSubtitle => 'Alterar o idioma da aplicação';

  @override
  String get selectLanguage => 'Selecione o idioma';

  @override
  String get systemLanguage => 'Idioma do sistema';

  @override
  String get english => 'Inglês';

  @override
  String get turkish => 'Turquia';

  @override
  String get languageChanged => 'Idioma alterado com sucesso.';

  @override
  String get languageSearchHint => 'Idiomas de pesquisa';

  @override
  String get languageRecommended => 'Recomendado';

  @override
  String get languageWelcomeTitle => 'Escolha o seu idioma';

  @override
  String get languageWelcomeSubtitle =>
      'Selecione o idioma que pretende utilizar no Botaniq. Pode alterá-lo a qualquer momento.';

  @override
  String get languageUseSystem => 'Utilizar o idioma do dispositivo';

  @override
  String get preferenceSystem => 'Utilizar configuração do sistema';

  @override
  String get themeLight => 'Luz';

  @override
  String get themeDark => 'Escuro';

  @override
  String get themeSelectionTitle => 'Escolha a aparência';

  @override
  String get measurementMetric => 'Métrica';

  @override
  String get measurementImperial => 'Imperial';

  @override
  String get measurementSelectionTitle => 'Escolha o sistema de medição';

  @override
  String get settingsSubtitle =>
      'Molde o Botaniq de acordo com o seu próprio ritmo de cuidado.';

  @override
  String get settingsLocalPreference => 'Salvo neste dispositivo';

  @override
  String get settingsDarkModeSubtitle =>
      'Uma paleta mais calma para momentos de pouca luz';

  @override
  String get settingsAccountSubtitle => 'Identidade, acesso e adesão';

  @override
  String get settingsEditProfileSubtitle =>
      'Nome, localização e preferências de cuidados';

  @override
  String get settingsPasswordSubtitle =>
      'Envie um link de redefinição seguro para o seu e-mail';

  @override
  String get settingsSubscriptionSubtitle =>
      'Plano premium e detalhes de faturação';

  @override
  String get settingsPasswordResetSent =>
      'E-mail de redefinição de palavra-passe enviado.';

  @override
  String get settingsComingSoon => 'Este espaço ainda está a crescer.';

  @override
  String get subscriptionPageTitle => 'Assinatura Premium';

  @override
  String get subscriptionHeroEyebrow => 'BOTANIQ PREMIUM';

  @override
  String get subscriptionHeroTitle =>
      'Cuidado mais inteligente para cada planta';

  @override
  String get subscriptionHeroSubtitle =>
      'Desbloqueie todas as ferramentas de cuidado premium e aumente o seu espaço verde com confiança.';

  @override
  String get subscriptionBenefitsTitle => 'Tudo em Premium';

  @override
  String get subscriptionBenefitIdentification =>
      'Identificação ilimitada de plantas e análise de saúde';

  @override
  String get subscriptionBenefitCare =>
      'Planos de cuidados personalizados e lembretes';

  @override
  String get subscriptionBenefitInsights =>
      'Conteúdo especializado e insights de cuidados avançados';

  @override
  String get subscriptionMonthlyPlan => 'Mensalmente';

  @override
  String get subscriptionAnnualPlan => 'Anual';

  @override
  String subscriptionPerMonth(String price) {
    return '$price/mês';
  }

  @override
  String subscriptionPerYear(String price) {
    return '$price/ano';
  }

  @override
  String get subscriptionBestValue => 'MELHOR VALOR';

  @override
  String subscriptionSavePercent(int percent) {
    return 'Poupe $percent%';
  }

  @override
  String get subscriptionContinue => 'Desbloquear Premium';

  @override
  String get subscriptionRestorePurchases => 'Restaurar compras';

  @override
  String get subscriptionRestoring => 'Restaurando...';

  @override
  String get subscriptionManage => 'Gerir assinatura';

  @override
  String get subscriptionActiveTitle => 'A sua assinatura Premium está ativa';

  @override
  String get subscriptionActiveSubtitle =>
      'Tem acesso a todos os recursos premium.';

  @override
  String subscriptionRenewsOn(String date) {
    return 'Renova em $date';
  }

  @override
  String subscriptionExpiresOn(String date) {
    return 'Ativo até $date';
  }

  @override
  String get subscriptionAutoRenewDisclosure =>
      'O pagamento é cobrado na sua conta Apple ou Google. A subscrição é renovada automaticamente, a menos que seja cancelada pelo menos 24 horas antes do final do período atual. Pode gerir ou cancelar a qualquer momento nas definições da conta da sua loja.';

  @override
  String get subscriptionTermsLink => 'Termos de Utilização';

  @override
  String get subscriptionPrivacyLink => 'Política de Privacidade';

  @override
  String get subscriptionPurchaseSuccess =>
      'A sua subscrição Premium está agora ativa.';

  @override
  String get subscriptionRestoreSuccess =>
      'A sua assinatura Premium foi restaurada.';

  @override
  String get subscriptionNothingToRestore =>
      'Não foi encontrada nenhuma associação ativa para esta conta da loja.';

  @override
  String get subscriptionPaymentPending =>
      'O pagamento aguarda aprovação da loja. A sua subscrição será ativada automaticamente assim que for aprovada.';

  @override
  String get subscriptionErrorGeneric =>
      'A operação não pôde ser concluída. Por favor, tente novamente.';

  @override
  String get subscriptionErrorNetwork =>
      'Verifique a sua ligação à Internet e tente novamente.';

  @override
  String get subscriptionErrorNotAllowed =>
      'Este dispositivo ou conta de loja não tem permissão para fazer compras.';

  @override
  String get subscriptionErrorStore =>
      'Não foi possível contactar a loja. Por favor, tente novamente em breve.';

  @override
  String get subscriptionMissingConfiguration =>
      'A chave RevenueCat está em falta nesta compilação.';

  @override
  String get subscriptionUnsupported =>
      'As subscrições estão disponíveis apenas nas aplicações iOS e Android.';

  @override
  String get subscriptionProductsUnavailable =>
      'Não foi possível carregar produtos mensais e anuais. Verifique a configuração da oferta RevenueCat.';

  @override
  String get subscriptionRetry => 'Tente novamente';

  @override
  String get subscriptionFree => 'Grátis';

  @override
  String get homeGoodMorning => 'Olá,';

  @override
  String homePersonalGreeting(String greeting, String name) {
    return '$greeting, $name 👋';
  }

  @override
  String get homeEmptyGarden => 'O seu jardim está vazio';

  @override
  String get homeEmptyGardenSubtitle =>
      'Comece a construir o seu santuário verde\nacrescentando a sua primeira planta.';

  @override
  String get homeAddFirstPlant => 'Adicionar a primeira planta';

  @override
  String get homeMyPlants => 'As minhas plantas';

  @override
  String get homeViewAll => 'Ver tudo';

  @override
  String get homeSmartCareReminders => 'Lembretes de cuidados inteligentes';

  @override
  String get homeWatering => 'Rega';

  @override
  String get homeWateringSubtitle => 'Rastreamento de solo';

  @override
  String get homeFertilizing => 'Fertilizando';

  @override
  String get homeFertilizingSubtitle => 'Alertas de nutrientes';

  @override
  String get gardenTitle => 'O meu jardim';

  @override
  String get gardenAllPlants => 'Todas as plantas';

  @override
  String get gardenNeedsWater => 'Precisa de água';

  @override
  String get gardenIndoor => 'Interior';

  @override
  String get gardenNoPlants =>
      'Ainda não há plantas.\nToque em + para adicionar a sua primeira planta!';

  @override
  String get gardenNoPlantsCategory => 'Nenhuma planta nesta categoria.';

  @override
  String get discoverTitle => 'Descubra';

  @override
  String get discoverSearchHint => 'Pesquise plantas, artigos, guias...';

  @override
  String get discoverLatestArticles => 'Últimos artigos';

  @override
  String get discoverSeeAll => 'Ver tudo';

  @override
  String get discoverTrendingGuides => 'Guias de tendências';

  @override
  String get healthyTitle => 'Centro de atendimento';

  @override
  String get healthySubtitle =>
      'Toque na alma das suas plantas, converse com elas.';

  @override
  String get healthyTabDoctor => 'Doutor';

  @override
  String get healthyTabHospital => 'Hospitais';

  @override
  String get healthyTabDiscover => 'Descubra';

  @override
  String get profileTitle => 'O meu perfil';

  @override
  String get profileEditProfile => 'Editar perfil';

  @override
  String get profileOverview => 'Visão geral';

  @override
  String get profileSettingsTab => 'Configurações';

  @override
  String get profileGardenerLevel => 'Nível Jardineiro';

  @override
  String get profileTotalPlants => 'Total de plantas';

  @override
  String get profileCompletedTasks => 'Tarefas Concluídas';

  @override
  String get profileWeeklyActivity => 'Atividade de cuidados semanal';

  @override
  String get profileGeneral => 'Geral';

  @override
  String get profileAppSettings => 'Configurações do aplicativo';

  @override
  String get profileNotificationPrefs => 'Preferências de notificação';

  @override
  String get profileSupportLegal => 'Suporte e Jurídico';

  @override
  String get profileHelpCenter => 'Central de Ajuda';

  @override
  String get profileTerms => 'Termos de Utilização e Políticas';

  @override
  String get profileSignOut => 'Sair';

  @override
  String get profileDeleteAccount => 'Apagar conta';

  @override
  String get profileSubtitle =>
      'A história do seu jardim, o progresso e o espaço pessoal.';

  @override
  String get profileGardenPassport => 'PASSAPORTE DE JARDIM';

  @override
  String get profileThisWeek => 'Esta semana';

  @override
  String get profileQuietWeek =>
      'Uma semana tranquila — o seu próximo momento de cuidados aparecerá aqui.';

  @override
  String get profileActiveWeek =>
      'O seu ritmo de cuidado está vivo e a crescer.';

  @override
  String get profileAppSettingsSubtitle => 'Idioma, unidades e ligação AI';

  @override
  String get profileNotificationPrefsSubtitle =>
      'Escolha quais os momentos de cuidado que lhe chegam';

  @override
  String get profileHelpCenterSubtitle => 'Respostas e orientação rápida';

  @override
  String get profileTermsSubtitle => 'Privacidade, termos e políticas';

  @override
  String get profileAccountActions => 'Ações da conta';

  @override
  String get profileSignOutQuestion => 'Tem a certeza de que quer sair?';

  @override
  String get profileDeleteAccountWarning =>
      'A eliminação da conta necessita de uma confirmação segura do servidor. Os seus dados não foram alterados.';

  @override
  String get cancel => 'Cancelar';

  @override
  String get continueAction => 'Continuar';

  @override
  String get profileTitleNew => 'Novo Jardineiro 🌱';

  @override
  String get profileTitleSprout => 'Amigo Broto 🌿';

  @override
  String get profileTitleLeaf => 'Amante de Folhas ☘️';

  @override
  String get profileTitleSkilled => 'Jardineiro habilidoso 🏡';

  @override
  String get profileTitleMaster => 'Mestre do Polegar Verde 👑';

  @override
  String get profileNextLevelStart =>
      'Adicione a sua primeira planta e comece a sua aventura de jardinagem!';

  @override
  String profileNextLevelLeaf(int count) {
    return 'Restam apenas plantas $count para se tornarem Leaf Lover.';
  }

  @override
  String profileNextLevelSkilled(int count) {
    return 'Restam apenas $count plantas para se tornar um Jardineiro Habilidoso.';
  }

  @override
  String profileNextLevelMaster(int count) {
    return 'Restam apenas plantas $count para se tornarem Green Thumb Master.';
  }

  @override
  String get profileNextLevelMax => 'Está no topo do seu jardim, parabéns!';

  @override
  String get navHome => 'Página inicial';

  @override
  String get navGarden => 'Jardim';

  @override
  String get navClinic => 'Clínica';

  @override
  String get navProfile => 'Perfil';

  @override
  String get scanPlant => 'Planta de digitalização';

  @override
  String get deletePlantTitle => 'Remover esta planta?';

  @override
  String get deletePlantMessage =>
      'A planta, as suas tarefas de cuidado e os registos da Clínica serão removidos permanentemente da sua conta.';

  @override
  String get deletePlantAction => 'Remover planta';

  @override
  String get deletePlantNotFound =>
      'A planta não foi encontrada ou já foi removida.';

  @override
  String deletePlantError(String error) {
    return 'A planta não pôde ser removida: $error';
  }

  @override
  String get profileChoosePhoto => 'Escolha a fotografia de perfil';

  @override
  String get profileFullName => 'Nome Completo';

  @override
  String get profileFullNameHint => 'Introduza o seu nome completo';

  @override
  String get profileNickname => 'Apelido';

  @override
  String get profileNicknameHint => 'Como devemos ligar-lhe?';

  @override
  String get profileAge => 'Idade';

  @override
  String get profileAgeHint => '1–120';

  @override
  String get profileAgeValidation => 'Introduza uma idade entre 1 e 120 anos.';

  @override
  String profileLoadError(String error) {
    return 'Não foi possível carregar o perfil: $error';
  }

  @override
  String get languageEnglish => 'Inglês';

  @override
  String get languageTurkish => 'Turco';

  @override
  String get profileEmailReadOnly => 'Endereço de e-mail (apenas leitura)';

  @override
  String get profileEmailHint => 'Introduza o seu e-mail';

  @override
  String get profileLocation => 'Localização';

  @override
  String get profileLocationHint => 'Cidade, País';

  @override
  String get profileSaveChanges => 'Guardar alterações';

  @override
  String get profileUpdated => 'O seu perfil foi atualizado.';

  @override
  String profileSaveError(String error) {
    return 'Não foi possível guardar o perfil: $error';
  }

  @override
  String get notificationWateringTitle => 'Lembretes de rega';

  @override
  String get notificationWateringSubtitle =>
      'Seja notificado quando chegar a altura de regar';

  @override
  String get notificationFertilizerTitle => 'Lembretes de fertilizantes';

  @override
  String get notificationFertilizerSubtitle =>
      'Alertas de alimentação sazonal para as suas plantas';

  @override
  String get notificationTitle => 'Notificações';

  @override
  String get notificationPlantCareAlerts =>
      'Alertas de cuidados com as plantas';

  @override
  String get notificationOther => 'Outras notificações';

  @override
  String get notificationWeatherTitle => 'Alertas meteorológicos';

  @override
  String get notificationWeatherSubtitle => 'Avisos meteorológicos extremos';

  @override
  String get notificationArticlesTitle => 'Novos artigos';

  @override
  String get notificationArticlesSubtitle =>
      'Dicas e truques para o seu jardim';

  @override
  String get gardenMyPlantFallback => 'A minha planta';

  @override
  String get gardenClinicBadge => 'Na clínica';

  @override
  String get wateringNever => 'Última rega: Nunca';

  @override
  String wateringLastDate(String date) {
    return 'Última rega: $date';
  }

  @override
  String wateringInterval(int days) {
    return 'A cada $days dias';
  }

  @override
  String get wateringNeverDue => 'Ainda não regado • Regue hoje';

  @override
  String wateringOverdue(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days dias em atraso',
      one: '1 dia em atraso',
      zero: 'Regar hoje',
    );
    return '$_temp0';
  }

  @override
  String get wateringDueToday => 'Água hoje';

  @override
  String get wateringDueTomorrow => 'Água amanhã';

  @override
  String wateringDueInDays(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'Regar dentro de $days dias',
      one: 'Regar dentro de 1 dia',
      zero: 'Regar hoje',
    );
    return '$_temp0';
  }

  @override
  String get plantUnknown => 'Planta Desconhecida';

  @override
  String get plantSpeciesFallback => 'Espécies de Plantas';

  @override
  String get plantDifficultyMedium => 'Médio';

  @override
  String get plantAbout => 'Sobre';

  @override
  String get plantLocationEnvironment => 'Localização e Ambiente';

  @override
  String get plantCareProtocol => 'Protocolo de Cuidados';

  @override
  String get plantCareHistory => 'Histórico de cuidados dos últimos 10 dias';

  @override
  String get plantHealthy => 'Saudável';

  @override
  String get plantInClinic => 'Na clínica';

  @override
  String get plantDifficulty => 'Dificuldade';

  @override
  String get plantToxicity => 'Toxicidade';

  @override
  String get plantEnvironment => 'Meio Ambiente';

  @override
  String get plantLightNeed => 'Necessidade de luz';

  @override
  String get plantToxicPets => 'Tóxico para animais de estimação';

  @override
  String get plantNonToxic => 'Não tóxico';

  @override
  String get plantIndoor => 'Interior';

  @override
  String get plantBrightIndirect => 'Indireto Brilhante';

  @override
  String get plantInfoUnavailable =>
      'As informações verificadas ainda não estão disponíveis.';

  @override
  String get plantIdealClimate => 'Clima Ideal';

  @override
  String get plantHumidity => 'Umidade';

  @override
  String get plantTemperatureRange => 'Faixa de temperatura';

  @override
  String get plantWateringFrequency => 'Frequência de rega';

  @override
  String plantWateringFrequencyValue(String interval) {
    return 'Água $interval.';
  }

  @override
  String get plantNextWatering => 'Próxima rega';

  @override
  String get plantWateringProtocol => 'Protocolo de rega';

  @override
  String get plantSoilProtocol => 'Solo';

  @override
  String get plantFeedingProtocol => 'Protocolo de Alimentação';

  @override
  String get plantPruningCleaning => 'Poda e Limpeza';

  @override
  String get plantPruningFallback =>
      'Limpe as folhas mensalmente. Podar as folhas mortas ou amareladas para estimular o crescimento.';

  @override
  String get plantHistoryEmpty =>
      'Sem histórico de cuidados nos últimos 10 dias.';

  @override
  String get plantWateringTask => 'Rega';

  @override
  String get plantFertilizingTask => 'Fertilizando';

  @override
  String get plantWateredAction => 'Regado ✓';

  @override
  String get plantWaterNowAction => 'Água agora';

  @override
  String get plantFertilizedAction => 'Fertilizado ✓';

  @override
  String get plantFertilizeAction => 'Fertilizar';

  @override
  String get plantAddGardenAction => 'Adicionar ao meu jardim';

  @override
  String get plantWaterSuccess => '💧 Regou a sua planta! Ótimo trabalho!';

  @override
  String get plantFertilizeSuccess =>
      '🌱 Fertilizante adicionado! A sua planta agradece!';

  @override
  String plantWaterError(String error) {
    return 'A rega não pôde ser salva: $error';
  }

  @override
  String plantFertilizeError(String error) {
    return 'A fecundação não pôde ser salva: $error';
  }

  @override
  String get clinicQuickTools => 'Ferramentas rápidas';

  @override
  String get clinicDoctorHero => 'Médico de plantas de IA\nAo seu serviço';

  @override
  String get clinicStartConsultation => 'Iniciar consulta';

  @override
  String get clinicChoosePlant => 'Qual a planta que gostaria de discutir?';

  @override
  String get clinicChoosePlantSubtitle =>
      'Escolha uma planta do seu jardim ou tire uma nova fotografia.';

  @override
  String get clinicNoGardenPlants =>
      'Ainda não existem plantas no seu jardim.\nComece por tirar uma nova foto.';

  @override
  String get clinicNewPhoto => 'Tire uma nova fotografia';

  @override
  String get clinicNewPhotoSubtitle =>
      'Fotografe a planta doente e obtenha um diagnóstico';

  @override
  String get clinicPestAnalysis => 'Análise de pragas';

  @override
  String get clinicVisualDiagnosis => 'Diagnóstico visual';

  @override
  String get clinicLightMeter => 'Medidor de luz';

  @override
  String get clinicSensorSimulation => 'Simulação de sensores';

  @override
  String get clinicTitle => 'Clínica de Plantas';

  @override
  String clinicSickCount(int count) {
    return '$count Doente';
  }

  @override
  String get clinicAllHealthy => 'Todas as suas plantas estão saudáveis! 🌿';

  @override
  String get clinicEmpty =>
      'Não existem plantas doentes na Clínica.\nSe está preocupado com uma planta,\npergunte no separador Médico.';

  @override
  String get clinicUnknown => 'Desconhecido';

  @override
  String get clinicPendingDiagnosis => 'Aguarda diagnóstico';

  @override
  String get clinicNoTreatment => 'O tratamento não foi determinado';

  @override
  String get clinicPrescription => 'Prescrição:';

  @override
  String get clinicRecovery => 'Recuperação';

  @override
  String get clinicRecovered => 'Recuperado';

  @override
  String get clinicContinue => 'Continuar';

  @override
  String get clinicRecoveredSuccess =>
      '🎉A sua planta está novamente saudável!';

  @override
  String get clinicUrgencyLow => 'Baixo';

  @override
  String get clinicUrgencyMedium => 'Médio';

  @override
  String get clinicUrgencyCritical => 'Crítico';

  @override
  String get healthTrendingTips => 'Tendências de dicas de saúde';

  @override
  String get healthHumidityArticleTitle =>
      'Preparação para o inverno: manter a humidade equilibrada';

  @override
  String get healthHumidityArticleSubtitle =>
      'Como proteger as suas plantas do ar seco do radiador durante os meses frios.';

  @override
  String get healthWeeklySpotlight => 'Doente e Remédio da Semana';

  @override
  String get healthAphidTitle => 'Infestação de pulgões';

  @override
  String get healthAphidSubtitle =>
      'Intervenção precoce e tratamento natural com óleo de Neem.';

  @override
  String get healthDiscoverLoadError =>
      'Não foi possível carregar o conteúdo do Discover de momento. Puxe para baixo para tentar novamente.';

  @override
  String get healthDiscoverEmpty =>
      'Ainda não há conteúdo de descoberta publicado.';

  @override
  String get healthDiscoverRetry => 'Tente novamente';

  @override
  String get lightMeterTitle => 'Medidor de luz';

  @override
  String get lightMeterInstructionTitle => 'Para medir a luz';

  @override
  String get lightMeterInstruction =>
      'Aponte a câmara frontal do telefone para\na posição da planta e a fonte de luz.';

  @override
  String get lightMeterCameraEstimate =>
      'Lux aproximado calculado a partir dos dados da câmara';

  @override
  String get lightMeterStabilizing => 'Medição de estabilização';

  @override
  String get lightMeterStabilizingRecommendation =>
      'Segure o telefone firmemente durante alguns segundos, enquanto as mudanças repentinas de exposição são filtradas.';

  @override
  String get lightMeterUnavailable => 'Medição indisponível';

  @override
  String get lightMeterUnavailableRecommendation =>
      'Ative a permissão da câmara e tente este ecrã novamente.';

  @override
  String get lightLow => 'Pouca luz (sombra)';

  @override
  String get lightMedium => 'Luz média (sala iluminada)';

  @override
  String get lightHigh => 'Luz alta (perto da janela)';

  @override
  String get lightVeryHigh => 'Luz muito alta (sol direto)';

  @override
  String get lightLowRecommendation =>
      'Adequado para Calathea, fetos ou plantas cobra.';

  @override
  String get lightMediumRecommendation =>
      'Ideal para Monstera, Ficus e Antúrio.';

  @override
  String get lightHighRecommendation =>
      'Adequado para Aloé, cactos e gerânios amantes do sol.';

  @override
  String get lightVeryHighRecommendation =>
      'Melhor para plantas de exterior e suculentas.';

  @override
  String get homeLoadingPlants => 'Plantas de carga...';

  @override
  String get homeNotifications => 'Notificações';

  @override
  String get homeWateringTime => 'Tempo de rega';

  @override
  String get homeWateringNotification =>
      'As suas plantas de interior precisam de rega.';

  @override
  String get homeWelcome => 'Bem-vindo!';

  @override
  String get homeWelcomeNotification =>
      'Bem-vindo ao Botaniq. Comece por adicionar a sua primeira planta.';

  @override
  String get homeTenMinutesAgo => 'Há 10 minutos';

  @override
  String get homeOneDayAgo => 'Há 1 dia';

  @override
  String get homeQuickActions => 'Ações rápidas';

  @override
  String get homeIdentifyCamera => 'Identifique-se com a sua câmara';

  @override
  String get homeTomorrow => 'Amanhã';

  @override
  String get homeNoTasks => 'Sem tarefa para este dia!';

  @override
  String get homeAllCared => 'As suas plantas estão todas cuidadas 🌿';

  @override
  String get homeOverdue => 'ATRASADO';

  @override
  String get homeInstructions => 'Instruções';

  @override
  String homeRequiredAmount(String amount) {
    return 'Obrigatório: $amount';
  }

  @override
  String get homeLater => 'Mais tarde';

  @override
  String get homeMarkDone => 'Marcar como concluído';

  @override
  String get homeSickPlants => 'Clínica de Plantas';

  @override
  String homeSickCount(int count) {
    return '$count Doente';
  }

  @override
  String get homeGreetingMorning => 'Bom dia';

  @override
  String get homeGreetingAfternoon => 'Boa tarde';

  @override
  String get homeGreetingEvening => 'Boa noite';

  @override
  String get homeTodayTasks => 'Tarefas de hoje';

  @override
  String get homeTomorrowTasks => 'Tarefas de amanhã';

  @override
  String homeDateTasks(String date) {
    return '$date Tarefas';
  }

  @override
  String get commonSkip => 'Pular';

  @override
  String get commonContinue => 'Continuar';

  @override
  String get commonClose => 'Fechar';

  @override
  String get commonDelete => 'Excluir';

  @override
  String get commonBack => 'Voltar';

  @override
  String get commonUnknown => 'Desconhecido';

  @override
  String get wizardSaveGarden => 'Guardar e adicionar ao jardim';

  @override
  String wizardPlantAdded(String name) {
    return '$name foi adicionado ao seu jardim! 🌿';
  }

  @override
  String get wizardRoomTitle => 'Onde está a sua planta?';

  @override
  String get wizardRoomSubtitle =>
      'Categorize a sua planta por divisão para a gerir facilmente.';

  @override
  String get wizardLivingRoom => 'Sala de estar';

  @override
  String get wizardBedroom => 'Quarto';

  @override
  String get wizardKitchen => 'Cozinha';

  @override
  String get wizardOffice => 'Escritório';

  @override
  String get wizardBathroom => 'Banheiro';

  @override
  String get wizardBalcony => 'Varanda';

  @override
  String get wizardLightTitle => 'Como está a luz neste local?';

  @override
  String get wizardLightSubtitle =>
      'A luz é um dos fatores mais importantes para a saúde da sua planta.';

  @override
  String get wizardDirectSun => 'Sol direto';

  @override
  String get wizardDirectSunDescription =>
      'Luz solar não filtrada diretamente na planta';

  @override
  String get wizardBrightIndirect => 'Indireto Brilhante';

  @override
  String get wizardBrightIndirectDescription =>
      'Perto de uma janela virada para leste ou oeste';

  @override
  String get wizardMediumLight => 'Luz média';

  @override
  String get wizardMediumLightDescription => 'A poucos metros de uma janela';

  @override
  String get wizardLowLight => 'Pouca luz';

  @override
  String get wizardLowLightDescription =>
      'Longe das janelas ou sob luz artificial';

  @override
  String get wizardDistanceTitle => 'Distância até à janela';

  @override
  String get wizardDistanceSubtitle =>
      'Selecione a distância aproximada até à janela mais próxima.';

  @override
  String get wizardMoreThanFiveMeters => 'Mais de 5 metros';

  @override
  String get wizardActiveHoursTitle => 'Horas de luz ativas';

  @override
  String get wizardActiveHoursSubtitle =>
      'Quantas horas de luz direta ou brilhante recebe este spot?';

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
      'Quando foi esta planta replantada pela última vez?';

  @override
  String get wizardRepottedSubtitle =>
      'O solo fresco é crucial para uma planta feliz.';

  @override
  String get wizardRecently => 'Recentemente (menos de 3 meses)';

  @override
  String get wizardSixMonthsAgo => 'Há 6 meses';

  @override
  String get wizardOneYearAgo => 'Há 1 ano';

  @override
  String get wizardTwoYearsAgo => 'há mais de 2 anos';

  @override
  String get wizardDontKnow => 'não sei';

  @override
  String get wizardPotTitle => 'De que material é o pote?';

  @override
  String get wizardPotSubtitle =>
      'O material do vaso afeta a rapidez com que o solo seca.';

  @override
  String get wizardPlasticPot => 'Plástico / Creche';

  @override
  String get wizardTerracottaPot => 'Terracota';

  @override
  String get wizardCeramicPot => 'Cerâmica / Esmaltada';

  @override
  String get wizardMetalPot => 'Metálico';

  @override
  String get wizardWateredTitle => 'Quando regou esta planta pela última vez?';

  @override
  String get wizardWateredSubtitle =>
      'Isto ajuda a calcular a próxima hora exata de rega.';

  @override
  String get wizardToday => 'Hoje';

  @override
  String get wizardYesterday => 'Ontem';

  @override
  String get wizardFewDaysAgo => 'Há alguns dias';

  @override
  String get wizardWeekAgo => 'Há uma semana';

  @override
  String get wizardMoreWeekAgo => 'Há mais de uma semana';

  @override
  String get historyTitle => 'Histórico de pesquisa';

  @override
  String get historyClearTitle => 'Limpar histórico';

  @override
  String get historyClearMessage =>
      'Todo o histórico de pesquisa e verificação será eliminado. Tem a certeza?';

  @override
  String get historyClearTooltip => 'Limpar histórico';

  @override
  String get historyEmptyTitle => 'Sem histórico de pesquisa';

  @override
  String get historyEmptySubtitle =>
      'As plantas digitalizadas com a câmara ou pesquisadas aparecerão aqui.';

  @override
  String get historyNoDetails =>
      'Informações detalhadas não estão disponíveis.';

  @override
  String get historyRegularWater => 'Rega regular';

  @override
  String get historyIndirectLight => 'Luz indireta';

  @override
  String get historyDescription => 'Descrição';

  @override
  String get historyWatering => 'Rega';

  @override
  String get historyLight => 'Luz';

  @override
  String get historyRecently => 'Recentemente';

  @override
  String historyMinutesAgo(int minutes) {
    return '$minutes minutos atrás';
  }

  @override
  String historyHoursAgo(int hours) {
    return '$hours horas atrás';
  }

  @override
  String get historyYesterday => 'Ontem';

  @override
  String get historyPlantRecord => 'Registo de pesquisa de plantas';

  @override
  String get photoWholeSpecimen => 'Foto do todo\nplanta ou cogumelo';

  @override
  String get photoWholeSpecimenSubtitle =>
      'Mantenha toda a amostra centrada na moldura para uma melhor identificação.';

  @override
  String get photoCorrect => 'Correto';

  @override
  String get photoTooClose => 'Muito perto';

  @override
  String get photoInstructions => 'Instruções';

  @override
  String get photoOpenCamera => 'Eu entendo, abra a câmara';

  @override
  String get scannerPlant => 'Planta';

  @override
  String get scannerMushroom => 'Cogumelo';

  @override
  String get scannerIdentifyingPlant => 'Identificando planta...';

  @override
  String get scannerIdentifyingMushroom => 'Identificando Cogumelo...';

  @override
  String get scannerCapture => 'Tire foto e digitalize';

  @override
  String get scannerFailed =>
      'Falha na digitalização. Por favor, tente novamente.';

  @override
  String scannerError(String error) {
    return 'Ocorreu um erro: $error';
  }

  @override
  String get scannerUnknownPlant => 'Planta Desconhecida';

  @override
  String get scannerUnknownMushroom => 'Cogumelo Desconhecido';

  @override
  String get scheduleTitle => 'Cronograma';

  @override
  String get scheduleTodayTask => 'Tarefas de hoje';

  @override
  String get scheduleNoTasks => 'Sem tarefa para hoje!';

  @override
  String get scheduleInstructions => 'Instruções';

  @override
  String scheduleRequired(String amount) {
    return 'Obrigatório: $amount';
  }

  @override
  String get scheduleRemindLater => 'Lembrar mais tarde';

  @override
  String get scheduleDone => 'Concluído';

  @override
  String get scheduleCareFallback => 'Cuide da sua planta.';

  @override
  String get chatDoctorTitle => 'Médico de plantas de IA';

  @override
  String chatPatient(String name) {
    return 'Doente: $name';
  }

  @override
  String get chatAnalyzing => 'Analisando...';

  @override
  String chatHint(String name) {
    return 'Pergunte sobre $name...';
  }

  @override
  String chatWelcome(String name) {
    return 'Olá! 🌿 Sou o seu médico de plantas de IA. Como posso ajudar com o $name?\n\nPosso diagnosticar uma foto ou responder às suas perguntas sobre cuidados.';
  }

  @override
  String chatContinueWelcome(String name) {
    return 'Olá! Vamos continuar com $name. 🌱';
  }

  @override
  String get chatQuestionYellowing => 'O que está a causar as folhas amarelas?';

  @override
  String get chatQuestionTreatment => 'Como posso tratar esta planta?';

  @override
  String get chatQuestionWatering => 'Devo alterar a frequência de rega?';

  @override
  String get chatQuestionFertilizer => 'Que fertilizante devo usar?';

  @override
  String get chatPhotoSent => 'Foto enviada';

  @override
  String get chatAnalyzePhoto => 'Analise a foto';

  @override
  String get chatDiagnosisUnknown => 'O diagnóstico não pôde ser determinado';

  @override
  String get chatNoTreatment => 'Sem recomendação de tratamento';

  @override
  String get chatRecoveryUnknown => 'Desconhecido';

  @override
  String get chatUnableIdentify => 'Planta não identificada';

  @override
  String chatError(String error) {
    return 'Desculpe, ocorreu um erro: $error. Por favor, tente novamente.';
  }

  @override
  String get chatCareTips => 'Dicas de cuidados';

  @override
  String get chatPlantLabel => 'Planta';

  @override
  String get chatDiagnosisLabel => 'Diagnóstico';

  @override
  String get chatTreatmentLabel => 'Tratamento';

  @override
  String get chatUrgencyLabel => 'Urgência';

  @override
  String get chatRecoveryLabel => 'Recuperação estimada';

  @override
  String get discoverMonsteraTitle =>
      'O segredo para o crescimento da Monstera';

  @override
  String get discoverIndoorPlants => 'Plantas de interior';

  @override
  String get discoverSucculentWatering => 'Guia de rega para suculentas';

  @override
  String get discoverCacti => 'Cactos e Suculentas';

  @override
  String get discoverHerbSoil => 'Melhores tipos de solo para ervas';

  @override
  String get discoverHerbs => 'Ervas';

  @override
  String get discoverPropagation => 'Propagação 101: Manual para Iniciados';

  @override
  String get discoverPests => 'Pragas comuns e como tratá-las';

  @override
  String get discoverRepotting => 'Repotting: quando e como?';

  @override
  String discoverMinutesRead(int minutes) {
    return '$minutes min de leitura';
  }

  @override
  String get skip => 'Pular';

  @override
  String get skipForNow => 'Saltar por enquanto';

  @override
  String get continueLabel => 'Continuar';

  @override
  String get getStarted => 'Comece';

  @override
  String get nextStep => 'Próxima etapa';

  @override
  String get maybeLater => 'Talvez mais tarde';

  @override
  String get emailAddress => 'Endereço de e-mail';

  @override
  String get password => 'Senha';

  @override
  String get firstName => 'Primeiro nome';

  @override
  String get lastName => 'Sobrenome';

  @override
  String get login => 'Faça login';

  @override
  String get signUp => 'Inscreva-se';

  @override
  String get welcomeBack => 'Bem-vindo de volta';

  @override
  String get loginSubtitle =>
      'Faça login para continuar a cuidar do seu jardim.';

  @override
  String get signUpSubtitle =>
      'Junte-se a nós e comece a construir o seu santuário verde.';

  @override
  String get forgotPassword => 'Esqueceu-se da senha?';

  @override
  String get enterEmailPassword =>
      'Por favor insira o seu e-mail e palavra-passe.';

  @override
  String get fillAllFields => 'Por favor preencha todos os campos.';

  @override
  String authError(String error) {
    return 'Algo correu mal: $error';
  }

  @override
  String get loginWith => 'Ou faça login com';

  @override
  String get signUpWith => 'Ou registe-se com';

  @override
  String get noAccount => 'Não tem conta?';

  @override
  String get alreadyAccount => 'Já tem conta?';

  @override
  String get developerSession => 'Criar sessão de programador';

  @override
  String get welcomeBotaniq => 'Bem-vindo à Botaniq';

  @override
  String get loginOptionsSubtitle =>
      'Faça login ou registe-se para fazer cópias de segurança das suas plantas, horários e preferências.';

  @override
  String get notificationAccessTitle => 'Não perca uma rega';

  @override
  String get notificationAccessSubtitle =>
      'Iremos lembrá-lo gentilmente quando for altura de cuidar dos seus amigos verdes. O cuidado das plantas é feito sem esforço e sem stress.';

  @override
  String get notificationTurnOn => 'Ativar lembretes';

  @override
  String get creatingClimate => 'Analisando o seu microclima...';

  @override
  String get creatingSchedules => 'Personalizando horários de atendimento...';

  @override
  String get creatingSanctuary => 'Preparar o seu santuário verde...';

  @override
  String get locationAccessTitle => 'Acesso à localização';

  @override
  String get locationAccessSubtitle =>
      'Personalize os cuidados com as plantas com base no microclima local.';

  @override
  String get locationRecommendation => 'Recomendações locais';

  @override
  String get locationRecommendationSubtitle =>
      'Plantas que prosperam no clima da sua região';

  @override
  String get locationWeather => 'Sincronização Meteorológica Inteligente';

  @override
  String get locationWeatherSubtitle =>
      'Os horários ajustam-se à chuva local em tempo real';

  @override
  String get locationAlerts => 'Alertas de geada e calor';

  @override
  String get locationAlertsSubtitle =>
      'Seja notificado antes de eventos climáticos extremos';

  @override
  String get locationEnable => 'Ativar acesso ao local';

  @override
  String get wherePlantsTitle => 'Onde estão as suas plantas?';

  @override
  String get wherePlantsSubtitle =>
      'Selecione todas as opções aplicáveis para personalizar os seus horários de atendimento.';

  @override
  String get locationIndoor => 'Interior';

  @override
  String get locationIndoorSubtitle => 'Sala, quarto, escritório';

  @override
  String get locationBalcony => 'Varanda';

  @override
  String get locationBalconySubtitle => 'Vasos de plantas num deck ou terraço';

  @override
  String get locationGarden => 'Jardim';

  @override
  String get locationGardenSubtitle =>
      'Plantas enterradas e canteiros de flores';

  @override
  String get helpTitleBefore => 'O que podemos';

  @override
  String get helpTitleHighlight => 'ajudá-lo';

  @override
  String get helpTitleAfter => 'com?';

  @override
  String get helpSubtitle =>
      'Selecione uma ou mais metas para personalizar o seu jardim.';

  @override
  String get helpHeal => 'Curar doente\nplantas';

  @override
  String get helpCare => 'Cuidado\nlembretes';

  @override
  String get helpIdentify => 'Identificar\nespécie';

  @override
  String get helpJournal => 'Crescimento\ndiário';

  @override
  String get helpOther => 'Outra coisa';

  @override
  String get journeyTitle => 'A sua jornada verde';

  @override
  String get journeySubtitle =>
      'Selecione o nível de serviço que pretende oferecer.';

  @override
  String get journeyCasualLabel => 'CASUAL';

  @override
  String get journeyCasualTitle => 'Baixa manutenção';

  @override
  String get journeyCasualSubtitle =>
      'Eu só quero manter as minhas plantas simples vivas e prósperas.';

  @override
  String get journeyEnthusiastLabel => 'ENTUSIASTA';

  @override
  String get journeyEnthusiastTitle => 'Cuidado Equilibrado';

  @override
  String get journeyEnthusiastSubtitle =>
      'Gosto de passar algum tempo semanal com a minha coleção crescente.';

  @override
  String get journeyObsessedLabel => 'OBCECADO';

  @override
  String get journeyObsessedTitle => 'Extraordinário pai de planta';

  @override
  String get journeyObsessedSubtitle =>
      'Vivo para as minhas plantas e quero horários especializados para a minha selva interior.';

  @override
  String get masteryTitleBefore => 'Como está o seu';

  @override
  String get masteryTitleHighlight => 'verde\npolegar';

  @override
  String get masteryTitleAfter => 'ultimamente?';

  @override
  String get masterySubtitle =>
      'Seja honesto: todos nós já fomos “O Serial Killer” em algum momento. Selecione o seu domínio atual.';

  @override
  String get masteryKiller => 'O assassino em série';

  @override
  String get masteryKillerSubtitle =>
      'Até as minhas plantas de plástico parecem preocupadas quando entro na sala.';

  @override
  String get masteryAccidental => 'Pai acidental';

  @override
  String get masteryAccidentalSubtitle =>
      'O meu cato sobreviveu duas semanas. Ainda nos estamos a conhecer.';

  @override
  String get masteryGrowth => 'Mentalidade de crescimento';

  @override
  String get masteryGrowthSubtitle =>
      'A maioria dos meus amigos tem folhas. Conheço os meus Monsteras do meu Pothos.';

  @override
  String get masteryWhisperer => 'Encantador de Plantas';

  @override
  String get masteryWhispererSubtitle =>
      'Eu propago plantas raras e falo fluentemente latim botânico.';

  @override
  String get onboardingOneTitle => 'Tome cuidado\ndas suas plantas';

  @override
  String get onboardingOneHighlight => 'Como um profissional';

  @override
  String get onboardingOneSubtitle =>
      'Horários inteligentes e identificação instantânea para a sua selva urbana.';

  @override
  String get onboardingOneBadge => 'CUIDADOS COM A IA';

  @override
  String get onboardingAiScan => 'Varredura de IA';

  @override
  String get onboardingSmartWater => 'Água Inteligente';

  @override
  String get onboardingLightTracking => 'Rastreamento de luz';

  @override
  String get onboardingTwoTitle => 'Identifique qualquer\nPlantar em';

  @override
  String get onboardingTwoHighlight => 'Segundos';

  @override
  String get onboardingTwoSubtitle =>
      'Tire uma fotografia para saber o seu nome, espécie e requisitos de cuidados.';

  @override
  String get onboardingTwoBadge => 'ESPECIALISTA BOTÂNICO';

  @override
  String get onboardingSnapPhoto => 'Foto instantânea';

  @override
  String get onboardingAccurateResult => 'Resultado Preciso';

  @override
  String get onboardingPlantWiki => 'Planta Wiki';

  @override
  String get onboardingThreeTitle => 'Nunca se esqueça\nPara regar';

  @override
  String get onboardingThreeHighlight => 'Novamente';

  @override
  String get onboardingThreeSubtitle =>
      'Receba lembretes programados de acordo com as necessidades e o ambiente da sua fábrica.';

  @override
  String get onboardingThreeBadge => 'HORÁRIOS INTELIGENTES';

  @override
  String get onboardingReminders => 'Lembretes';

  @override
  String get onboardingClimateData => 'Dados climáticos';

  @override
  String get onboardingHealthyGrowth => 'Crescimento Saudável';

  @override
  String get onboardingCommunity => 'Junte-se a mais de 50.000 pais de plantas';

  @override
  String get onboardingAgreement =>
      'AO CONTINUAR, CONCORDA COM OS NOSSOS TERMOS E POLÍTICA DE PRIVACIDADE';

  @override
  String get termsTitle => 'Termos e Políticas';

  @override
  String get termsUpdated => 'Última atualização: julho de 2026';

  @override
  String get termsUseTitle => '1. Termos de Utilização';

  @override
  String get termsUseBody =>
      'Ao aceder ou utilizar o Botaniq, concorda com estes Termos de Utilização e com as leis aplicáveis. Se não concordar, não poderá utilizar o serviço.';

  @override
  String get termsPrivacyTitle => '2. Privacidade do utilizador';

  @override
  String get termsPrivacyBody =>
      'Recolhemos apenas os dados pessoais necessários para fornecer horários personalizados de cuidados com as plantas. Não vendemos os seus dados pessoais a terceiros.';

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
  String get termsPlantTitle => '3. Dados da planta';

  @override
  String get termsPlantBody =>
      'As informações sobre os cuidados a ter com as plantas, identificação e diagnóstico são fornecidas para fins informativos. Os resultados da IA ​​​​nem sempre estão corretos, por isso observe a sua planta e procure um especialista para riscos graves.';

  @override
  String get termsLiabilityTitle => '6. Disclaimers, Liability, and Indemnity';

  @override
  String get termsLiabilityBody =>
      'Botaniq is provided \"as is\" and \"as available,\" without warranties of any kind, express or implied, including accuracy, reliability, or fitness for a particular purpose. To the fullest extent permitted by law, we and our service providers are not liable for any indirect, incidental, special, or consequential damages, or for any loss of data, plants, or property arising from your use of the service, and our total liability for any claim is limited to the amount you paid us, if any, in the twelve months before the claim. You agree to indemnify and hold us harmless from claims arising from your use of the service, your content, or your violation of these Terms or applicable law.';

  @override
  String get termsPremiumTitle => '4. Assinaturas Premium';

  @override
  String get termsPremiumBody =>
      'A sua subscrição Premium mensal ou anual é cobrada na sua conta Apple ou Google após a confirmação da compra. É renovado automaticamente, a menos que seja cancelado pelo menos 24 horas antes do fim do período atual. Pode gerir ou cancelar nas definições da conta da sua loja. Os pedidos de reembolso são tratados de acordo com a política da loja aplicável.';

  @override
  String get termsLawTitle => '8. Governing Law and Changes';

  @override
  String get termsLawBody =>
      'These Terms are governed by the laws of the jurisdiction in which we operate, without regard to conflict-of-law principles, and any dispute will be resolved under that jurisdiction\'s applicable procedures to the fullest extent permitted by law. We may update these Terms and our data practices at any time by posting the revised version in the app.';

  @override
  String get termsClosing =>
      'Desfrute de paz de espírito e de plantas mais felizes.';

  @override
  String get weatherTitle => 'Tempo';

  @override
  String get weatherSunnyTip =>
      'Hoje está sol – verifique o solo antes de regar.';

  @override
  String get weatherCloudyTip =>
      'O tempo nublado atrasa a evaporação; regue um pouco menos.';

  @override
  String get weatherRainyTip =>
      'Chuvoso e húmido – evite regar demasiado as plantas ao ar livre.';

  @override
  String get weatherStormTip =>
      'Tempo tempestuoso – mova os vasos delicados para um local protegido.';

  @override
  String get weatherSnowTip =>
      'Frio e neve - proteja as plantas dos choques térmicos.';
}

/// The translations for Portuguese, as used in Brazil (`pt_BR`).
class AppLocalizationsPtBr extends AppLocalizationsPt {
  AppLocalizationsPtBr() : super('pt_BR');

  @override
  String get changePassword => 'Alterar senha';

  @override
  String get subscriptionManagement => 'Gerenciamento de assinaturas';

  @override
  String get premium => 'Prêmio';

  @override
  String get languageSubtitle => 'Alterar o idioma do aplicativo';

  @override
  String get languageWelcomeTitle => 'Escolha seu idioma';

  @override
  String get languageWelcomeSubtitle =>
      'Selecione o idioma que deseja usar no Botaniq. Você pode alterá-lo a qualquer momento.';

  @override
  String get languageUseSystem => 'Usar o idioma do dispositivo';

  @override
  String get preferenceSystem => 'Usar configuração do sistema';

  @override
  String get settingsSubtitle =>
      'Molde o Botaniq de acordo com seu próprio ritmo de cuidado.';

  @override
  String get settingsPasswordSubtitle =>
      'Envie um link de redefinição seguro para seu e-mail';

  @override
  String get settingsSubscriptionSubtitle =>
      'Plano premium e detalhes de faturamento';

  @override
  String get settingsPasswordResetSent =>
      'E-mail de redefinição de senha enviado.';

  @override
  String get settingsComingSoon => 'Este espaço ainda está crescendo.';

  @override
  String subscriptionSavePercent(int percent) {
    return 'Economize $percent%';
  }

  @override
  String get subscriptionManage => 'Gerenciar assinatura';

  @override
  String get subscriptionActiveTitle => 'Sua assinatura Premium está ativa';

  @override
  String get subscriptionActiveSubtitle =>
      'Você tem acesso a todos os recursos premium.';

  @override
  String get subscriptionAutoRenewDisclosure =>
      'O pagamento é cobrado em sua conta Apple ou Google. A assinatura é renovada automaticamente, a menos que seja cancelada pelo menos 24 horas antes do final do período atual. Você pode gerenciar ou cancelar a qualquer momento nas configurações da conta da sua loja.';

  @override
  String get subscriptionTermsLink => 'Termos de Uso';

  @override
  String get subscriptionPurchaseSuccess =>
      'Sua assinatura Premium agora está ativa.';

  @override
  String get subscriptionRestoreSuccess =>
      'Sua assinatura Premium foi restaurada.';

  @override
  String get subscriptionNothingToRestore =>
      'Nenhuma associação ativa foi encontrada para esta conta da loja.';

  @override
  String get subscriptionPaymentPending =>
      'O pagamento está aguardando aprovação da loja. Sua assinatura será ativada automaticamente assim que for aprovada.';

  @override
  String get subscriptionErrorNetwork =>
      'Verifique sua conexão com a Internet e tente novamente.';

  @override
  String get subscriptionErrorStore =>
      'Não foi possível entrar em contato com a loja. Por favor, tente novamente em breve.';

  @override
  String get subscriptionMissingConfiguration =>
      'A chave RevenueCat está faltando nesta compilação.';

  @override
  String get subscriptionUnsupported =>
      'As assinaturas estão disponíveis apenas nos aplicativos iOS e Android.';

  @override
  String get homeEmptyGarden => 'Seu jardim está vazio';

  @override
  String get homeEmptyGardenSubtitle =>
      'Comece a construir seu santuário verde\nadicionando sua primeira planta.';

  @override
  String get homeMyPlants => 'Minhas plantas';

  @override
  String get gardenTitle => 'Meu jardim';

  @override
  String get gardenNoPlants =>
      'Ainda não há plantas.\nToque em + para adicionar sua primeira planta!';

  @override
  String get healthySubtitle =>
      'Toque a alma das suas plantas, converse com elas.';

  @override
  String get profileTitle => 'Meu perfil';

  @override
  String get profileWeeklyActivity => 'Atividade de cuidado semanal';

  @override
  String get profileTerms => 'Termos de Uso e Políticas';

  @override
  String get profileDeleteAccount => 'Excluir conta';

  @override
  String get profileSubtitle =>
      'A história do seu jardim, progresso e espaço pessoal.';

  @override
  String get profileQuietWeek =>
      'Uma semana tranquila — seu próximo momento de cuidado aparecerá aqui.';

  @override
  String get profileActiveWeek => 'Seu ritmo de cuidado está vivo e crescendo.';

  @override
  String get profileAppSettingsSubtitle => 'Idioma, unidades e conexão AI';

  @override
  String get profileNotificationPrefsSubtitle =>
      'Escolha quais momentos de cuidado chegam até você';

  @override
  String get profileSignOutQuestion => 'Tem certeza de que deseja sair?';

  @override
  String get profileDeleteAccountWarning =>
      'A exclusão da conta precisa de uma confirmação segura do servidor. Seus dados não foram alterados.';

  @override
  String get profileNextLevelStart =>
      'Adicione sua primeira planta e comece sua aventura de jardinagem!';

  @override
  String profileNextLevelSkilled(int count) {
    return 'Restam apenas $count plantas para se tornar Jardineiro Habilidoso.';
  }

  @override
  String get profileNextLevelMax =>
      'Você está no topo do seu jardim, parabéns!';

  @override
  String get deletePlantMessage =>
      'A planta, suas tarefas de cuidado e os registros da Clínica serão removidos permanentemente da sua conta.';

  @override
  String get profileChoosePhoto => 'Escolha a foto do perfil';

  @override
  String get profileFullNameHint => 'Digite seu nome completo';

  @override
  String get profileNicknameHint => 'Como devemos ligar para você?';

  @override
  String get profileAgeValidation => 'Insira uma idade entre 1 e 120 anos.';

  @override
  String get profileEmailReadOnly => 'Endereço de e-mail (somente leitura)';

  @override
  String get profileEmailHint => 'Digite seu e-mail';

  @override
  String get profileSaveChanges => 'Salvar alterações';

  @override
  String get profileUpdated => 'Seu perfil foi atualizado.';

  @override
  String profileSaveError(String error) {
    return 'Não foi possível salvar o perfil: $error';
  }

  @override
  String get notificationWateringSubtitle =>
      'Seja notificado quando chegar a hora de regar';

  @override
  String get notificationFertilizerSubtitle =>
      'Alertas de alimentação sazonal para suas plantas';

  @override
  String get notificationPlantCareAlerts => 'Alertas de cuidados com plantas';

  @override
  String get gardenMyPlantFallback => 'Minha planta';

  @override
  String get plantLocationEnvironment => 'Localização e Meio Ambiente';

  @override
  String get plantWaterSuccess => '💧 Você regou sua planta! Ótimo trabalho!';

  @override
  String get plantFertilizeSuccess =>
      '🌱 Fertilizante adicionado! Sua planta agradece!';

  @override
  String plantFertilizeError(String error) {
    return 'A fertilização não pôde ser salva: $error';
  }

  @override
  String get clinicChoosePlant => 'Qual planta você gostaria de discutir?';

  @override
  String get clinicChoosePlantSubtitle =>
      'Escolha uma planta do seu jardim ou tire uma nova foto.';

  @override
  String get clinicNoGardenPlants =>
      'Ainda não há plantas no seu jardim.\nComece tirando uma nova foto.';

  @override
  String get clinicNewPhoto => 'Tire uma nova foto';

  @override
  String get clinicEmpty =>
      'Não há plantas doentes na Clínica.\nSe você está preocupado com uma planta,\npergunte na guia Médico.';

  @override
  String get clinicPendingDiagnosis => 'Aguardando diagnóstico';

  @override
  String get clinicRecoveredSuccess => '🎉Sua planta está saudável novamente!';

  @override
  String get healthHumidityArticleTitle =>
      'Preparação para o inverno: mantendo a umidade equilibrada';

  @override
  String get healthHumidityArticleSubtitle =>
      'Como proteger suas plantas do ar seco do radiador durante os meses frios.';

  @override
  String get healthWeeklySpotlight => 'Paciente e Remédio da Semana';

  @override
  String get healthDiscoverLoadError =>
      'Não foi possível carregar o conteúdo do Discover no momento. Puxe para baixo para tentar novamente.';

  @override
  String get lightMeterInstruction =>
      'Aponte a câmera frontal do telefone para\na posição da planta e a fonte de luz.';

  @override
  String get lightMeterCameraEstimate =>
      'Lux aproximado calculado a partir dos dados da câmera';

  @override
  String get lightMeterStabilizingRecommendation =>
      'Segure o telefone firmemente por alguns segundos enquanto as mudanças repentinas de exposição são filtradas.';

  @override
  String get lightMeterUnavailableRecommendation =>
      'Ative a permissão da câmera e tente esta tela novamente.';

  @override
  String get lightLowRecommendation =>
      'Adequado para Calathea, samambaias ou plantas cobra.';

  @override
  String get lightHighRecommendation =>
      'Adequado para Aloe, cactos e gerânios amantes do sol.';

  @override
  String get lightVeryHighRecommendation =>
      'Melhor para plantas ao ar livre e suculentas.';

  @override
  String get homeLoadingPlants => 'Carregando plantas...';

  @override
  String get homeWateringNotification =>
      'Suas plantas de interior precisam de rega.';

  @override
  String get homeWelcomeNotification =>
      'Bem-vindo ao Botaniq. Comece adicionando sua primeira planta.';

  @override
  String get homeTenMinutesAgo => '10 minutos atrás';

  @override
  String get homeOneDayAgo => '1 dia atrás';

  @override
  String get homeIdentifyCamera => 'Identifique-se com sua câmera';

  @override
  String get homeNoTasks => 'Nenhuma tarefa para este dia!';

  @override
  String get homeAllCared => 'Suas plantas estão todas cuidadas 🌿';

  @override
  String get wizardSaveGarden => 'Salvar e adicionar ao jardim';

  @override
  String get wizardRoomTitle => 'Onde está sua planta?';

  @override
  String get wizardRoomSubtitle =>
      'Categorize sua planta por cômodo para gerenciá-la facilmente.';

  @override
  String get wizardBrightIndirectDescription =>
      'Perto de uma janela voltada para leste ou oeste';

  @override
  String get wizardMediumLight => 'Luz Média';

  @override
  String get wizardLowLightDescription =>
      'Longe de janelas ou sob luz artificial';

  @override
  String get wizardDistanceTitle => 'Distância até a janela';

  @override
  String get wizardDistanceSubtitle =>
      'Selecione a distância aproximada até a janela mais próxima.';

  @override
  String get wizardActiveHoursSubtitle =>
      'Quantas horas de luz direta ou brilhante este spot recebe?';

  @override
  String get wizardRepottedTitle =>
      'Quando esta planta foi replantada pela última vez?';

  @override
  String get wizardRepottedSubtitle =>
      'Solo fresco é crucial para uma planta feliz.';

  @override
  String get wizardSixMonthsAgo => '6 meses atrás';

  @override
  String get wizardOneYearAgo => '1 ano atrás';

  @override
  String get wizardDontKnow => 'eu não sei';

  @override
  String get wizardPotTitle => 'Qual material é o pote?';

  @override
  String get wizardPlasticPot => 'Plástico / Berçário';

  @override
  String get wizardWateredTitle =>
      'Quando você regou esta planta pela última vez?';

  @override
  String get wizardWateredSubtitle =>
      'Isso ajuda a calcular a próxima hora exata de rega.';

  @override
  String get wizardFewDaysAgo => 'Alguns dias atrás';

  @override
  String get historyClearMessage =>
      'Todo o histórico de pesquisa e verificação será excluído. Tem certeza?';

  @override
  String get historyEmptySubtitle =>
      'As plantas digitalizadas com a câmera ou pesquisadas aparecerão aqui.';

  @override
  String get historyPlantRecord => 'Registro de pesquisa de plantas';

  @override
  String get photoWholeSpecimenSubtitle =>
      'Mantenha toda a amostra centralizada na moldura para melhor identificação.';

  @override
  String get photoOpenCamera => 'Eu entendo, abra a câmera';

  @override
  String get scheduleNoTasks => 'Nenhuma tarefa para hoje!';

  @override
  String chatPatient(String name) {
    return 'Paciente: $name';
  }

  @override
  String chatWelcome(String name) {
    return 'Olá! 🌿 Sou seu médico de plantas de IA. Como posso ajudar com $name?\n\nPosso diagnosticar uma foto ou responder às suas perguntas sobre cuidados.';
  }

  @override
  String get chatQuestionYellowing => 'O que está causando as folhas amarelas?';

  @override
  String get chatQuestionWatering => 'Devo mudar a frequência de rega?';

  @override
  String get chatQuestionFertilizer => 'Qual fertilizante devo usar?';

  @override
  String get chatNoTreatment => 'Nenhuma recomendação de tratamento';

  @override
  String get discoverPropagation => 'Propagação 101: Manual para Iniciantes';

  @override
  String get skipForNow => 'Pular por enquanto';

  @override
  String get loginSubtitle =>
      'Faça login para continuar cuidando do seu jardim.';

  @override
  String get forgotPassword => 'Esqueceu a senha?';

  @override
  String get enterEmailPassword => 'Por favor insira seu e-mail e senha.';

  @override
  String authError(String error) {
    return 'Algo deu errado: $error';
  }

  @override
  String get signUpWith => 'Ou cadastre-se com';

  @override
  String get noAccount => 'Não tem uma conta?';

  @override
  String get alreadyAccount => 'Já tem uma conta?';

  @override
  String get developerSession => 'Criar sessão de desenvolvedor';

  @override
  String get loginOptionsSubtitle =>
      'Faça login ou cadastre-se para fazer backup de suas plantas, horários e preferências.';

  @override
  String get notificationAccessSubtitle =>
      'Iremos lembrá-lo gentilmente quando for hora de cuidar de seus amigos verdes. O cuidado das plantas é feito sem esforço e sem estresse.';

  @override
  String get creatingClimate => 'Analisando seu microclima...';

  @override
  String get creatingSanctuary => 'Preparando seu santuário verde...';

  @override
  String get locationWeatherSubtitle =>
      'Os horários se ajustam à chuva local em tempo real';

  @override
  String get locationEnable => 'Habilitar acesso ao local';

  @override
  String get wherePlantsTitle => 'Onde estão suas plantas?';

  @override
  String get wherePlantsSubtitle =>
      'Selecione todas as opções aplicáveis para personalizar seus horários de atendimento.';

  @override
  String get locationBalconySubtitle =>
      'Vasos de plantas em um deck ou terraço';

  @override
  String get helpTitleHighlight => 'ajudar você';

  @override
  String get helpSubtitle =>
      'Selecione uma ou mais metas para personalizar seu jardim.';

  @override
  String get journeyTitle => 'Sua jornada verde';

  @override
  String get journeySubtitle =>
      'Selecione o nível de atendimento que deseja oferecer.';

  @override
  String get journeyCasualSubtitle =>
      'Eu só quero manter minhas plantas simples vivas e prósperas.';

  @override
  String get journeyEnthusiastSubtitle =>
      'Gosto de passar algum tempo semanal com minha coleção crescente.';

  @override
  String get journeyObsessedSubtitle =>
      'Vivo para minhas plantas e quero horários especializados para minha selva interna.';

  @override
  String get masterySubtitle =>
      'Seja honesto: todos nós já fomos “O Serial Killer” em algum momento. Selecione seu domínio atual.';

  @override
  String get masteryKillerSubtitle =>
      'Até minhas plantas de plástico parecem preocupadas quando entro na sala.';

  @override
  String get masteryAccidentalSubtitle =>
      'Meu cacto sobreviveu duas semanas. Ainda estamos nos conhecendo.';

  @override
  String get masteryGrowthSubtitle =>
      'A maioria dos meus amigos tem folhas. Eu conheço meus Monsteras do meu Pothos.';

  @override
  String get masteryWhispererSubtitle =>
      'Eu propago plantas raras e falo latim botânico fluentemente.';

  @override
  String get onboardingOneTitle => 'Tome cuidado\nde suas plantas';

  @override
  String get onboardingOneSubtitle =>
      'Horários inteligentes e identificação instantânea para sua selva urbana.';

  @override
  String get onboardingOneBadge => 'CUIDADOS COM IA';

  @override
  String get onboardingTwoSubtitle =>
      'Tire uma foto para saber seu nome, espécie e requisitos de cuidados.';

  @override
  String get onboardingThreeSubtitle =>
      'Receba lembretes programados de acordo com as necessidades e o ambiente da sua planta.';

  @override
  String get onboardingAgreement =>
      'AO CONTINUAR, VOCÊ CONCORDA COM NOSSOS TERMOS E POLÍTICA DE PRIVACIDADE';

  @override
  String get termsUseTitle => '1. Termos de Uso';

  @override
  String get termsUseBody =>
      'Ao acessar ou usar o Botaniq, você concorda com estes Termos de Uso e com as leis aplicáveis. Se você não concordar, não poderá usar o serviço.';

  @override
  String get termsPrivacyTitle => '2. Privacidade do usuário';

  @override
  String get termsPrivacyBody =>
      'Coletamos apenas os dados pessoais necessários para fornecer cronogramas personalizados de cuidados com as plantas. Não vendemos os seus dados pessoais a terceiros.';

  @override
  String get termsPlantBody =>
      'Informações sobre cuidados com plantas, identificação e diagnóstico são fornecidas para fins informativos. Os resultados da IA ​​nem sempre estão corretos, portanto observe sua planta e procure um especialista para riscos graves.';

  @override
  String get termsPremiumBody =>
      'Sua assinatura Premium mensal ou anual é cobrada em sua conta Apple ou Google após a confirmação da compra. Ele é renovado automaticamente, a menos que seja cancelado pelo menos 24 horas antes do término do período atual. Você pode gerenciar ou cancelar nas configurações da conta da sua loja. As solicitações de reembolso são tratadas de acordo com a política da loja aplicável.';

  @override
  String get termsClosing =>
      'Desfrute de paz de espírito e plantas mais felizes.';

  @override
  String get weatherSunnyTip =>
      'Hoje faz sol – verifique o solo antes de regar.';

  @override
  String get weatherCloudyTip =>
      'O tempo nublado retarda a evaporação; regue um pouco menos.';

  @override
  String get weatherRainyTip =>
      'Chuvoso e úmido – evite regar demais as plantas ao ar livre.';
}
