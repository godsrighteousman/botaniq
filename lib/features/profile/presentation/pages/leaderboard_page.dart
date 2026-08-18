import 'package:botaniq/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Tüm kullanıcılar arasında tamamlanan bakım görevi sayısına göre sıralanan
/// küresel liderlik tablosu. Veri, RLS'i güvenli şekilde atlayan ve yalnızca
/// agregatif sayıları döndüren `get_care_task_leaderboard` RPC'sinden gelir
/// (bkz. supabase/migrations/20260817120000_care_task_leaderboard.sql).
class LeaderboardPage extends StatefulWidget {
  const LeaderboardPage({super.key});

  @override
  State<LeaderboardPage> createState() => _LeaderboardPageState();
}

class _LeaderboardPageState extends State<LeaderboardPage> {
  Color get _background => Theme.of(context).scaffoldBackgroundColor;
  Color get _ink => Theme.of(context).colorScheme.onSurface;
  Color get _muted => Theme.of(context).colorScheme.onSurfaceVariant;
  static const _green = Color(0xFF0ED761);
  static const _gold = Color(0xFFEAB308);
  static const _silver = Color(0xFF9CA3AF);
  static const _bronze = Color(0xFFB45309);

  bool _isLoading = true;
  String? _error;
  List<Map<String, dynamic>> _rows = const [];
  String? _currentUserId;

  @override
  void initState() {
    super.initState();
    _currentUserId = Supabase.instance.client.auth.currentUser?.id;
    _load();
  }

  Future<void> _load() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });
    try {
      final response = await Supabase.instance.client
          .rpc('get_care_task_leaderboard', params: {'limit_count': 50})
          .timeout(const Duration(seconds: 8));
      final rows = (response as List)
          .map((row) => Map<String, dynamic>.from(row as Map))
          .toList();
      if (!mounted) return;
      setState(() {
        _rows = rows;
        _isLoading = false;
      });
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _error = error.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: _background,
      appBar: AppBar(
        backgroundColor: _background,
        elevation: 0,
        foregroundColor: _ink,
        title: Text(
          l10n.leaderboardTitle,
          style: GoogleFonts.outfit(fontWeight: FontWeight.w700),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _load,
        child: _buildBody(l10n),
      ),
    );
  }

  Widget _buildBody(AppLocalizations l10n) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator(color: _green));
    }
    if (_error != null) {
      return ListView(
        children: [
          const SizedBox(height: 120),
          Icon(Icons.error_outline_rounded, color: _muted, size: 40),
          const SizedBox(height: 12),
          Center(
            child: Text(
              l10n.authError(_error!),
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(color: _muted),
            ),
          ),
        ],
      );
    }
    if (_rows.isEmpty) {
      return ListView(
        children: [
          const SizedBox(height: 120),
          Icon(Icons.emoji_events_outlined, color: _muted, size: 40),
          const SizedBox(height: 12),
          Center(
            child: Text(
              l10n.leaderboardEmptyState,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(color: _muted),
            ),
          ),
        ],
      );
    }
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 40),
      itemCount: _rows.length,
      separatorBuilder: (_, _) => const SizedBox(height: 10),
      itemBuilder: (context, index) {
        final row = _rows[index];
        final rank = (row['rank'] as num?)?.toInt() ?? (index + 1);
        final name = (row['full_name'] as String?)?.trim();
        final avatarUrl = (row['avatar_url'] as String?)?.trim();
        final completedCount = (row['completed_count'] as num?)?.toInt() ?? 0;
        final isMe = row['user_id'] == _currentUserId;

        return _LeaderboardRow(
          rank: rank,
          displayName: (name == null || name.isEmpty)
              ? l10n.profileTitleNew
              : name,
          avatarUrl: avatarUrl,
          completedCount: completedCount,
          isMe: isMe,
          l10n: l10n,
          rankColor: switch (rank) {
            1 => _gold,
            2 => _silver,
            3 => _bronze,
            _ => _muted,
          },
        );
      },
    );
  }
}

class _LeaderboardRow extends StatelessWidget {
  const _LeaderboardRow({
    required this.rank,
    required this.displayName,
    required this.avatarUrl,
    required this.completedCount,
    required this.isMe,
    required this.l10n,
    required this.rankColor,
  });

  final int rank;
  final String displayName;
  final String? avatarUrl;
  final int completedCount;
  final bool isMe;
  final AppLocalizations l10n;
  final Color rankColor;

  static const _deepGreen = Color(0xFF174B32);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final surface = theme.colorScheme.surface;
    final ink = theme.colorScheme.onSurface;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: isMe ? _deepGreen : surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isMe ? _deepGreen : theme.colorScheme.outlineVariant,
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 28,
            child: Text(
              '#$rank',
              textAlign: TextAlign.center,
              style: GoogleFonts.outfit(
                color: isMe ? Colors.white : rankColor,
                fontWeight: FontWeight.w800,
                fontSize: 15,
              ),
            ),
          ),
          const SizedBox(width: 10),
          CircleAvatar(
            radius: 20,
            backgroundColor: theme.colorScheme.surfaceContainerHighest,
            backgroundImage: (avatarUrl != null && avatarUrl!.isNotEmpty)
                ? NetworkImage(avatarUrl!)
                : null,
            child: (avatarUrl == null || avatarUrl!.isEmpty)
                ? Text(
                    displayName.isNotEmpty
                        ? displayName[0].toUpperCase()
                        : '?',
                    style: GoogleFonts.outfit(
                      color: _deepGreen,
                      fontWeight: FontWeight.w700,
                    ),
                  )
                : null,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              isMe ? l10n.leaderboardYou : displayName,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.inter(
                color: isMe ? Colors.white : ink,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ),
          Text(
            l10n.leaderboardCompletedTasks(completedCount),
            style: GoogleFonts.inter(
              color: isMe
                  ? Colors.white.withValues(alpha: 0.85)
                  : theme.colorScheme.onSurfaceVariant,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
