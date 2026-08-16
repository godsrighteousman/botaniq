// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appTitle => 'Botaniq';

  @override
  String get settings => '设置';

  @override
  String get preferences => '偏好设置';

  @override
  String get darkMode => '深色模式';

  @override
  String get metricSystem => '公制';

  @override
  String get metricSystemSubtitle => '使用摄氏度和米';

  @override
  String get account => '账户';

  @override
  String get editProfile => '编辑个人资料';

  @override
  String get changePassword => '更改密码';

  @override
  String get subscriptionManagement => '订阅管理';

  @override
  String get premium => '高级版';

  @override
  String get language => '语言';

  @override
  String get languageSubtitle => '更改应用程序语言';

  @override
  String get selectLanguage => '选择语言';

  @override
  String get systemLanguage => '系统语言';

  @override
  String get english => '英语';

  @override
  String get turkish => '图尔克切';

  @override
  String get languageChanged => '语言更改成功。';

  @override
  String get languageSearchHint => '搜索语言';

  @override
  String get languageRecommended => '推荐';

  @override
  String get languageWelcomeTitle => '选择您的语言';

  @override
  String get languageWelcomeSubtitle => '选择您想要在 Botaniq 中使用的语言。您可以随时更改它。';

  @override
  String get languageUseSystem => '使用设备语言';

  @override
  String get preferenceSystem => '使用系统设置';

  @override
  String get themeLight => '光';

  @override
  String get themeDark => '黑暗';

  @override
  String get themeSelectionTitle => '选择外观';

  @override
  String get measurementMetric => '公制';

  @override
  String get measurementImperial => '帝国';

  @override
  String get measurementSelectionTitle => '选择测量系统';

  @override
  String get settingsSubtitle => '根据您自己的护理节奏塑造 Botaniq。';

  @override
  String get settingsLocalPreference => '已保存在此设备上';

  @override
  String get settingsDarkModeSubtitle => '适合低光时刻的平静调色板';

  @override
  String get settingsAccountSubtitle => '身份、访问权限和会员资格';

  @override
  String get settingsEditProfileSubtitle => '姓名、地点和护理偏好';

  @override
  String get settingsPasswordSubtitle => '将安全重置链接发送到您的电子邮件';

  @override
  String get settingsSubscriptionSubtitle => '高级计划和账单详细信息';

  @override
  String get settingsPasswordResetSent => '已发送密码重置电子邮件。';

  @override
  String get settingsComingSoon => '这个空间仍在增长。';

  @override
  String get subscriptionPageTitle => '高级会员资格';

  @override
  String get subscriptionHeroEyebrow => 'BOTANIQ PREMIUM';

  @override
  String get subscriptionHeroTitle => '更智能地照顾每株植物';

  @override
  String get subscriptionHeroSubtitle => '解锁每一个高级护理工具，自信地拓展您的绿色空间。';

  @override
  String get subscriptionBenefitsTitle => '一切尽在高级版';

  @override
  String get subscriptionBenefitIdentification => '无限制的植物识别和健康分析';

  @override
  String get subscriptionBenefitCare => '个性化护理计划和提醒';

  @override
  String get subscriptionBenefitInsights => '专家内容和高级护理见解';

  @override
  String get subscriptionMonthlyPlan => '每月';

  @override
  String get subscriptionAnnualPlan => '年度';

  @override
  String subscriptionPerMonth(String price) {
    return '$price / 月';
  }

  @override
  String subscriptionPerYear(String price) {
    return '$price / 年';
  }

  @override
  String get subscriptionBestValue => '最超值';

  @override
  String subscriptionSavePercent(int percent) {
    return '节省 $percent%';
  }

  @override
  String get subscriptionContinue => '解锁高级版';

  @override
  String get subscriptionRestorePurchases => '恢复购买';

  @override
  String get subscriptionRestoring => '正在恢复...';

  @override
  String get subscriptionManage => '管理订阅';

  @override
  String get subscriptionActiveTitle => '您的高级会员资格已激活';

  @override
  String get subscriptionActiveSubtitle => '您可以使用所有高级功能。';

  @override
  String subscriptionRenewsOn(String date) {
    return '在 $date 上续订';
  }

  @override
  String subscriptionExpiresOn(String date) {
    return '活跃直至 $date';
  }

  @override
  String get subscriptionAutoRenewDisclosure =>
      '付款将从您的 Apple 或 Google 帐户中扣除。除非在当前周期结束前至少 24 小时取消，否则订阅将自动续订。您可以随时在商店帐户设置中管理或取消它。';

  @override
  String get subscriptionTermsLink => '使用条款';

  @override
  String get subscriptionPrivacyLink => '隐私政策';

  @override
  String get subscriptionPurchaseSuccess => '您的高级会员资格现已生效。';

  @override
  String get subscriptionRestoreSuccess => '您的高级会员资格已恢复。';

  @override
  String get subscriptionNothingToRestore => '未找到此商店帐户的有效会员资格。';

  @override
  String get subscriptionPaymentPending => '付款正在等待商店批准。一旦获得批准，您的会员资格将自动激活。';

  @override
  String get subscriptionErrorGeneric => '操作无法完成。请再试一次。';

  @override
  String get subscriptionErrorNetwork => '检查您的互联网连接，然后重试。';

  @override
  String get subscriptionErrorNotAllowed => '该设备或商店帐户不允许进行购买。';

  @override
  String get subscriptionErrorStore => '无法联系到该商店。请稍后重试。';

  @override
  String get subscriptionMissingConfiguration => '此版本中缺少 RevenueCat 密钥。';

  @override
  String get subscriptionUnsupported => '订阅仅在 iOS 和 Android 应用程序中可用。';

  @override
  String get subscriptionProductsUnavailable =>
      '无法加载月度和年度产品。检查 RevenueCat 产品配置。';

  @override
  String get subscriptionRetry => '再试一次';

  @override
  String get subscriptionFree => '免费';

  @override
  String get homeGoodMorning => '你好，';

  @override
  String homePersonalGreeting(String greeting, String name) {
    return '$greeting，$name 👋';
  }

  @override
  String get homeEmptyGarden => '你的花园空了';

  @override
  String get homeEmptyGardenSubtitle => '开始建设你的绿色庇护所\n添加你的第一株植物。';

  @override
  String get homeAddFirstPlant => '添加第一个工厂';

  @override
  String get homeMyPlants => '我的植物';

  @override
  String get homeViewAll => '查看全部';

  @override
  String get homeSmartCareReminders => '智能护理提醒';

  @override
  String get homeWatering => '浇水';

  @override
  String get homeWateringSubtitle => '土壤追踪';

  @override
  String get homeFertilizing => '施肥';

  @override
  String get homeFertilizingSubtitle => '营养警报';

  @override
  String get gardenTitle => '我的花园';

  @override
  String get gardenAllPlants => '所有植物';

  @override
  String get gardenNeedsWater => '需要水';

  @override
  String get gardenIndoor => '室内';

  @override
  String get gardenNoPlants => '还没有植物。\n点击+添加您的第一株植物！';

  @override
  String get gardenNoPlantsCategory => '此类别中没有植物。';

  @override
  String get discoverTitle => '发现';

  @override
  String get discoverSearchHint => '搜索植物、文章、指南...';

  @override
  String get discoverLatestArticles => '最新文章';

  @override
  String get discoverSeeAll => '查看全部';

  @override
  String get discoverTrendingGuides => '热门指南';

  @override
  String get healthyTitle => '护理中心';

  @override
  String get healthySubtitle => '触摸植物的灵魂，与它们交谈。';

  @override
  String get healthyTabDoctor => '医生';

  @override
  String get healthyTabHospital => '医院';

  @override
  String get healthyTabDiscover => '发现';

  @override
  String get profileTitle => '我的个人资料';

  @override
  String get profileEditProfile => '编辑个人资料';

  @override
  String get profileOverview => '概述';

  @override
  String get profileSettingsTab => '设置';

  @override
  String get profileGardenerLevel => '园丁级别';

  @override
  String get profileTotalPlants => '植物总数';

  @override
  String get profileCompletedTasks => '已完成的任务';

  @override
  String get profileWeeklyActivity => '每周护理活动';

  @override
  String get profileGeneral => '一般';

  @override
  String get profileAppSettings => '应用程序设置';

  @override
  String get profileNotificationPrefs => '通知首选项';

  @override
  String get profileSupportLegal => '支持与法律';

  @override
  String get profileHelpCenter => '帮助中心';

  @override
  String get profileTerms => '使用条款和政策';

  @override
  String get profileSignOut => '退出';

  @override
  String get profileDeleteAccount => '删除账户';

  @override
  String get profileSubtitle => '您的花园故事、进展和个人空间。';

  @override
  String get profileGardenPassport => '花园护照';

  @override
  String get profileThisWeek => '本周';

  @override
  String get profileQuietWeek => '安静的一周——您的下一个护理时刻将出现在这里。';

  @override
  String get profileActiveWeek => '您的护理节奏活跃且不断发展。';

  @override
  String get profileAppSettingsSubtitle => '语言、单位和人工智能连接';

  @override
  String get profileNotificationPrefsSubtitle => '选择适合您的护理时刻';

  @override
  String get profileHelpCenterSubtitle => '答案和快速指导';

  @override
  String get profileTermsSubtitle => '隐私、条款和政策';

  @override
  String get profileAccountActions => '账户操作';

  @override
  String get profileSignOutQuestion => '您确定要退出吗？';

  @override
  String get profileDeleteAccountWarning => '帐户删除需要安全的服务器端确认。您的数据尚未更改。';

  @override
  String get cancel => '取消';

  @override
  String get continueAction => '继续';

  @override
  String get profileTitleNew => '新园丁🌱';

  @override
  String get profileTitleSprout => '发芽朋友🌿';

  @override
  String get profileTitleLeaf => '叶子爱好者☘️';

  @override
  String get profileTitleSkilled => '熟练的园丁🏡';

  @override
  String get profileTitleMaster => '绿拇指大师👑';

  @override
  String get profileNextLevelStart => '添加您的第一株植物并开始您的园艺冒险！';

  @override
  String profileNextLevelLeaf(int count) {
    return '只剩下 $count 植物成为恋叶人。';
  }

  @override
  String profileNextLevelSkilled(int count) {
    return '只剩下 $count 植物才能成为熟练园丁。';
  }

  @override
  String profileNextLevelMaster(int count) {
    return '只剩下 $count 植物可以成为绿拇指大师。';
  }

  @override
  String get profileNextLevelMax => '您已到达花园顶峰，恭喜！';

  @override
  String get navHome => '首页';

  @override
  String get navGarden => '花园';

  @override
  String get navClinic => '诊所';

  @override
  String get navProfile => '公司简介';

  @override
  String get scanPlant => '扫描工厂';

  @override
  String get deletePlantTitle => '移除这个植物？';

  @override
  String get deletePlantMessage => '该植物、其护理任务和诊所记录将从您的帐户中永久删除。';

  @override
  String get deletePlantAction => '移除植物';

  @override
  String get deletePlantNotFound => '该植物无法找到或已被移除。';

  @override
  String deletePlantError(String error) {
    return '无法移除该植物：$error';
  }

  @override
  String get profileChoosePhoto => '选择个人资料照片';

  @override
  String get profileFullName => '全名';

  @override
  String get profileFullNameHint => '输入您的全名';

  @override
  String get profileNickname => '昵称';

  @override
  String get profileNicknameHint => '我们该怎么称呼你呢？';

  @override
  String get profileAge => '年龄';

  @override
  String get profileAgeHint => '1–120';

  @override
  String get profileAgeValidation => '请输入 1 到 120 之间的年龄。';

  @override
  String profileLoadError(String error) {
    return '无法加载配置文件：$error';
  }

  @override
  String get languageEnglish => '英语';

  @override
  String get languageTurkish => '土耳其语';

  @override
  String get profileEmailReadOnly => '电子邮件地址（只读）';

  @override
  String get profileEmailHint => '输入您的电子邮件';

  @override
  String get profileLocation => '地点';

  @override
  String get profileLocationHint => '城市、国家';

  @override
  String get profileSaveChanges => '保存更改';

  @override
  String get profileUpdated => '您的个人资料已更新。';

  @override
  String profileSaveError(String error) {
    return '无法保存配置文件：$error';
  }

  @override
  String get notificationWateringTitle => '浇水提醒';

  @override
  String get notificationWateringSubtitle => '到了浇水时间时收到通知';

  @override
  String get notificationFertilizerTitle => '肥料提醒';

  @override
  String get notificationFertilizerSubtitle => '植物的季节性施肥警报';

  @override
  String get notificationTitle => '通知';

  @override
  String get notificationPlantCareAlerts => '植物护理警报';

  @override
  String get notificationOther => '其他通知';

  @override
  String get notificationWeatherTitle => '天气警报';

  @override
  String get notificationWeatherSubtitle => '极端天气警告';

  @override
  String get notificationArticlesTitle => '新文章';

  @override
  String get notificationArticlesSubtitle => '花园的提示和技巧';

  @override
  String get gardenMyPlantFallback => '我的植物';

  @override
  String get gardenClinicBadge => '在诊所';

  @override
  String get wateringNever => '最后一次浇水：从未';

  @override
  String wateringLastDate(String date) {
    return '最后浇水：$date';
  }

  @override
  String wateringInterval(int days) {
    return '每 $days 天';
  }

  @override
  String get wateringNeverDue => '尚未浇水 • 今天浇水';

  @override
  String wateringOverdue(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '已逾期 $days 天',
      zero: '今天浇水',
    );
    return '$_temp0';
  }

  @override
  String get wateringDueToday => '今天浇水';

  @override
  String get wateringDueTomorrow => '明天浇水';

  @override
  String wateringDueInDays(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days 天后浇水',
      zero: '今天浇水',
    );
    return '$_temp0';
  }

  @override
  String get plantUnknown => '未知植物';

  @override
  String get plantSpeciesFallback => '植物种类';

  @override
  String get plantDifficultyMedium => '中等';

  @override
  String get plantAbout => '关于';

  @override
  String get plantLocationEnvironment => '地点及环境';

  @override
  String get plantCareProtocol => '护理协议';

  @override
  String get plantCareHistory => '最近 10 天的护理历史';

  @override
  String get plantHealthy => '健康';

  @override
  String get plantInClinic => '在诊所';

  @override
  String get plantDifficulty => '难度';

  @override
  String get plantToxicity => '毒性';

  @override
  String get plantEnvironment => '环境';

  @override
  String get plantLightNeed => '轻度需求';

  @override
  String get plantToxicPets => '对宠物有毒';

  @override
  String get plantNonToxic => '无毒';

  @override
  String get plantIndoor => '室内';

  @override
  String get plantBrightIndirect => '明亮间接';

  @override
  String get plantInfoUnavailable => '目前还无法获得经过验证的信息。';

  @override
  String get plantIdealClimate => '理想的气候';

  @override
  String get plantHumidity => '湿度';

  @override
  String get plantTemperatureRange => '温度范围';

  @override
  String get plantWateringFrequency => '浇水频率';

  @override
  String plantWateringFrequencyValue(String interval) {
    return '水$interval。';
  }

  @override
  String get plantNextWatering => '下一步浇水';

  @override
  String get plantWateringProtocol => '浇水协议';

  @override
  String get plantSoilProtocol => '土壤';

  @override
  String get plantFeedingProtocol => '喂养方案';

  @override
  String get plantPruningCleaning => '修剪和清洁';

  @override
  String get plantPruningFallback => '每月擦拭叶子。修剪枯死或发黄的叶子以促进生长。';

  @override
  String get plantHistoryEmpty => '最近 10 天无护理史。';

  @override
  String get plantWateringTask => '浇水';

  @override
  String get plantFertilizingTask => '施肥';

  @override
  String get plantWateredAction => '浇水 ✓';

  @override
  String get plantWaterNowAction => '现在浇水';

  @override
  String get plantFertilizedAction => '受精 ✓';

  @override
  String get plantFertilizeAction => '施肥';

  @override
  String get plantAddGardenAction => '添加到我的花园';

  @override
  String get plantWaterSuccess => '💧 你给你的植物浇水了！干得好！';

  @override
  String get plantFertilizeSuccess => '🌱添加肥料！你的植物说谢谢！';

  @override
  String plantWaterError(String error) {
    return '浇水无法保存：$error';
  }

  @override
  String plantFertilizeError(String error) {
    return '无法保存施肥：$error';
  }

  @override
  String get clinicQuickTools => '快速工具';

  @override
  String get clinicDoctorHero => '人工智能植物医生\n竭诚为您服务';

  @override
  String get clinicStartConsultation => '开始咨询';

  @override
  String get clinicChoosePlant => '您想讨论哪种植物？';

  @override
  String get clinicChoosePlantSubtitle => '从您的花园中选择一种植物或拍摄一张新照片。';

  @override
  String get clinicNoGardenPlants => '你的花园里还没有植物。\n首先拍摄一张新照片。';

  @override
  String get clinicNewPhoto => '拍摄一张新照片';

  @override
  String get clinicNewPhotoSubtitle => '拍摄患病植物并获得诊断';

  @override
  String get clinicPestAnalysis => '害虫分析';

  @override
  String get clinicVisualDiagnosis => '视觉诊断';

  @override
  String get clinicLightMeter => '照度计';

  @override
  String get clinicSensorSimulation => '传感器模拟';

  @override
  String get clinicTitle => '植物诊所';

  @override
  String clinicSickCount(int count) {
    return '$count 生病了';
  }

  @override
  String get clinicAllHealthy => '您所有的植物都很健康！ 🌿';

  @override
  String get clinicEmpty => '诊所内没有患病植物。\n如果你关心一株植物，\n从“医生”选项卡询问。';

  @override
  String get clinicUnknown => '未知';

  @override
  String get clinicPendingDiagnosis => '等待诊断';

  @override
  String get clinicNoTreatment => '治疗方案尚未确定';

  @override
  String get clinicPrescription => '处方：';

  @override
  String get clinicRecovery => '恢复';

  @override
  String get clinicRecovered => '已恢复';

  @override
  String get clinicContinue => '继续';

  @override
  String get clinicRecoveredSuccess => '🎉 你的植物又健康了！';

  @override
  String get clinicUrgencyLow => '低';

  @override
  String get clinicUrgencyMedium => '中等';

  @override
  String get clinicUrgencyCritical => '关键';

  @override
  String get healthTrendingTips => '流行健康秘诀';

  @override
  String get healthHumidityArticleTitle => '冬季准备：保持湿度平衡';

  @override
  String get healthHumidityArticleSubtitle => '如何在寒冷的月份保护您的植物免受干燥的散热器空气的影响。';

  @override
  String get healthWeeklySpotlight => '本周的患者和治疗方法';

  @override
  String get healthAphidTitle => '蚜虫侵扰';

  @override
  String get healthAphidSubtitle => '早期干预和天然印楝油治疗。';

  @override
  String get healthDiscoverLoadError => '目前无法加载发现内容。拉下来再试一次。';

  @override
  String get healthDiscoverEmpty => '尚未发布发现内容。';

  @override
  String get healthDiscoverRetry => '再试一次';

  @override
  String get lightMeterTitle => '照度计';

  @override
  String get lightMeterInstructionTitle => '测量光';

  @override
  String get lightMeterInstruction => '将手机前置摄像头朝向\n植物的位置和光源。';

  @override
  String get lightMeterCameraEstimate => '根据相机数据计算出的近似勒克斯';

  @override
  String get lightMeterStabilizing => '稳定测量';

  @override
  String get lightMeterStabilizingRecommendation => '保持手机稳定几秒钟，同时过滤突然的曝光变化。';

  @override
  String get lightMeterUnavailable => '无法测量';

  @override
  String get lightMeterUnavailableRecommendation => '启用相机权限并再次尝试此屏幕。';

  @override
  String get lightLow => '弱光（阴影）';

  @override
  String get lightMedium => '中光（明亮房间）';

  @override
  String get lightHigh => '高光（靠近窗户）';

  @override
  String get lightVeryHigh => '极高光（阳光直射）';

  @override
  String get lightLowRecommendation => '适用于竹芋属、蕨类植物或蛇类植物。';

  @override
  String get lightMediumRecommendation => '非常适合龟背竹、榕树和红掌。';

  @override
  String get lightHighRecommendation => '适合喜阳光的芦荟、仙人掌和天竺葵。';

  @override
  String get lightVeryHighRecommendation => '最适合户外植物和多肉植物。';

  @override
  String get homeLoadingPlants => '正在加载植物...';

  @override
  String get homeNotifications => '通知';

  @override
  String get homeWateringTime => '浇水时间';

  @override
  String get homeWateringNotification => '你的室内植物需要浇水。';

  @override
  String get homeWelcome => '欢迎！';

  @override
  String get homeWelcomeNotification => '欢迎来到Botaniq。首先添加你的第一株植物。';

  @override
  String get homeTenMinutesAgo => '10 分钟前';

  @override
  String get homeOneDayAgo => '1 天前';

  @override
  String get homeQuickActions => '快速行动';

  @override
  String get homeIdentifyCamera => '用你的相机识别';

  @override
  String get homeTomorrow => '明天';

  @override
  String get homeNoTasks => '今天没有任务！';

  @override
  String get homeAllCared => '你的植物都被照顾好了🌿';

  @override
  String get homeOverdue => '逾期';

  @override
  String get homeInstructions => '使用说明';

  @override
  String homeRequiredAmount(String amount) {
    return '必需：$amount';
  }

  @override
  String get homeLater => '后来';

  @override
  String get homeMarkDone => '标记为完成';

  @override
  String get homeSickPlants => '植物诊所';

  @override
  String homeSickCount(int count) {
    return '$count 生病了';
  }

  @override
  String get homeGreetingMorning => '早上好';

  @override
  String get homeGreetingAfternoon => '下午好';

  @override
  String get homeGreetingEvening => '晚上好';

  @override
  String get homeTodayTasks => '今天的任务';

  @override
  String get homeTomorrowTasks => '明天的任务';

  @override
  String homeDateTasks(String date) {
    return '$date 任务';
  }

  @override
  String get commonSkip => '跳过';

  @override
  String get commonContinue => '继续';

  @override
  String get commonClose => '关闭';

  @override
  String get commonDelete => '删除';

  @override
  String get commonBack => '返回';

  @override
  String get commonUnknown => '未知';

  @override
  String get wizardSaveGarden => '保存并添加到花园';

  @override
  String wizardPlantAdded(String name) {
    return '$name 已添加到您的花园！ 🌿';
  }

  @override
  String get wizardRoomTitle => '你的工厂在哪里？';

  @override
  String get wizardRoomSubtitle => '按房间对植物进行分类，以便轻松管理。';

  @override
  String get wizardLivingRoom => '客厅';

  @override
  String get wizardBedroom => '卧室';

  @override
  String get wizardKitchen => '厨房';

  @override
  String get wizardOffice => '办公室';

  @override
  String get wizardBathroom => '浴室';

  @override
  String get wizardBalcony => '阳台';

  @override
  String get wizardLightTitle => '这个地方的光线如何？';

  @override
  String get wizardLightSubtitle => '光是植物健康最重要的因素之一。';

  @override
  String get wizardDirectSun => '直射阳光';

  @override
  String get wizardDirectSunDescription => '未经过滤的阳光直接照射在植物上';

  @override
  String get wizardBrightIndirect => '明亮间接';

  @override
  String get wizardBrightIndirectDescription => '靠近朝东或朝西的窗户';

  @override
  String get wizardMediumLight => '中光';

  @override
  String get wizardMediumLightDescription => '距离窗户几英尺远';

  @override
  String get wizardLowLight => '弱光';

  @override
  String get wizardLowLightDescription => '远离窗户或在人造光下';

  @override
  String get wizardDistanceTitle => '到窗户的距离';

  @override
  String get wizardDistanceSubtitle => '选择到最近窗口的大致距离。';

  @override
  String get wizardMoreThanFiveMeters => '超过5m';

  @override
  String get wizardActiveHoursTitle => '活跃光照时间';

  @override
  String get wizardActiveHoursSubtitle => '该地点接受多少小时的直射光或强光？';

  @override
  String wizardHour(int count) {
    return '$count 小时';
  }

  @override
  String wizardHours(int count) {
    return '$count 小时';
  }

  @override
  String get wizardSixPlusHours => '6小时以上';

  @override
  String get wizardRepottedTitle => '这株植物最后一次换盆是什么时候？';

  @override
  String get wizardRepottedSubtitle => '新鲜的土壤对于植物的生长至关重要。';

  @override
  String get wizardRecently => '最近（3个月以内）';

  @override
  String get wizardSixMonthsAgo => '6 个月前';

  @override
  String get wizardOneYearAgo => '1年前';

  @override
  String get wizardTwoYearsAgo => '2+年前';

  @override
  String get wizardDontKnow => '我不知道';

  @override
  String get wizardPotTitle => '锅是什么材质的？';

  @override
  String get wizardPotSubtitle => '盆栽材料会影响土壤干燥的速度。';

  @override
  String get wizardPlasticPot => '塑料/苗圃';

  @override
  String get wizardTerracottaPot => '兵马俑';

  @override
  String get wizardCeramicPot => '陶瓷/釉面';

  @override
  String get wizardMetalPot => '金属';

  @override
  String get wizardWateredTitle => '你上次给这棵植物浇水是什么时候？';

  @override
  String get wizardWateredSubtitle => '这有助于计算准确的下一次浇水时间。';

  @override
  String get wizardToday => '今天';

  @override
  String get wizardYesterday => '昨天';

  @override
  String get wizardFewDaysAgo => '几天前';

  @override
  String get wizardWeekAgo => '一周前';

  @override
  String get wizardMoreWeekAgo => '一个多星期前';

  @override
  String get historyTitle => '搜索历史';

  @override
  String get historyClearTitle => '清除历史记录';

  @override
  String get historyClearMessage => '所有搜索和扫描历史记录都将被删除。你确定吗？';

  @override
  String get historyClearTooltip => '清除历史记录';

  @override
  String get historyEmptyTitle => '没有搜索历史';

  @override
  String get historyEmptySubtitle => '用相机扫描或搜索到的植物将出现在此处。';

  @override
  String get historyNoDetails => '没有详细信息。';

  @override
  String get historyRegularWater => '定期浇水';

  @override
  String get historyIndirectLight => '间接光';

  @override
  String get historyDescription => '描述';

  @override
  String get historyWatering => '浇水';

  @override
  String get historyLight => '光';

  @override
  String get historyRecently => '最近';

  @override
  String historyMinutesAgo(int minutes) {
    return '$minutes 分钟前';
  }

  @override
  String historyHoursAgo(int hours) {
    return '$hours 小时前';
  }

  @override
  String get historyYesterday => '昨天';

  @override
  String get historyPlantRecord => '植物搜寻记录';

  @override
  String get photoWholeSpecimen => '整体照片\n植物或蘑菇';

  @override
  String get photoWholeSpecimenSubtitle => '将整个标本保持在框架中央，以便更好地识别。';

  @override
  String get photoCorrect => '正确';

  @override
  String get photoTooClose => '太近了';

  @override
  String get photoInstructions => '使用说明';

  @override
  String get photoOpenCamera => '我明白了，打开相机';

  @override
  String get scannerPlant => '植物';

  @override
  String get scannerMushroom => '蘑菇';

  @override
  String get scannerIdentifyingPlant => '识别植物...';

  @override
  String get scannerIdentifyingMushroom => '鉴别蘑菇...';

  @override
  String get scannerCapture => '拍照及扫描';

  @override
  String get scannerFailed => '扫描失败。请再试一次。';

  @override
  String scannerError(String error) {
    return '发生错误：$error';
  }

  @override
  String get scannerUnknownPlant => '未知植物';

  @override
  String get scannerUnknownMushroom => '未知蘑菇';

  @override
  String get scheduleTitle => '时间表';

  @override
  String get scheduleTodayTask => '今天的任务';

  @override
  String get scheduleNoTasks => '今天没有任务！';

  @override
  String get scheduleInstructions => '使用说明';

  @override
  String scheduleRequired(String amount) {
    return '必需：$amount';
  }

  @override
  String get scheduleRemindLater => '稍后提醒';

  @override
  String get scheduleDone => '完成';

  @override
  String get scheduleCareFallback => '照顾你的植物。';

  @override
  String get chatDoctorTitle => '人工智能植物医生';

  @override
  String chatPatient(String name) {
    return '患者：$name';
  }

  @override
  String get chatAnalyzing => '正在分析...';

  @override
  String chatHint(String name) {
    return '询问 $name...';
  }

  @override
  String chatWelcome(String name) {
    return '你好！ 🌿 我是你们的人工智能植物医生。我可以如何帮助 $name？\n\n我可以诊断照片或回答您的护理问题。';
  }

  @override
  String chatContinueWelcome(String name) {
    return '你好！让我们继续$name。 🌱';
  }

  @override
  String get chatQuestionYellowing => '叶子发黄是什么原因造成的？';

  @override
  String get chatQuestionTreatment => '我该如何处理这种植物？';

  @override
  String get chatQuestionWatering => '我应该改变浇水频率吗？';

  @override
  String get chatQuestionFertilizer => '我应该使用哪种肥料？';

  @override
  String get chatPhotoSent => '照片已发送';

  @override
  String get chatAnalyzePhoto => '分析照片';

  @override
  String get chatDiagnosisUnknown => '无法确定诊断';

  @override
  String get chatNoTreatment => '无治疗建议';

  @override
  String get chatRecoveryUnknown => '未知';

  @override
  String get chatUnableIdentify => '不明植物';

  @override
  String chatError(String error) {
    return '抱歉，发生错误：$error。请再试一次。';
  }

  @override
  String get chatCareTips => '护理秘诀';

  @override
  String get chatPlantLabel => '植物';

  @override
  String get chatDiagnosisLabel => '诊断';

  @override
  String get chatTreatmentLabel => '治疗';

  @override
  String get chatUrgencyLabel => '紧迫性';

  @override
  String get chatRecoveryLabel => '预计恢复情况';

  @override
  String get discoverMonsteraTitle => '龟背竹生长的秘密';

  @override
  String get discoverIndoorPlants => '室内植物';

  @override
  String get discoverSucculentWatering => '多肉植物浇水指南';

  @override
  String get discoverCacti => '仙人掌和多肉植物';

  @override
  String get discoverHerbSoil => '最适合种植药草的土壤类型';

  @override
  String get discoverHerbs => '香草';

  @override
  String get discoverPropagation => '传播 101：初学者手册';

  @override
  String get discoverPests => '常见害虫及其防治方法';

  @override
  String get discoverRepotting => '换盆：何时以及如何？';

  @override
  String discoverMinutesRead(int minutes) {
    return '$minutes 最小读取数';
  }

  @override
  String get skip => '跳过';

  @override
  String get skipForNow => '暂时跳过';

  @override
  String get continueLabel => '继续';

  @override
  String get getStarted => '开始使用';

  @override
  String get nextStep => '下一步';

  @override
  String get maybeLater => '也许稍后';

  @override
  String get emailAddress => '电子邮件地址';

  @override
  String get password => '密码';

  @override
  String get firstName => '名字';

  @override
  String get lastName => '姓氏';

  @override
  String get login => '登录';

  @override
  String get signUp => '注册';

  @override
  String get welcomeBack => '欢迎回来';

  @override
  String get loginSubtitle => '登录以继续照料您的花园。';

  @override
  String get signUpSubtitle => '加入我们，开始建设您的绿色庇护所。';

  @override
  String get forgotPassword => '忘记密码？';

  @override
  String get enterEmailPassword => '请输入您的电子邮件和密码。';

  @override
  String get fillAllFields => '请填写所有字段。';

  @override
  String authError(String error) {
    return '出了点问题：$error';
  }

  @override
  String get loginWith => '或者使用以下方式登录';

  @override
  String get signUpWith => '或者注册';

  @override
  String get noAccount => '没有帐户？';

  @override
  String get alreadyAccount => '已经有帐户？';

  @override
  String get developerSession => '创建开发者会话';

  @override
  String get welcomeBotaniq => '欢迎来到Botaniq';

  @override
  String get loginOptionsSubtitle => '登录或注册以备份您的植物、日程安排和首选项。';

  @override
  String get notificationAccessTitle => '不要错过浇水';

  @override
  String get notificationAccessSubtitle =>
      '当需要关心您的绿色朋友时，我们会温柔地提醒您。植物护理变得轻松无压力。';

  @override
  String get notificationTurnOn => '打开提醒';

  @override
  String get creatingClimate => '分析您的微气候...';

  @override
  String get creatingSchedules => '定制护理时间表...';

  @override
  String get creatingSanctuary => '准备你的绿色庇护所......';

  @override
  String get locationAccessTitle => '位置访问';

  @override
  String get locationAccessSubtitle => '根据当地的小气候进行个性化的植物护理。';

  @override
  String get locationRecommendation => '本地推荐';

  @override
  String get locationRecommendationSubtitle => '在您所在地区的气候下茁壮成长的植物';

  @override
  String get locationWeather => '智能天气同步';

  @override
  String get locationWeatherSubtitle => '时间表根据当地实时降雨情况进行调整';

  @override
  String get locationAlerts => '霜冻和高温警报';

  @override
  String get locationAlertsSubtitle => '在极端天气袭来之前收到通知';

  @override
  String get locationEnable => '启用位置访问';

  @override
  String get wherePlantsTitle => '你的植物在哪里？';

  @override
  String get wherePlantsSubtitle => '选择所有适用的选项来定制您的护理时间表。';

  @override
  String get locationIndoor => '室内';

  @override
  String get locationIndoorSubtitle => '客厅、卧室、办公室';

  @override
  String get locationBalcony => '阳台';

  @override
  String get locationBalconySubtitle => '甲板或露台上的盆栽植物';

  @override
  String get locationGarden => '花园';

  @override
  String get locationGardenSubtitle => '地下植物和花坛';

  @override
  String get helpTitleBefore => '我们能做什么';

  @override
  String get helpTitleHighlight => '帮助你';

  @override
  String get helpTitleAfter => '与？';

  @override
  String get helpSubtitle => '选择一个或多个目标来个性化您的花园。';

  @override
  String get helpHeal => '治好病\n植物';

  @override
  String get helpCare => '护理\n提醒';

  @override
  String get helpIdentify => '识别\n物种';

  @override
  String get helpJournal => '成长\n日记';

  @override
  String get helpOther => '其他的东西';

  @override
  String get journeyTitle => '您的绿色之旅';

  @override
  String get journeySubtitle => '选择您希望提供的护理级别。';

  @override
  String get journeyCasualLabel => '休闲';

  @override
  String get journeyCasualTitle => '低维护成本';

  @override
  String get journeyCasualSubtitle => '我只想让我的简单植物保持活力和繁荣。';

  @override
  String get journeyEnthusiastLabel => '爱好者';

  @override
  String get journeyEnthusiastTitle => '均衡护理';

  @override
  String get journeyEnthusiastSubtitle => '我喜欢每周花一些时间来欣赏我不断增加的收藏。';

  @override
  String get journeyObsessedLabel => '痴迷';

  @override
  String get journeyObsessedTitle => '非凡的植物亲本';

  @override
  String get journeyObsessedSubtitle => '我为我的植物而活，并希望为我的室内丛林制定专家的时间表。';

  @override
  String get masteryTitleBefore => '你怎么样';

  @override
  String get masteryTitleHighlight => '绿色\n拇指';

  @override
  String get masteryTitleAfter => '最近？';

  @override
  String get masterySubtitle => '说实话，我们都曾在某个时刻成为“连环杀手”。选择您当前的掌握程度。';

  @override
  String get masteryKiller => '连环杀手';

  @override
  String get masteryKillerSubtitle => '当我进入房间时，就连我的塑料植物也显得很担心。';

  @override
  String get masteryAccidental => '意外父母';

  @override
  String get masteryAccidentalSubtitle => '我的仙人掌已经存活两周了。我们还在互相了解中。';

  @override
  String get masteryGrowth => '成长心态';

  @override
  String get masteryGrowthSubtitle => '我的大多数朋友都有叶子。我从我的绿萝中了解了我的龟背竹。';

  @override
  String get masteryWhisperer => '植物语者';

  @override
  String get masteryWhispererSubtitle => '我繁殖稀有植物并能说流利的植物拉丁语。';

  @override
  String get onboardingOneTitle => '保重\n你的植物';

  @override
  String get onboardingOneHighlight => '像专业人士一样';

  @override
  String get onboardingOneSubtitle => '智能时间表和即时识别您的城市丛林。';

  @override
  String get onboardingOneBadge => '人工智能驱动的护理';

  @override
  String get onboardingAiScan => '人工智能扫描';

  @override
  String get onboardingSmartWater => '智慧水务';

  @override
  String get onboardingLightTracking => '光追踪';

  @override
  String get onboardingTwoTitle => '识别任何\n厂于';

  @override
  String get onboardingTwoHighlight => '秒数';

  @override
  String get onboardingTwoSubtitle => '拍张照片以了解其名称、种类和护理要求。';

  @override
  String get onboardingTwoBadge => '植物专家';

  @override
  String get onboardingSnapPhoto => '拍照';

  @override
  String get onboardingAccurateResult => '结果准确';

  @override
  String get onboardingPlantWiki => '植物维基';

  @override
  String get onboardingThreeTitle => '永远不会忘记\n到水';

  @override
  String get onboardingThreeHighlight => '再次';

  @override
  String get onboardingThreeSubtitle => '根据工厂的需求和环境适时发出提醒。';

  @override
  String get onboardingThreeBadge => '智能时间表';

  @override
  String get onboardingReminders => '提醒事项';

  @override
  String get onboardingClimateData => '气候数据';

  @override
  String get onboardingHealthyGrowth => '健康成长';

  @override
  String get onboardingCommunity => '加入 50,000 多个植物亲本';

  @override
  String get onboardingAgreement => '继续，即表示您同意我们的条款和隐私政策';

  @override
  String get termsTitle => '条款与政策';

  @override
  String get termsUpdated => '最后更新时间：2026 年 7 月';

  @override
  String get termsUseTitle => '1. 使用条款';

  @override
  String get termsUseBody => '通过访问或使用 Botaniq，您同意这些使用条款和适用法律。如果您不同意，您不得使用该服务。';

  @override
  String get termsPrivacyTitle => '2. 用户隐私';

  @override
  String get termsPrivacyBody => '我们仅收集提供定制植物护理计划所需的个人数据。我们不会将您的个人数据出售给第三方。';

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
  String get termsPlantTitle => '3. 植物数据';

  @override
  String get termsPlantBody =>
      '提供植物护理、识别和诊断信息仅供参考。人工智能结果可能并不总是正确的，因此请观察您的工厂并就严重风险寻求专家的帮助。';

  @override
  String get termsLiabilityTitle => '6. Disclaimers, Liability, and Indemnity';

  @override
  String get termsLiabilityBody =>
      'Botaniq is provided \"as is\" and \"as available,\" without warranties of any kind, express or implied, including accuracy, reliability, or fitness for a particular purpose. To the fullest extent permitted by law, we and our service providers are not liable for any indirect, incidental, special, or consequential damages, or for any loss of data, plants, or property arising from your use of the service, and our total liability for any claim is limited to the amount you paid us, if any, in the twelve months before the claim. You agree to indemnify and hold us harmless from claims arising from your use of the service, your content, or your violation of these Terms or applicable law.';

  @override
  String get termsPremiumTitle => '4. 高级订阅';

  @override
  String get termsPremiumBody =>
      '确认购买后，您的每月或每年高级订阅将从您的 Apple 或 Google 帐户中扣除。除非在当前期限结束前至少 24 小时取消，否则它将自动续订。您可以在商店帐户设置中管理或取消它。退款请求根据适用的商店政策处理。';

  @override
  String get termsLawTitle => '8. Governing Law and Changes';

  @override
  String get termsLawBody =>
      'These Terms are governed by the laws of the jurisdiction in which we operate, without regard to conflict-of-law principles, and any dispute will be resolved under that jurisdiction\'s applicable procedures to the fullest extent permitted by law. We may update these Terms and our data practices at any time by posting the revised version in the app.';

  @override
  String get termsClosing => '享受心灵的平静和快乐的植物。';

  @override
  String get weatherTitle => '天气';

  @override
  String get weatherSunnyTip => '今天阳光明媚——浇水前检查土壤。';

  @override
  String get weatherCloudyTip => '多云天气减缓蒸发；水少一点。';

  @override
  String get weatherRainyTip => '多雨且潮湿——避免室外植物浇水过多。';

  @override
  String get weatherStormTip => '暴风雨天气——将精致的花盆移至遮蔽处。';

  @override
  String get weatherSnowTip => '寒冷多雪——保护植物免受温度冲击。';
}

