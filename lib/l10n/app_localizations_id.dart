// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Indonesian (`id`).
class AppLocalizationsId extends AppLocalizations {
  AppLocalizationsId([String locale = 'id']) : super(locale);

  @override
  String get appTitle => 'Botaniq';

  @override
  String get settings => 'Pengaturan';

  @override
  String get preferences => 'Preferensi';

  @override
  String get darkMode => 'Mode Gelap';

  @override
  String get metricSystem => 'Sistem Metrik';

  @override
  String get metricSystemSubtitle => 'Gunakan Celsius dan Meter';

  @override
  String get account => 'Akun';

  @override
  String get editProfile => 'Sunting Profil';

  @override
  String get changePassword => 'Ubah Kata Sandi';

  @override
  String get subscriptionManagement => 'Manajemen Langganan';

  @override
  String get premium => 'Premi';

  @override
  String get language => 'Bahasa';

  @override
  String get languageSubtitle => 'Ubah bahasa aplikasi';

  @override
  String get selectLanguage => 'Pilih Bahasa';

  @override
  String get systemLanguage => 'Bahasa Sistem';

  @override
  String get english => 'bahasa Inggris';

  @override
  String get turkish => 'Turki';

  @override
  String get languageChanged => 'Bahasa berhasil diubah.';

  @override
  String get languageSearchHint => 'Cari bahasa';

  @override
  String get languageRecommended => 'Direkomendasikan';

  @override
  String get languageWelcomeTitle => 'Pilih bahasa Anda';

  @override
  String get languageWelcomeSubtitle =>
      'Pilih bahasa yang ingin Anda gunakan di Botaniq. Anda dapat mengubahnya kapan saja.';

  @override
  String get languageUseSystem => 'Gunakan bahasa perangkat';

  @override
  String get preferenceSystem => 'Gunakan pengaturan sistem';

  @override
  String get themeLight => 'Ringan';

  @override
  String get themeDark => 'Gelap';

  @override
  String get themeSelectionTitle => 'Pilih penampilan';

  @override
  String get measurementMetric => 'Metrik';

  @override
  String get measurementImperial => 'Kekaisaran';

  @override
  String get measurementSelectionTitle => 'Pilih sistem pengukuran';

  @override
  String get settingsSubtitle =>
      'Bentuk Botaniq sesuai ritme perawatan Anda sendiri.';

  @override
  String get settingsLocalPreference => 'Disimpan di perangkat ini';

  @override
  String get settingsDarkModeSubtitle =>
      'Palet yang lebih tenang untuk momen minim cahaya';

  @override
  String get settingsAccountSubtitle => 'Identitas, akses dan keanggotaan';

  @override
  String get settingsEditProfileSubtitle =>
      'Nama, lokasi dan preferensi perawatan';

  @override
  String get settingsPasswordSubtitle =>
      'Kirim tautan reset aman ke email Anda';

  @override
  String get settingsSubscriptionSubtitle =>
      'Paket premium dan detail penagihan';

  @override
  String get settingsPasswordResetSent =>
      'Email pengaturan ulang kata sandi terkirim.';

  @override
  String get settingsComingSoon => 'Ruang ini masih terus berkembang.';

  @override
  String get subscriptionPageTitle => 'Keanggotaan Premium';

  @override
  String get subscriptionHeroEyebrow => 'BOTANIQ PREMIUM';

  @override
  String get subscriptionHeroTitle =>
      'Perawatan yang lebih cerdas untuk setiap tanaman';

  @override
  String get subscriptionHeroSubtitle =>
      'Buka kunci setiap alat perawatan premium dan kembangkan ruang hijau Anda dengan percaya diri.';

  @override
  String get subscriptionBenefitsTitle => 'Semuanya di Premium';

  @override
  String get subscriptionBenefitIdentification =>
      'Identifikasi tanaman dan analisis kesehatan tanpa batas';

  @override
  String get subscriptionBenefitCare =>
      'Rencana dan pengingat perawatan yang dipersonalisasi';

  @override
  String get subscriptionBenefitInsights =>
      'Konten ahli dan wawasan perawatan tingkat lanjut';

  @override
  String get subscriptionMonthlyPlan => 'Bulanan';

  @override
  String get subscriptionAnnualPlan => 'Tahunan';

  @override
  String subscriptionPerMonth(String price) {
    return '$price / bulan';
  }

  @override
  String subscriptionPerYear(String price) {
    return '$price / tahun';
  }

  @override
  String get subscriptionBestValue => 'NILAI TERBAIK';

  @override
  String subscriptionSavePercent(int percent) {
    return 'Hemat $percent%';
  }

  @override
  String get subscriptionContinue => 'Buka kunci Premium';

  @override
  String get subscriptionRestorePurchases => 'Kembalikan Pembelian';

  @override
  String get subscriptionRestoring => 'Memulihkan...';

  @override
  String get subscriptionManage => 'Kelola Langganan';

  @override
  String get subscriptionActiveTitle => 'Keanggotaan Premium Anda aktif';

  @override
  String get subscriptionActiveSubtitle =>
      'Anda memiliki akses ke setiap fitur premium.';

  @override
  String subscriptionRenewsOn(String date) {
    return 'Diperbarui pada $date';
  }

  @override
  String subscriptionExpiresOn(String date) {
    return 'Aktif sampai $date';
  }

  @override
  String get subscriptionAutoRenewDisclosure =>
      'Pembayaran dibebankan ke akun Apple atau Google Anda. Langganan diperpanjang secara otomatis kecuali dibatalkan setidaknya 24 jam sebelum akhir periode berjalan. Anda dapat mengelola atau membatalkannya kapan saja di pengaturan akun toko Anda.';

  @override
  String get subscriptionTermsLink => 'Ketentuan Penggunaan';

  @override
  String get subscriptionPrivacyLink => 'Kebijakan Privasi';

  @override
  String get subscriptionPurchaseSuccess =>
      'Keanggotaan Premium Anda sekarang aktif.';

  @override
  String get subscriptionRestoreSuccess =>
      'Keanggotaan Premium Anda telah dipulihkan.';

  @override
  String get subscriptionNothingToRestore =>
      'Tidak ditemukan keanggotaan aktif untuk akun toko ini.';

  @override
  String get subscriptionPaymentPending =>
      'Pembayaran sedang menunggu persetujuan toko. Keanggotaan Anda akan aktif secara otomatis setelah disetujui.';

  @override
  String get subscriptionErrorGeneric =>
      'Operasi tidak dapat diselesaikan. Silakan coba lagi.';

