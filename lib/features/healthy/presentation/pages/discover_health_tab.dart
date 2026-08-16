import 'package:botaniq/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../data/health_discover_service.dart';
import '../../domain/health_discover_content.dart';

class DiscoverHealthTab extends StatefulWidget {
  const DiscoverHealthTab({super.key});

  @override
  State<DiscoverHealthTab> createState() => _DiscoverHealthTabState();
}

class _DiscoverHealthTabState extends State<DiscoverHealthTab> {
  static const _ink = Color(0xFF2C3E35);
  static const _muted = Color(0xFF6E6E73);
  static const _green = Color(0xFF4FA976);

  final HealthDiscoverService _service = HealthDiscoverService.fromSupabase();
  Future<List<HealthDiscoverContent>>? _contentFuture;
  String? _languageCode;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final nextLanguageCode = Localizations.localeOf(context).languageCode;
    if (_contentFuture == null || _languageCode != nextLanguageCode) {
      _languageCode = nextLanguageCode;
      _contentFuture = _service.fetchPublished(languageCode: nextLanguageCode);
    }
  }

  Future<void> _refresh() async {
    final future = _service.fetchPublished(languageCode: _languageCode ?? 'tr');
    setState(() => _contentFuture = future);
    await future;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<HealthDiscoverContent>>(
      future: _contentFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting &&
            !snapshot.hasData) {
          return const Center(child: CircularProgressIndicator(color: _green));
        }
        if (snapshot.hasError) {
          return _buildMessageState(
            icon: Icons.cloud_off_rounded,
            message: AppLocalizations.of(context)!.healthDiscoverLoadError,
            showRetry: true,
          );
        }

        final content = snapshot.data ?? const <HealthDiscoverContent>[];
        if (content.isEmpty) {
          return _buildMessageState(
            icon: Icons.local_florist_outlined,
            message: AppLocalizations.of(context)!.healthDiscoverEmpty,
          );
        }

        final tips = content
            .where((item) => item.type == HealthDiscoverContentType.tip)
            .toList(growable: false);
        final spotlights = content
            .where((item) => item.type == HealthDiscoverContentType.spotlight)
            .toList(growable: false);

        return RefreshIndicator(
          color: _green,
          onRefresh: _refresh,
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics(),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            children: [
              if (tips.isNotEmpty) ...[
                _buildSectionTitle(
                  AppLocalizations.of(context)!.healthTrendingTips,
                ),
                const SizedBox(height: 16),
                for (var index = 0; index < tips.length; index++) ...[
                  _buildTipCard(tips[index]),
                  if (index != tips.length - 1) const SizedBox(height: 16),
                ],
              ],
              if (tips.isNotEmpty && spotlights.isNotEmpty)
                const SizedBox(height: 32),
              if (spotlights.isNotEmpty) ...[
                _buildSectionTitle(
                  AppLocalizations.of(context)!.healthWeeklySpotlight,
                ),
                const SizedBox(height: 16),
                for (var index = 0; index < spotlights.length; index++) ...[
                  _buildSpotlight(spotlights[index]),
                  if (index != spotlights.length - 1)
                    const SizedBox(height: 12),
                ],
              ],
              const SizedBox(height: 100),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMessageState({
    required IconData icon,
    required String message,
    bool showRetry = false,
  }) {
    final l10n = AppLocalizations.of(context)!;
    return RefreshIndicator(
      color: _green,
      onRefresh: _refresh,
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(32, 100, 32, 32),
        children: [
          Icon(icon, size: 48, color: const Color(0xFF8B9E93)),
          const SizedBox(height: 16),
          Text(
            message,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(color: _muted, fontSize: 14, height: 1.5),
          ),
          if (showRetry) ...[
            const SizedBox(height: 18),
            Center(
              child: OutlinedButton.icon(
                onPressed: _refresh,
                icon: const Icon(Icons.refresh_rounded),
                label: Text(l10n.healthDiscoverRetry),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.outfit(
        color: _ink,
        fontSize: 20,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  Widget _buildTipCard(HealthDiscoverContent content) {
    final accent = _parseColor(content.accentColor);
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(28),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: content.body.isEmpty ? null : () => _showDetails(content),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (content.imageUrl != null)
              Image.network(
                content.imageUrl!,
                height: 168,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => _imageFallback(
                  height: 168,
                  icon: _iconFor(content.iconName),
                  accent: accent,
                ),
              )
            else
              _imageFallback(
                height: 120,
                icon: _iconFor(content.iconName),
                accent: accent,
              ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    content.title,
                    style: GoogleFonts.outfit(
                      color: _ink,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (content.subtitle.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Text(
                      content.subtitle,
                      style: GoogleFonts.inter(
                        color: _muted,
                        fontSize: 14,
                        height: 1.5,
                      ),
                    ),
                  ],
                  if (content.body.isNotEmpty) ...[
                    const SizedBox(height: 14),
                    Icon(Icons.arrow_forward_rounded, size: 20, color: accent),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _imageFallback({
    required double height,
    required IconData icon,
    required Color accent,
  }) {
    return Container(
      height: height,
      width: double.infinity,
      color: accent.withValues(alpha: 0.1),
      alignment: Alignment.center,
      child: Icon(icon, color: accent, size: 42),
    );
  }

  Widget _buildSpotlight(HealthDiscoverContent content) {
    final accent = _parseColor(content.accentColor);
    return Material(
      color: accent.withValues(alpha: 0.08),
      borderRadius: BorderRadius.circular(28),
      child: InkWell(
        borderRadius: BorderRadius.circular(28),
        onTap: content.body.isEmpty ? null : () => _showDetails(content),
        child: Padding(
          padding: const EdgeInsets.all(22),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  _iconFor(content.iconName),
                  color: accent,
                  size: 30,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      content.title,
                      style: GoogleFonts.outfit(
                        color: _ink,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    if (content.subtitle.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text(
                        content.subtitle,
                        style: GoogleFonts.inter(
                          color: _muted,
                          fontSize: 13,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              if (content.body.isNotEmpty)
                const Icon(
                  Icons.chevron_right_rounded,
                  color: Color(0xFF8B9E93),
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDetails(HealthDiscoverContent content) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (sheetContext) => DraggableScrollableSheet(
        initialChildSize: 0.58,
        minChildSize: 0.35,
        maxChildSize: 0.9,
        expand: false,
        builder: (context, scrollController) => Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
          ),
          child: ListView(
            controller: scrollController,
            padding: const EdgeInsets.fromLTRB(24, 12, 24, 32),
            children: [
              Center(
                child: Container(
                  width: 42,
                  height: 4,
                  decoration: BoxDecoration(
                    color: const Color(0xFFD7E1DA),
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                content.title,
                style: GoogleFonts.outfit(
                  color: _ink,
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                ),
              ),
              if (content.subtitle.isNotEmpty) ...[
                const SizedBox(height: 10),
                Text(
                  content.subtitle,
                  style: GoogleFonts.inter(
                    color: _muted,
                    fontSize: 15,
                    height: 1.5,
                  ),
                ),
              ],
              const SizedBox(height: 22),
              Text(
                content.body,
                style: GoogleFonts.inter(
                  color: _ink,
                  fontSize: 15,
                  height: 1.7,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _iconFor(String? name) {
    return switch (name) {
      'bug' => Icons.bug_report_rounded,
      'water' => Icons.water_drop_rounded,
      'light' => Icons.wb_sunny_rounded,
      'health' => Icons.health_and_safety_rounded,
      'leaf' => Icons.eco_rounded,
      _ => Icons.star_rounded,
    };
  }

  Color _parseColor(String? hex) {
    if (hex == null || hex.length != 7) {
      return _green;
    }
    final value = int.tryParse(hex.substring(1), radix: 16);
    return value == null ? _green : Color(0xFF000000 | value);
  }
}
