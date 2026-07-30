import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:botaniq/l10n/app_localizations.dart';
import '../../../../core/services/openai_service.dart';
import '../../../../core/services/sick_plant_service.dart';

class AiChatPage extends StatefulWidget {
  final String plantName;
  final String? plantId;
  final String? plantImageUrl;
  final String? sickPlantId; // Mevcut hasta bitkiye devam etmek için

  const AiChatPage({
    super.key,
    required this.plantName,
    this.plantId,
    this.plantImageUrl,
    this.sickPlantId,
  });

  @override
  State<AiChatPage> createState() => _AiChatPageState();
}

class _AiChatPageState extends State<AiChatPage> {
  final Color _primaryGreen = const Color(0xFF4FA976);
  final Color _bgHint = const Color(0xFFF9FAF9);

  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final ImagePicker _picker = ImagePicker();

  final List<Map<String, dynamic>> _messages = [];
  bool _isLoading = false;
  String? _currentSickPlantId;
  late String _displayPlantName;
  bool _welcomeInitialized = false;

  @override
  void initState() {
    super.initState();
    _currentSickPlantId = widget.sickPlantId;
    _displayPlantName = widget.plantName;

    if (_currentSickPlantId != null) {
      _loadChatHistory();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_currentSickPlantId == null && !_welcomeInitialized) {
      final l10n = AppLocalizations.of(context)!;
      _messages.add({
        'content': l10n.chatWelcome(widget.plantName),
        'role': 'assistant',
        'image_url': null,
      });
      _welcomeInitialized = true;
    }
  }

  Future<void> _loadChatHistory() async {
    try {
      final data = await Supabase.instance.client
          .from('diagnosis_messages')
          .select()
          .eq('sick_plant_id', _currentSickPlantId!)
          .order('created_at', ascending: true);

      if (mounted) {
        setState(() {
          _messages.clear();
          for (final msg in data) {
            _messages.add({
              'content': msg['content'] ?? '',
              'role': msg['role'] ?? 'assistant',
              'image_url': msg['image_url'],
            });
          }
          if (_messages.isEmpty) {
            final l10n = AppLocalizations.of(context)!;
            _messages.add({
              'content': l10n.chatContinueWelcome(widget.plantName),
              'role': 'assistant',
              'image_url': null,
            });
          }
        });
        _scrollToBottom();
      }
    } catch (e) {
      debugPrint("Chat geçmişi yükleme hatası: $e");
    }
  }

  Future<void> _sendMessage(String text, {String? imageBase64}) async {
    if (text.trim().isEmpty && imageBase64 == null) return;

    setState(() {
      _messages.add({
        'content': text,
        'role': 'user',
        'image_url': imageBase64 != null
            ? 'data:image/jpeg;base64,$imageBase64'
            : null,
      });
      _isLoading = true;
    });

    _messageController.clear();
    _scrollToBottom();

    try {
      // Eğer henüz hasta bitki kaydı yoksa ve fotoğraf gönderildiyse → teşhis koy
      if (imageBase64 != null && _currentSickPlantId == null) {
        await _performDiagnosis(imageBase64, text);
      } else {
        await _performChat(text, imageBase64);
      }
    } catch (e) {
      if (mounted) {
        final l10n = AppLocalizations.of(context)!;
        final message = e.toString().length > 100
            ? '${e.toString().substring(0, 100)}...'
            : e.toString();
        setState(() {
          _messages.add({
            'content': l10n.chatError(message),
            'role': 'assistant',
            'image_url': null,
          });
          _isLoading = false;
        });
        _scrollToBottom();
      }
    }
  }