  @override
  String get subscriptionErrorNetwork =>
      'Periksa koneksi internet Anda dan coba lagi.';

  @override
  String get subscriptionErrorNotAllowed =>
      'Perangkat atau akun toko ini tidak diperbolehkan untuk melakukan pembelian.';

  @override
  String get subscriptionErrorStore =>
      'Toko tidak dapat dijangkau. Silakan coba lagi sebentar lagi.';

  @override
  String get subscriptionMissingConfiguration =>
      'Kunci RevenueCat tidak ada di build ini.';

  @override
  String get subscriptionUnsupported =>
      'Langganan hanya tersedia di aplikasi iOS dan Android.';

  @override
  String get subscriptionProductsUnavailable =>
      'Produk bulanan dan tahunan tidak dapat dimuat. Periksa konfigurasi penawaran RevenueCat.';

  @override
  String get subscriptionRetry => 'Coba Lagi';

  @override
  String get subscriptionFree => 'Gratis';

  @override
  String get homeGoodMorning => 'Halo,';

  @override
  String homePersonalGreeting(String greeting, String name) {
    return '$greeting, $name 👋';
  }

  @override
  String get homeEmptyGarden => 'Tamanmu kosong';

  @override
  String get homeEmptyGardenSubtitle =>
      'Mulailah membangun tempat perlindungan hijau Anda\ndengan menambahkan tanaman pertama Anda.';

  @override
  String get homeAddFirstPlant => 'Tambahkan Tanaman Pertama';

  @override
  String get homeMyPlants => 'Tanaman Saya';

  @override
  String get homeViewAll => 'Lihat Semua';

  @override
  String get homeSmartCareReminders => 'Pengingat Perawatan Cerdas';

  @override
  String get homeWatering => 'Penyiraman';

  @override
  String get homeWateringSubtitle => 'Pelacakan tanah';

  @override
  String get homeFertilizing => 'Pemupukan';

  @override
  String get homeFertilizingSubtitle => 'Peringatan nutrisi';

  @override
  String get gardenTitle => 'Tamanku';

  @override
  String get gardenAllPlants => 'Semua Tanaman';

  @override
  String get gardenNeedsWater => 'Membutuhkan Air';

  @override
  String get gardenIndoor => 'Dalam ruangan';

  @override
  String get gardenNoPlants =>
      'Belum ada tanaman.\nKetuk + untuk menambahkan tanaman pertama Anda!';

  @override
  String get gardenNoPlantsCategory => 'Tidak ada tanaman dalam kategori ini.';

  @override
  String get discoverTitle => 'Temukan';

  @override
  String get discoverSearchHint => 'Cari tanaman, artikel, panduan...';

  @override
  String get discoverLatestArticles => 'Artikel Terbaru';

  @override
  String get discoverSeeAll => 'Lihat semuanya';

  @override
  String get discoverTrendingGuides => 'Panduan Tren';

  @override
  String get healthyTitle => 'Pusat Perawatan';

  @override
  String get healthySubtitle =>
      'Sentuh jiwa tanaman Anda, bicaralah dengan mereka.';

  @override
  String get healthyTabDoctor => 'Dokter';

  @override
  String get healthyTabHospital => 'Rumah Sakit';

  @override
  String get healthyTabDiscover => 'Temukan';

  @override
  String get profileTitle => 'Profil Saya';

  @override
  String get profileEditProfile => 'Sunting Profil';

  @override
  String get profileOverview => 'Ikhtisar';

  @override
  String get profileSettingsTab => 'Pengaturan';

  @override
  String get profileGardenerLevel => 'Tingkat Tukang Kebun';

  @override
  String get profileTotalPlants => 'Jumlah Tanaman';

  @override
  String get profileCompletedTasks => 'Tugas Selesai';

  @override
  String get profileWeeklyActivity => 'Aktivitas Perawatan Mingguan';

  @override
  String get profileGeneral => 'Umum';

  @override
  String get profileAppSettings => 'Pengaturan Aplikasi';

  @override
  String get profileNotificationPrefs => 'Preferensi Pemberitahuan';

  @override
  String get profileSupportLegal => 'Dukungan & Hukum';

  @override
  String get profileHelpCenter => 'Pusat Bantuan';

  @override
  String get profileTerms => 'Ketentuan Penggunaan & Kebijakan';

  @override
  String get profileSignOut => 'Keluar';

  @override
  String get profileDeleteAccount => 'Hapus Akun';

  @override
  String get profileSubtitle => 'Kisah taman Anda, kemajuan dan ruang pribadi.';

  @override
  String get profileGardenPassport => 'PASPOR TAMAN';

  @override
  String get profileThisWeek => 'Minggu ini';

  @override
  String get profileQuietWeek =>
      'Minggu yang tenang — momen perawatan Anda berikutnya akan muncul di sini.';

  @override
  String get profileActiveWeek => 'Ritme perawatan Anda hidup dan berkembang.';

  @override
  String get profileAppSettingsSubtitle => 'Bahasa, unit, dan koneksi AI';

  @override
  String get profileNotificationPrefsSubtitle =>
      'Pilih momen perawatan mana yang sampai kepada Anda';

  @override
  String get profileHelpCenterSubtitle => 'Jawaban dan panduan cepat';

  @override
  String get profileTermsSubtitle => 'Privasi, syarat dan kebijakan';

  @override
  String get profileAccountActions => 'Tindakan akun';

  @override
  String get profileSignOutQuestion => 'Apakah Anda yakin ingin keluar?';

  @override
  String get profileDeleteAccountWarning =>
      'Penghapusan akun memerlukan konfirmasi sisi server yang aman. Data Anda belum diubah.';

  @override
  String get cancel => 'Batalkan';

  @override
  String get continueAction => 'Lanjutkan';

  @override
  String get profileTitleNew => 'Tukang Kebun Baru 🌱';

  @override
  String get profileTitleSprout => 'Teman Tunas 🌿';

  @override
  String get profileTitleLeaf => 'Pencinta Daun ☘️';

  @override
  String get profileTitleSkilled => 'Tukang Kebun Terampil 🏡';

  @override
  String get profileTitleMaster => 'Master Jempol Hijau 👑';

  @override
  String get profileNextLevelStart =>
      'Tambahkan tanaman pertama Anda dan mulailah petualangan berkebun Anda!';

  @override
  String profileNextLevelLeaf(int count) {
    return 'Hanya tanaman $count yang tersisa untuk menjadi Leaf Lover.';
  }

  @override
  String profileNextLevelSkilled(int count) {
    return 'Hanya tersisa $count tanaman untuk menjadi Tukang Kebun Terampil.';
  }

