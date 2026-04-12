import 'package:botaniq/features/garden/presentation/pages/plant_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../garden/presentation/pages/plant_detail_page.dart';

class SearchPlantPage extends StatefulWidget {
  const SearchPlantPage({super.key});

  @override
  State<SearchPlantPage> createState() => _SearchPlantPageState();
}

class _SearchPlantPageState extends State<SearchPlantPage> {
  final Color _accentGreen = const Color(0xFF86D5A6);
  final Color _lightBg = const Color(0xFFF9FAF9);
  final Color _cardBg = Colors.white;
  final Color _textSecondary = const Color(0xFF8B9E93);
  final Color _primaryText = const Color(0xFF2C3E35);

  final TextEditingController _searchController = TextEditingController();
  int _selectedCategoryIndex = 0;

  final List<String> _categories = [
    'All Plants',
    'Indoor',
    'Outdoor',
    'Succulents',
    'Flowering',
  ];

  final List<Map<String, dynamic>> _samplePlants = [
    {
      'name': 'Monstera Deliciosa',
      'category': 'Indoor • Easy Care',
      'image': 'https://picsum.photos/seed/monstera/600/600',
      'difficulty': 'Easy',
    },
    {
      'name': 'Snake Plant',
      'category': 'Low Light • Purifier',
      'image': 'https://picsum.photos/seed/snake/600/600',
      'difficulty': 'Easy',
    },
    {
      'name': 'Fiddle Leaf Fig',
      'category': 'Tree • Bright Light',
      'image': 'https://picsum.photos/seed/fiddle/600/600',
      'difficulty': 'Hard',
    },
    {
      'name': 'Aloe Vera',
      'category': 'Succulent • Medicine',
      'image': 'https://picsum.photos/seed/aloe/600/600',
      'difficulty': 'Medium',
    },
    {
      'name': 'Peace Lily',
      'category': 'Indoor • Flowering',
      'image': 'https://picsum.photos/seed/lily/600/600',
      'difficulty': 'Medium',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _lightBg,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            const SizedBox(height: 16),
            _buildCategories(),
            const SizedBox(height: 24),
            Expanded(child: _buildPlantList()),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: _cardBg,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFCBD5E1).withOpacity(0.02 * 4),
                        blurRadius: 16,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.arrow_back_ios_new,
                    color: Color(0xFF3B4D43),
                    size: 18,
                  ),
                ),
              ),
              Text(
                'Explore',
                style: GoogleFonts.outfit(
                  color: _primaryText,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: _cardBg,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFCBD5E1).withOpacity(0.02 * 4),
                      blurRadius: 16,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.shopping_bag_outlined,
                  color: Color(0xFF3B4D43),
                  size: 20,
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          Text(
            'Find your next\ngreen friend',
            style: GoogleFonts.outfit(
              color: _primaryText,
              fontSize: 32,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.5,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 24),
          _buildSearchBar(),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: _cardBg,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFCBD5E1).withOpacity(0.04 * 4),
                  blurRadius: 20,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: TextField(
              controller: _searchController,
              style: GoogleFonts.inter(color: _primaryText, fontSize: 16),
              decoration: InputDecoration(
                hintText: 'Search plants...',
                hintStyle: GoogleFonts.inter(
                  color: _textSecondary,
                  fontSize: 15,
                ),
                prefixIcon: const Icon(
                  Icons.search_rounded,
                  color: Color(0xFF8B9E93),
                  size: 22,
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Container(
          width: 54,
          height: 54,
          decoration: BoxDecoration(
            color: _primaryText,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: _primaryText.withOpacity(0.2),
                blurRadius: 16,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: const Icon(Icons.tune_rounded, color: Colors.white, size: 24),
        ),
      ],
    );
  }

  Widget _buildCategories() {
    return SizedBox(
      height: 48,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          final isSelected = _selectedCategoryIndex == index;
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedCategoryIndex = index;
              });
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              decoration: BoxDecoration(
                color: isSelected ? _accentGreen : Colors.transparent,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: isSelected
                      ? _accentGreen
                      : _textSecondary.withOpacity(0.2),
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                _categories[index],
                style: GoogleFonts.inter(
                  color: isSelected ? Colors.white : _textSecondary,
                  fontSize: 15,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildPlantList() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      physics: const BouncingScrollPhysics(),
      itemCount: _samplePlants.length,
      itemBuilder: (context, index) {
        return _buildModernPlantCard(_samplePlants[index], index);
      },
    );
  }

  Widget _buildModernPlantCard(Map<String, dynamic> plant, int index) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                PlantDetailPage(plantData: plant, isFromGarden: false),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 24),
        height: 160,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // Background Card
            Positioned(
              right: 0,
              left: 40,
              top: 20,
              bottom: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: _cardBg,
                  borderRadius: BorderRadius.circular(32),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFCBD5E1).withOpacity(0.04 * 4),
                      blurRadius: 30,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                padding: const EdgeInsets.only(
                  left: 100, // space for image
                  right: 20,
                  top: 20,
                  bottom: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      plant['name'],
                      style: GoogleFonts.outfit(
                        color: _primaryText,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        height: 1.2,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      plant['category'],
                      style: GoogleFonts.inter(
                        color: _textSecondary,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: _accentGreen.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            plant['difficulty'],
                            style: GoogleFonts.inter(
                              color: const Color(0xFF4FA976),
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Image overlap
            Positioned(
              left: 0,
              top: 0,
              bottom: 20,
              width: 120,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 20,
                      offset: const Offset(4, 10),
                    ),
                  ],
                  image: DecorationImage(
                    image: NetworkImage(plant['image']),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),

            // Add button
            Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: _primaryText,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomRight: Radius.circular(32),
                  ),
                ),
                child: const Icon(
                  Icons.add_rounded,
                  color: Colors.white,
                  size: 24,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
