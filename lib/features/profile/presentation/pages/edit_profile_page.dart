import 'dart:typed_data';

import 'package:botaniq/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/services/care_notification_service.dart';
import '../../../../core/theme/app_colors.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _fullNameController = TextEditingController();
  final _nicknameController = TextEditingController();
  final _ageController = TextEditingController();
  final _emailController = TextEditingController(); // read-only reference
  final _locationController = TextEditingController();
  final _imagePicker = ImagePicker();

  bool _wateringReminders = true;
  bool _fertilizerReminders = true;
  String _avatarUrl = '';
  Uint8List? _selectedAvatarBytes;
  String _avatarExtension = 'jpg';

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
      Map<String, dynamic>? data;
      for (final table in const ['users', 'profiles']) {
        try {
          data = await Supabase.instance.client
              .from(table)
              .select()
              .eq('id', user.id)
              .maybeSingle();
          if (data != null) break;
        } catch (_) {
          // Eski kurulumlarda profil tablosu farklı olabilir.
        }
      }

      if (data != null && mounted) {
        final profile = data;
        setState(() {
          _fullNameController.text = profile['full_name'] ?? '';
          _nicknameController.text = profile['nickname'] ?? '';
          _ageController.text = profile['age']?.toString() ?? '';
          _emailController.text = profile['email'] ?? user.email ?? '';
          _locationController.text = profile['location'] ?? '';
          _avatarUrl = profile['avatar_url']?.toString() ?? '';
          _wateringReminders = profile['watering_reminders'] ?? true;
          _fertilizerReminders = profile['fertilizer_reminders'] ?? true;
        });
      } else {
        _emailController.text = user.email ?? '';
      }
    } catch (e) {
      if (mounted) {
        final l10n = AppLocalizations.of(context)!;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.profileLoadError(e.toString()))),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _saveProfile() async {
    final l10n = AppLocalizations.of(context)!;
    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) return;

    final ageText = _ageController.text.trim();
    final age = ageText.isEmpty ? null : int.tryParse(ageText);
    if (ageText.isNotEmpty && (age == null || age < 1 || age > 120)) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10n.profileAgeValidation)));
      return;
    }

    setState(() => _isSaving = true);

    try {
      final avatarUrl = await _uploadAvatarIfNeeded(user.id);
      final nickname = _nicknameController.text.trim().replaceFirst(
        RegExp(r'^@+'),
        '',
      );
      final payload = <String, dynamic>{
        'id': user.id,
        'full_name': _fullNameController.text.trim(),
        'email': _emailController.text.trim(),
        'location': _locationController.text.trim(),
        'nickname': nickname.isEmpty ? null : nickname,
        'age': age,
        'avatar_url': avatarUrl,
        'watering_reminders': _wateringReminders,
        'fertilizer_reminders': _fertilizerReminders,
      };

      await Supabase.instance.client.from('users').upsert(payload);
      await Supabase.instance.client.from('profiles').upsert({
        ...payload,
        'updated_at': DateTime.now().toUtc().toIso8601String(),
      });
      await Supabase.instance.client.auth.updateUser(
        UserAttributes(
          data: {
            'full_name': _fullNameController.text.trim(),
            'nickname': nickname,
            'avatar_url': avatarUrl,
          },
        ),
      );
      try {
        await CareNotificationService.instance.refreshSchedules();
      } catch (error) {
        debugPrint('Profil kaydı sonrası bildirimler yenilenemedi: $error');
      }

      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(l10n.profileUpdated)));
        Navigator.pop(context, true); // true indicates successful save
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.profileSaveError(e.toString()))),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
  }

  Future<String> _uploadAvatarIfNeeded(String userId) async {
    final bytes = _selectedAvatarBytes;
    if (bytes == null) return _avatarUrl;

    final path =
        '${userId}_profile_${DateTime.now().millisecondsSinceEpoch}.$_avatarExtension';
    await Supabase.instance.client.storage
        .from('plant-images')
        .uploadBinary(
          path,
          bytes,
          fileOptions: FileOptions(
            contentType: _avatarExtension == 'png' ? 'image/png' : 'image/jpeg',
          ),
        );
    return Supabase.instance.client.storage
        .from('plant-images')
        .getPublicUrl(path);
  }

  Future<void> _pickAvatar() async {
    final selected = await _imagePicker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1200,
      imageQuality: 86,
    );
    if (selected == null) return;

    final bytes = await selected.readAsBytes();
    final extension = selected.name.split('.').last.toLowerCase();
    if (!mounted) return;
    setState(() {
      _selectedAvatarBytes = bytes;
      _avatarExtension = extension == 'png' ? 'png' : 'jpg';
    });
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _nicknameController.dispose();
    _ageController.dispose();
    _emailController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
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
        leading: BackButton(
          color: _primaryText,
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          l10n.editProfile,
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
                child: GestureDetector(
                  onTap: _pickAvatar,
                  child: Stack(
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: _accentGreen.withValues(alpha: 0.2),
                          shape: BoxShape.circle,
                          image: _selectedAvatarBytes != null
                              ? DecorationImage(
                                  image: MemoryImage(_selectedAvatarBytes!),
                                  fit: BoxFit.cover,
                                  matchTextDirection: false,
                                )
                              : _avatarUrl.isNotEmpty
                              ? DecorationImage(
                                  image: NetworkImage(_avatarUrl),
                                  fit: BoxFit.cover,
                                  matchTextDirection: false,
                                )
                              : null,
                        ),
                        child:
                            _selectedAvatarBytes == null && _avatarUrl.isEmpty
                            ? Icon(
                                Icons.person_rounded,
                                color: _primaryText.withValues(alpha: 0.45),
                                size: 42,
                              )
                            : null,
                      ),
                      PositionedDirectional(
                        bottom: 0,
                        end: 0,
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
              ),
              const SizedBox(height: 10),
              Center(
                child: TextButton.icon(
                  onPressed: _pickAvatar,
                  icon: const Icon(Icons.add_a_photo_outlined, size: 18),
                  label: Text(l10n.profileChoosePhoto),
                ),
              ),
              const SizedBox(height: 32),

              _buildInputLabel(l10n.profileFullName),
              _buildTextField(
                _fullNameController,
                l10n.profileFullNameHint,
                Icons.person_outline_rounded,
              ),

              const SizedBox(height: 20),

              _buildInputLabel(l10n.profileNickname),
              _buildTextField(
                _nicknameController,
                l10n.profileNicknameHint,
                Icons.alternate_email_rounded,
              ),

              const SizedBox(height: 20),

              _buildInputLabel(l10n.profileAge),
              _buildTextField(
                _ageController,
                l10n.profileAgeHint,
                Icons.cake_outlined,
                keyboardType: TextInputType.number,
              ),

              const SizedBox(height: 20),

              _buildInputLabel(l10n.profileEmailReadOnly),
              _buildTextField(
                _emailController,
                l10n.profileEmailHint,
                Icons.email_outlined,
                readOnly: true,
                forceLtr: true,
              ),

              const SizedBox(height: 20),

              _buildInputLabel(l10n.profileLocation),
              _buildTextField(
                _locationController,
                l10n.profileLocationHint,
                Icons.location_on_outlined,
              ),

              const SizedBox(height: 32),

              Text(
                l10n.preferences,
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
                      l10n.notificationWateringTitle,
                      l10n.notificationWateringSubtitle,
                      _wateringReminders,
                      (val) => setState(() => _wateringReminders = val),
                    ),
                    Divider(height: 1, color: _lightBg, indent: 64),
                    _buildSwitchTile(
                      l10n.notificationFertilizerTitle,
                      l10n.notificationFertilizerSubtitle,
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
                          l10n.profileSaveChanges,
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
      padding: const EdgeInsetsDirectional.only(bottom: 8, start: 4),
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
    TextInputType? keyboardType,
    bool forceLtr = false,
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
        keyboardType: keyboardType,
        textDirection: forceLtr ? TextDirection.ltr : null,
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