  @override
  String profileNextLevelMaster(int count) {
    return 'Hanya tersisa $count tanaman untuk menjadi Green Thumb Master.';
  }

  @override
  String get profileNextLevelMax =>
      'Anda berada di puncak taman Anda, selamat!';

  @override
  String get navHome => 'Rumah';

  @override
  String get navGarden => 'Taman';

  @override
  String get navClinic => 'Klinik';

  @override
  String get navProfile => 'Profil';

  @override
  String get scanPlant => 'Pindai Tanaman';

  @override
  String get deletePlantTitle => 'Hapus tanaman ini?';

  @override
  String get deletePlantMessage =>
      'Pabrik, tugas perawatannya, dan catatan Klinik akan dihapus secara permanen dari akun Anda.';

  @override
  String get deletePlantAction => 'Hapus Tanaman';

  @override
  String get deletePlantNotFound =>
      'Tanaman tersebut tidak dapat ditemukan atau telah dipindahkan.';

  @override
  String deletePlantError(String error) {
    return 'Tanaman tidak dapat dicabut: $error';
  }

  @override
  String get profileChoosePhoto => 'Pilih Foto Profil';

  @override
  String get profileFullName => 'Nama Lengkap';

  @override
  String get profileFullNameHint => 'Masukkan nama lengkap Anda';

  @override
  String get profileNickname => 'Nama panggilan';

  @override
  String get profileNicknameHint => 'Bagaimana kami harus menghubungi Anda?';

  @override
  String get profileAge => 'Usia';

  @override
  String get profileAgeHint => '1–120';

  @override
  String get profileAgeValidation => 'Silakan masukkan usia antara 1 dan 120.';

  @override
  String profileLoadError(String error) {
    return 'Tidak dapat memuat profil: $error';
  }

  @override
  String get languageEnglish => 'bahasa Inggris';

  @override
  String get languageTurkish => 'Turki';

  @override
  String get profileEmailReadOnly => 'Alamat Email (Hanya Baca)';

  @override
  String get profileEmailHint => 'Masukkan email Anda';

  @override
  String get profileLocation => 'Lokasi';

  @override
  String get profileLocationHint => 'Kota, Negara';

  @override
  String get profileSaveChanges => 'Simpan Perubahan';

  @override
  String get profileUpdated => 'Profil Anda telah diperbarui.';

  @override
  String profileSaveError(String error) {
    return 'Profil tidak dapat disimpan: $error';
  }

  @override
  String get notificationWateringTitle => 'Pengingat Penyiraman';

  @override
  String get notificationWateringSubtitle =>
      'Dapatkan pemberitahuan saat waktunya menyiram';

  @override
  String get notificationFertilizerTitle => 'Pengingat Pupuk';

  @override
  String get notificationFertilizerSubtitle =>
      'Peringatan pemberian makan musiman untuk tanaman Anda';

  @override
  String get notificationTitle => 'Pemberitahuan';

  @override
  String get notificationPlantCareAlerts => 'Peringatan Perawatan Tanaman';

  @override
  String get notificationOther => 'Pemberitahuan Lainnya';

  @override
  String get notificationWeatherTitle => 'Peringatan Cuaca';

  @override
  String get notificationWeatherSubtitle => 'Peringatan cuaca ekstrem';

  @override
  String get notificationArticlesTitle => 'Artikel Baru';

  @override
  String get notificationArticlesSubtitle => 'Tip dan trik untuk taman Anda';

  @override
  String get gardenMyPlantFallback => 'Tanaman saya';

  @override
  String get gardenClinicBadge => 'Di Klinik';

  @override
  String get wateringNever => 'Terakhir disiram: Tidak pernah';

  @override
  String wateringLastDate(String date) {
    return 'Terakhir disiram: $date';
  }

  @override
  String wateringInterval(int days) {
    return 'Setiap $days hari';
  }

  @override
  String get wateringNeverDue => 'Belum disiram • Siram hari ini';

