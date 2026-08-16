import 'dart:math' as math;

import 'package:botaniq/core/locale/locale_provider.dart';
import 'package:botaniq/core/locale/supported_app_locale.dart';
import 'package:botaniq/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// The result of a language picker interaction.
///
/// A wrapper is used so dismissing the sheet (`null`) can be distinguished
/// from explicitly choosing the system language ([localeTag] is `null`).
@immutable
class LanguagePickerSelection {
  const LanguagePickerSelection.locale(String tag) : localeTag = tag;

  const LanguagePickerSelection.system() : localeTag = null;

  final String? localeTag;

  bool get followsSystem => localeTag == null;
}

/// Opens Botaniq's searchable language picker without changing the locale.
///
/// This lower-level helper is useful when a flow needs to perform additional
/// work before or after applying the selection. Use
/// [showAndApplyLanguagePicker] when no extra coordination is needed.
Future<LanguagePickerSelection?> showLanguagePicker(
  BuildContext context, {
  LocaleProvider? localeProvider,
  String? selectedTag,
  bool includeSystem = true,
}) {
  final provider = localeProvider ?? context.read<LocaleProvider>();

  return showModalBottomSheet<LanguagePickerSelection>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: Colors.transparent,
    barrierColor: Theme.of(context).colorScheme.scrim.withValues(alpha: 0.42),
    builder: (sheetContext) {
      final sheetMediaQuery = MediaQuery.of(sheetContext);
      final availableHeight = math.max(
        0.0,
        sheetMediaQuery.size.height - sheetMediaQuery.viewInsets.bottom,
      );
      final sheetHeight = math.min(
        760.0,
        availableHeight * (sheetMediaQuery.viewInsets.bottom > 0 ? 0.98 : 0.9),
      );
      return AnimatedPadding(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOut,
        padding: EdgeInsets.only(bottom: sheetMediaQuery.viewInsets.bottom),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: sheetMediaQuery.size.width >= 680 ? 24 : 0,
            ),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 640),
              child: SizedBox(
                width: double.infinity,
                height: sheetHeight,
                child: Material(
                  color: Theme.of(sheetContext).colorScheme.surface,
                  clipBehavior: Clip.antiAlias,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(32),
                    ),
                  ),
                  child: LanguagePickerSheet(
                    selectedTag: selectedTag ?? provider.currentLocaleTag,
                    recommendedTag: SupportedAppLocales.tagFor(
                      provider.recommendedLocale,
                    ),
                    includeSystem: includeSystem,
                    onSelected: (selection) {
                      Navigator.of(sheetContext).pop(selection);
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}

/// Opens the language picker and immediately applies an explicit selection.
///
/// Returns `true` when the user selected an option and `false` when the sheet
/// was dismissed.
Future<bool> showAndApplyLanguagePicker(
  BuildContext context, {
  bool includeSystem = true,
}) async {
  final provider = context.read<LocaleProvider>();
  final selection = await showLanguagePicker(
    context,
    localeProvider: provider,
    includeSystem: includeSystem,
  );
  if (selection == null) return false;

  await provider.setLocale(selection.localeTag);
  return true;
}

class LanguagePickerSheet extends StatefulWidget {
  const LanguagePickerSheet({
    required this.selectedTag,
    required this.recommendedTag,
    required this.onSelected,
    this.includeSystem = true,
    super.key,
  });

  final String? selectedTag;
  final String recommendedTag;
  final bool includeSystem;
  final ValueChanged<LanguagePickerSelection> onSelected;

  @override
  State<LanguagePickerSheet> createState() => _LanguagePickerSheetState();
}

class _LanguagePickerSheetState extends State<LanguagePickerSheet> {
  final TextEditingController _searchController = TextEditingController();

  String get _query => _searchController.text.trim().toLowerCase();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_handleSearchChanged);
  }

  @override
  void dispose() {
    _searchController
      ..removeListener(_handleSearchChanged)
      ..dispose();
    super.dispose();
  }

  void _handleSearchChanged() => setState(() {});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final deviceLocale = SupportedAppLocales.byLocale(
      WidgetsBinding.instance.platformDispatcher.locale,
    );
    final systemSearchText =
        ('${l10n.languageUseSystem} ${deviceLocale.searchableText}')
            .toLowerCase();
    final showSystem =
        widget.includeSystem &&
        (_query.isEmpty || systemSearchText.contains(_query));
    final entries = SupportedAppLocales.entries
        .where(
          (entry) => _query.isEmpty || entry.searchableText.contains(_query),
        )
        .toList(growable: true);

    if (_query.isEmpty) {
      entries.sort((a, b) {
        final aIsRecommended = a.tag == widget.recommendedTag;
        final bIsRecommended = b.tag == widget.recommendedTag;
        if (aIsRecommended == bIsRecommended) return 0;
        return aIsRecommended ? -1 : 1;
      });
    }

    return SafeArea(
      top: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 10),
          Center(
            child: Container(
              width: 42,
              height: 4,
              decoration: BoxDecoration(
                color: scheme.outlineVariant,
                borderRadius: BorderRadius.circular(99),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(20, 12, 12, 12),
            child: Row(
              children: [
                Container(
                  width: 46,
                  height: 46,
                  decoration: BoxDecoration(
                    color: scheme.primaryContainer,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(
                    Icons.translate_rounded,
                    color: scheme.onPrimaryContainer,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(
                    l10n.selectLanguage,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.3,
                    ),
                  ),
                ),
                IconButton(
                  tooltip: MaterialLocalizations.of(context).closeButtonTooltip,
                  onPressed: () => Navigator.of(context).maybePop(),
                  icon: const Icon(Icons.close_rounded),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
            child: TextField(
              controller: _searchController,
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                hintText: l10n.languageSearchHint,
                prefixIcon: const Icon(Icons.search_rounded),
                suffixIcon: _query.isEmpty
                    ? null
                    : IconButton(
                        tooltip: MaterialLocalizations.of(
                          context,
                        ).deleteButtonTooltip,
                        onPressed: _searchController.clear,
                        icon: const Icon(Icons.close_rounded),
                      ),
              ),
            ),
          ),
          Divider(height: 1, color: scheme.outlineVariant),
          Expanded(
            child: entries.isEmpty && !showSystem
                ? _EmptySearchResult(
                    label: WidgetsLocalizations.of(context).noResultsFound,
                  )
                : ListView.separated(
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
                    itemCount: entries.length + (showSystem ? 1 : 0),
                    separatorBuilder: (_, _) => const SizedBox(height: 8),
                    itemBuilder: (context, index) {
                      if (showSystem && index == 0) {
                        return _SystemLanguageTile(
                          label: l10n.languageUseSystem,
                          deviceLanguage: deviceLocale.nativeName,
                          selected: widget.selectedTag == null,
                          onTap: () => widget.onSelected(
                            const LanguagePickerSelection.system(),
                          ),
                        );
                      }

                      final entry = entries[index - (showSystem ? 1 : 0)];
                      return _LanguageTile(
                        entry: entry,
                        recommendedLabel: l10n.languageRecommended,
                        recommended: entry.tag == widget.recommendedTag,
                        selected: entry.tag == widget.selectedTag,
                        onTap: () => widget.onSelected(
                          LanguagePickerSelection.locale(entry.tag),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class _EmptySearchResult extends StatelessWidget {
  const _EmptySearchResult({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Semantics(
      liveRegion: true,
      label: label,
      child: ExcludeSemantics(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.search_off_rounded,
                  size: 40,
                  color: scheme.onSurfaceVariant,
                ),
                const SizedBox(height: 12),
                Text(
                  label,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: scheme.onSurfaceVariant,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LanguageTile extends StatelessWidget {
  const _LanguageTile({
    required this.entry,
    required this.recommendedLabel,
    required this.recommended,
    required this.selected,
    required this.onTap,
  });

  final SupportedAppLocale entry;
  final String recommendedLabel;
  final bool recommended;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final semanticLabel = <String>[
      entry.nativeName,
      if (entry.englishName != entry.nativeName) entry.englishName,
      if (recommended) recommendedLabel,
    ].join(', ');

    return Semantics(
      button: true,
      selected: selected,
      label: semanticLabel,
      onTap: onTap,
      child: ExcludeSemantics(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          decoration: BoxDecoration(
            color: selected
                ? scheme.primaryContainer.withValues(alpha: 0.62)
                : scheme.surfaceContainerLow,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: selected ? scheme.primary : scheme.outlineVariant,
              width: selected ? 1.5 : 1,
            ),
          ),
          clipBehavior: Clip.antiAlias,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(14, 12, 14, 12),
                child: Row(
                  children: [
                    _LanguageLeading(emoji: entry.emoji),
                    const SizedBox(width: 13),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            entry.nativeName,
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          if (entry.englishName != entry.nativeName) ...[
                            const SizedBox(height: 2),
                            Text(
                              entry.englishName,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: scheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                          if (recommended) ...[
                            const SizedBox(height: 4),
                            Text(
                              recommendedLabel,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.labelSmall?.copyWith(
                                color: scheme.primary,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    _SelectionIndicator(selected: selected),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SystemLanguageTile extends StatelessWidget {
  const _SystemLanguageTile({
    required this.label,
    required this.deviceLanguage,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final String deviceLanguage;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Semantics(
      button: true,
      selected: selected,
      label: '$label, $deviceLanguage',
      onTap: onTap,
      child: ExcludeSemantics(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          decoration: BoxDecoration(
            color: selected
                ? scheme.primaryContainer.withValues(alpha: 0.62)
                : scheme.surfaceContainerLow,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: selected ? scheme.primary : scheme.outlineVariant,
              width: selected ? 1.5 : 1,
            ),
          ),
          clipBehavior: Clip.antiAlias,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(14, 12, 14, 12),
                child: Row(
                  children: [
                    _LanguageLeading(
                      icon: Icons.phone_iphone_rounded,
                      iconColor: scheme.primary,
                    ),
                    const SizedBox(width: 13),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            label,
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            deviceLanguage,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: scheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    _SelectionIndicator(selected: selected),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _LanguageLeading extends StatelessWidget {
  const _LanguageLeading({this.emoji, this.icon, this.iconColor});

  final String? emoji;
  final IconData? icon;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      width: 46,
      height: 46,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: emoji != null
          ? Text(emoji!, style: const TextStyle(fontSize: 24))
          : Icon(icon, color: iconColor, size: 22),
    );
  }
}

class _SelectionIndicator extends StatelessWidget {
  const _SelectionIndicator({required this.selected});

  final bool selected;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      width: 27,
      height: 27,
      decoration: BoxDecoration(
        color: selected ? scheme.primary : Colors.transparent,
        shape: BoxShape.circle,
        border: Border.all(
          color: selected ? scheme.primary : scheme.outline,
          width: 1.5,
        ),
      ),
      child: selected
          ? Icon(Icons.check_rounded, color: scheme.onPrimary, size: 18)
          : null,
    );
  }
}
