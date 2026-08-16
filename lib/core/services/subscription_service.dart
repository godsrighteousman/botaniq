import 'package:flutter/foundation.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import '../config/revenuecat_config.dart';

class SubscriptionConfigurationException implements Exception {
  const SubscriptionConfigurationException(this.reason);

  final SubscriptionConfigurationFailure reason;
}

enum SubscriptionConfigurationFailure { unsupportedPlatform, missingApiKey }

/// RevenueCat SDK çağrılarını widget ve ekranlardan uzak tutar.
///
/// Uygulama yalnızca Supabase tarafından üretilen kararlı kullanıcı UUID'siyle
/// RevenueCat'e bağlanır. Böylece aynı kullanıcı cihazlar arasında tek müşteri
/// kaydı ve tek entitlement üzerinden izlenir.
class SubscriptionService {
  bool _isConfigured = false;
  String? _identifiedUserId;
  Future<void> _identificationQueue = Future<void>.value();

  bool get isSupported => RevenueCatConfig.isSupportedPlatform;
  bool get isConfigured => _isConfigured;
  bool get hasApiKey => RevenueCatConfig.platformApiKey != null;
  String get entitlementId => RevenueCatConfig.entitlementId;

  Future<CustomerInfo> identify(String userId) {
    final operation = _identificationQueue.then((_) => _identify(userId));
    _identificationQueue = operation.then<void>(
      (_) {},
      onError: (Object error, StackTrace stackTrace) {},
    );
    return operation;
  }

  Future<CustomerInfo> _identify(String userId) async {
    if (!isSupported) {
      throw const SubscriptionConfigurationException(
        SubscriptionConfigurationFailure.unsupportedPlatform,
      );
    }

    final apiKey = RevenueCatConfig.platformApiKey;
    if (apiKey == null) {
      throw const SubscriptionConfigurationException(
        SubscriptionConfigurationFailure.missingApiKey,
      );
    }

    if (!_isConfigured) {
      await Purchases.setLogLevel(kDebugMode ? LogLevel.debug : LogLevel.warn);
      final configuration = PurchasesConfiguration(apiKey)..appUserID = userId;
      await Purchases.configure(configuration);
      _isConfigured = true;
      _identifiedUserId = userId;
      return Purchases.getCustomerInfo();
    }

    if (_identifiedUserId != userId) {
      final result = await Purchases.logIn(userId);
      _identifiedUserId = userId;
      return result.customerInfo;
    }

    return Purchases.getCustomerInfo();
  }

  Future<Offerings> getOfferings() => Purchases.getOfferings();

  Future<CustomerInfo> getCustomerInfo() => Purchases.getCustomerInfo();

  Future<CustomerInfo> purchase(Package package) async {
    final result = await Purchases.purchase(PurchaseParams.package(package));
    return result.customerInfo;
  }

  Future<CustomerInfo> restorePurchases() => Purchases.restorePurchases();

  void addCustomerInfoListener(CustomerInfoUpdateListener listener) {
    Purchases.addCustomerInfoUpdateListener(listener);
  }

  void removeCustomerInfoListener(CustomerInfoUpdateListener listener) {
    Purchases.removeCustomerInfoUpdateListener(listener);
  }
}