  Future<void> _performDiagnosis(String imageBase64, String? userText) async {
    try {
      final result = await OpenAIService.diagnosePlant(
        imageBase64,
        plantName: widget.plantName,
      );

      if (result != null && mounted) {
        final l10n = AppLocalizations.of(context)!;
        final diagnosis = result['diagnosis'] ?? l10n.chatDiagnosisUnknown;
        final prescription = result['prescription'] ?? l10n.chatNoTreatment;
        final urgency = result['urgency'] ?? 'Orta';
        final species = _cleanIdentification(result['species']);
        final detectedName =
            _cleanIdentification(result['plant_name']) ??
            _cleanIdentification(result['name']);
        final resolvedPlantName = _resolvePlantName(
          detectedName: detectedName,
          species: species,
        );
        final careTips = (result['care_tips'] as List?)?.cast<String>() ?? [];
        final recoveryTime =
            result['recovery_time'] ?? l10n.chatRecoveryUnknown;

        // Hasta bitki kaydı oluştur
        final userId = Supabase.instance.client.auth.currentUser?.id;
        if (userId != null) {
          final sickPlantData = await SickPlantService.saveDiagnosis(
            plantId: widget.plantId,
            plantName: resolvedPlantName,
            species: species,
            imageUrl: widget.plantImageUrl,
            diagnosis: diagnosis.toString(),
            prescription: prescription.toString(),
            urgency: urgency,
          );

          _currentSickPlantId = sickPlantData['id'];

          // Mesajları DB'ye kaydet
          await _saveMessageToDb(
            userText ?? l10n.chatPhotoSent,
            'user',
            imageUrl: 'photo',
          );
        }

        final tipsText = careTips.isNotEmpty
            ? '\n\n💡 **${l10n.chatCareTips}:**\n'
                  '${careTips.map((t) => '• $t').join('\n')}'
            : '';

        final responseText =
            "🌿 **${l10n.chatPlantLabel}:** $resolvedPlantName"
            "${species == null ? '' : ' ($species)'}\n\n"
            "🔍 **${l10n.chatDiagnosisLabel}:** $diagnosis\n\n"
            "💊 **${l10n.chatTreatmentLabel}:** $prescription\n\n"
            "⚠️ **${l10n.chatUrgencyLabel}:** "
            "${_localizedUrgency(l10n, urgency)}\n\n"
            "⏱️ **${l10n.chatRecoveryLabel}:** $recoveryTime$tipsText";

        setState(() {
          _displayPlantName = resolvedPlantName;
          _messages.add({
            'content': responseText,
            'role': 'assistant',
            'image_url': null,
          });
          _isLoading = false;
        });

        // Yanıtı DB'ye kaydet
        if (_currentSickPlantId != null) {
          await _saveMessageToDb(responseText, 'assistant');
        }

        _scrollToBottom();
      }
    } catch (e) {
      rethrow;
    }
  }

  String _resolvePlantName({String? detectedName, String? species}) {
    if (!_isGenericPlantName(widget.plantName)) {
      return widget.plantName.trim();
    }
    return detectedName ??
        species ??
        AppLocalizations.of(context)!.chatUnableIdentify;
  }

  String _localizedUrgency(AppLocalizations l10n, Object? urgency) {
    switch (SickPlantService.normalizeUrgency(urgency)) {
      case 'Kritik':
        return l10n.clinicUrgencyCritical;
      case 'Düşük':
        return l10n.clinicUrgencyLow;
      default:
        return l10n.clinicUrgencyMedium;
    }
  }

  String? _cleanIdentification(Object? value) {
    final text = value?.toString().trim();
    if (text == null || text.isEmpty) return null;
    final normalized = text.toLowerCase();
    if (normalized == 'belirsiz' ||
        normalized == 'unknown' ||
        normalized == 'null' ||
        normalized == 'n/a') {
      return null;
    }
    return text;
  }

  bool _isGenericPlantName(String value) {
    final normalized = value.trim().toLowerCase();
    return normalized.isEmpty ||
        normalized == 'yeni bitki' ||
        normalized == 'new plant' ||
        normalized == 'bilinmeyen bitki' ||
        normalized == 'unknown plant' ||
        normalized == 'haşere analizi';
  }

  Future<void> _performChat(String text, String? imageBase64) async {
    try {
      // Mesaj geçmişini hazırla (son 10 mesaj)
      final recentMessages = _messages
          .skip(_messages.length > 10 ? _messages.length - 10 : 0)
          .map((m) {
            final msg = <String, dynamic>{
              'role': m['role'],
              'content': m['content'] ?? '',
            };
            if (m['image_url'] != null && m['image_url'] != 'photo') {
              msg['image_url'] = m['image_url'];
            }
            return msg;
          })
          .toList();

      final reply = await OpenAIService.chatWithDoctor(recentMessages);

      if (mounted) {
        setState(() {
          _messages.add({
            'content': reply ?? 'Yanıt alınamadı. Tekrar deneyin.',
            'role': 'assistant',
            'image_url': null,
          });
          _isLoading = false;
        });
        _scrollToBottom();

        // Mesajları DB'ye kaydet
        if (_currentSickPlantId != null) {
          await _saveMessageToDb(text, 'user');
          await _saveMessageToDb(reply ?? '', 'assistant');
        }
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> _saveMessageToDb(
    String content,
    String role, {
    String? imageUrl,
  }) async {
    if (_currentSickPlantId == null) return;
    try {
      await Supabase.instance.client.from('diagnosis_messages').insert({
        'sick_plant_id': _currentSickPlantId,
        'role': role,
        'content': content,
        'image_url': imageUrl,
      });
    } catch (e) {
      debugPrint("Mesaj kaydetme hatası: $e");
    }
  }

  Future<void> _pickAndSendImage() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 800,
        maxHeight: 800,
        imageQuality: 80,
      );

      if (image != null) {
        final bytes = await File(image.path).readAsBytes();
        final base64Image = base64Encode(bytes);
        await _sendMessage(
          AppLocalizations.of(context)!.chatAnalyzePhoto,
          imageBase64: base64Image,
        );
      }
    } catch (e) {
      debugPrint("Fotoğraf çekme hatası: $e");
    }
  }

