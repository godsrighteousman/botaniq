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

  const HomeHeader({
    super.key,
    required this.userName,
    required this.onNotificationsTap,
    required this.onSignOutTap,
  });

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context).toString();
    final now = DateTime.now();
    final greeting = _getGreeting(AppLocalizations.of(context)!, now);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$greeting, $userName 👋',
                style: GoogleFonts.outfit(
                  color: const Color(0xFF1B3A2A),
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.5,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                DateFormat('d MMMM, EEEE', locale).format(now),
                style: GoogleFonts.inter(
                  color: const Color(0xFF7A8F82),
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

  const _ActionButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.85),
          shape: BoxShape.circle,
          border: Border.all(color: const Color(0xFF0ED761).withOpacity(0.12)),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF0ED761).withOpacity(0.06),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Icon(icon, color: const Color(0xFF3B4D43), size: 20),
      ),
    );
  }
}