/// The translations for Chinese, using the Han script (`zh_Hans`).
class AppLocalizationsZhHans extends AppLocalizationsZh {
  AppLocalizationsZhHans() : super('zh_Hans');
}

/// The translations for Chinese, using the Han script (`zh_Hant`).
class AppLocalizationsZhHant extends AppLocalizationsZh {
  AppLocalizationsZhHant() : super('zh_Hant');

  @override
  String get settings => '設定';

  @override
  String get preferences => '偏好設定';

  @override
  String get metricSystemSubtitle => '使用攝氏度和米';

  @override
  String get account => '帳戶';

  @override
  String get editProfile => '編輯個人資料';

  @override
  String get changePassword => '更改密碼';

  @override
  String get subscriptionManagement => '訂閱管理';

  @override
  String get premium => '高級版';

  @override
  String get language => '語言';

  @override
  String get languageSubtitle => '更改應用程式語言';

  @override
  String get selectLanguage => '選擇語言';

  @override
  String get systemLanguage => '系統語言';

  @override
  String get english => '英語';

  @override
  String get turkish => '圖爾克切';

  @override
  String get languageChanged => '語言更改成功。';

  @override
  String get languageSearchHint => '搜尋語言';

  @override
  String get languageRecommended => '推薦';

  @override
  String get languageWelcomeTitle => '選擇您的語言';

