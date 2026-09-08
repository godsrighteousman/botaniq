import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:botaniq/l10n/app_localizations.dart';

/// Kullanıcıyı karşılayan header bileşeni.
/// Kullanıcı adı, tarih bilgisi ve aksiyon butonları içerir.
class HomeHeader extends StatelessWidget {
  final String userName;
  final VoidCallback onNotificationsTap;
  final VoidCallback onSignOutTap;
  final VoidCallback onThemeToggleTap;
  final bool isDarkMode;

  const HomeHeader({
    super.key,
    required this.userName,
    required this.onNotificationsTap,
    required this.onSignOutTap,
    required this.onThemeToggleTap,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context).toString();
    final now = DateTime.now();
    final l10n = AppLocalizations.of(context)!;
    final greeting = _getGreeting(l10n, now);
    final displayName = userName.isEmpty ? l10n.appTitle : userName;
    final colors = Theme.of(context).colorScheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.homePersonalGreeting(greeting, displayName),
                style: GoogleFonts.outfit(
                  color: colors.onSurface,
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.5,
                  height: 1.15,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                DateFormat('d MMMM, EEEE', locale).format(now),
                style: GoogleFonts.inter(
                  color: colors.onSurfaceVariant,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        Row(
          children: [
            _ActionButton(
              icon: isDarkMode
                  ? Icons.light_mode_outlined
                  : Icons.dark_mode_outlined,
              tooltip: isDarkMode ? l10n.themeLight : l10n.themeDark,
              onTap: onThemeToggleTap,
            ),
            const SizedBox(width: 10),
            _ActionButton(
              icon: Icons.notifications_none_rounded,
              onTap: onNotificationsTap,
            ),
            const SizedBox(width: 10),
            _ActionButton(icon: Icons.logout_rounded, onTap: onSignOutTap),
          ],
        ),
      ],
    );
  }

  String _getGreeting(AppLocalizations l10n, DateTime now) {
    final hour = now.hour;
    if (hour < 12) return l10n.homeGreetingMorning;
    if (hour < 17) return l10n.homeGreetingAfternoon;
    return l10n.homeGreetingEvening;
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final String? tooltip;

  const _ActionButton({required this.icon, required this.onTap, this.tooltip});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final button = Material(
      color: colors.surface.withValues(alpha: 0.9),
      shape: CircleBorder(
        side: BorderSide(color: const Color(0xFF0ED761).withValues(alpha: 0.14)),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          width: 44,
          height: 44,
          child: Icon(icon, color: colors.onSurface, size: 20),
        ),
      ),
    );
    final withShadow = Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0ED761).withValues(alpha: 0.06),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: button,
    );
    if (tooltip == null) return withShadow;
    return Tooltip(message: tooltip!, child: withShadow);
  }
}
