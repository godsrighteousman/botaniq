import 'dart:convert';
import 'dart:io';

import 'package:botaniq/core/locale/supported_app_locale.dart';
import 'package:botaniq/l10n/app_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final l10nDirectory = Directory('lib/l10n');
  final placeholderPattern = RegExp(
    r'\{([A-Za-z][A-Za-z0-9_]*)(?:\}|,)',
  );
  final resources = <String, Map<String, String>>{};

  setUpAll(() {
    for (final file in l10nDirectory.listSync().whereType<File>().where(
      (file) => file.path.endsWith('.arb'),
    )) {
      final decoded =
          jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
      final locale = decoded['@@locale']?.toString();
      expect(locale, isNotNull, reason: '${file.path} needs @@locale');
      resources[locale!] = {
        for (final entry in decoded.entries)
          if (!entry.key.startsWith('@')) entry.key: entry.value.toString(),
      };
    }
  });

  test('all registered locales have generated delegate support', () {
    for (final entry in SupportedAppLocales.entries) {
      expect(
        AppLocalizations.supportedLocales,
        contains(entry.locale),
        reason: '${entry.tag} is not generated',
      );
    }
  });

  test('locale resources are complete through shared regional inheritance', () {
    final template = resources['en']!;
    final expectedKeys = template.keys.toSet();

    for (final entry in SupportedAppLocales.entries) {
      final resourceLocale = entry.tag.replaceAll('-', '_');
      final baseLocale = switch (resourceLocale) {
        'pt_BR' => 'pt',
        'zh_Hans' || 'zh_Hant' => 'zh',
        'nl_NL' || 'nl_BE' => 'nl',
        _ => resourceLocale,
      };
      expect(resources, contains(baseLocale), reason: 'missing $baseLocale');
      expect(
        resources,
        contains(resourceLocale),
        reason: 'missing $resourceLocale',
      );

      final effective = <String, String>{
        ...resources[baseLocale]!,
        ...resources[resourceLocale]!,
      };
      expect(effective.keys.toSet(), expectedKeys, reason: entry.tag);
      expect(effective['appTitle'], 'Botaniq', reason: entry.tag);

      for (final key in expectedKeys) {
        final value = effective[key]!;
        expect(value.trim(), isNotEmpty, reason: '${entry.tag}/$key is empty');
        expect(
          value,
          isNot(contains('BOTANIQPH')),
          reason: '${entry.tag}/$key',
        );
        final expectedPlaceholders = placeholderPattern
            .allMatches(template[key]!)
            .map((match) => match.group(1))
            .toSet();
        final actualPlaceholders = placeholderPattern
            .allMatches(value)
            .map((match) => match.group(1))
            .toSet();
        expect(
          actualPlaceholders,
          expectedPlaceholders,
          reason: '${entry.tag}/$key placeholder mismatch',
        );
      }
    }
  });

  test('count messages exercise locale-aware ICU plural rules', () {
    for (final entry in SupportedAppLocales.entries) {
      final resourceLocale = entry.tag.replaceAll('-', '_');
      final baseLocale = switch (resourceLocale) {
        'pt_BR' => 'pt',
        'zh_Hans' || 'zh_Hant' => 'zh',
        'nl_NL' || 'nl_BE' => 'nl',
        _ => resourceLocale,
      };
      final effective = <String, String>{
        ...resources[baseLocale]!,
        ...resources[resourceLocale]!,
      };
      expect(effective['wateringOverdue'], contains('{days, plural,'));
      expect(effective['wateringDueInDays'], contains('{days, plural,'));
    }
  });
}