  @override
  String get languageWelcomeSubtitle => '選擇您想要在 Botaniq 中使用的語言。您可以隨時更改它。';

  @override
  String get languageUseSystem => '使用裝置語言';

  @override
  String get preferenceSystem => '使用系統設定';

  @override
  String get themeSelectionTitle => '選擇外觀';

  @override
  String get measurementImperial => '帝國';

  @override
  String get measurementSelectionTitle => '選擇測量系統';

  @override
  String get settingsSubtitle => '根據您自己的護理步調塑造 Botaniq。';

  @override
  String get settingsLocalPreference => '已儲存在此裝置上';

  @override
  String get settingsDarkModeSubtitle => '適合低光時刻的平靜調色板';

  @override
  String get settingsAccountSubtitle => '身分、存取權限和會員資格';

  @override
  String get settingsEditProfileSubtitle => '姓名、地點和護理偏好';

  @override
  String get settingsPasswordSubtitle => '將安全重置連結發送到您的電子郵件';

  @override
  String get settingsSubscriptionSubtitle => '高級計劃和帳單詳細信息';

  @override
  String get settingsPasswordResetSent => '已發送密碼重設電子郵件。';

  @override
  String get settingsComingSoon => '這個空間仍在成長。';

  @override
  String get subscriptionPageTitle => '高級會員資格';

