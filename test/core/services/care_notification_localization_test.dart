import 'package:botaniq/core/locale/supported_app_locale.dart';
import 'package:botaniq/l10n/app_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('notification copy loads for the exact supported locale set', () async {
    expect(SupportedAppLocales.tags, {
      'en',
      'tr',
      'de',
      'fr',
      'es',
      'it',
      'pt',
      'pt-BR',
      'pl',
      'ru',
      'zh-Hans',
      'zh-Hant',
      'id',
      'th',
      'ar',
      'nl-NL',
      'nl-BE',
    });

    for (final locale in SupportedAppLocales.entries) {
      final localizations = await AppLocalizations.delegate.load(locale.locale);
      expect(
        localizations.notificationWateringTitle,
        isNotEmpty,
        reason: '${locale.tag} watering notification title',
      );
      expect(
        localizations.homeWateringNotification,
        isNotEmpty,
        reason: '${locale.tag} watering notification body',
      );
      expect(
        localizations.clinicTitle,
        isNotEmpty,
        reason: '${locale.tag} clinic notification title',
      );
      expect(
        localizations.clinicNewPhotoSubtitle,
        isNotEmpty,
        reason: '${locale.tag} clinic notification body',
      );
    }
  });
}