  @override
  String wateringOverdue(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'Terlambat $days hari',
      zero: 'Siram hari ini',
    );
    return '$_temp0';
  }

  @override
  String get wateringDueToday => 'Air hari ini';

  @override
  String get wateringDueTomorrow => 'Air besok';

  @override
  String wateringDueInDays(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'Siram dalam $days hari',
      zero: 'Siram hari ini',
    );
    return '$_temp0';
  }

  @override
  String get plantUnknown => 'Tanaman Tidak Dikenal';

  @override
  String get plantSpeciesFallback => 'Spesies Tumbuhan';

  @override
  String get plantDifficultyMedium => 'Sedang';

  @override
  String get plantAbout => 'Tentang';

  @override
  String get plantLocationEnvironment => 'Lokasi & Lingkungan';

  @override
  String get plantCareProtocol => 'Protokol Perawatan';

  @override
  String get plantCareHistory => 'Riwayat Perawatan 10 Hari Terakhir';

  @override
  String get plantHealthy => 'Sehat';

  @override
  String get plantInClinic => 'Di Klinik';

  @override
  String get plantDifficulty => 'Kesulitan';

  @override
  String get plantToxicity => 'Toksisitas';

  @override
  String get plantEnvironment => 'Lingkungan Hidup';

  @override
  String get plantLightNeed => 'Kebutuhan Ringan';

  @override
  String get plantToxicPets => 'Beracun bagi hewan peliharaan';

  @override
  String get plantNonToxic => 'Tidak beracun';

  @override
  String get plantIndoor => 'Dalam ruangan';

  @override
  String get plantBrightIndirect => 'Cerah Tidak Langsung';

  @override
  String get plantInfoUnavailable => 'Informasi terverifikasi belum tersedia.';

  @override
  String get plantIdealClimate => 'Iklim Ideal';

  @override
  String get plantHumidity => 'Kelembaban';

  @override
  String get plantTemperatureRange => 'Kisaran Suhu';

  @override
  String get plantWateringFrequency => 'Frekuensi Penyiraman';

  @override
  String plantWateringFrequencyValue(String interval) {
    return 'Air $interval.';
  }

  @override
  String get plantNextWatering => 'Penyiraman Selanjutnya';

  @override
  String get plantWateringProtocol => 'Protokol Penyiraman';

  @override
  String get plantSoilProtocol => 'Tanah';

  @override
  String get plantFeedingProtocol => 'Protokol Pemberian Makan';

  @override
  String get plantPruningCleaning => 'Pemangkasan & Pembersihan';

  @override
  String get plantPruningFallback =>
      'Lap daun setiap bulan. Pangkas daun yang mati atau menguning untuk mendorong pertumbuhan.';

  @override
  String get plantHistoryEmpty =>
      'Tidak ada riwayat perawatan selama 10 hari terakhir.';

  @override
  String get plantWateringTask => 'Penyiraman';

  @override
  String get plantFertilizingTask => 'Pemupukan';

  @override
  String get plantWateredAction => 'Disiram ✓';

  @override
  String get plantWaterNowAction => 'Air Sekarang';

  @override
  String get plantFertilizedAction => 'Dipupuk ✓';

  @override
  String get plantFertilizeAction => 'Pupuk';

  @override
  String get plantAddGardenAction => 'Tambahkan ke Taman Saya';

  @override
  String get plantWaterSuccess =>
      '💧 Anda menyirami tanaman Anda! Kerja bagus!';

  @override
  String get plantFertilizeSuccess =>
      '🌱 Pupuk ditambahkan! Tanaman Anda mengucapkan terima kasih!';

  @override
  String plantWaterError(String error) {
    return 'Penyiraman tidak dapat dihemat: $error';
  }

  @override
  String plantFertilizeError(String error) {
    return 'Pemupukan tidak dapat disimpan: $error';
  }

  @override
  String get clinicQuickTools => 'Alat Cepat';

  @override
  String get clinicDoctorHero => 'Dokter Tanaman AI\nSiap Melayani Anda';

  @override
  String get clinicStartConsultation => 'Mulai Konsultasi';

  @override
  String get clinicChoosePlant => 'Tanaman mana yang ingin Anda diskusikan?';

  @override
  String get clinicChoosePlantSubtitle =>
      'Pilih tanaman dari kebun Anda atau ambil foto baru.';

  @override
  String get clinicNoGardenPlants =>
      'Belum ada tanaman di kebun Anda.\nMulailah dengan mengambil foto baru.';

  @override
  String get clinicNewPhoto => 'Ambil Foto Baru';

  @override
  String get clinicNewPhotoSubtitle =>
      'Foto tanaman yang sakit dan dapatkan diagnosis';

  @override
  String get clinicPestAnalysis => 'Analisis Hama';

  @override
  String get clinicVisualDiagnosis => 'Diagnosa visual';

  @override
  String get clinicLightMeter => 'Pengukur Cahaya';

  @override
  String get clinicSensorSimulation => 'Simulasi sensor';

  @override
  String get clinicTitle => 'Klinik Tumbuhan';

  @override
  String clinicSickCount(int count) {
    return '$count Sakit';
  }

  @override
  String get clinicAllHealthy => 'Semua Tanaman Anda Sehat! 🌿';

  @override
  String get clinicEmpty =>
      'Tidak ada tanaman sakit di Klinik.\nJika Anda khawatir tentang tanaman,\ntanyakan dari tab Dokter.';

  @override
  String get clinicUnknown => 'Tidak diketahui';

  @override
  String get clinicPendingDiagnosis => 'Menunggu diagnosis';

  @override
  String get clinicNoTreatment => 'Pengobatan belum ditentukan';

  @override
  String get clinicPrescription => 'Resep:';

  @override
  String get clinicRecovery => 'Pemulihan';

  @override
  String get clinicRecovered => 'Sembuh';

  @override
  String get clinicContinue => 'Lanjutkan';

  @override
  String get clinicRecoveredSuccess => '🎉 Tanaman Anda sehat kembali!';

  @override
  String get clinicUrgencyLow => 'Rendah';

  @override
  String get clinicUrgencyMedium => 'Sedang';

  @override
  String get clinicUrgencyCritical => 'Kritis';

  @override
  String get healthTrendingTips => 'Tips Kesehatan yang Sedang Tren';

  @override
  String get healthHumidityArticleTitle =>
      'Persiapan Musim Dingin: Menjaga Kelembapan Seimbang';

  @override
  String get healthHumidityArticleSubtitle =>
      'Bagaimana melindungi tanaman Anda dari udara radiator kering selama bulan-bulan dingin.';

  @override
  String get healthWeeklySpotlight => 'Pasien & Pengobatan Minggu Ini';

  @override
  String get healthAphidTitle => 'Infestasi Kutu Daun';

  @override
  String get healthAphidSubtitle =>
      'Intervensi dini dan pengobatan Minyak Neem alami.';

  @override
  String get healthDiscoverLoadError =>
      'Temukan konten tidak dapat dimuat saat ini. Tarik ke bawah untuk mencoba lagi.';

  @override
  String get healthDiscoverEmpty =>
      'Belum ada konten penemuan yang dipublikasikan.';

  @override
  String get healthDiscoverRetry => 'Coba Lagi';

  @override
  String get lightMeterTitle => 'Pengukur Cahaya';

  @override
  String get lightMeterInstructionTitle => 'Untuk Mengukur Cahaya';

  @override
  String get lightMeterInstruction =>
      'Arahkan kamera depan ponsel ke arah\nposisi tanaman dan sumber cahaya.';

  @override
  String get lightMeterCameraEstimate =>
      'Perkiraan lux dihitung dari data kamera';

  @override
  String get lightMeterStabilizing => 'Menstabilkan pengukuran';

  @override
  String get lightMeterStabilizingRecommendation =>
      'Pegang ponsel dengan stabil selama beberapa detik sementara perubahan eksposur yang tiba-tiba disaring.';

  @override
  String get lightMeterUnavailable => 'Pengukuran tidak tersedia';

  @override
  String get lightMeterUnavailableRecommendation =>
      'Aktifkan izin kamera dan coba layar ini lagi.';

  @override
  String get lightLow => 'Cahaya Rendah (Naungan)';

  @override
  String get lightMedium => 'Cahaya Sedang (Ruangan Terang)';

  @override
  String get lightHigh => 'Cahaya Tinggi (Dekat Jendela)';

  @override
  String get lightVeryHigh => 'Cahaya Sangat Tinggi (Matahari Langsung)';

  @override
  String get lightLowRecommendation =>
      'Cocok untuk tanaman Calathea, pakis atau ular.';

  @override
  String get lightMediumRecommendation =>
      'Ideal untuk Monstera, Ficus, dan Anthurium.';

  @override
  String get lightHighRecommendation =>
      'Cocok untuk lidah buaya, kaktus, dan geranium yang menyukai sinar matahari.';

  @override
  String get lightVeryHighRecommendation =>
      'Terbaik untuk tanaman luar ruangan dan sukulen.';

  @override
  String get homeLoadingPlants => 'Memuat tanaman...';

  @override
  String get homeNotifications => 'Pemberitahuan';

  @override
  String get homeWateringTime => 'Waktu Penyiraman';

  @override
  String get homeWateringNotification =>
      'Tanaman dalam ruangan Anda perlu disiram.';

  @override
  String get homeWelcome => 'Selamat datang!';

  @override
  String get homeWelcomeNotification =>
      'Selamat datang di Botaniq. Mulailah dengan menambahkan tanaman pertama Anda.';

  @override
  String get homeTenMinutesAgo => '10 menit yang lalu';

  @override
  String get homeOneDayAgo => '1 hari yang lalu';

  @override
  String get homeQuickActions => 'Tindakan Cepat';

  @override
  String get homeIdentifyCamera => 'Identifikasi dengan kamera Anda';

  @override
  String get homeTomorrow => 'Besok';

  @override
  String get homeNoTasks => 'Tidak ada tugas untuk hari ini!';

  @override
  String get homeAllCared => 'Semua tanaman Anda dirawat 🌿';

  @override
  String get homeOverdue => 'TERLAMBAT';

  @override
  String get homeInstructions => 'instruksi';

  @override
  String homeRequiredAmount(String amount) {
    return 'Diperlukan: $amount';
  }

  @override
  String get homeLater => 'Nanti';

  @override
  String get homeMarkDone => 'Tandai sebagai Selesai';

  @override
  String get homeSickPlants => 'Klinik Tumbuhan';

  @override
  String homeSickCount(int count) {
    return '$count Sakit';
  }

  @override
  String get homeGreetingMorning => 'Selamat pagi';

  @override
  String get homeGreetingAfternoon => 'Selamat sore';

  @override
  String get homeGreetingEvening => 'Selamat malam';

  @override
  String get homeTodayTasks => 'Tugas Hari Ini';

  @override
  String get homeTomorrowTasks => 'Tugas Besok';

  @override
  String homeDateTasks(String date) {
    return '$date Tugas';
  }

  @override
  String get commonSkip => 'Lewati';

  @override
  String get commonContinue => 'Lanjutkan';

  @override
  String get commonClose => 'Tutup';

  @override
  String get commonDelete => 'Hapus';

  @override
  String get commonBack => 'Kembali';

  @override
  String get commonUnknown => 'Tidak diketahui';

  @override
  String get wizardSaveGarden => 'Simpan & Tambahkan ke Taman';

  @override
  String wizardPlantAdded(String name) {
    return '$name telah ditambahkan ke taman Anda! 🌿';
  }

  @override
  String get wizardRoomTitle => 'Dimana tanamanmu?';

  @override
  String get wizardRoomSubtitle =>
      'Kategorikan tanaman Anda berdasarkan ruangan untuk mengelolanya dengan mudah.';

  @override
  String get wizardLivingRoom => 'Ruang Tamu';

  @override
  String get wizardBedroom => 'Kamar tidur';

  @override
  String get wizardKitchen => 'Dapur';

  @override
  String get wizardOffice => 'Kantor';

  @override
  String get wizardBathroom => 'Kamar mandi';

  @override
  String get wizardBalcony => 'Balkon';

  @override
  String get wizardLightTitle => 'Bagaimana pencahayaan di tempat ini?';

  @override
  String get wizardLightSubtitle =>
      'Cahaya adalah salah satu faktor terpenting bagi kesehatan tanaman Anda.';

  @override
  String get wizardDirectSun => 'Matahari Langsung';

  @override
  String get wizardDirectSunDescription =>
      'Sinar matahari tanpa filter langsung mengenai tanaman';

  @override
  String get wizardBrightIndirect => 'Cerah Tidak Langsung';

  @override
  String get wizardBrightIndirectDescription =>
      'Dekat dengan jendela yang menghadap ke timur atau barat';

  @override
  String get wizardMediumLight => 'Cahaya Sedang';

  @override
  String get wizardMediumLightDescription => 'Beberapa meter dari jendela';

  @override
  String get wizardLowLight => 'Cahaya Rendah';

  @override
  String get wizardLowLightDescription =>
      'Jauh dari jendela atau di bawah cahaya buatan';

  @override
  String get wizardDistanceTitle => 'Jarak ke Jendela';

  @override
  String get wizardDistanceSubtitle =>
      'Pilih perkiraan jarak ke jendela terdekat.';

  @override
  String get wizardMoreThanFiveMeters => 'Lebih dari 5 m';

  @override
  String get wizardActiveHoursTitle => 'Jam Cahaya Aktif';

  @override
  String get wizardActiveHoursSubtitle =>
      'Berapa jam cahaya langsung atau terang yang diterima tempat ini?';

  @override
  String wizardHour(int count) {
    return '$count jam';
  }

  @override
  String wizardHours(int count) {
    return '$count jam';
  }

  @override
  String get wizardSixPlusHours => '6+ jam';

  @override
  String get wizardRepottedTitle =>
      'Kapan terakhir kali tanaman ini direpoting?';

  @override
  String get wizardRepottedSubtitle =>
      'Tanah segar sangat penting untuk tanaman yang bahagia.';

  @override
  String get wizardRecently => 'Baru-baru ini (di bawah 3 bulan)';

  @override
  String get wizardSixMonthsAgo => '6 bulan yang lalu';

  @override
  String get wizardOneYearAgo => '1 tahun yang lalu';

  @override
  String get wizardTwoYearsAgo => '2+ tahun yang lalu';

  @override
  String get wizardDontKnow => 'Saya tidak tahu';

  @override
  String get wizardPotTitle => 'Bahan potnya apa?';

  @override
  String get wizardPotSubtitle =>
      'Bahan pot mempengaruhi seberapa cepat tanah mengering.';

  @override
  String get wizardPlasticPot => 'Plastik / Pembibitan';

  @override
  String get wizardTerracottaPot => 'Terakota';

  @override
  String get wizardCeramicPot => 'Keramik / Mengkilap';

  @override
  String get wizardMetalPot => 'Logam';

  @override
  String get wizardWateredTitle =>
      'Kapan terakhir kali Anda menyiram tanaman ini?';

  @override
  String get wizardWateredSubtitle =>
      'Ini membantu menghitung waktu penyiraman berikutnya dengan tepat.';

  @override
  String get wizardToday => 'Hari ini';

  @override
  String get wizardYesterday => 'Kemarin';

  @override
  String get wizardFewDaysAgo => 'Beberapa hari yang lalu';

  @override
  String get wizardWeekAgo => 'Seminggu yang lalu';

  @override
  String get wizardMoreWeekAgo => 'Lebih dari seminggu yang lalu';

  @override
  String get historyTitle => 'Riwayat Pencarian';

  @override
  String get historyClearTitle => 'Hapus Riwayat';

  @override
  String get historyClearMessage =>
      'Semua riwayat pencarian dan pemindaian akan dihapus. Apa kamu yakin?';

  @override
  String get historyClearTooltip => 'Hapus Riwayat';

  @override
  String get historyEmptyTitle => 'Tidak Ada Riwayat Pencarian';

  @override
  String get historyEmptySubtitle =>
      'Tanaman yang dipindai dengan kamera atau dicari akan muncul di sini.';

  @override
  String get historyNoDetails => 'Informasi rinci tidak tersedia.';

  @override
  String get historyRegularWater => 'Penyiraman secara teratur';

  @override
  String get historyIndirectLight => 'Cahaya tidak langsung';

  @override
  String get historyDescription => 'Deskripsi';

  @override
  String get historyWatering => 'Penyiraman';

  @override
  String get historyLight => 'Ringan';

  @override
  String get historyRecently => 'Baru-baru ini';

  @override
  String historyMinutesAgo(int minutes) {
    return '$minutes menit yang lalu';
  }

  @override
  String historyHoursAgo(int hours) {
    return '$hours jam yang lalu';
  }

  @override
  String get historyYesterday => 'Kemarin';

  @override
  String get historyPlantRecord => 'Catatan Pencarian Tanaman';

  @override
  String get photoWholeSpecimen => 'Foto keseluruhan\ntanaman atau jamur';

  @override
  String get photoWholeSpecimenSubtitle =>
      'Jaga agar seluruh spesimen tetap berada di tengah bingkai untuk identifikasi yang lebih baik.';

  @override
  String get photoCorrect => 'Benar';

  @override
  String get photoTooClose => 'Terlalu Dekat';

  @override
  String get photoInstructions => 'instruksi';

  @override
  String get photoOpenCamera => 'Saya Mengerti, Buka Kamera';

  @override
  String get scannerPlant => 'Tanaman';

  @override
  String get scannerMushroom => 'Jamur';

  @override
  String get scannerIdentifyingPlant => 'Mengidentifikasi Tanaman...';

  @override
  String get scannerIdentifyingMushroom => 'Mengidentifikasi Jamur...';

  @override
  String get scannerCapture => 'Ambil Foto & Pindai';

  @override
  String get scannerFailed => 'Pemindaian gagal. Silakan coba lagi.';

  @override
  String scannerError(String error) {
    return 'Terjadi kesalahan: $error';
  }

  @override
  String get scannerUnknownPlant => 'Tanaman Tidak Dikenal';

  @override
  String get scannerUnknownMushroom => 'Jamur Tidak Dikenal';

  @override
  String get scheduleTitle => 'Jadwal';

  @override
  String get scheduleTodayTask => 'Tugas Hari Ini';

  @override
  String get scheduleNoTasks => 'Tidak ada tugas untuk hari ini!';

  @override
  String get scheduleInstructions => 'instruksi';

  @override
  String scheduleRequired(String amount) {
    return 'Diperlukan: $amount';
  }

  @override
  String get scheduleRemindLater => 'Ingatkan Nanti';

  @override
  String get scheduleDone => 'Selesai';

  @override
  String get scheduleCareFallback => 'Jaga tanaman Anda.';

  @override
  String get chatDoctorTitle => 'Dokter Tanaman AI';

  @override
  String chatPatient(String name) {
    return 'Pasien: $name';
  }

  @override
  String get chatAnalyzing => 'Menganalisis...';

  @override
  String chatHint(String name) {
    return 'Tanyakan tentang $name...';
  }

  @override
  String chatWelcome(String name) {
    return 'Halo! 🌿 Saya adalah Dokter Tanaman AI Anda. Bagaimana saya bisa membantu dengan $name?\n\nSaya dapat mendiagnosis foto atau menjawab pertanyaan perawatan Anda.';
  }

  @override
  String chatContinueWelcome(String name) {
    return 'Halo! Mari lanjutkan dengan $name. 🌱';
  }

  @override
  String get chatQuestionYellowing => 'Apa penyebab daun menguning?';

  @override
  String get chatQuestionTreatment => 'Bagaimana cara merawat tanaman ini?';

  @override
  String get chatQuestionWatering =>
      'Haruskah saya mengubah frekuensi penyiraman?';

  @override
  String get chatQuestionFertilizer => 'Pupuk apa yang harus saya gunakan?';

  @override
  String get chatPhotoSent => 'Foto terkirim';

  @override
  String get chatAnalyzePhoto => 'Analisis foto tersebut';

  @override
  String get chatDiagnosisUnknown => 'Diagnosis tidak dapat ditentukan';

  @override
  String get chatNoTreatment => 'Tidak ada rekomendasi pengobatan';

  @override
  String get chatRecoveryUnknown => 'Tidak diketahui';

  @override
  String get chatUnableIdentify => 'Tanaman Tak Dikenal';

  @override
  String chatError(String error) {
    return 'Maaf, terjadi kesalahan: $error. Silakan coba lagi.';
  }

  @override
  String get chatCareTips => 'Tip Perawatan';

  @override
  String get chatPlantLabel => 'Tanaman';

  @override
  String get chatDiagnosisLabel => 'Diagnosa';

  @override
  String get chatTreatmentLabel => 'Pengobatan';

  @override
  String get chatUrgencyLabel => 'Urgensi';

  @override
  String get chatRecoveryLabel => 'Perkiraan Pemulihan';

  @override
  String get discoverMonsteraTitle => 'Rahasia Pertumbuhan Monstera';

  @override
  String get discoverIndoorPlants => 'Tanaman Dalam Ruangan';

  @override
  String get discoverSucculentWatering => 'Panduan Penyiraman untuk Sukulen';

  @override
  String get discoverCacti => 'Kaktus & Sukulen';

  @override
  String get discoverHerbSoil => 'Jenis Tanah Terbaik untuk Herbal';

  @override
  String get discoverHerbs => 'herbal';

  @override
  String get discoverPropagation => 'Propagasi 101: Panduan Pemula';

  @override
  String get discoverPests => 'Hama Umum dan Cara Mengobatinya';

  @override
  String get discoverRepotting => 'Repotting: Kapan dan Bagaimana?';

  @override
  String discoverMinutesRead(int minutes) {
    return '$minutes mnt membaca';
  }

  @override
  String get skip => 'Lewati';

  @override
  String get skipForNow => 'Lewati untuk saat ini';

  @override
  String get continueLabel => 'Lanjutkan';

  @override
  String get getStarted => 'Memulai';

  @override
  String get nextStep => 'Langkah Selanjutnya';

  @override
  String get maybeLater => 'Mungkin Nanti';

  @override
  String get emailAddress => 'Alamat Surel';

  @override
  String get password => 'Kata sandi';

  @override
  String get firstName => 'Nama Depan';

  @override
  String get lastName => 'Nama Belakang';

  @override
  String get login => 'Masuk';

  @override
  String get signUp => 'Daftar';

  @override
  String get welcomeBack => 'Selamat Datang Kembali';

  @override
  String get loginSubtitle => 'Masuk untuk terus merawat taman Anda.';

  @override
  String get signUpSubtitle =>
      'Bergabunglah dengan kami dan mulailah membangun suaka hijau Anda.';

  @override
  String get forgotPassword => 'Lupa Kata Sandi?';

  @override
  String get enterEmailPassword =>
      'Silakan masukkan email dan kata sandi Anda.';

  @override
  String get fillAllFields => 'Silakan isi semua kolom.';

  @override
  String authError(String error) {
    return 'Ada yang tidak beres: $error';
  }

  @override
  String get loginWith => 'Atau masuk dengan';

  @override
  String get signUpWith => 'Atau daftar dengan';

  @override
  String get noAccount => 'Belum punya akun?';

  @override
  String get alreadyAccount => 'Sudah punya akun?';

  @override
  String get developerSession => 'Buat Sesi Pengembang';

  @override
  String get welcomeBotaniq => 'Selamat datang di Botaniq';

  @override
  String get loginOptionsSubtitle =>
      'Masuk atau daftar untuk mencadangkan pabrik, jadwal, dan preferensi Anda.';

  @override
  String get notificationAccessTitle => 'Jangan lewatkan penyiraman';

  @override
  String get notificationAccessSubtitle =>
      'Kami akan dengan lembut mengingatkan Anda kapan waktunya merawat teman-teman hijau Anda. Perawatan tanaman menjadi mudah dan bebas stres.';

  @override
  String get notificationTurnOn => 'Aktifkan Pengingat';

  @override
  String get creatingClimate => 'Menganalisis iklim mikro Anda...';

  @override
  String get creatingSchedules => 'Menyesuaikan jadwal perawatan...';

  @override
  String get creatingSanctuary =>
      'Mempersiapkan tempat perlindungan hijau Anda...';

  @override
  String get locationAccessTitle => 'Akses Lokasi';

  @override
  String get locationAccessSubtitle =>
      'Personalisasikan perawatan tanaman berdasarkan iklim mikro lokal Anda.';

  @override
  String get locationRecommendation => 'Rekomendasi Lokal';

  @override
  String get locationRecommendationSubtitle =>
      'Tanaman yang tumbuh subur di iklim daerah Anda';

  @override
  String get locationWeather => 'Sinkronisasi Cuaca Cerdas';

  @override
  String get locationWeatherSubtitle =>
      'Jadwal menyesuaikan dengan hujan lokal real-time';

  @override
  String get locationAlerts => 'Peringatan Beku & Panas';

  @override
  String get locationAlertsSubtitle =>
      'Dapatkan pemberitahuan sebelum cuaca ekstrem melanda';

  @override
  String get locationEnable => 'Aktifkan Akses Lokasi';

  @override
  String get wherePlantsTitle => 'Dimana tanamanmu?';

  @override
  String get wherePlantsSubtitle =>
      'Pilih semua yang sesuai untuk menyesuaikan jadwal perawatan Anda.';

  @override
  String get locationIndoor => 'Dalam ruangan';

  @override
  String get locationIndoorSubtitle => 'Ruang tamu, kamar tidur, kantor';

  @override
  String get locationBalcony => 'Balkon';

  @override
  String get locationBalconySubtitle => 'Tanaman pot di dek atau teras';

  @override
  String get locationGarden => 'Taman';

  @override
  String get locationGardenSubtitle => 'Tanaman di dalam tanah dan petak bunga';

  @override
  String get helpTitleBefore => 'Apa yang bisa kita lakukan?';

  @override
  String get helpTitleHighlight => 'membantumu';

  @override
  String get helpTitleAfter => 'dengan?';

  @override
  String get helpSubtitle =>
      'Pilih satu atau lebih tujuan untuk mempersonalisasi taman Anda.';

  @override
  String get helpHeal => 'Sembuhkan sakit\ntanaman';

  @override
  String get helpCare => 'Peduli\npengingat';

  @override
  String get helpIdentify => 'Identifikasi\nspesies';

  @override
  String get helpJournal => 'Pertumbuhan\njurnal';

  @override
  String get helpOther => 'Sesuatu yang lain';

  @override
  String get journeyTitle => 'Perjalanan Hijau Anda';

  @override
  String get journeySubtitle =>
      'Pilih tingkat perawatan yang ingin Anda berikan.';

  @override
  String get journeyCasualLabel => 'KASUAL';

  @override
  String get journeyCasualTitle => 'Perawatan Rendah';

  @override
  String get journeyCasualSubtitle =>
      'Saya hanya ingin tanaman sederhana saya tetap hidup dan tumbuh subur.';

  @override
  String get journeyEnthusiastLabel => 'PENGGEMAR';

  @override
  String get journeyEnthusiastTitle => 'Perawatan Seimbang';

  @override
  String get journeyEnthusiastSubtitle =>
      'Saya menikmati menghabiskan waktu mingguan dengan koleksi saya yang terus bertambah.';

  @override
  String get journeyObsessedLabel => 'TEROBSESI';

  @override
  String get journeyObsessedTitle => 'Induk Tanaman Luar Biasa';

  @override
  String get journeyObsessedSubtitle =>
      'Saya hidup untuk tanaman saya dan menginginkan jadwal ahli untuk hutan dalam ruangan saya.';

  @override
  String get masteryTitleBefore => 'Bagaimana kabarmu?';

  @override
  String get masteryTitleHighlight => 'hijau\nibu jari';

  @override
  String get masteryTitleAfter => 'akhir-akhir ini?';

  @override
  String get masterySubtitle =>
      'Jujur saja—kita semua pernah menjadi \"Pembunuh Berantai\" pada suatu saat. Pilih penguasaan Anda saat ini.';

  @override
  String get masteryKiller => 'Pembunuh Berantai';

  @override
  String get masteryKillerSubtitle =>
      'Bahkan tanaman plastikku pun terlihat khawatir saat aku memasuki ruangan.';

  @override
  String get masteryAccidental => 'Orang Tua yang Tidak Disengaja';

  @override
  String get masteryAccidentalSubtitle =>
      'Kaktus saya telah bertahan dua minggu. Kami masih saling mengenal.';

  @override
  String get masteryGrowth => 'Pola Pikir Pertumbuhan';

  @override
  String get masteryGrowthSubtitle =>
      'Kebanyakan temanku punya daun. Saya tahu Monstera saya dari Pothos saya.';

  @override
  String get masteryWhisperer => 'Pembisik Tanaman';

  @override
  String get masteryWhispererSubtitle =>
      'Saya menyebarkan tanaman langka dan fasih berbahasa Latin botani.';

  @override
  String get onboardingOneTitle => 'Berhati-hatilah\nTanaman Anda';

  @override
  String get onboardingOneHighlight => 'Seperti seorang profesional';

  @override
  String get onboardingOneSubtitle =>
      'Jadwal cerdas dan identifikasi instan untuk hutan kota Anda.';

  @override
  String get onboardingOneBadge => 'PERAWATAN BERDAYA AI';

  @override
  String get onboardingAiScan => 'Pemindaian AI';

  @override
  String get onboardingSmartWater => 'Air Cerdas';

  @override
  String get onboardingLightTracking => 'Pelacakan Cahaya';

  @override
  String get onboardingTwoTitle => 'Identifikasi Apa Saja\nTanam di';

  @override
  String get onboardingTwoHighlight => 'Detik';

  @override
  String get onboardingTwoSubtitle =>
      'Ambil foto untuk mengetahui nama, spesies, dan persyaratan perawatannya.';

  @override
  String get onboardingTwoBadge => 'AHLI BOTAN';

  @override
  String get onboardingSnapPhoto => 'Jepret Foto';

  @override
  String get onboardingAccurateResult => 'Hasil Akurat';

  @override
  String get onboardingPlantWiki => 'Tanaman Wiki';

  @override
  String get onboardingThreeTitle => 'Jangan pernah lupa\nKe Air';

  @override
  String get onboardingThreeHighlight => 'Sekali lagi';

  @override
  String get onboardingThreeSubtitle =>
      'Dapatkan pengingat yang disesuaikan dengan kebutuhan dan lingkungan pabrik Anda.';

  @override
  String get onboardingThreeBadge => 'JADWAL CERDAS';

  @override
  String get onboardingReminders => 'Pengingat';

  @override
  String get onboardingClimateData => 'Data Iklim';

  @override
  String get onboardingHealthyGrowth => 'Pertumbuhan yang Sehat';

  @override
  String get onboardingCommunity =>
      'Bergabunglah dengan 50.000+ orang tua tanaman';

  @override
  String get onboardingAgreement =>
      'DENGAN MELANJUTKAN, ANDA MENYETUJUI SYARAT & KEBIJAKAN PRIVASI KAMI';

  @override
  String get termsTitle => 'Syarat & Kebijakan';

  @override
  String get termsUpdated => 'Terakhir diperbarui: Juli 2026';

  @override
  String get termsUseTitle => '1. Ketentuan Penggunaan';

  @override
  String get termsUseBody =>
      'Dengan mengakses atau menggunakan Botaniq, Anda menyetujui Ketentuan Penggunaan ini dan hukum yang berlaku. Jika Anda tidak setuju, Anda tidak boleh menggunakan layanan ini.';

  @override
  String get termsPrivacyTitle => '2. Privasi Pengguna';

  @override
  String get termsPrivacyBody =>
      'Kami hanya mengumpulkan data pribadi yang diperlukan untuk menyediakan jadwal perawatan tanaman yang disesuaikan. Kami tidak menjual data pribadi Anda kepada pihak ketiga.';

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
  String get termsPlantTitle => '3. Data Tanaman';

  @override
  String get termsPlantBody =>
      'Informasi perawatan tanaman, identifikasi, dan diagnosis disediakan untuk tujuan informasi. Hasil AI mungkin tidak selalu benar, jadi amati pabrik Anda dan carilah ahlinya untuk mengetahui risiko serius.';

  @override
  String get termsLiabilityTitle => '6. Disclaimers, Liability, and Indemnity';

  @override
  String get termsLiabilityBody =>
      'Botaniq is provided \"as is\" and \"as available,\" without warranties of any kind, express or implied, including accuracy, reliability, or fitness for a particular purpose. To the fullest extent permitted by law, we and our service providers are not liable for any indirect, incidental, special, or consequential damages, or for any loss of data, plants, or property arising from your use of the service, and our total liability for any claim is limited to the amount you paid us, if any, in the twelve months before the claim. You agree to indemnify and hold us harmless from claims arising from your use of the service, your content, or your violation of these Terms or applicable law.';

  @override
  String get termsPremiumTitle => '4. Langganan Premium';

  @override
  String get termsPremiumBody =>
      'Langganan Premium bulanan atau tahunan Anda dibebankan ke akun Apple atau Google Anda setelah konfirmasi pembelian. Ini diperpanjang secara otomatis kecuali dibatalkan setidaknya 24 jam sebelum periode berjalan berakhir. Anda dapat mengelola atau membatalkannya di pengaturan akun toko Anda. Permintaan pengembalian dana ditangani berdasarkan kebijakan toko yang berlaku.';

  @override
  String get termsLawTitle => '8. Governing Law and Changes';

  @override
  String get termsLawBody =>
      'These Terms are governed by the laws of the jurisdiction in which we operate, without regard to conflict-of-law principles, and any dispute will be resolved under that jurisdiction\'s applicable procedures to the fullest extent permitted by law. We may update these Terms and our data practices at any time by posting the revised version in the app.';

  @override
  String get termsClosing =>
      'Nikmati ketenangan pikiran dan tanaman yang lebih bahagia.';

  @override
  String get weatherTitle => 'Cuaca';

  @override
  String get weatherSunnyTip => 'Hari ini cerah—periksa tanah sebelum disiram.';

  @override
  String get weatherCloudyTip =>
      'Cuaca mendung memperlambat penguapan; air sedikit lebih sedikit.';

  @override
  String get weatherRainyTip =>
      'Hujan dan lembap—hindari menyiram tanaman di luar ruangan secara berlebihan.';

  @override
  String get weatherStormTip =>
      'Cuaca badai—pindahkan pot yang rapuh ke tempat yang terlindung.';

  @override
  String get weatherSnowTip =>
      'Dingin dan bersalju—melindungi tanaman dari guncangan suhu.';
}