  @override
  String get subscriptionHeroEyebrow => 'BOTANIQ PREMIUM';

  @override
  String get subscriptionHeroTitle => '更聰明地照顧每株植物';

  @override
  String get subscriptionHeroSubtitle => '解鎖每個高級護理工具，自信地拓展您的綠色空間。';

  @override
  String get subscriptionBenefitsTitle => '一切盡在高級版';

  @override
  String get subscriptionBenefitIdentification => '無限制的植物識別和健康分析';

  @override
  String get subscriptionBenefitCare => '個人化護理計劃和提醒';

  @override
  String get subscriptionBenefitInsights => '專家內容和高級護理見解';

  @override
  String subscriptionSavePercent(int percent) {
    return '節省 $percent%';
  }

  @override
  String get subscriptionContinue => '解鎖高級版';

  @override
  String get subscriptionRestorePurchases => '恢復購買';

  @override
  String get subscriptionRestoring => '正在恢復...';

  @override
  String get subscriptionManage => '管理訂閱';

  @override
  String get subscriptionActiveTitle => '您的高級會員資格已激活';

  @override
  String get subscriptionActiveSubtitle => '您可以使用所有進階功能。';

  @override
  String subscriptionRenewsOn(String date) {
    return '在 $date 續訂';
  }

  @override
  String subscriptionExpiresOn(String date) {
    return '活躍至 $date';
  }

