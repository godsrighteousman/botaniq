import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
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
  bool _isPurchasing = false;
  bool _isRestoring = false;

  SubscriptionStatus get status => _status;
  PurchasesErrorCode? get lastErrorCode => _lastErrorCode;
  bool get isLoading => _status == SubscriptionStatus.loading;
  bool get isReady => _status == SubscriptionStatus.ready;
  bool get isPurchasing => _isPurchasing;
  bool get isRestoring => _isRestoring;
  bool get isBusy => _isPurchasing || _isRestoring;
  Package? get monthlyPackage => _offering?.monthly;
  Package? get annualPackage => _offering?.annual;
  Package? get selectedPackage => _selectedPackage;
  CustomerInfo? get customerInfo => _customerInfo;

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
      _status = SubscriptionStatus.failed;
      notifyListeners();
    }
  }

  Future<void> refresh() async {
    final userId = _currentUserId;
    if (userId == null || isLoading) return;

    final generation = ++_syncGeneration;
    _status = SubscriptionStatus.loading;
    _lastErrorCode = null;
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
      _setPlatformFailure(error);
    } catch (error) {
      debugPrint('Abonelik bilgileri yenilenemedi: $error');
      if (generation != _syncGeneration) return;
      _status = SubscriptionStatus.failed;
      notifyListeners();
    }
  }

  Future<void> _loadOfferings(int generation) async {
    final offerings = await _service.getOfferings();
    if (generation != _syncGeneration) return;

    _offering = offerings.current;
    final hasBothPlans = monthlyPackage != null && annualPackage != null;
    if (!hasBothPlans) {
      _selectedPackage = annualPackage ?? monthlyPackage;
      _status = SubscriptionStatus.productsUnavailable;
    } else {
      final selectedIdentifier = _selectedPackage?.identifier;
      _selectedPackage = [annualPackage, monthlyPackage]
          .whereType<Package>()
          .firstWhere(
            (package) => package.identifier == selectedIdentifier,
            orElse: () => annualPackage!,
          );
      _status = SubscriptionStatus.ready;
    }
    notifyListeners();
  }

  void selectPackage(Package package) {
    if (isBusy || package == _selectedPackage) return;
    _selectedPackage = package;
    _lastErrorCode = null;
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

  void _setPlatformFailure(PlatformException error) {
    _lastErrorCode = PurchasesErrorHelper.getErrorCode(error);
    _status = SubscriptionStatus.failed;
    notifyListeners();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _authSubscription?.cancel();
    _removeCustomerInfoListener();
    super.dispose();
  }
}
