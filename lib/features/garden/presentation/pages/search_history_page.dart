import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../../../core/services/search_history_service.dart';
import 'add_plant_wizard.dart';

/// Aratılan ve taranan bitkilerin geçmiş kaydını listeleyen sayfa.
class SearchHistoryPage extends StatefulWidget {
  const SearchHistoryPage({super.key});

  @override
  State<SearchHistoryPage> createState() => _SearchHistoryPageState();
}

class _SearchHistoryPageState extends State<SearchHistoryPage> {
  final Color _accentGreen = const Color(0xFF0ED761);
  final Color _lightBg = const Color(0xFFF5F9F6);
  final Color _primaryText = const Color(0xFF1B3A2A);
  final Color _textSecondary = const Color(0xFF7A8F82);

  List<Map<String, dynamic>> _historyList = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  Future<void> _loadHistory() async {
    final history = await SearchHistoryService.getHistory();
    if (mounted) {
      setState(() {
        _historyList = history;
        _isLoading = false;
      });
    }
  }

  Future<void> _clearAllHistory() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: Text(
          'Geçmişi Temizle',
          style: GoogleFonts.outfit(
            color: _primaryText,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          'Tüm arama ve tarama geçmişiniz silinecektir. Emin misiniz?',
          style: GoogleFonts.inter(color: const Color(0xFF5C7165)),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(
              'Vazgeç',
              style: GoogleFonts.inter(
                color: _textSecondary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFEF7C56),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0,
            ),
            child: Text(
              'Sil',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );

    if (confirm == true) {
      await SearchHistoryService.clearHistory();
      _loadHistory();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _lightBg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFFE8F5EE)),
            ),
            child: Icon(Icons.arrow_back_rounded, color: _primaryText, size: 20),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Arama Geçmişi',
          style: GoogleFonts.outfit(
            color: _primaryText,
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: false,
        actions: [
          if (_historyList.isNotEmpty)
            IconButton(
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFFFF6B6B).withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.delete_outline_rounded,
                  color: Color(0xFFFF6B6B),
                  size: 20,
                ),
              ),
              onPressed: _clearAllHistory,
              tooltip: 'Geçmişi Temizle',
            ),
          const SizedBox(width: 12),
        ],
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(color: Color(0xFF0ED761)),
            )
          : _historyList.isEmpty
              ? _buildEmptyHistoryState()
              : RefreshIndicator(
                  onRefresh: _loadHistory,
                  color: _accentGreen,
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics(),
                    ),
                    padding: const EdgeInsets.all(24),
                    itemCount: _historyList.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 14),
                    itemBuilder: (context, index) {
                      final item = _historyList[index];
                      return _HistoryCard(
                        item: item,
                        onTap: () => _showItemDetailSheet(item),
                      );
                    },
                  ),
                ),
    );
  }

  Widget _buildEmptyHistoryState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(36),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                color: _accentGreen.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.history_rounded,
                color: _accentGreen,
                size: 44,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Arama Kaydı Bulunmuyor',
              style: GoogleFonts.outfit(
                color: _primaryText,
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Kamera ile taranan veya aratılan bitkileriniz burada geçmiş kaydı olarak görüntülenecektir.',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                color: _textSecondary,
                fontSize: 14,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showItemDetailSheet(Map<String, dynamic> item) {
    final name = item['name'] ?? 'Bilinmeyen Bitki';
    final species = item['species'] ?? '';
    final description = item['description'] ?? 'Detaylı bilgi bulunmuyor.';
    final waterNeeds = item['water_needs'] ?? 'Düzenli sulama';
    final lightNeeds = item['light_needs'] ?? 'Dolaylı ışık';

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(32),
              topRight: Radius.circular(32),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      color: const Color(0xFF0ED761).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Center(
                      child: Text('🌿', style: TextStyle(fontSize: 32)),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: GoogleFonts.outfit(
                            color: _primaryText,
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        if (species.isNotEmpty) ...[
                          const SizedBox(height: 2),
                          Text(
                            species,
                            style: GoogleFonts.inter(
                              color: _accentGreen,
                              fontSize: 13,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5F9F6),
                        shape: BoxShape.circle,
                        border: Border.all(color: const Color(0xFFE8F5EE)),
                      ),
                      child: const Icon(
                        Icons.close_rounded,
                        color: Color(0xFF5C7165),
                        size: 18,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              Text(
                'Açıklama',
                style: GoogleFonts.outfit(
                  color: _primaryText,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                description,
                style: GoogleFonts.inter(
                  color: const Color(0xFF5C7165),
                  fontSize: 14,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 20),

              // Bakım Etiketleri
              Row(
                children: [
                  Expanded(
                    child: _buildInfoChip(
                      Icons.water_drop_rounded,
                      'Sulama',
                      waterNeeds,
                      const Color(0xFF5A9FFE),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildInfoChip(
                      Icons.wb_sunny_rounded,
                      'Işık',
                      lightNeeds,
                      const Color(0xFFFFB347),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 28),

              // Bahçeme Ekle Butonu
              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddPlantWizard(
                          plantData: {
                            'name': name,
                            'species': species,
                            'water_requirement': waterNeeds,
                            'light_condition': lightNeeds,
                            'description': description,
                          },
                          imagePath: '',
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  child: Ink(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF0ED761), Color(0xFF0ABF55)],
                      ),
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF0ED761).withOpacity(0.3),
                          blurRadius: 16,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Container(
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.add_rounded, color: Colors.white, size: 20),
                          const SizedBox(width: 8),
                          Text(
                            'Bahçeme Ekle',
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
            ],
          ),
        );
      },
    );
  }

  Widget _buildInfoChip(IconData icon, String title, String value, Color color) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F9F6),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE8F5EE)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 16),
              const SizedBox(width: 6),
              Text(
                title,
                style: GoogleFonts.inter(
                  color: _textSecondary,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: GoogleFonts.inter(
              color: _primaryText,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class _HistoryCard extends StatelessWidget {
  final Map<String, dynamic> item;
  final VoidCallback onTap;

  const _HistoryCard({
    required this.item,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final name = item['name'] ?? 'Bilinmeyen Bitki';
    final species = item['species'] ?? '';
    final searchedAtStr = item['searched_at'] as String?;
    String timeAgo = 'Yakın zamanda';

    if (searchedAtStr != null) {
      final date = DateTime.tryParse(searchedAtStr);
      if (date != null) {
        final diff = DateTime.now().difference(date);
        if (diff.inMinutes < 60) {
          timeAgo = '${diff.inMinutes} dk önce';
        } else if (diff.inHours < 24) {
          timeAgo = '${diff.inHours} saat önce';
        } else if (diff.inDays == 1) {
          timeAgo = 'Dün';
        } else {
          timeAgo = DateFormat('d MMM', 'tr_TR').format(date);
        }
      }
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: const Color(0xFFE8F5EE)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 14,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: const Color(0xFF0ED761).withOpacity(0.08),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Center(
                child: Text('🌿', style: TextStyle(fontSize: 26)),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: GoogleFonts.outfit(
                      color: const Color(0xFF1B3A2A),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    species.isNotEmpty ? species : 'Bitki Arama Kaydı',
                    style: GoogleFonts.inter(
                      color: const Color(0xFF7A8F82),
                      fontSize: 12,
                      fontStyle: species.isNotEmpty ? FontStyle.italic : FontStyle.normal,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  timeAgo,
                  style: GoogleFonts.inter(
                    color: const Color(0xFF7A8F82),
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 6),
                const Icon(
                  Icons.chevron_right_rounded,
                  color: Color(0xFF7A8F82),
                  size: 20,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