  @override
  String get subscriptionAutoRenewDisclosure =>
      '付款將從您的 Apple 或 Google 帳戶中扣除。除非在當前週期結束前至少 24 小時取消，否則訂閱將自動續訂。您可以隨時在商店帳戶設定中管理或取消它。';

  @override
  String get subscriptionTermsLink => '使用條款';

  @override
  String get subscriptionPrivacyLink => '隱私權政策';

  @override
  String get subscriptionPurchaseSuccess => '您的高級會員資格現已生效。';

  @override
  String get subscriptionRestoreSuccess => '您的高級會員資格已恢復。';

  @override
  String get subscriptionNothingToRestore => '未找到此商店帳戶的有效會員資格。';

  @override
  String get subscriptionPaymentPending => '付款正在等待商店批准。一旦獲得批准，您的會員資格將自動啟動。';

  @override
  String get subscriptionErrorGeneric => '操作無法完成。請再試一次。';

  @override
  String get subscriptionErrorNetwork => '檢查您的網路連接，然後再試一次。';

  @override
  String get subscriptionErrorNotAllowed => '該設備或商店帳戶不允許進行購買。';

  @override
  String get subscriptionErrorStore => '無法聯絡該商店。請稍後重試。';

  @override
  String get subscriptionMissingConfiguration => '此版本中缺少 RevenueCat 密鑰。';

  @override
  String get subscriptionUnsupported => '訂閱僅在 iOS 和 Android 應用程式中可用。';

  @override
  String get subscriptionProductsUnavailable =>
      '無法加載月度和年度產品。檢查 RevenueCat 產品配置。';

  @override
  String get subscriptionRetry => '再試一次';

  @override
  String get subscriptionFree => '免費';

  @override
  String get homeEmptyGarden => '你的花園空了';

  @override
  String get homeEmptyGardenSubtitle => '開始建造你的綠色庇護所\n加入你的第一株植物。';

  @override
  String get homeAddFirstPlant => '增加第一個工廠';

  @override
  String get homeViewAll => '看全部';

  @override
  String get homeSmartCareReminders => '智慧護理提醒';

  @override
  String get homeWatering => '澆水';

  @override
  String get homeWateringSubtitle => '土壤追蹤';

  @override
  String get homeFertilizingSubtitle => '營養警報';

  @override
  String get gardenTitle => '我的花園';

  @override
  String get gardenIndoor => '室內';

  @override
  String get gardenNoPlants => '還沒有植物。\n點擊+加入您的第一株植物！';

  @override
  String get gardenNoPlantsCategory => '此類別中沒有植物。';

  @override
  String get discoverTitle => '發現';

  @override
  String get discoverSearchHint => '搜尋植物、文章、指南...';

  @override
  String get discoverSeeAll => '看全部';

  @override
  String get discoverTrendingGuides => '熱門指南';

  @override
  String get healthyTitle => '護理中心';

  @override
  String get healthySubtitle => '觸摸植物的靈魂，與它們交談。';

  @override
  String get healthyTabDoctor => '醫生';

  @override
  String get healthyTabHospital => '醫院';

  @override
  String get healthyTabDiscover => '發現';

