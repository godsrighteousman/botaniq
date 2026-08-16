import 'dart:ui';

import 'package:intl/intl.dart';

import '../locale/locale_provider.dart';

enum ResolvedMeasurementSystem { metric, imperial }

/// Converts canonical metric values only at the presentation boundary.
///
/// Canonical storage units are Celsius, millimetres, millilitres and grams.
/// Keeping conversion here avoids precision loss from repeated round-trips.
class MeasurementFormatter {
  MeasurementFormatter({
    required this.preference,
    required this.formattingLocale,
    Locale? regionalLocale,
  }) : regionalLocale = regionalLocale ?? PlatformDispatcher.instance.locale;

  final MeasurementSystemPreference preference;
  final String formattingLocale;
  final Locale regionalLocale;

  ResolvedMeasurementSystem get resolvedSystem => switch (preference) {
    MeasurementSystemPreference.metric => ResolvedMeasurementSystem.metric,
    MeasurementSystemPreference.imperial => ResolvedMeasurementSystem.imperial,
    MeasurementSystemPreference.system => _systemForRegion(regionalLocale),
  };

  bool get usesMetric => resolvedSystem == ResolvedMeasurementSystem.metric;

  String temperatureCelsius(double celsius, {int fractionDigits = 0}) {
    final value = usesMetric ? celsius : (celsius * 9 / 5) + 32;
    return '${_number(value, fractionDigits)} °${usesMetric ? 'C' : 'F'}';
  }

  String lengthMillimetres(double millimetres) {
    if (usesMetric) {
      if (millimetres >= 1000) {
        return '${_number(millimetres / 1000, 1)} m';
      }
      if (millimetres >= 10) {
        return '${_number(millimetres / 10, 1)} cm';
      }
      return '${_number(millimetres, 1)} mm';
    }
    final inches = millimetres / 25.4;
    if (inches >= 12) return '${_number(inches / 12, 1)} ft';
    return '${_number(inches, 1)} in';
  }

  String rainfallMillimetres(double millimetres) => usesMetric
      ? '${_number(millimetres, 1)} mm'
      : '${_number(millimetres / 25.4, 2)} in';

  String volumeMillilitres(double millilitres) {
    if (usesMetric) {
      if (millilitres >= 1000) {
        return '${_number(millilitres / 1000, 1)} L';
      }
      return '${_number(millilitres, 0)} ml';
    }
    const millilitresPerFluidOunce = 29.5735295625;
    const millilitresPerCup = 236.5882365;
    const millilitresPerGallon = 3785.411784;
    if (millilitres >= millilitresPerGallon) {
      return '${_number(millilitres / millilitresPerGallon, 2)} gal';
    }
    if (millilitres >= millilitresPerCup * 2) {
      return '${_number(millilitres / millilitresPerCup, 1)} cup';
    }
    return '${_number(millilitres / millilitresPerFluidOunce, 1)} fl oz';
  }

  String weightGrams(double grams) {
    if (usesMetric) {
      if (grams >= 1000) return '${_number(grams / 1000, 1)} kg';
      return '${_number(grams, 0)} g';
    }
    const gramsPerOunce = 28.349523125;
    const gramsPerPound = 453.59237;
    if (grams >= gramsPerPound) {
      return '${_number(grams / gramsPerPound, 1)} lb';
    }
    return '${_number(grams / gramsPerOunce, 1)} oz';
  }

  /// Converts deterministic legacy volume strings such as `250ml` or `1 L`.
  /// Unstructured care prose is returned unchanged.
  String displayLegacyAmount(String amount) {
    final millilitres = tryParseVolumeMillilitres(amount);
    return millilitres == null ? amount : volumeMillilitres(millilitres);
  }

  static double? tryParseVolumeMillilitres(String input) {
    final normalized = input.trim().toLowerCase().replaceAll(',', '.');
    final match = RegExp(
      r'^(\d+(?:\.\d+)?)\s*(ml|millilit(?:er|re)s?|l|lit(?:er|re)s?)$',
    ).firstMatch(normalized);
    if (match == null) return null;
    final value = double.tryParse(match.group(1)!);
    if (value == null) return null;
    final unit = match.group(2)!;
    return unit == 'l' || unit.startsWith('lit') ? value * 1000 : value;
  }

  String _number(double value, int maximumFractionDigits) {
    final formatter = NumberFormat.decimalPattern(formattingLocale)
      ..minimumFractionDigits = 0
      ..maximumFractionDigits = maximumFractionDigits;
    return formatter.format(value);
  }

  static ResolvedMeasurementSystem _systemForRegion(Locale locale) {
    final country = locale.countryCode?.toUpperCase();
    return const {'US', 'LR', 'MM'}.contains(country)
        ? ResolvedMeasurementSystem.imperial
        : ResolvedMeasurementSystem.metric;
  }
}
