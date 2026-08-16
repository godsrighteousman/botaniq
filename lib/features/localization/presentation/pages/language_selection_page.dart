import 'package:botaniq/core/locale/locale_provider.dart';
import 'package:botaniq/core/locale/supported_app_locale.dart';
import 'package:botaniq/features/localization/presentation/widgets/language_picker_sheet.dart';
import 'package:botaniq/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// First-launch language gate shown before authentication and onboarding.
///
/// Completion is deliberately stored through [LocaleProvider] independently
/// from onboarding progress.
class LanguageSelectionPage extends StatefulWidget {
  const LanguageSelectionPage({super.key});

  @override
  State<LanguageSelectionPage> createState() => _LanguageSelectionPageState();
}

class _LanguageSelectionPageState extends State<LanguageSelectionPage> {
  String? _selectedTag;
  bool _initialized = false;
  bool _isCompleting = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_initialized) return;

    _selectedTag = context.read<LocaleProvider>().currentLocaleTag;
    _initialized = true;
  }

  Future<void> _openLanguagePicker() async {
    final provider = context.read<LocaleProvider>();
    final selection = await showLanguagePicker(
      context,
      localeProvider: provider,
      selectedTag: _selectedTag,
    );
    if (selection == null) return;

    final applyLocale = provider.setLocale(selection.localeTag);
    if (mounted) {
      setState(() => _selectedTag = selection.localeTag);
    }
    await applyLocale;
  }

  Future<void> _useSystemLanguage() async {
    final provider = context.read<LocaleProvider>();
    final applyLocale = provider.setLocale(null);
    if (mounted) {
      setState(() => _selectedTag = null);
    }
    await applyLocale;
  }

  Future<void> _completeSelection() async {
    if (_isCompleting) return;
    setState(() => _isCompleting = true);

    try {
      final provider = context.read<LocaleProvider>();
      await provider.setLocale(_selectedTag);
      await provider.completeInitialSelection(_selectedTag);
    } finally {
      if (mounted) {
        setState(() => _isCompleting = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Scaffold(
      body: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: AlignmentDirectional.topStart,
            end: AlignmentDirectional.bottomEnd,
            colors: [
              scheme.surface,
              Color.alphaBlend(
                scheme.primary.withValues(alpha: 0.075),
                scheme.surface,
              ),
            ],
          ),
        ),
        child: SafeArea(
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            slivers: [
              SliverPadding(
                padding: const EdgeInsetsDirectional.fromSTEB(20, 20, 20, 24),
                sliver: SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 560),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _BrandMark(label: l10n.appTitle),
                          const SizedBox(height: 34),
                          Text(
                            l10n.languageWelcomeTitle,
                            textAlign: TextAlign.center,
                            style: theme.textTheme.headlineMedium?.copyWith(
                              fontWeight: FontWeight.w900,
                              height: 1.08,
                              letterSpacing: -0.8,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              l10n.languageWelcomeSubtitle,
                              textAlign: TextAlign.center,
                              style: theme.textTheme.bodyLarge?.copyWith(
                                color: scheme.onSurfaceVariant,
                                height: 1.5,
                              ),
                            ),
                          ),
                          const SizedBox(height: 34),
                          _LanguageSelectionCard(
                            selectedTag: _selectedTag,
                            recommendedTag: SupportedAppLocales.tagFor(
                              context.watch<LocaleProvider>().recommendedLocale,
                            ),
                            selectLabel: l10n.selectLanguage,
                            systemLabel: l10n.languageUseSystem,
                            recommendedLabel: l10n.languageRecommended,
                            onTap: _isCompleting ? null : _openLanguagePicker,
                          ),
                          const SizedBox(height: 12),
                          Align(
                            alignment: AlignmentDirectional.center,
                            child: TextButton.icon(
                              onPressed: _isCompleting || _selectedTag == null
                                  ? null
                                  : _useSystemLanguage,
                              icon: const Icon(Icons.phone_iphone_rounded),
                              label: Text(l10n.languageUseSystem),
                            ),
                          ),
                          const Spacer(),
                          const SizedBox(height: 28),
                          FilledButton(
                            onPressed: _isCompleting
                                ? null
                                : _completeSelection,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Opacity(
                                  opacity: _isCompleting ? 0 : 1,
                                  child: Text(l10n.continueAction),
                                ),
                                if (_isCompleting)
                                  SizedBox.square(
                                    dimension: 22,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2.5,
                                      color: scheme.onSurfaceVariant,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BrandMark extends StatelessWidget {
  const _BrandMark({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Align(
      alignment: AlignmentDirectional.center,
      child: Semantics(
        image: true,
        label: label,
        child: ExcludeSemantics(
          child: Container(
            width: 86,
            height: 86,
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: scheme.surface,
              borderRadius: BorderRadius.circular(27),
              border: Border.all(color: scheme.primary.withValues(alpha: 0.28)),
              boxShadow: [
                BoxShadow(
                  color: scheme.primary.withValues(alpha: 0.16),
                  blurRadius: 30,
                  offset: const Offset(0, 14),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(22),
              child: Image.asset(
                'assets/images/botaniq_app_icon_v2.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _LanguageSelectionCard extends StatelessWidget {
  const _LanguageSelectionCard({
    required this.selectedTag,
    required this.recommendedTag,
    required this.selectLabel,
    required this.systemLabel,
    required this.recommendedLabel,
    required this.onTap,
  });

  final String? selectedTag;
  final String recommendedTag;
  final String selectLabel;
  final String systemLabel;
  final String recommendedLabel;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final entry = SupportedAppLocales.byTag(selectedTag);
    final isRecommended = entry?.tag == recommendedTag;
    final deviceLocale = SupportedAppLocales.byLocale(
      WidgetsBinding.instance.platformDispatcher.locale,
    );
    final title = entry?.nativeName ?? systemLabel;
    final String? subtitle = entry == null
        ? deviceLocale.nativeName
        : entry.englishName == entry.nativeName
        ? null
        : entry.englishName;
    final semanticLabel = <String>[
      selectLabel,
      title,
      ?subtitle,
      if (isRecommended) recommendedLabel,
    ].join(', ');

    return Semantics(
      button: true,
      enabled: onTap != null,
      label: semanticLabel,
      onTap: onTap,
      child: ExcludeSemantics(
        child: Material(
          color: scheme.surface,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(26),
            side: BorderSide(color: scheme.outlineVariant),
          ),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(18, 17, 16, 17),
              child: Row(
                children: [
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 180),
                    child: Container(
                      key: ValueKey(selectedTag ?? 'system'),
                      width: 52,
                      height: 52,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: scheme.primaryContainer,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: entry == null
                          ? Icon(
                              Icons.language_rounded,
                              color: scheme.onPrimaryContainer,
                            )
                          : Text(
                              entry.emoji,
                              style: const TextStyle(fontSize: 27),
                            ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          selectLabel,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.labelMedium?.copyWith(
                            color: scheme.onSurfaceVariant,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 3),
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 180),
                          child: Text(
                            title,
                            key: ValueKey(title),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                        if (subtitle != null) ...[
                          const SizedBox(height: 2),
                          Text(
                            subtitle,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: scheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                        if (isRecommended) ...[
                          const SizedBox(height: 5),
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
                  const SizedBox(width: 8),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 17,
                    color: scheme.onSurfaceVariant,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