  @override
  String get profileTitle => '我的個人資料';

  @override
  String get profileEditProfile => '編輯個人資料';

  @override
  String get profileSettingsTab => '設定';

  @override
  String get profileGardenerLevel => '園丁級別';

  @override
  String get profileTotalPlants => '植物總數';

  @override
  String get profileCompletedTasks => '已完成的任務';

  @override
  String get profileWeeklyActivity => '每週護理活動';

  @override
  String get profileAppSettings => '應用程式設定';

  @override
  String get profileNotificationPrefs => '通知首選項';

  @override
  String get profileSupportLegal => '支持與法律';

  @override
  String get profileHelpCenter => '幫助中心';

  @override
  String get profileTerms => '使用條款和政策';

  @override
  String get profileDeleteAccount => '刪除帳戶';

  @override
  String get profileSubtitle => '您的花園故事、進展和個人空間。';

  @override
  String get profileGardenPassport => '花園護照';

  @override
  String get profileThisWeek => '本週';

  @override
  String get profileQuietWeek => '安靜的一周——您的下一個護理時刻將出現在這裡。';

  @override
  String get profileActiveWeek => '您的護理節奏活躍且不斷發展。';

  @override
  String get profileAppSettingsSubtitle => '語言、單位和人工智慧連接';

  @override
  String get profileNotificationPrefsSubtitle => '選擇適合您的護理時刻';

  @override
  String get profileHelpCenterSubtitle => '答案和快速指導';

  @override
  String get profileTermsSubtitle => '隱私權、條款與政策';

  @override
  String get profileAccountActions => '帳戶操作';

  @override
  String get profileSignOutQuestion => '您確定要退出嗎？';

  @override
  String get profileDeleteAccountWarning => '帳戶刪除需要安全的伺服器端確認。您的資料尚未更改。';

  @override
  String get continueAction => '繼續';

  @override
  String get profileTitleNew => '新園丁🌱';

  @override
  String get profileTitleSprout => '發芽朋友🌿';

  @override
  String get profileTitleLeaf => '葉子愛好者☘️';

  @override
  String get profileTitleSkilled => '熟練的園丁🏡';

  @override
  String get profileTitleMaster => '綠拇指大師👑';

  @override
  String get profileNextLevelStart => '添加您的第一株植物並開始您的園藝冒險！';

  @override
  String profileNextLevelLeaf(int count) {
    return '只剩下 $count 植物成為戀葉人。';
  }

  @override
  String profileNextLevelSkilled(int count) {
    return '只剩下 $count 植物才能成為熟練園丁。';
  }

  @override
  String profileNextLevelMaster(int count) {
    return '只剩下 $count 植物可以成為綠拇指大師。';
  }

  @override
  String get profileNextLevelMax => '您已到達花園頂峰，恭喜！';

  @override
  String get navHome => '首頁';

  @override
  String get navGarden => '花園';

  @override
  String get navClinic => '診所';

  @override
  String get navProfile => '公司簡介';

  @override
  String get scanPlant => '掃描工廠';

  @override
  String get deletePlantTitle => '移除這個植物？';

  @override
  String get deletePlantMessage => '該植物、其護理任務和診所記錄將從您的帳戶中永久刪除。';

  @override
  String get deletePlantNotFound => '該植物無法找到或已被移除。';

  @override
  String deletePlantError(String error) {
    return '無法移除該植物：$error';
  }

  @override
  String get profileChoosePhoto => '選擇個人資料照片';

  @override
  String get profileFullNameHint => '輸入您的全名';

  @override
  String get profileNickname => '暱稱';

  @override
  String get profileNicknameHint => '我們該怎麼稱呼你呢？';

  @override
  String get profileAge => '年齡';

  @override
  String get profileAgeValidation => '請輸入 1 到 120 之間的年齡。';

  @override
  String profileLoadError(String error) {
    return '無法載入設定檔：$error';
  }

  @override
  String get languageEnglish => '英語';

  @override
  String get languageTurkish => '土耳其語';

  @override
  String get profileEmailReadOnly => '電子郵件地址（唯讀）';

  @override
  String get profileEmailHint => '輸入您的電子郵件';

  @override
  String get profileLocation => '地點';

  @override
  String get profileLocationHint => '城市、國家';

  @override
  String get profileSaveChanges => '儲存變更';

  @override
  String get profileUpdated => '您的個人資料已更新。';

  @override
  String profileSaveError(String error) {
    return '無法儲存設定檔：$error';
  }

  @override
  String get notificationWateringTitle => '澆水提醒';

  @override
  String get notificationWateringSubtitle => '到了澆水時間時收到通知';

  @override
  String get notificationFertilizerSubtitle => '植物的季節性施肥警報';

  @override
  String get notificationPlantCareAlerts => '植物護理警報';

  @override
  String get notificationWeatherTitle => '天氣警報';

  @override
  String get notificationWeatherSubtitle => '極端天氣警告';

  @override
  String get notificationArticlesSubtitle => '花園的提示和技巧';

  @override
  String get gardenClinicBadge => '在診所';

  @override
  String get wateringNever => '最後一次澆水：從未';

  @override
  String wateringLastDate(String date) {
    return '最後澆水：$date';
  }

  @override
  String get wateringNeverDue => '尚未澆水 • 今天澆水';