  Future<void> _pickFromGallery() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 800,
        maxHeight: 800,
        imageQuality: 80,
      );

      if (image != null) {
        final bytes = await File(image.path).readAsBytes();
        final base64Image = base64Encode(bytes);
        await _sendMessage(
          AppLocalizations.of(context)!.chatAnalyzePhoto,
          imageBase64: base64Image,
        );
      }
    } catch (e) {
      debugPrint("Galeri hatası: $e");
    }
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: _bgHint,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Color(0xFF2C3E35),
            size: 18,
          ),
          onPressed: () => Navigator.pop(context, _currentSickPlantId != null),
        ),
        title: Column(
          children: [
            Text(
              l10n.chatDoctorTitle,
              style: GoogleFonts.outfit(
                color: const Color(0xFF2C3E35),
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              l10n.chatPatient(_displayPlantName),
              style: GoogleFonts.inter(
                color: _primaryGreen,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              itemCount: _messages.length + (_isLoading ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == _messages.length && _isLoading) {
                  return _buildTypingIndicator();
                }
                final msg = _messages[index];
                return _buildMessageBubble(
                  msg['content'] ?? '',
                  msg['role'] == 'user',
                  imageUrl: msg['image_url'],
                );
              },
            ),
          ),
          if (!_isLoading) _buildQuickReplies(),
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildTypingIndicator() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFCBD5E1).withOpacity(0.16),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: _primaryGreen,
              ),
            ),
            const SizedBox(width: 12),
            Text(
              AppLocalizations.of(context)!.chatAnalyzing,
              style: GoogleFonts.inter(
                color: const Color(0xFF8B9E93),
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageBubble(String text, bool isUser, {String? imageUrl}) {
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.78,
        ),
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isUser ? _primaryGreen : Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(24),
            topRight: const Radius.circular(24),
            bottomLeft: Radius.circular(isUser ? 24 : 4),
            bottomRight: Radius.circular(isUser ? 4 : 24),
          ),
          boxShadow: [
            if (!isUser)
              BoxShadow(
                color: const Color(0xFFCBD5E1).withOpacity(0.16),
                blurRadius: 16,
                offset: const Offset(0, 4),
              ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (imageUrl != null &&
                imageUrl != 'photo' &&
                imageUrl.startsWith('data:'))
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.memory(
                    base64Decode(imageUrl.split(',').last),
                    width: double.infinity,
                    height: 180,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      height: 80,
                      color: const Color(0xFFF1F5F9),
                      child: const Center(
                        child: Icon(Icons.image_not_supported),
                      ),
                    ),
                  ),
                ),
              ),
            Text(
              text,
              style: GoogleFonts.inter(
                color: isUser ? Colors.white : const Color(0xFF2C3E35),
                fontSize: 15,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickReplies() {
    final l10n = AppLocalizations.of(context)!;
    final quickReplies = [
      l10n.chatQuestionYellowing,
      l10n.chatQuestionTreatment,
      l10n.chatQuestionWatering,
      l10n.chatQuestionFertilizer,
    ];
    return SizedBox(
      height: 48,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: quickReplies.length,
        separatorBuilder: (context, index) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final reply = quickReplies[index];
          return GestureDetector(
            onTap: () => _sendMessage(reply),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: Text(
                reply,
                style: GoogleFonts.inter(
                  color: const Color(0xFF435A4D),
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 16, 12, 32),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFF1F5F9))),
      ),
      child: Row(
        children: [
          // Kamera butonu
          GestureDetector(
            onTap: _isLoading ? null : _pickAndSendImage,
            child: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: _primaryGreen.withOpacity(0.1),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(
                Icons.camera_alt_rounded,
                color: _isLoading ? const Color(0xFF8B9E93) : _primaryGreen,
                size: 22,
              ),
            ),
          ),
          const SizedBox(width: 8),
          // Galeri butonu
          GestureDetector(
            onTap: _isLoading ? null : _pickFromGallery,
            child: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: const Color(0xFFF1F5F9),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(
                Icons.photo_library_rounded,
                color: _isLoading
                    ? const Color(0xFF8B9E93)
                    : const Color(0xFF6E6E73),
                size: 22,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              decoration: BoxDecoration(
                color: _bgHint,
                borderRadius: BorderRadius.circular(28),
              ),
              child: TextField(
                controller: _messageController,
                enabled: !_isLoading,
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(
                    context,
                  )!.chatHint(widget.plantName),
                  hintStyle: GoogleFonts.inter(
                    color: const Color(0xFF8B9E93),
                    fontSize: 14,
                  ),
                  border: InputBorder.none,
                ),
                style: GoogleFonts.inter(
                  color: const Color(0xFF2C3E35),
                  fontSize: 15,
                ),
                onSubmitted: _isLoading ? null : _sendMessage,
              ),
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: _isLoading
                ? null
                : () => _sendMessage(_messageController.text),
            child: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: _isLoading ? const Color(0xFF8B9E93) : _primaryGreen,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: _primaryGreen.withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Icon(
                Icons.send_rounded,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
