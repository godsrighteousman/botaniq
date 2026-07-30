import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/services/schedule_service.dart';
import '../../../../core/services/watering_schedule_service.dart';
import '../../../../core/services/care_notification_service.dart';
import '../../../../l10n/app_localizations.dart';

class AddPlantWizard extends StatefulWidget {
  final Map<String, dynamic> plantData;
  final String imagePath;

  const AddPlantWizard({
    super.key,
    required this.plantData,
    required this.imagePath,
  });

  @override
  State<AddPlantWizard> createState() => _AddPlantWizardState();
}

class _AddPlantWizardState extends State<AddPlantWizard> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final Color _accentGreen = const Color(0xFF86D5A6);
  final Color _lightBg = const Color(0xFFF9FAF9);
  final Color _textPrimary = const Color(0xFF2C3E35);
  final Color _textSecondary = const Color(0xFF8B9E93);

  // States for answers
  String? _selectedRoom;
  String? _selectedLight;
  String? _selectedDistance;
  String? _selectedHours;
  String? _selectedRepotted;
  String? _selectedPot;
  String? _selectedWatered;
  bool _isSaving = false;

  final List<String> _distances = [
    '0 - 1 m',
    '1 - 2 m',
    '2 - 3 m',
    '3 - 5 m',
    'More than 5 m',
  ];
  final List<String> _hours = [
    '1 hour',
    '2 hours',
    '3 hours',
    '4 hours',
    '5 hours',
    '6+ hours',
  ];

  @override
  void initState() {
    super.initState();
    _selectedDistance = _distances[0];
    _selectedHours = _hours[0];
  }

  void _nextPage() {
    if (_currentPage < 6) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _savePlantToSupabase();
    }
  }

  /// Bitkiyi Supabase'e kaydeder:
  /// 1) Fotoğrafı Storage'a yükler
  /// 2) plants tablosuna insert eder
  /// 3) ScheduleService ile ilk görevleri oluşturur
  Future<void> _savePlantToSupabase() async {
    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) return;

    setState(() => _isSaving = true);

    try {
      // 0. Kullanıcı kaydını garantile (önce users, sonra profiles tablosunu dene)
      try {
        await Supabase.instance.client.from('users').upsert({
          'id': user.id,
          'email': user.email ?? '',
          'full_name': user.userMetadata?['full_name'] ?? '',
        }, onConflict: 'id');
        debugPrint('Users upsert başarılı.');
      } catch (usersErr) {
        debugPrint('Users upsert hatası, profiles deneniyor: $usersErr');
        try {
          await Supabase.instance.client.from('profiles').upsert({
            'id': user.id,
            'email': user.email ?? '',
            'full_name': user.userMetadata?['full_name'] ?? '',
            'updated_at': DateTime.now().toIso8601String(),
          }, onConflict: 'id');
        } catch (profileErr) {
          debugPrint('Profiles upsert de atlandı: $profileErr');
        }
      }

      // 1. Fotoğrafı Storage'a yükle
      String imageUrl = widget.plantData['image'] ?? '';
      if (widget.imagePath.isNotEmpty) {
        try {
          final bytes = await File(widget.imagePath).readAsBytes();
          final fileName =
              '${user.id}_${DateTime.now().millisecondsSinceEpoch}.jpg';
          await Supabase.instance.client.storage
              .from('plant-images')
              .uploadBinary(fileName, bytes);
          imageUrl = Supabase.instance.client.storage
              .from('plant-images')
              .getPublicUrl(fileName);
        } catch (storageErr) {
          debugPrint('Storage yükleme hatası: $storageErr');
          imageUrl = '';
        }
      }

      // 2. Son sulama tarihini hesapla
      DateTime? lastWateredAt;
      final now = DateTime.now();
      if (_selectedWatered == 'Today') {
        lastWateredAt = now;
      } else if (_selectedWatered == 'Yesterday') {
        lastWateredAt = now.subtract(const Duration(days: 1));
      } else if (_selectedWatered == 'A few days ago') {
        lastWateredAt = now.subtract(const Duration(days: 3));
      } else if (_selectedWatered == 'A week ago') {
        lastWateredAt = now.subtract(const Duration(days: 7));
      } else if (_selectedWatered == 'More than a week ago') {
        lastWateredAt = now.subtract(const Duration(days: 10));
      }

      // 2.5 Catalog eşleştirmesi ara (aynı bitkiden varsa onun tanımlanmış bilgisinden getirmek için)
      String? catalogId;
      try {
        final String searchName = widget.plantData['name'] ?? '';
        final String searchSpecies = widget.plantData['species'] ?? '';
        if (searchName.isNotEmpty || searchSpecies.isNotEmpty) {
          // İsim veya türe göre eşleşen bir katalog kaydı bulalım
          final catRes = await Supabase.instance.client
              .from('plant_catalog')
              .select('id')
              .or('species.ilike.%$searchSpecies%,name.ilike.%$searchName%')
              .limit(1)
              .maybeSingle();

          if (catRes != null) {
            catalogId = catRes['id'] as String?;
          }
        }
      } catch (e) {
        debugPrint('Catalog lookup warning: $e');
      }

      // 3. plants tablosuna insert
      final wateringIntervalDays = WateringScheduleService.positiveInterval(
        widget.plantData['watering_interval_days'],
      );
      final Map<String, dynamic> insertPayload = {
        'user_id': user.id,
        'custom_name': widget.plantData['name'] ?? 'My Plant',
        'species': widget.plantData['species'] ?? '',
        'image_url': imageUrl,
        'health_status': 'Healthy',
        'watering_interval_days': wateringIntervalDays,
      };

      if (catalogId != null) {
        insertPayload['catalog_id'] = catalogId;
      }

      if (_selectedRoom != null) insertPayload['room'] = _selectedRoom;
      if (_selectedLight != null)
        insertPayload['light_condition'] = _selectedLight;
      if (_selectedDistance != null)
        insertPayload['distance_to_window'] = _selectedDistance;
      if (_selectedHours != null)
        insertPayload['sunlight_hours'] = _selectedHours;
      if (_selectedRepotted != null)
        insertPayload['last_repotted'] = _selectedRepotted;
      if (_selectedPot != null) insertPayload['pot_type'] = _selectedPot;
      if (lastWateredAt != null) {
        insertPayload['last_watered_at'] = lastWateredAt
            .toIso8601String()
            .substring(0, 10);
      }

      debugPrint('Tam insert payload: $insertPayload');
      Map<String, dynamic> result;
      try {
        // Önce tam payload (tüm wizard alanları) ile dene
        result = await Supabase.instance.client
            .from('plants')
            .insert(insertPayload)
            .select()
            .single();
      } catch (schemaErr) {
        debugPrint('Tam payload başarısız (şema eksik olabilir): $schemaErr');
        debugPrint('Temel payload ile tekrar deneniyor...');
        // Hata olursa sadece zorunlu alanlarla kaydet
        final Map<String, dynamic> basicPayload = {
          'user_id': user.id,
          'custom_name': widget.plantData['name'] ?? 'My Plant',
          'species': widget.plantData['species'] ?? '',
          'image_url': imageUrl,
          'health_status': 'Healthy',
          'watering_interval_days': wateringIntervalDays,
        };
        if (catalogId != null) {
          basicPayload['catalog_id'] = catalogId;
        }
        result = await Supabase.instance.client
            .from('plants')
            .insert(basicPayload)
            .select()
            .single();
        debugPrint('Temel payload ile kayıt başarılı.');
      }

      final plantId = result['id'] as String;
      debugPrint('Plants insert başarılı: id=$plantId');

      // 4. Bakım takvimini oluştur
      try {
        await ScheduleService.createInitialSchedules(
          plantId: plantId,
          userId: user.id,
        );
        debugPrint('Bakım takvimi oluşturuldu.');
      } catch (scheduleErr) {
        debugPrint(
          'Schedule oluşturma hatası (görmezden gelindi): $scheduleErr',
        );
      }
      await CareNotificationService.instance.refreshSchedules();

      if (mounted) {
        final l10n = AppLocalizations.of(context)!;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Icons.check_circle, color: Colors.white),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    l10n.wizardPlantAdded(
                      widget.plantData['name'] ?? l10n.plantUnknown,
                    ),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            backgroundColor: const Color(0xFF86D5A6),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            duration: const Duration(seconds: 3),
          ),
        );
        Navigator.of(context).popUntil((route) => route.isFirst);
      }
    } catch (e, stack) {
      debugPrint('Kaydetme hatası: $e\n$stack');
      if (mounted) {
        String errorMsg = e.toString();
        if (errorMsg.contains('42703') || errorMsg.contains('column')) {
          errorMsg =
              '⚠️ Veritabanı şeması eksik. Supabase\'de fix_plants_schema.sql dosyasını çalıştırın.';
        } else if (errorMsg.contains('23503') ||
            errorMsg.contains('foreign key')) {
          errorMsg =
              '⚠️ Kullanıcı profili bulunamadı. Çıkış yapıp tekrar giriş deneyin.';
        } else if (errorMsg.contains('42501') ||
            errorMsg.contains('permission denied')) {
          errorMsg =
              '⚠️ İzin hatası. Supabase RLS politikalarını kontrol edin.';
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMsg),
            backgroundColor: Colors.redAccent,
            duration: const Duration(seconds: 8),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: _lightBg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded, color: _textPrimary),
          onPressed: () {
            if (_currentPage > 0) {
              _pageController.previousPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            } else {
              Navigator.pop(context);
            }
          },
        ),
        actions: [
          TextButton(
            onPressed: () =>
                Navigator.of(context).popUntil((route) => route.isFirst),
            child: Text(
              l10n.skip,
              style: GoogleFonts.inter(
                color: _textSecondary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Progress bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              child: LinearProgressIndicator(
                value: (_currentPage + 1) / 7,
                backgroundColor: Colors.grey[200],
                valueColor: AlwaysStoppedAnimation<Color>(_accentGreen),
                minHeight: 8,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (idx) => setState(() => _currentPage = idx),
                children: [
                  _buildRoomSelection(),
                  _buildLightSelection(),
                  _buildDistanceSelection(),
                  _buildHoursSelection(),
                  _buildRepottedSelection(),
                  _buildPotSelection(),
                  _buildWateredSelection(),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomButton(),
    );
  }

  Widget _buildBottomButton() {
    final l10n = AppLocalizations.of(context)!;
    bool canProceed = false;
    switch (_currentPage) {
      case 0:
        canProceed = _selectedRoom != null;
        break;
      case 1:
        canProceed = _selectedLight != null;
        break;
      case 2:
        canProceed = _selectedDistance != null;
        break;
      case 3:
        canProceed = _selectedHours != null;
        break;
      case 4:
        canProceed = _selectedRepotted != null;
        break;
      case 5:
        canProceed = _selectedPot != null;
        break;
      case 6:
        canProceed = _selectedWatered != null;
        break;
    }

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SizedBox(
          height: 56,
          child: ElevatedButton(
            onPressed: (canProceed && !_isSaving) ? _nextPage : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: _accentGreen,
              disabledBackgroundColor: Colors.grey[300],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 0,
            ),
            child: _isSaving
                ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                : Text(
                    _currentPage == 6
                        ? l10n.wizardSaveGarden
                        : l10n.continueLabel,
                    style: GoogleFonts.inter(
                      color: canProceed ? Colors.white : Colors.grey[600],
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  // --- PAGES ---

  Widget _buildPageContainer(String title, String subtitle, Widget child) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.outfit(
              color: _textPrimary,
              fontSize: 28,
              fontWeight: FontWeight.bold,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: GoogleFonts.inter(color: _textSecondary, fontSize: 15),
          ),
          const SizedBox(height: 32),
          Expanded(child: child),
        ],
      ),
    );
  }

  Widget _buildRoomSelection() {
    final l10n = AppLocalizations.of(context)!;
    final rooms = [
      {
        'name': 'Living Room',
        'label': l10n.wizardLivingRoom,
        'icon': Icons.weekend_outlined,
      },
      {
        'name': 'Bedroom',
        'label': l10n.wizardBedroom,
        'icon': Icons.bed_outlined,
      },
      {
        'name': 'Kitchen',
        'label': l10n.wizardKitchen,
        'icon': Icons.countertops_outlined,
      },
      {
        'name': 'Office',
        'label': l10n.wizardOffice,
        'icon': Icons.computer_outlined,
      },
      {
        'name': 'Bathroom',
        'label': l10n.wizardBathroom,
        'icon': Icons.bathtub_outlined,
      },
      {
        'name': 'Balcony',
        'label': l10n.wizardBalcony,
        'icon': Icons.balcony_outlined,
      },
    ];

    return _buildPageContainer(
      l10n.wizardRoomTitle,
      l10n.wizardRoomSubtitle,
      GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 1.2,
        ),
        itemCount: rooms.length,
        itemBuilder: (context, index) {
          final room = rooms[index];
          final isSelected = _selectedRoom == room['name'];
          return _buildChoiceCard(
            title: room['label'] as String,
            icon: room['icon'] as IconData,
            isSelected: isSelected,
            onTap: () => setState(() => _selectedRoom = room['name'] as String),
          );
        },
      ),
    );
  }

  Widget _buildLightSelection() {
    final l10n = AppLocalizations.of(context)!;
    final lights = [
      {
        'name': 'Direct Sun',
        'label': l10n.wizardDirectSun,
        'desc': l10n.wizardDirectSunDescription,
        'icon': Icons.wb_sunny_outlined,
      },
      {
        'name': 'Bright Indirect',
        'label': l10n.wizardBrightIndirect,
        'desc': l10n.wizardBrightIndirectDescription,
        'icon': Icons.wb_twilight_outlined,
      },
      {
        'name': 'Medium Light',
        'label': l10n.wizardMediumLight,
        'desc': l10n.wizardMediumLightDescription,
        'icon': Icons.wb_cloudy_outlined,
      },
      {
        'name': 'Low Light',
        'label': l10n.wizardLowLight,
        'desc': l10n.wizardLowLightDescription,
        'icon': Icons.nights_stay_outlined,
      },
    ];

    return _buildPageContainer(
      l10n.wizardLightTitle,
      l10n.wizardLightSubtitle,
      ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: lights.length,
        itemBuilder: (context, index) {
          final light = lights[index];
          final isSelected = _selectedLight == light['name'];
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: _buildListChoiceCard(
              title: light['label'] as String,
              subtitle: light['desc'] as String,
              icon: light['icon'] as IconData,
              isSelected: isSelected,
              onTap: () =>
                  setState(() => _selectedLight = light['name'] as String),
            ),
          );
        },
      ),
    );
  }

  Widget _buildDistanceSelection() {
    final l10n = AppLocalizations.of(context)!;
    return _buildPageContainer(
      l10n.wizardDistanceTitle,
      l10n.wizardDistanceSubtitle,
      Center(
        child: SizedBox(
          height: 300,
          child: ListWheelScrollView.useDelegate(
            itemExtent: 60,
            physics: const FixedExtentScrollPhysics(),
            onSelectedItemChanged: (index) {
              setState(() => _selectedDistance = _distances[index]);
            },
            childDelegate: ListWheelChildBuilderDelegate(
              builder: (context, index) {
                if (index < 0 || index >= _distances.length) return null;
                final isSelected = _selectedDistance == _distances[index];
                return Center(
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? _accentGreen.withOpacity(0.1)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      _localizedDistance(l10n, _distances[index]),
                      style: GoogleFonts.outfit(
                        color: isSelected ? _accentGreen : Colors.grey[400],
                        fontSize: isSelected ? 24 : 20,
                        fontWeight: isSelected
                            ? FontWeight.bold
                            : FontWeight.w500,
                      ),
                    ),
                  ),
                );
              },
              childCount: _distances.length,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHoursSelection() {
    final l10n = AppLocalizations.of(context)!;
    return _buildPageContainer(
      l10n.wizardActiveHoursTitle,
      l10n.wizardActiveHoursSubtitle,
      Center(
        child: SizedBox(
          height: 300,
          child: ListWheelScrollView.useDelegate(
            itemExtent: 60,
            physics: const FixedExtentScrollPhysics(),
            onSelectedItemChanged: (index) {
              setState(() => _selectedHours = _hours[index]);
            },
            childDelegate: ListWheelChildBuilderDelegate(
              builder: (context, index) {
                if (index < 0 || index >= _hours.length) return null;
                final isSelected = _selectedHours == _hours[index];
                return Center(
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? _accentGreen.withOpacity(0.1)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      _localizedHours(l10n, _hours[index]),
                      style: GoogleFonts.outfit(
                        color: isSelected ? _accentGreen : Colors.grey[400],
                        fontSize: isSelected ? 24 : 20,
                        fontWeight: isSelected
                            ? FontWeight.bold
                            : FontWeight.w500,
                      ),
                    ),
                  ),
                );
              },
              childCount: _hours.length,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRepottedSelection() {
    final l10n = AppLocalizations.of(context)!;
    final list = [
      'Recently (under 3 months)',
      '6 months ago',
      '1 year ago',
      '2+ years ago',
      "I don't know",
    ];

    return _buildPageContainer(
      l10n.wizardRepottedTitle,
      l10n.wizardRepottedSubtitle,
      ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: list.length,
        itemBuilder: (context, index) {
          final isSelected = _selectedRepotted == list[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: _buildTextChoiceCard(
              title: _localizedRepotted(l10n, list[index]),
              isSelected: isSelected,
              onTap: () => setState(() => _selectedRepotted = list[index]),
            ),
          );
        },
      ),
    );
  }

  Widget _buildPotSelection() {
    final l10n = AppLocalizations.of(context)!;
    final list = [
      {
        'name': 'Plastic / Nursery',
        'label': l10n.wizardPlasticPot,
        'icon': Icons.shopping_bag_outlined,
      },
      {
        'name': 'Terracotta',
        'label': l10n.wizardTerracottaPot,
        'icon': Icons.bento_outlined,
      },
      {
        'name': 'Ceramic / Glazed',
        'label': l10n.wizardCeramicPot,
        'icon': Icons.coffee_outlined,
      },
      {
        'name': 'Metal',
        'label': l10n.wizardMetalPot,
        'icon': Icons.kitchen_outlined,
      },
    ];

    return _buildPageContainer(
      l10n.wizardPotTitle,
      l10n.wizardPotSubtitle,
      GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 1.1,
        ),
        itemCount: list.length,
        itemBuilder: (context, index) {
          final isSelected = _selectedPot == list[index]['name'];
          return _buildChoiceCard(
            title: list[index]['label'] as String,
            icon: list[index]['icon'] as IconData,
            isSelected: isSelected,
            onTap: () =>
                setState(() => _selectedPot = list[index]['name'] as String),
          );
        },
      ),
    );
  }

  Widget _buildWateredSelection() {
    final l10n = AppLocalizations.of(context)!;
    final list = [
      'Today',
      'Yesterday',
      'A few days ago',
      'A week ago',
      'More than a week ago',
      "I don't know",
    ];

    return _buildPageContainer(
      l10n.wizardWateredTitle,
      l10n.wizardWateredSubtitle,
      ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: list.length,
        itemBuilder: (context, index) {
          final isSelected = _selectedWatered == list[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: _buildTextChoiceCard(
              title: _localizedWatered(l10n, list[index]),
              isSelected: isSelected,
              onTap: () => setState(() => _selectedWatered = list[index]),
            ),
          );
        },
      ),
    );
  }

  String _localizedDistance(AppLocalizations l10n, String value) {
    return value == 'More than 5 m' ? l10n.wizardMoreThanFiveMeters : value;
  }

  String _localizedHours(AppLocalizations l10n, String value) {
    if (value == '6+ hours') return l10n.wizardSixPlusHours;
    final count = int.tryParse(value.split(' ').first) ?? 1;
    return count == 1 ? l10n.wizardHour(count) : l10n.wizardHours(count);
  }

  String _localizedRepotted(AppLocalizations l10n, String value) {
    return switch (value) {
      'Recently (under 3 months)' => l10n.wizardRecently,
      '6 months ago' => l10n.wizardSixMonthsAgo,
      '1 year ago' => l10n.wizardOneYearAgo,
      '2+ years ago' => l10n.wizardTwoYearsAgo,
      _ => l10n.wizardDontKnow,
    };
  }

  String _localizedWatered(AppLocalizations l10n, String value) {
    return switch (value) {
      'Today' => l10n.wizardToday,
      'Yesterday' => l10n.wizardYesterday,
      'A few days ago' => l10n.wizardFewDaysAgo,
      'A week ago' => l10n.wizardWeekAgo,
      'More than a week ago' => l10n.wizardMoreWeekAgo,
      _ => l10n.wizardDontKnow,
    };
  }

  // --- UI WIDGET COMPONENTS ---

  Widget _buildChoiceCard({
    required String title,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: isSelected ? _accentGreen.withOpacity(0.1) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? _accentGreen : Colors.transparent,
            width: 2,
          ),
          boxShadow: [
            if (!isSelected)
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isSelected ? _accentGreen : _textSecondary,
              size: 36,
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: GoogleFonts.inter(
                color: isSelected ? _accentGreen : _textPrimary,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListChoiceCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? _accentGreen.withOpacity(0.1) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? _accentGreen : Colors.transparent,
            width: 2,
          ),
          boxShadow: [
            if (!isSelected)
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isSelected ? _accentGreen : Colors.grey[100],
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: isSelected ? Colors.white : _textSecondary,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.inter(
                      color: isSelected ? _accentGreen : _textPrimary,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: GoogleFonts.inter(
                      color: _textSecondary,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextChoiceCard({
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: isSelected ? _accentGreen.withOpacity(0.1) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? _accentGreen : Colors.transparent,
            width: 2,
          ),
          boxShadow: [
            if (!isSelected)
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: GoogleFonts.inter(
                color: isSelected ? _accentGreen : _textPrimary,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                fontSize: 15,
              ),
            ),
            if (isSelected)
              Icon(Icons.check_circle_rounded, color: _accentGreen, size: 24)
            else
              Icon(Icons.circle_outlined, color: Colors.grey[300], size: 24),
          ],
        ),
      ),
    );
  }
}
