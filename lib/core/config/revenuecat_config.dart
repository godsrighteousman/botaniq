import 'package:flutter/foundation.dart';

class RevenueCatConfig {
  RevenueCatConfig._();

  static const String iosApiKey = String.fromEnvironment(
    'REVENUECAT_IOS_API_KEY',
  );
  static const String androidApiKey = String.fromEnvironment(
    'REVENUECAT_ANDROID_API_KEY',
  );
  static const String entitlementId = String.fromEnvironment(
    'REVENUECAT_ENTITLEMENT_ID',
    defaultValue: 'premium',
  );

  static bool get isSupportedPlatform {
    if (kIsWeb) return false;
    return defaultTargetPlatform == TargetPlatform.iOS ||
        defaultTargetPlatform == TargetPlatform.android;
  }

  static String? get platformApiKey {
    if (!isSupportedPlatform) return null;
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      return iosApiKey.trim().isEmpty ? null : iosApiKey.trim();
    }
    return androidApiKey.trim().isEmpty ? null : androidApiKey.trim();
  }
}
