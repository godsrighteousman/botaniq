import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/services/subscription_service.dart';

enum SubscriptionStatus {
  initial,
  signedOut,
  loading,
  ready,
  unsupported,
  missingConfiguration,
  productsUnavailable,
  failed,
}

enum SubscriptionActionResult {
  success,
  cancelled,
  pending,
  noActiveEntitlement,
  failed,
}

class SubscriptionController extends ChangeNotifier
    with WidgetsBindingObserver {
  SubscriptionController({SubscriptionService? service})
    : _service = service ?? SubscriptionService() {
    WidgetsBinding.instance.addObserver(this);
  }

  final SubscriptionService _service;

  StreamSubscription<AuthState>? _authSubscription;
  CustomerInfoUpdateListener? _customerInfoListener;
  CustomerInfo? _customerInfo;
  Offering? _offering;
  Package? _selectedPackage;
  String? _currentUserId;
  int _syncGeneration = 0;

  SubscriptionStatus _status = SubscriptionStatus.initial;
  PurchasesErrorCode? _lastErrorCode;
  String? _lastErrorDetail;
  bool _isPurchasing = false;
  bool _isRestoring = false;
  bool _isDisposed = false;
  int _autoRetryCount = 0;

  /// İlk yükleme başarısız olduğunda kaç kez sessizce tekrar deneneceği.
  /// Mağaza/backend dalgalanmaları çoğunlukla saniyeler içinde düzelir; bu
  /// yüzden kullanıcıyı "Tekrar dene" butonuna mahkûm etmek yerine kendimiz
  /// deneriz.
  static const int _maxAutoRetries = 3;

  SubscriptionStatus get status => _status;
  PurchasesErrorCode? get lastErrorCode => _lastErrorCode;

  /// Ham hata metni — yalnızca teşhis amaçlı, `kDebugMode` altında UI'da
  /// gösterilir. Üretimde kullanıcıya asla teknik hata metni gösterilmez.
  String? get lastErrorDetail => _lastErrorDetail;
  bool get isLoading => _status == SubscriptionStatus.loading;
  bool get isReady => _status == SubscriptionStatus.ready;
  bool get isPurchasing => _isPurchasing;
  bool get isRestoring => _isRestoring;
  bool get isBusy => _isPurchasing || _isRestoring;
  Package? get monthlyPackage => _offering?.monthly;
  Package? get annualPackage => _offering?.annual;
  Package? get selectedPackage => _selectedPackage;
  CustomerInfo? get customerInfo => _customerInfo;

  /// Elde gösterilebilir, eksiksiz bir teklif (hem aylık hem yıllık) var mı.
  ///
  /// Bu doğruyken geçici bir ağ/backend hatası yüzünden ödeme duvarını yıkmak
  /// kullanıcıyı çıkmaz sokakta bırakır; zaten yüklenmiş paketleri göstermeye
  /// devam etmek her zaman daha doğrudur.
  bool get hasCompleteOffering =>
      monthlyPackage != null && annualPackage != null;

  /// Hata ekranında gösterilen kısa tanı kodu (örn. `configuration_error`).
  /// Kullanıcıya teknik metin değil, yalnızca destek için okunabilir bir kod
  /// verir; App Review gibi durumlarda kör kalmamızı engeller.
  String? get errorCodeLabel {
    final code = _lastErrorCode;
    if (code == null) return null;
    return code.name
        .replaceAll(RegExp(r'Error$'), '')
        .replaceAllMapped(
          RegExp(r'[A-Z]'),
          (match) => '_${match[0]!.toLowerCase()}',
        );
  }

  EntitlementInfo? get premiumEntitlement =>
      _customerInfo?.entitlements.all[_service.entitlementId];

  bool get isPremium => premiumEntitlement?.isActive ?? false;
  String? get managementUrl => _customerInfo?.managementURL;

  DateTime? get expirationDate {
    final rawDate = premiumEntitlement?.expirationDate;
    return rawDate == null ? null : DateTime.tryParse(rawDate)?.toLocal();
  }

  int? get annualSavingsPercent {
    final monthlyProduct = monthlyPackage?.storeProduct;
    final annualProduct = annualPackage?.storeProduct;
    final monthlyPrice = monthlyProduct?.price;
    final annualPrice = annualProduct?.price;
    if (monthlyPrice == null || annualPrice == null || monthlyPrice <= 0) {
      return null;
    }
    if (monthlyProduct!.currencyCode != annualProduct!.currencyCode) {
      return null;
    }
    final regularAnnualPrice = monthlyPrice * 12;
    if (annualPrice >= regularAnnualPrice) return null;
    return ((1 - (annualPrice / regularAnnualPrice)) * 100).round();
  }

  /// Yıllık planın gerçek mağaza fiyatından hesaplanan gün başına maliyeti —
  /// uydurma bir rakam değil, `StoreProduct.price`/365'ten türetilir.
  String? get annualDailyPriceLabel {
    final annualProduct = annualPackage?.storeProduct;
    final price = annualProduct?.price;
    final currencyCode = annualProduct?.currencyCode;
    if (price == null || currencyCode == null || price <= 0) return null;
    try {
      final formatter = NumberFormat.simpleCurrency(name: currencyCode);
      return formatter.format(price / 365);
    } catch (_) {
      return null;
    }
  }

  /// Uygulama bu süreç boyunca zaten bir kez otomatik ödeme duvarı gösterdi mi.
  bool _launchPaywallShown = false;

  /// Uygulama girişinde tam ekran ödeme duvarının otomatik gösterilip
  /// gösterilmeyeceği: yalnızca abonelik ürünleri başarıyla yüklendiğinde
  /// (paketler dolu, sayfa güvenle açılabilir), kullanıcı premium değilken
  /// ve bu süreçte daha önce gösterilmediyse `true` döner.
  bool get shouldShowLaunchPaywall =>
      !_launchPaywallShown &&
      status == SubscriptionStatus.ready &&
      !isPremium;

  /// Otomatik ödeme duvarı gösterildiğinde çağrılır; aynı süreçte tekrar
  /// otomatik açılmasını engeller (kullanıcı istediği zaman elle açabilir).
  void markLaunchPaywallShown() => _launchPaywallShown = true;

  /// Kalan ücretsiz AI hakkını (0-2) sunucudan getirir; premium kullanıcılar
  /// için anlamsızdır. Yalnızca gösterim amaçlı — hak düşürmez.
  Future<int?> fetchRemainingFreeQueries() async {
    try {
      for (final table in const ['users', 'profiles']) {
        try {
          final userId = Supabase.instance.client.auth.currentUser?.id;
          if (userId == null) return null;
          final row = await Supabase.instance.client
              .from(table)
              .select('free_ai_queries_used')
              .eq('id', userId)
              .maybeSingle()
              .timeout(const Duration(seconds: 5));
          final used = row?['free_ai_queries_used'];
          if (used is int) return (2 - used).clamp(0, 2);
        } catch (_) {
          // Eski kurulumlarda yalnızca tablolardan biri bulunabilir.
        }
      }
    } catch (_) {}
    return null;
  }

  /// Bir AI çağrısına (tarama/teşhis/sohbet) izin verilip verilmeyeceğine
  /// karar verir. Premium kullanıcılar her zaman geçer. Değilse, sunucudaki
  /// `consume_free_ai_query` RPC'sini çağırır — bu hem kontrol hem düşürme
  /// işlemini tek atomik adımda yapar, böylece istemci tarafında hile ile
  /// atlatılamaz ve art arda hızlı iki dokunuş iki hakkı aynı anda
  /// düşüremez.
  ///
  /// Ağ hatasında kullanıcıyı bloklamak yerine geçişe izin verir — bağlantı
  /// sorunuyla gerçek bir bahçıvanı uygulamanın dışında bırakmak, nadir bir
  /// aşım riskinden çok daha kötü bir kullanıcı deneyimidir.
  Future<bool> consumeAiQuotaOrPrompt() async {
    if (isPremium) return true;
    try {
      final response = await Supabase.instance.client
          .rpc('consume_free_ai_query')
          .timeout(const Duration(seconds: 8));
      final rows = response as List;
      if (rows.isEmpty) return true;
      final row = rows.first as Map<String, dynamic>;
      return row['allowed'] == true;
    } catch (error) {
      debugPrint('Ücretsiz AI kotası kontrol edilemedi: $error');
      return true;
    }
  }

  void bindToAuth(GoTrueClient auth) {
    _authSubscription?.cancel();
    _authSubscription = auth.onAuthStateChange.listen((event) {
      unawaited(_syncUser(event.session?.user.id));
    });
    unawaited(_syncUser(auth.currentUser?.id));
  }

  Future<void> _syncUser(String? userId) async {
    if (userId != null && _currentUserId == userId && (isLoading || isReady)) {
      return;
    }

    final generation = ++_syncGeneration;
    if (userId == null) {
      _removeCustomerInfoListener();
      _currentUserId = null;
      _customerInfo = null;
      _offering = null;
      _selectedPackage = null;
      _lastErrorCode = null;
      _lastErrorDetail = null;
      _status = SubscriptionStatus.signedOut;
      notifyListeners();
      return;
    }

    if (_currentUserId != userId) {
      _removeCustomerInfoListener();
    }

    _currentUserId = userId;
    _status = SubscriptionStatus.loading;
    _lastErrorCode = null;
    _lastErrorDetail = null;
    notifyListeners();

    try {
      final customerInfo = await _service.identify(userId);
      if (generation != _syncGeneration) return;
      _ensureCustomerInfoListener();
      _customerInfo = customerInfo;
      await _loadOfferings(generation);
    } on SubscriptionConfigurationException catch (error) {
      if (generation != _syncGeneration) return;
      _status = switch (error.reason) {
        SubscriptionConfigurationFailure.unsupportedPlatform =>
          SubscriptionStatus.unsupported,
        SubscriptionConfigurationFailure.missingApiKey =>
          SubscriptionStatus.missingConfiguration,
      };
      notifyListeners();
    } on PlatformException catch (error) {
      if (generation != _syncGeneration) return;
      _setPlatformFailure(error);
    } catch (error) {
      debugPrint('RevenueCat başlatılamadı: $error');
      if (generation != _syncGeneration) return;
      _lastErrorDetail = error.toString();
      _status = SubscriptionStatus.failed;
      notifyListeners();
      _scheduleAutoRetry();
    }
  }

  Future<void> refresh() async {
    final userId = _currentUserId;
    if (userId == null || isLoading) return;

    // Ekranda çalışan bir ödeme duvarı varsa onu yükleme göstergesiyle ya da
    // hata kartıyla değiştirmeyiz: yenileme sessizce denenir, başarısız olursa
    // kullanıcı zaten geçerli olan paketleri görmeye devam eder.
    final keepCurrentPaywall = hasCompleteOffering;

    final generation = ++_syncGeneration;
    if (!keepCurrentPaywall) {
      _status = SubscriptionStatus.loading;
    }
    _lastErrorCode = null;
    _lastErrorDetail = null;
    notifyListeners();

    try {
      _customerInfo = await _service.identify(userId);
      if (generation != _syncGeneration) return;
      _ensureCustomerInfoListener();
      await _loadOfferings(generation);
    } on SubscriptionConfigurationException catch (error) {
      if (generation != _syncGeneration) return;
      _status = switch (error.reason) {
        SubscriptionConfigurationFailure.unsupportedPlatform =>
          SubscriptionStatus.unsupported,
        SubscriptionConfigurationFailure.missingApiKey =>
          SubscriptionStatus.missingConfiguration,
      };
      notifyListeners();
    } on PlatformException catch (error) {
      if (generation != _syncGeneration) return;
      _setPlatformFailure(error, keepCurrentPaywall: keepCurrentPaywall);
    } catch (error) {
      debugPrint('Abonelik bilgileri yenilenemedi: $error');
      if (generation != _syncGeneration) return;
      _lastErrorDetail = error.toString();
      _status = keepCurrentPaywall
          ? SubscriptionStatus.ready
          : SubscriptionStatus.failed;
      notifyListeners();
      if (!keepCurrentPaywall) _scheduleAutoRetry();
    }
  }

  Future<void> _loadOfferings(int generation) async {
    final previousOffering = _offering;
    final hadCompleteOffering = hasCompleteOffering;

    final offerings = await _service.getOfferings();
    if (generation != _syncGeneration) return;

    _offering = offerings.current;
    final hasBothPlans = monthlyPackage != null && annualPackage != null;
    if (!hasBothPlans && hadCompleteOffering) {
      // Mağaza bu sefer ürünleri eksik döndürdü (geçici backend/sandbox
      // dalgalanması). Çalışan teklifi çöpe atıp kullanıcıyı ürünsüz bir
      // ekranda bırakmak yerine elimizdekini korumaya devam ederiz.
      _offering = previousOffering;
      _status = SubscriptionStatus.ready;
      notifyListeners();
      return;
    }
    if (!hasBothPlans) {
      _selectedPackage = annualPackage ?? monthlyPackage;
      _status = SubscriptionStatus.productsUnavailable;
      notifyListeners();
      _scheduleAutoRetry();
      return;
    }

    final selectedIdentifier = _selectedPackage?.identifier;
    _selectedPackage = [annualPackage, monthlyPackage]
        .whereType<Package>()
        .firstWhere(
          (package) => package.identifier == selectedIdentifier,
          orElse: () => annualPackage!,
        );
    _status = SubscriptionStatus.ready;
    _autoRetryCount = 0;
    notifyListeners();
  }

  void selectPackage(Package package) {
    if (isBusy || package == _selectedPackage) return;
    _selectedPackage = package;
    _lastErrorCode = null;
    _lastErrorDetail = null;
    notifyListeners();
  }

  Future<SubscriptionActionResult> purchaseSelected() async {
    final package = _selectedPackage;
    final userId = _currentUserId;
    if (package == null || userId == null || isBusy || !isReady) {
      return SubscriptionActionResult.failed;
    }

    _isPurchasing = true;
    _lastErrorCode = null;
    _lastErrorDetail = null;
    notifyListeners();
    try {
      final customerInfo = await _service.purchase(package);
      if (_currentUserId != userId) {
        return SubscriptionActionResult.failed;
      }
      _customerInfo = customerInfo;
      notifyListeners();
      return isPremium
          ? SubscriptionActionResult.success
          : SubscriptionActionResult.noActiveEntitlement;
    } on PlatformException catch (error) {
      final code = PurchasesErrorHelper.getErrorCode(error);
      if (code == PurchasesErrorCode.purchaseCancelledError) {
        return SubscriptionActionResult.cancelled;
      }
      if (code == PurchasesErrorCode.paymentPendingError) {
        return SubscriptionActionResult.pending;
      }
      _lastErrorCode = code;
      return SubscriptionActionResult.failed;
    } catch (error) {
      debugPrint('Satın alma tamamlanamadı: $error');
      return SubscriptionActionResult.failed;
    } finally {
      _isPurchasing = false;
      notifyListeners();
    }
  }

  Future<SubscriptionActionResult> restorePurchases() async {
    final userId = _currentUserId;
    if (userId == null || isBusy || !_service.isConfigured) {
      return SubscriptionActionResult.failed;
    }
    _isRestoring = true;
    _lastErrorCode = null;
    _lastErrorDetail = null;
    notifyListeners();
    try {
      final customerInfo = await _service.restorePurchases();
      if (_currentUserId != userId) {
        return SubscriptionActionResult.failed;
      }
      _customerInfo = customerInfo;
      notifyListeners();
      return isPremium
          ? SubscriptionActionResult.success
          : SubscriptionActionResult.noActiveEntitlement;
    } on PlatformException catch (error) {
      _lastErrorCode = PurchasesErrorHelper.getErrorCode(error);
      return SubscriptionActionResult.failed;
    } catch (error) {
      debugPrint('Satın almalar geri yüklenemedi: $error');
      return SubscriptionActionResult.failed;
    } finally {
      _isRestoring = false;
      notifyListeners();
    }
  }

  void _ensureCustomerInfoListener() {
    if (_customerInfoListener != null) return;
    var isRegistering = true;
    _customerInfoListener = (customerInfo) {
      if (isRegistering || _currentUserId == null) return;
      _customerInfo = customerInfo;
      notifyListeners();
    };
    _service.addCustomerInfoListener(_customerInfoListener!);
    isRegistering = false;
  }

  void _removeCustomerInfoListener() {
    final listener = _customerInfoListener;
    if (listener == null) return;
    _service.removeCustomerInfoListener(listener);
    _customerInfoListener = null;
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed &&
        _currentUserId != null &&
        _service.isConfigured &&
        !isBusy) {
      unawaited(_refreshCustomerInfoSilently());
    }
  }

  Future<void> _refreshCustomerInfoSilently() async {
    final userId = _currentUserId;
    final generation = _syncGeneration;
    if (userId == null) return;

    try {
      final customerInfo = await _service.getCustomerInfo();
      if (generation != _syncGeneration || _currentUserId != userId) return;
      _customerInfo = customerInfo;
      notifyListeners();
    } catch (error) {
      debugPrint('Abonelik durumu arka planda yenilenemedi: $error');
    }
  }

  void _setPlatformFailure(
    PlatformException error, {
    bool keepCurrentPaywall = false,
  }) {
    _lastErrorCode = PurchasesErrorHelper.getErrorCode(error);
    _lastErrorDetail = '${error.code}: ${error.message}';
    _status = keepCurrentPaywall
        ? SubscriptionStatus.ready
        : SubscriptionStatus.failed;
    notifyListeners();
    if (!keepCurrentPaywall) _scheduleAutoRetry();
  }

  /// Geçici bir hatadan sonra artan gecikmelerle kendiliğinden yeniden dener.
  /// Kullanıcı bu sırada hata kartını görür ama elini sürmeden düzelme şansı
  /// olur — App Review gibi tek denemelik senaryolarda kritik.
  void _scheduleAutoRetry() {
    if (_autoRetryCount >= _maxAutoRetries) return;
    final attempt = ++_autoRetryCount;
    Future<void>.delayed(Duration(seconds: 2 * attempt), () {
      if (_isDisposed || _currentUserId == null) return;
      if (_status != SubscriptionStatus.failed &&
          _status != SubscriptionStatus.productsUnavailable) {
        return;
      }
      unawaited(refresh());
    });
  }

  @override
  void dispose() {
    _isDisposed = true;
    WidgetsBinding.instance.removeObserver(this);
    _authSubscription?.cancel();
    _removeCustomerInfoListener();
    super.dispose();
  }
}