  @override
  String wateringOverdue(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '已逾期 $days 天',
      zero: '今天澆水',
    );
    return '$_temp0';
  }

  @override
  String get wateringDueToday => '今天澆水';

  @override
  String get wateringDueTomorrow => '明天澆水';

  @override
  String wateringDueInDays(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days 天後澆水',
      zero: '今天澆水',
    );
    return '$_temp0';
  }

  @override
  String get plantSpeciesFallback => '植物種類';

  @override
  String get plantAbout => '關於';

  @override
  String get plantLocationEnvironment => '地點及環境';

  @override
  String get plantCareProtocol => '護理協議';

  @override
  String get plantCareHistory => '最近 10 天的護理歷史';

  @override
  String get plantInClinic => '在診所';

  @override
  String get plantDifficulty => '難度';

  @override
  String get plantEnvironment => '環境';

  @override
  String get plantLightNeed => '輕度需求';

  @override
  String get plantToxicPets => '對寵物有毒';

  @override
  String get plantNonToxic => '無毒';

  @override
  String get plantIndoor => '室內';

  @override
  String get plantBrightIndirect => '明亮間接';

  @override
  String get plantInfoUnavailable => '目前還無法獲得經過驗證的資訊。';

  @override
  String get plantIdealClimate => '理想的氣候';

  @override
  String get plantHumidity => '濕度';

  @override
  String get plantTemperatureRange => '溫度範圍';

  @override
  String get plantWateringFrequency => '澆水頻率';

  @override
  String get plantNextWatering => '下一步澆水';

  @override
  String get plantWateringProtocol => '澆水協議';

  @override
  String get plantFeedingProtocol => '餵食計畫';

  @override
  String get plantPruningCleaning => '修剪和清潔';

  @override
  String get plantPruningFallback => '每月擦拭葉子。修剪枯死或發黃的葉子以促進生長。';

  @override
  String get plantHistoryEmpty => '最近 10 天無護理史。';

  @override
  String get plantWateringTask => '澆水';

  @override
  String get plantWateredAction => '澆水 ✓';

  @override
  String get plantWaterNowAction => '現在澆水';

  @override
  String get plantAddGardenAction => '添加到我的花園';

  @override
  String get plantWaterSuccess => '💧 你給你的植物澆水了！幹得好！';

  @override
  String get plantFertilizeSuccess => '🌱添加肥料！你的植物說謝謝！';

  @override
  String plantWaterError(String error) {
    return '澆水無法保存：$error';
  }

  @override
  String plantFertilizeError(String error) {
    return '無法保存施肥：$error';
  }

  @override
  String get clinicDoctorHero => '人工智慧植物醫生\n竭誠為您服務';

  @override
  String get clinicStartConsultation => '開始諮詢';

  @override
  String get clinicChoosePlant => '您想討論哪一種植物？';

  @override
  String get clinicChoosePlantSubtitle => '從您的花園中選擇一種植物或拍攝新照片。';

  @override
  String get clinicNoGardenPlants => '你的花園裡還沒有植物。\n首先拍攝一張新照片。';

  @override
  String get clinicNewPhoto => '拍攝一張新照片';

  @override
  String get clinicNewPhotoSubtitle => '拍攝患病植物並獲得診斷';

  @override
  String get clinicPestAnalysis => '害蟲分析';

  @override
  String get clinicVisualDiagnosis => '視覺診斷';

  @override
  String get clinicLightMeter => '照度計';

  @override
  String get clinicSensorSimulation => '感測器模擬';

  @override
  String get clinicTitle => '植物診所';

  @override
  String get clinicEmpty => '診所內沒有患病植物。\n如果你關心一株植物，\n從“醫生”選項卡詢問。';

  @override
  String get clinicPendingDiagnosis => '等待診斷';

  @override
  String get clinicNoTreatment => '治療方案尚未確定';

  @override
  String get clinicPrescription => '處方：';

  @override
  String get clinicRecovery => '恢復';

  @override
  String get clinicRecovered => '已恢復';

  @override
  String get clinicContinue => '繼續';

  @override
  String get clinicUrgencyCritical => '關鍵';

  @override
  String get healthTrendingTips => '流行健康秘訣';

  @override
  String get healthHumidityArticleTitle => '冬季準備：保持濕度平衡';

  @override
  String get healthHumidityArticleSubtitle => '如何在寒冷的月份保護您的植物免受乾燥的散熱器空氣的影響。';

  @override
  String get healthWeeklySpotlight => '本週的患者和治療方法';

  @override
  String get healthAphidTitle => '蚜蟲侵擾';

  @override
  String get healthAphidSubtitle => '早期介入和天然印楝油治療。';

  @override
  String get healthDiscoverLoadError => '目前無法載入發現內容。拉下來再試一次。';

  @override
  String get healthDiscoverEmpty => '尚未發布發現內容。';

  @override
  String get healthDiscoverRetry => '再試一次';

  @override
  String get lightMeterTitle => '照度計';

  @override
  String get lightMeterInstructionTitle => '測量光';

  @override
  String get lightMeterInstruction => '將手機前置鏡頭朝向\n植物的位置和光源。';

  @override
  String get lightMeterCameraEstimate => '根據相機數據計算出的近似勒克斯';

  @override
  String get lightMeterStabilizing => '穩定測量';

  @override
  String get lightMeterStabilizingRecommendation => '保持手機穩定幾秒鐘，同時過濾突然的曝光變化。';

  @override
  String get lightMeterUnavailable => '無法測量';

  @override
  String get lightMeterUnavailableRecommendation => '啟用相機權限並再次嘗試此畫面。';

  @override
  String get lightLow => '弱光（陰影）';

  @override
  String get lightMedium => '中光（明亮房間）';

  @override
  String get lightHigh => '高光（靠近窗戶）';

  @override
  String get lightVeryHigh => '極高光（陽光直射）';

  @override
  String get lightLowRecommendation => '適用於竹芋屬、蕨類植物或蛇類植物。';

  @override
  String get lightMediumRecommendation => '非常適合龜背竹、榕樹和紅掌。';

  @override
  String get lightHighRecommendation => '適合喜陽光的蘆薈、仙人掌和天竺葵。';

  @override
  String get lightVeryHighRecommendation => '最適合戶外植物和多肉植物。';

  @override
  String get homeLoadingPlants => '正在加載植物...';

  @override
  String get homeWateringTime => '澆水時間';

  @override
  String get homeWateringNotification => '你的室內植物需要澆水。';

  @override
  String get homeWelcome => '歡迎！';

  @override
  String get homeWelcomeNotification => '歡迎來到 Botaniq。先新增你的第一株植物。';

  @override
  String get homeTenMinutesAgo => '10 分鐘前';

  @override
  String get homeQuickActions => '快速行動';

  @override
  String get homeIdentifyCamera => '用你的相機識別';

  @override
  String get homeNoTasks => '今天沒有任務！';

  @override
  String get homeAllCared => '你的植物都被照顧好了🌿';

  @override
  String get homeInstructions => '使用說明';

  @override
  String homeRequiredAmount(String amount) {
    return '必備：$amount';
  }

  @override
  String get homeLater => '後來';

  @override
  String get homeMarkDone => '標記為完成';

  @override
  String get homeSickPlants => '植物診所';

  @override
  String get homeGreetingMorning => '早安';

  @override
  String get homeGreetingAfternoon => '午安';

  @override
  String get homeGreetingEvening => '晚安';

  @override
  String get homeTodayTasks => '今天的任務';

  @override
  String get homeTomorrowTasks => '明天的任務';

  @override
  String homeDateTasks(String date) {
    return '$date 任務';
  }

  @override
  String get commonSkip => '跳過';

  @override
  String get commonContinue => '繼續';

  @override
  String get commonClose => '關閉';

  @override
  String get commonDelete => '刪除';

  @override
  String get wizardSaveGarden => '保存並添加到花園';

  @override
  String wizardPlantAdded(String name) {
    return '$name 已加入您的花園！ 🌿';
  }

  @override
  String get wizardRoomTitle => '你的工廠在哪裡？';

  @override
  String get wizardRoomSubtitle => '按房間將植物分類，以便輕鬆管理。';

  @override
  String get wizardLivingRoom => '客廳';

  @override
  String get wizardBedroom => '臥室';

  @override
  String get wizardKitchen => '廚房';

  @override
  String get wizardOffice => '辦公室';

  @override
  String get wizardBalcony => '陽台';

  @override
  String get wizardLightTitle => '這個地方的光線如何？';

  @override
  String get wizardDirectSun => '直射陽光';

  @override
  String get wizardDirectSunDescription => '未經過濾的陽光直接照射在植物上';

  @override
  String get wizardBrightIndirect => '明亮間接';

  @override
  String get wizardBrightIndirectDescription => '靠近朝東或朝西的窗戶';

  @override
  String get wizardMediumLightDescription => '距離窗戶幾英尺遠';

  @override
  String get wizardLowLightDescription => '遠離窗戶或在人造光下';

  @override
  String get wizardDistanceTitle => '到窗戶的距離';

  @override
  String get wizardDistanceSubtitle => '選擇到最近視窗的大致距離。';

  @override
  String get wizardMoreThanFiveMeters => '超過5m';

  @override
  String get wizardActiveHoursTitle => '活躍光照時間';

  @override
  String get wizardActiveHoursSubtitle => '該地點接受多少小時的直射光或強光？';

  @override
  String wizardHour(int count) {
    return '$count 小時';
  }

  @override
  String wizardHours(int count) {
    return '$count 小時';
  }

  @override
  String get wizardSixPlusHours => '6小時以上';

  @override
  String get wizardRepottedTitle => '這株植物最後一次換盆是什麼時候？';

  @override
  String get wizardRepottedSubtitle => '新鮮的土壤對於植物的生長至關重要。';

  @override
  String get wizardRecently => '最近（3個月以內）';

  @override
  String get wizardSixMonthsAgo => '6 個月前';

  @override
  String get wizardPotTitle => '鍋子是什麼材質的？';

  @override
  String get wizardPotSubtitle => '盆栽材料會影響土壤乾燥的速度。';

  @override
  String get wizardPlasticPot => '塑膠/苗圃';

  @override
  String get wizardTerracottaPot => '兵馬俑';

  @override
  String get wizardMetalPot => '金屬';

  @override
  String get wizardWateredTitle => '你上次給這棵植物澆水是什麼時候？';

  @override
  String get wizardWateredSubtitle => '這有助於計算準確的下一次澆水時間。';

  @override
  String get wizardFewDaysAgo => '幾天前';

  @override
  String get wizardWeekAgo => '一週前';

  @override
  String get wizardMoreWeekAgo => '一個多星期前';

  @override
  String get historyTitle => '搜尋紀錄';

  @override
  String get historyClearTitle => '清除歷史記錄';

  @override
  String get historyClearMessage => '所有搜尋和掃描歷史記錄都將被刪除。你確定嗎？';

  @override
  String get historyClearTooltip => '清除歷史記錄';

  @override
  String get historyEmptyTitle => '沒有搜尋紀錄';

  @override
  String get historyEmptySubtitle => '用相機掃描或搜尋到的植物將出現在此。';

  @override
  String get historyNoDetails => '沒有詳細資料。';

  @override
  String get historyRegularWater => '定期澆水';

  @override
  String get historyIndirectLight => '間接光線';

  @override
  String get historyWatering => '澆水';

  @override
  String historyMinutesAgo(int minutes) {
    return '$minutes 分鐘前';
  }

  @override
  String historyHoursAgo(int hours) {
    return '$hours 小時前';
  }

  @override
  String get historyPlantRecord => '植物搜尋紀錄';

  @override
  String get photoWholeSpecimen => '整體照片\n植物或蘑菇';

  @override
  String get photoWholeSpecimenSubtitle => '將整個標本保持在框架中央，以便更好地識別。';

  @override
  String get photoCorrect => '正確';

  @override
  String get photoInstructions => '使用說明';

  @override
  String get photoOpenCamera => '我明白了，打開相機';

  @override
  String get scannerMushroom => '菇';

  @override
  String get scannerIdentifyingPlant => '辨識植物...';

  @override
  String get scannerIdentifyingMushroom => '鑑別蘑菇...';

  @override
  String get scannerCapture => '拍照及掃描';

  @override
  String get scannerFailed => '掃描失敗。請再試一次。';

  @override
  String scannerError(String error) {
    return '發生錯誤：$error';
  }

  @override
  String get scheduleTitle => '時間表';

  @override
  String get scheduleTodayTask => '今天的任務';

  @override
  String get scheduleNoTasks => '今天沒有任務！';

  @override
  String get scheduleInstructions => '使用說明';

  @override
  String scheduleRequired(String amount) {
    return '必備：$amount';
  }

  @override
  String get scheduleRemindLater => '稍後提醒';

  @override
  String get scheduleCareFallback => '照顧你的植物。';

  @override
  String get chatDoctorTitle => '人工智慧植物醫生';

  @override
  String chatPatient(String name) {
    return '病人：$name';
  }

  @override
  String chatHint(String name) {
    return '詢問 $name...';
  }

  @override
  String chatWelcome(String name) {
    return '你好！ 🌿 我是你們的人工智慧植物醫生。我可以如何幫助 $name？\n\n我可以診斷照片或回答您的護理問題。';
  }

  @override
  String chatContinueWelcome(String name) {
    return '你好！讓我們繼續$name。 🌱';
  }

  @override
  String get chatQuestionYellowing => '葉子發黃是什麼原因造成的？';

  @override
  String get chatQuestionTreatment => '我該如何處理這種植物？';

  @override
  String get chatQuestionWatering => '我該改變澆水頻率嗎？';

  @override
  String get chatQuestionFertilizer => '我應該使用哪種肥料？';

  @override
  String get chatPhotoSent => '照片已發送';

  @override
  String get chatDiagnosisUnknown => '無法確定診斷';

  @override
  String get chatNoTreatment => '無治療建議';

  @override
  String chatError(String error) {
    return '抱歉，發生錯誤：$error。請再試一次。';
  }

  @override
  String get chatCareTips => '護理秘訣';

  @override
  String get chatDiagnosisLabel => '診斷';

  @override
  String get chatTreatmentLabel => '治療';

  @override
  String get chatUrgencyLabel => '緊迫性';

  @override
  String get chatRecoveryLabel => '預計恢復狀況';

  @override
  String get discoverMonsteraTitle => '龜背竹成長的秘密';

  @override
  String get discoverIndoorPlants => '室內植物';

  @override
  String get discoverSucculentWatering => '多肉植物澆水指南';

  @override
  String get discoverHerbSoil => '最適合種植藥草的土壤類型';

  @override
  String get discoverPropagation => '傳播 101：初學者手冊';

  @override
  String get discoverPests => '常見害蟲及其防治方法';

  @override
  String get discoverRepotting => '換盆：何時以及如何？';

  @override
  String discoverMinutesRead(int minutes) {
    return '$minutes 最小讀取數';
  }

  @override
  String get skip => '跳過';

  @override
  String get skipForNow => '暫時跳過';

  @override
  String get continueLabel => '繼續';

  @override
  String get getStarted => '開始使用';

  @override
  String get maybeLater => '也許稍後';

  @override
  String get emailAddress => '電子郵件地址';

  @override
  String get password => '密碼';

  @override
  String get login => '登入';

  @override
  String get signUp => '註冊';

  @override
  String get welcomeBack => '歡迎回來';

  @override
  String get loginSubtitle => '登入以繼續照料您的花園。';

  @override
  String get signUpSubtitle => '加入我們，開始建造您的綠色庇護所。';

  @override
  String get forgotPassword => '忘記密碼？';

  @override
  String get enterEmailPassword => '請輸入您的電子郵件和密碼。';

  @override
  String get fillAllFields => '請填寫所有欄位。';

  @override
  String authError(String error) {
    return '出了點問題：$error';
  }

  @override
  String get loginWith => '或使用以下方式登入';

  @override
  String get signUpWith => '或註冊';

  @override
  String get noAccount => '沒有帳戶？';

  @override
  String get alreadyAccount => '已經有帳戶？';

  @override
  String get developerSession => '創建開發者會話';

  @override
  String get welcomeBotaniq => '歡迎來到 Botaniq';

  @override
  String get loginOptionsSubtitle => '登入或註冊以備份您的植物、日程安排和首選項。';

  @override
  String get notificationAccessTitle => '不要錯過澆水';

  @override
  String get notificationAccessSubtitle =>
      '當需要關心您的綠色朋友時，我們會溫柔地提醒您。植物護理變得輕鬆無壓力。';

  @override
  String get notificationTurnOn => '打開提醒';

  @override
  String get creatingClimate => '分析您的微氣候...';

  @override
  String get creatingSchedules => '客製化護理時間表...';

  @override
  String get creatingSanctuary => '準備你的綠色庇護所.....';

  @override
  String get locationAccessTitle => '位置訪問';

  @override
  String get locationAccessSubtitle => '根據當地的小氣候進行個人化的植物護理。';

  @override
  String get locationRecommendation => '本地推薦';

  @override
  String get locationRecommendationSubtitle => '在您所在地區的氣候下茁壯成長的植物';

  @override
  String get locationWeather => '智慧天氣同步';

  @override
  String get locationWeatherSubtitle => '時間表根據當地即時降雨情況進行調整';

  @override
  String get locationAlerts => '霜凍和高溫警報';

  @override
  String get locationAlertsSubtitle => '在極端天氣來臨前收到通知';

  @override
  String get locationEnable => '啟用位置訪問';

  @override
  String get wherePlantsTitle => '你的植物在哪裡？';

  @override
  String get wherePlantsSubtitle => '選擇所有適用的選項來客製化您的護理時間表。';

  @override
  String get locationIndoor => '室內';

  @override
  String get locationIndoorSubtitle => '客廳、臥室、辦公室';

  @override
  String get locationBalcony => '陽台';

  @override
  String get locationGarden => '花園';

  @override
  String get locationGardenSubtitle => '地下植物與花壇';

  @override
  String get helpTitleBefore => '我們能做什麼';

  @override
  String get helpTitleHighlight => '幫助你';

  @override
  String get helpTitleAfter => '與？';

  @override
  String get helpSubtitle => '選擇一個或多個目標來個性化您的花園。';

  @override
  String get helpCare => '護理\n提醒';

  @override
  String get helpIdentify => '識別\n種';

  @override
  String get helpJournal => '成長\n期刊';

  @override
  String get helpOther => '其他的東西';

  @override
  String get journeyTitle => '您的綠色之旅';

  @override
  String get journeySubtitle => '選擇您希望提供的護理等級。';

  @override
  String get journeyCasualLabel => '休閒';

  @override
  String get journeyCasualTitle => '低維護成本';

  @override
  String get journeyCasualSubtitle => '我只想讓我的簡單植物保持活力和繁榮。';

  @override
  String get journeyEnthusiastLabel => '愛好者';

  @override
  String get journeyEnthusiastTitle => '均衡護理';

  @override
  String get journeyEnthusiastSubtitle => '我喜歡每週花一些時間來欣賞我不斷增加的收藏。';

  @override
  String get journeyObsessedLabel => '迷戀';

  @override
  String get journeyObsessedTitle => '非凡的植物親本';

  @override
  String get journeyObsessedSubtitle => '我為我的植物而活，並希望為我的室內叢林制定專家的時間表。';

  @override
  String get masteryTitleBefore => '你怎麼樣';

  @override
  String get masteryTitleHighlight => '綠色\n大拇指';

  @override
  String get masterySubtitle => '說實話，我們都曾在某個時刻成為「連環殺手」。選擇您目前的掌握程度。';

  @override
  String get masteryKiller => '連續殺人犯';

  @override
  String get masteryKillerSubtitle => '當我進入房間時，就連我的塑膠植物也顯得很擔心。';

  @override
  String get masteryAccidentalSubtitle => '我的仙人掌已經存活兩週了。我們還在互相了解。';

  @override
  String get masteryGrowth => '成長心態';

  @override
  String get masteryGrowthSubtitle => '我大多數的朋友都有葉子。我從我的綠蘿中了解了我的龜背竹。';

  @override
  String get masteryWhisperer => '植物語者';

  @override
  String get masteryWhispererSubtitle => '我繁殖稀有植物並能說流利的植物拉丁語。';

  @override
  String get onboardingOneHighlight => '像專業人士一樣';

  @override
  String get onboardingOneSubtitle => '智慧時間表和即時識別您的城市叢林。';

  @override
  String get onboardingOneBadge => '人工智慧驅動的護理';

  @override
  String get onboardingAiScan => '人工智慧掃描';

  @override
  String get onboardingSmartWater => '智慧水務';

  @override
  String get onboardingLightTracking => '光追蹤';

  @override
  String get onboardingTwoTitle => '識別任何\n廠於';

  @override
  String get onboardingTwoHighlight => '秒數';

  @override
  String get onboardingTwoSubtitle => '拍張照片以了解其名稱、種類和護理要求。';

  @override
  String get onboardingTwoBadge => '植物專家';

  @override
  String get onboardingAccurateResult => '結果準確';

  @override
  String get onboardingPlantWiki => '植物維基';

  @override
  String get onboardingThreeTitle => '永遠不會忘記\n到水';

  @override
  String get onboardingThreeSubtitle => '根據工廠的需求和環境適時發出提醒。';

  @override
  String get onboardingThreeBadge => '智慧時間表';

  @override
  String get onboardingReminders => '提醒事項';

  @override
  String get onboardingClimateData => '氣候數據';

  @override
  String get onboardingHealthyGrowth => '健康成長';

  @override
  String get onboardingCommunity => '加入 50,000 多個植物親本';

  @override
  String get onboardingAgreement => '繼續，即表示您同意我們的條款和隱私權政策';

  @override
  String get termsTitle => '條款與政策';

  @override
  String get termsUpdated => '最後更新時間：2026 年 7 月';

  @override
  String get termsUseTitle => '1. 使用條款';

  @override
  String get termsUseBody => '透過造訪或使用 Botaniq，您同意這些使用條款和適用法律。如果您不同意，您不得使用本服務。';

  @override
  String get termsPrivacyTitle => '2. 用戶隱私';

  @override
  String get termsPrivacyBody => '我們僅收集提供客製化植物護理計劃所需的個人資料。我們不會將您的個人資料出售給第三方。';

  @override
  String get termsPlantTitle => '3. 植物數據';

  @override
  String get termsPlantBody =>
      '提供植物護理、識別和診斷資訊僅供參考。人工智慧結果可能並不總是正確的，因此請觀察您的工廠並就嚴重風險尋求專家的幫助。';

  @override
  String get termsPremiumTitle => '4. 高級訂閱';

  @override
  String get termsPremiumBody =>
      '確認購買後，您的按月或按年高級訂閱費用將從您的 Apple 或 Google 帳戶中扣除。除非在當前期限結束前至少 24 小時取消，否則它將自動續訂。您可以在商店帳戶設定中管理或取消它。退款請求根據適用的商店政策處理。';

  @override
  String get termsClosing => '享受心靈的平靜和快樂的植物。';

  @override
  String get weatherTitle => '天氣';

  @override
  String get weatherSunnyTip => '今天陽光明媚——澆水前檢查土壤。';

  @override
  String get weatherCloudyTip => '多雲天氣減緩蒸發；水少一點。';

  @override
  String get weatherRainyTip => '多雨且潮濕－避免室外植物澆水過多。';

  @override
  String get weatherStormTip => '暴風雨天氣－將精緻的花盆移至遮蔽處。';

  @override
  String get weatherSnowTip => '寒冷多雪－保護植物免受溫度衝擊。';
}
