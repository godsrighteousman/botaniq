import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/theme/app_colors.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController(); // read-only reference
  final _locationController = TextEditingController();

  bool _wateringReminders = true;
  bool _fertilizerReminders = true;

  bool _isLoading = true;
  bool _isSaving = false;

  final Color _accentGreen = const Color(0xFF86D5A6);
  final Color _primaryText = const Color(0xFF2C3E35);
  final Color _textSecondary = const Color(0xFF8B9E93);
  final Color _lightBg = const Color(0xFFF9FAF9);
  final Color _cardBg = Colors.white;

  @override
  void initState() {
    super.initState();
    _fetchProfile();
  }

  Future<void> _fetchProfile() async {
    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) {
      if (mounted) setState(() => _isLoading = false);
      return;
    }

    try {
      final data = await Supabase.instance.client
          .from('users')
          .select()
          .eq('id', user.id)
          .maybeSingle();

      if (data != null && mounted) {
        setState(() {
          _fullNameController.text = data['full_name'] ?? '';
          _emailController.text = data['email'] ?? user.email ?? '';
          _locationController.text = data['location'] ?? '';
          _wateringReminders = data['watering_reminders'] ?? true;
          _fertilizerReminders = data['fertilizer_reminders'] ?? true;
        });
      } else {
        _emailController.text = user.email ?? '';
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Profil okunamadi: $e')));
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _saveProfile() async {
    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) return;

    setState(() => _isSaving = true);

    try {
      await Supabase.instance.client.from('users').upsert({
        'id': user.id,
        'full_name': _fullNameController.text.trim(),
        'email': _emailController.text.trim(),
        'location': _locationController.text.trim(),
        'watering_reminders': _wateringReminders,
        'fertilizer_reminders': _fertilizerReminders,
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profil basariyla güncellendi!')),
        );
        Navigator.pop(context, true); // true indicates successful save
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Kaydetme hatasi: $e')));
      }
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        backgroundColor: _lightBg,
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: _lightBg,
      appBar: AppBar(
        backgroundColor: _lightBg,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: _primaryText),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Edit Profile',
          style: GoogleFonts.outfit(
            color: _primaryText,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              // Avatar
              Center(
                child: Stack(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: _accentGreen.withOpacity(0.2),
                        shape: BoxShape.circle,
                        image: const DecorationImage(
                          image: NetworkImage(
                            'https://i.pravatar.cc/150?img=68',
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: const BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.camera_alt_rounded,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              _buildInputLabel('Full Name'),
              _buildTextField(
                _fullNameController,
                'Enter your full name',
                Icons.person_outline_rounded,
              ),

              const SizedBox(height: 20),

              _buildInputLabel('Email Address (Read Only)'),
              _buildTextField(
                _emailController,
                'Enter your email',
                Icons.email_outlined,
                readOnly: true,
              ),

              const SizedBox(height: 20),

              _buildInputLabel('Location'),
              _buildTextField(
                _locationController,
                'City, Country',
                Icons.location_on_outlined,
              ),

              const SizedBox(height: 32),

              Text(
                'Preferences',
                style: GoogleFonts.outfit(
                  color: _primaryText,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),

              Container(
                decoration: BoxDecoration(
                  color: _cardBg,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    _buildSwitchTile(
                      'Watering Reminders',
                      'Get notified when it\'s time to water',
                      _wateringReminders,
                      (val) => setState(() => _wateringReminders = val),
                    ),
                    Divider(height: 1, color: _lightBg, indent: 64),
                    _buildSwitchTile(
                      'Fertilizer Reminders',
                      'Seasonal feeding alerts for your plants',
                      _fertilizerReminders,
                      (val) => setState(() => _fertilizerReminders = val),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 48),

              // Save Button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _isSaving ? null : _saveProfile,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 0,
                  ),
                  child: _isSaving
                      ? const CircularProgressIndicator(color: Colors.white)
                      : Text(
                          'Save Changes',
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, left: 4),
      child: Text(
        text,
        style: GoogleFonts.inter(
          color: _textSecondary,
          fontSize: 13,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String hint,
    IconData icon, {
    bool readOnly = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: readOnly ? _cardBg.withValues(alpha: 0.5) : _cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.transparent),
      ),
      child: TextField(
        controller: controller,
        readOnly: readOnly,
        style: GoogleFonts.inter(
          color: readOnly ? _textSecondary : _primaryText,
          fontSize: 15,
        ),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: GoogleFonts.inter(
            color: _textSecondary.withValues(alpha: 0.6),
          ),
          prefixIcon: Icon(icon, color: _accentGreen, size: 20),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 16),
        ),
      ),
    );
  }

  Widget _buildSwitchTile(
    String title,
    String subtitle,
    bool value,
    ValueChanged<bool> onChanged,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: _lightBg, shape: BoxShape.circle),
            child: Icon(
              Icons.notifications_active_rounded,
              color: _accentGreen,
              size: 20,
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
                    color: _primaryText,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: GoogleFonts.inter(color: _textSecondary, fontSize: 12),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeThumbColor: Colors.white,
            activeTrackColor: _accentGreen,
            inactiveTrackColor: const Color(0xFFE2E8E4),
          ),
        ],
      ),
    );
  }
}
