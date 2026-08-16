import 'package:botaniq/core/locale/locale_provider.dart';
import 'package:botaniq/core/measurement/measurement_formatter.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('MeasurementFormatter', () {
    test('converts canonical metric values at the display boundary', () {
      final imperial = MeasurementFormatter(
        preference: MeasurementSystemPreference.imperial,
        formattingLocale: 'en_US',
        regionalLocale: const Locale('US'),
      );

      expect(imperial.temperatureCelsius(20), '68 °F');
      expect(imperial.lengthMillimetres(25.4), '1 in');
      expect(imperial.rainfallMillimetres(25.4), '1 in');
      expect(imperial.volumeMillilitres(236.5882365), '8 fl oz');
      expect(imperial.weightGrams(453.59237), '1 lb');
    });

    test('formats metric units and locale-specific decimal separators', () {
      final metric = MeasurementFormatter(
        preference: MeasurementSystemPreference.metric,
        formattingLocale: 'de',
        regionalLocale: const Locale('DE'),
      );

      expect(metric.temperatureCelsius(20.5, fractionDigits: 1), '20,5 °C');
      expect(metric.lengthMillimetres(125), '12,5 cm');
      expect(metric.volumeMillilitres(1500), '1,5 L');
      expect(metric.weightGrams(1500), '1,5 kg');
    });

    test('system units follow region independently from selected language', () {
      final englishInFrance = MeasurementFormatter(
        preference: MeasurementSystemPreference.system,
        formattingLocale: 'en',
        regionalLocale: const Locale('fr', 'FR'),
      );
      final turkishInUs = MeasurementFormatter(
        preference: MeasurementSystemPreference.system,
        formattingLocale: 'tr',
        regionalLocale: const Locale('en', 'US'),
      );

      expect(englishInFrance.usesMetric, isTrue);
      expect(turkishInUs.usesMetric, isFalse);
      expect(englishInFrance.temperatureCelsius(0), '0 °C');
      expect(turkishInUs.temperatureCelsius(0), '32 °F');
    });

    test(
      'legacy volume parser is deterministic and leaves prose untouched',
      () {
        expect(MeasurementFormatter.tryParseVolumeMillilitres('250ml'), 250);
        expect(MeasurementFormatter.tryParseVolumeMillilitres('1,5 L'), 1500);
        expect(
          MeasurementFormatter.tryParseVolumeMillilitres('water generously'),
          isNull,
        );
      },
    );
  });
}
