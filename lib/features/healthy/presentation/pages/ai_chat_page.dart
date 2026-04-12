import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AiChatPage extends StatefulWidget {
  final String plantName;

  const AiChatPage({super.key, required this.plantName});

  @override
  State<AiChatPage> createState() => _AiChatPageState();
}

class _AiChatPageState extends State<AiChatPage> {
  final Color _primaryGreen = const Color(0xFF4FA976);
  final Color _bgHint = const Color(0xFFF9FAF9);

  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  final List<Map<String, dynamic>> _messages = [];

  final List<String> _quickReplies = [
    "Bu bitki ne kadar ışık sever?",
    "Yapraklarındaki sararmanın sebebi ne olabilir?",
    "Sulama periyodum nasıl olmalı?",
    "Besin takviyesi zamanı geldi mi?",
  ];

  @override
  void initState() {
    super.initState();
    // AI'ın ilk selamlama mesajı
    _messages.add({
      'text': "Merhaba! Harika bir ${widget.plantName} yetiştiriyorsun. 🌿 Onun sağlığı veya bakımıyla ilgili sana nasıl yardımcı olabilirim?",
      'isUser': false,
    });
  }

  void _sendMessage(String text) {
    if (text.trim().isEmpty) return;

    setState(() {
      _messages.add({
        'text': text,
        'isUser': true,
      });
    });

    _messageController.clear();
    _scrollToBottom();

    // Kısa bir bekleme ve yapay zekadan mock cevap
    Future.delayed(const Duration(seconds: 1), () {
      if (!mounted) return;
      setState(() {
        _messages.add({
          'text': "Şu an deneme modundayım. '${widget.plantName}' için sorduğun soruya detaylı bir cevap üretebilmem için yakında API entegrasyonum aktif olacak. Başka bir sorun var mı?",
          'isUser': false,
        });
      });
      _scrollToBottom();
    });
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgHint,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Color(0xFF2C3E35), size: 18),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          children: [
            Text(
              'AI Tesis Doktoru',
              style: GoogleFonts.outfit(
                color: const Color(0xFF2C3E35),
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              'Hasta: ${widget.plantName}',
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
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[index];
                return _buildMessageBubble(msg['text'], msg['isUser']);
              },
            ),
          ),
          _buildQuickReplies(),
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(String text, bool isUser) {
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
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
                color: const Color(0xFFCBD5E1).withOpacity(0.04 * 4),
                blurRadius: 16,
                offset: const Offset(0, 4),
              ),
          ],
        ),
        child: Text(
          text,
          style: GoogleFonts.inter(
            color: isUser ? Colors.white : const Color(0xFF2C3E35),
            fontSize: 15,
            height: 1.4,
          ),
        ),
      ),
    );
  }

  Widget _buildQuickReplies() {
    return SizedBox(
      height: 48,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: _quickReplies.length,
        separatorBuilder: (context, index) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final reply = _quickReplies[index];
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
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Color(0xFFF1F5F9)),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: _bgHint,
                borderRadius: BorderRadius.circular(28),
              ),
              child: TextField(
                controller: _messageController,
                decoration: InputDecoration(
                  hintText: '${widget.plantName} hakkında bir soru sor...',
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
                onSubmitted: _sendMessage,
              ),
            ),
          ),
          const SizedBox(width: 12),
          GestureDetector(
            onTap: () => _sendMessage(_messageController.text),
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: _primaryGreen,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: _primaryGreen.withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Icon(Icons.send_rounded, color: Colors.white, size: 20),
            ),
          ),
        ],
      ),
    );
  }
}
