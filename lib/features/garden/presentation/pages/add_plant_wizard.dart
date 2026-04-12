import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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

  final List<String> _distances = ['0 - 1 m', '1 - 2 m', '2 - 3 m', '3 - 5 m', 'More than 5 m'];
  final List<String> _hours = ['1 hour', '2 hours', '3 hours', '4 hours', '5 hours', '6+ hours'];

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
      // Done - navigate back to home screen (pop everything until home)
      Navigator.of(context).popUntil((route) => route.isFirst);
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
            onPressed: () => Navigator.of(context).popUntil((route) => route.isFirst),
            child: Text(
              'Skip',
              style: GoogleFonts.inter(color: _textSecondary, fontWeight: FontWeight.w600),
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
    bool canProceed = false;
    switch (_currentPage) {
      case 0: canProceed = _selectedRoom != null; break;
      case 1: canProceed = _selectedLight != null; break;
      case 2: canProceed = _selectedDistance != null; break;
      case 3: canProceed = _selectedHours != null; break;
      case 4: canProceed = _selectedRepotted != null; break;
      case 5: canProceed = _selectedPot != null; break;
      case 6: canProceed = _selectedWatered != null; break;
    }

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SizedBox(
          height: 56,
          child: ElevatedButton(
            onPressed: canProceed ? _nextPage : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: _accentGreen,
              disabledBackgroundColor: Colors.grey[300],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 0,
            ),
            child: Text(
              _currentPage == 6 ? 'Save & Add to Garden' : 'Continue',
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
            style: GoogleFonts.inter(
              color: _textSecondary,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 32),
          Expanded(child: child),
        ],
      ),
    );
  }

  Widget _buildRoomSelection() {
    final rooms = [
      {'name': 'Living Room', 'icon': Icons.weekend_outlined},
      {'name': 'Bedroom', 'icon': Icons.bed_outlined},
      {'name': 'Kitchen', 'icon': Icons.countertops_outlined},
      {'name': 'Office', 'icon': Icons.computer_outlined},
      {'name': 'Bathroom', 'icon': Icons.bathtub_outlined},
      {'name': 'Balcony', 'icon': Icons.balcony_outlined},
    ];

    return _buildPageContainer(
      'Where are your plants?',
      'Categorize your plants by room to manage them easily.',
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
            title: room['name'] as String,
            icon: room['icon'] as IconData,
            isSelected: isSelected,
            onTap: () => setState(() => _selectedRoom = room['name'] as String),
          );
        },
      ),
    );
  }

  Widget _buildLightSelection() {
    final lights = [
      {'name': 'Direct Sun', 'desc': 'Unfiltered sunlight straight on the plant', 'icon': Icons.wb_sunny_outlined},
      {'name': 'Bright Indirect', 'desc': 'Close to an east or west window', 'icon': Icons.wb_twilight_outlined},
      {'name': 'Medium Light', 'desc': 'A few feet away from a window', 'icon': Icons.wb_cloudy_outlined},
      {'name': 'Low Light', 'desc': 'Far from windows or artificial light', 'icon': Icons.nights_stay_outlined},
    ];

    return _buildPageContainer(
      'How is the light in this spot?',
      'Light is the most important factor for your plant\'s health.',
      ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: lights.length,
        itemBuilder: (context, index) {
          final light = lights[index];
          final isSelected = _selectedLight == light['name'];
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: _buildListChoiceCard(
              title: light['name'] as String,
              subtitle: light['desc'] as String,
              icon: light['icon'] as IconData,
              isSelected: isSelected,
              onTap: () => setState(() => _selectedLight = light['name'] as String),
            ),
          );
        },
      ),
    );
  }

  Widget _buildDistanceSelection() {
    return _buildPageContainer(
      'Distance to window',
      'Select the approximate distance from your plant to the nearest window.',
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
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    decoration: BoxDecoration(
                      color: isSelected ? _accentGreen.withOpacity(0.1) : Colors.transparent,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      _distances[index],
                      style: GoogleFonts.outfit(
                        color: isSelected ? _accentGreen : Colors.grey[400],
                        fontSize: isSelected ? 24 : 20,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
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
    return _buildPageContainer(
      'Active hours',
      'How many hours of direct or bright sunlight does this spot get?',
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
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    decoration: BoxDecoration(
                      color: isSelected ? _accentGreen.withOpacity(0.1) : Colors.transparent,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      _hours[index],
                      style: GoogleFonts.outfit(
                        color: isSelected ? _accentGreen : Colors.grey[400],
                        fontSize: isSelected ? 24 : 20,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
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
    final list = [
      'Recently (under 3 months)',
      '6 months ago',
      '1 year ago',
      '2+ years ago',
      "I don't know",
    ];

    return _buildPageContainer(
      'When was this plant last repotted?',
      'Fresh soil is crucial for happy plants.',
      ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: list.length,
        itemBuilder: (context, index) {
          final isSelected = _selectedRepotted == list[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: _buildTextChoiceCard(
              title: list[index],
              isSelected: isSelected,
              onTap: () => setState(() => _selectedRepotted = list[index]),
            ),
          );
        },
      ),
    );
  }

  Widget _buildPotSelection() {
    final list = [
      {'name': 'Plastic / Nursery', 'icon': Icons.shopping_bag_outlined},
      {'name': 'Terracotta', 'icon': Icons.bento_outlined},
      {'name': 'Ceramic / Glazed', 'icon': Icons.coffee_outlined},
      {'name': 'Metal', 'icon': Icons.kitchen_outlined},
    ];

    return _buildPageContainer(
      'What material is the pot in?',
      'Pot material affects how quickly the soil dries out.',
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
            title: list[index]['name'] as String,
            icon: list[index]['icon'] as IconData,
            isSelected: isSelected,
            onTap: () => setState(() => _selectedPot = list[index]['name'] as String),
          );
        },
      ),
    );
  }

  Widget _buildWateredSelection() {
    final list = [
      'Today',
      'Yesterday',
      'A few days ago',
      'A week ago',
      'More than a week ago',
      "I don't know",
    ];

    return _buildPageContainer(
      'When did you last water this plant?',
      'This helps us calculate the exact time for the next watering.',
      ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: list.length,
        itemBuilder: (context, index) {
          final isSelected = _selectedWatered == list[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: _buildTextChoiceCard(
              title: list[index],
              isSelected: isSelected,
              onTap: () => setState(() => _selectedWatered = list[index]),
            ),
          );
        },
      ),
    );
  }

  // --- UI WIDGET COMPONENTS ---

  Widget _buildChoiceCard({required String title, required IconData icon, required bool isSelected, required VoidCallback onTap}) {
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
            Icon(icon, color: isSelected ? _accentGreen : _textSecondary, size: 36),
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

  Widget _buildListChoiceCard({required String title, required String subtitle, required IconData icon, required bool isSelected, required VoidCallback onTap}) {
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
              child: Icon(icon, color: isSelected ? Colors.white : _textSecondary, size: 24),
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

  Widget _buildTextChoiceCard({required String title, required bool isSelected, required VoidCallback onTap}) {
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
