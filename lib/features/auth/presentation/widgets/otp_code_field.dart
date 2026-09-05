import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/theme/app_colors.dart';

/// 6 haneli doğrulama kodu girişi.
///
/// Görünürde altı ayrı kutu vardır ama arkada tek bir [TextField] çalışır —
/// böylece iOS'un SMS/e-posta otomatik doldurma ve yapıştırma davranışları
/// olduğu gibi korunur, altı ayrı focus node'u senkron tutma karmaşası da
/// olmaz. Dolan kutu yumuşak bir geçişle vurgulanır; kod tamamlandığında
/// [onCompleted] bir kez tetiklenir.
class OtpCodeField extends StatefulWidget {
  const OtpCodeField({
    super.key,
    required this.controller,
    this.length = 6,
    this.onCompleted,
    this.enabled = true,
    this.hasError = false,
  });

  final TextEditingController controller;
  final int length;
  final ValueChanged<String>? onCompleted;
  final bool enabled;
  final bool hasError;

  @override
  State<OtpCodeField> createState() => _OtpCodeFieldState();
}

class _OtpCodeFieldState extends State<OtpCodeField> {
  final FocusNode _focusNode = FocusNode();
  String _lastCompleted = '';

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_handleChange);
    _focusNode.addListener(_rebuild);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_handleChange);
    _focusNode.removeListener(_rebuild);
    _focusNode.dispose();
    super.dispose();
  }

  void _rebuild() {
    if (mounted) setState(() {});
  }

  void _handleChange() {
    if (!mounted) return;
    setState(() {});
    final value = widget.controller.text;
    // Aynı kod için onCompleted'ı tekrar tekrar tetiklemiyoruz; kullanıcı
    // bir hane silip yeniden yazdığında yeniden tetiklenir.
    if (value.length == widget.length && value != _lastCompleted) {
      _lastCompleted = value;
      // Bir kare sonraya bırakıyoruz: bu geri çağrı metin değişikliği
      // bildirimi içinden geliyor ve çağıran ekran doğrulamaya başlarken
      // setState çağırıyor. Aynı karede yapılırsa "build sırasında
      // setState" istisnası oluşabiliyor.
      final callback = widget.onCompleted;
      if (callback != null) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) callback(value);
        });
      }
    } else if (value.length < widget.length) {
      _lastCompleted = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final code = widget.controller.text;
    return Semantics(
      textField: true,
      child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(widget.length, (index) {
              final filled = index < code.length;
              final isNext = index == code.length && _focusNode.hasFocus;
              final borderColor = widget.hasError
                  ? const Color(0xFFE8705A)
                  : isNext
                  ? AppColors.primary
                  : filled
                  ? AppColors.primary.withValues(alpha: 0.55)
                  : Colors.white.withValues(alpha: 0.12);

              return Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                    right: index == widget.length - 1 ? 0 : 8,
                  ),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 180),
                    curve: Curves.easeOut,
                    height: 62,
                    decoration: BoxDecoration(
                      color: filled
                          ? AppColors.primary.withValues(alpha: 0.12)
                          : Colors.white.withValues(alpha: 0.05),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: borderColor,
                        width: isNext ? 2 : 1,
                      ),
                      boxShadow: isNext
                          ? [
                              BoxShadow(
                                color: AppColors.primary.withValues(
                                  alpha: 0.25,
                                ),
                                blurRadius: 14,
                                offset: const Offset(0, 4),
                              ),
                            ]
                          : null,
                    ),
                    alignment: Alignment.center,
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 140),
                      transitionBuilder: (child, animation) => ScaleTransition(
                        scale: animation,
                        child: FadeTransition(opacity: animation, child: child),
                      ),
                      child: Text(
                        filled ? code[index] : '',
                        key: ValueKey('$index-${filled ? code[index] : ''}'),
                        style: GoogleFonts.outfit(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
          Positioned.fill(
            child: TextField(
              controller: widget.controller,
              focusNode: _focusNode,
              enabled: widget.enabled,
              autofocus: true,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.done,
              autofillHints: const [AutofillHints.oneTimeCode],
              maxLength: widget.length,
              showCursor: false,
              enableInteractiveSelection: false,
              textAlign: TextAlign.center,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              style: const TextStyle(color: Colors.transparent, fontSize: 1),
              decoration: const InputDecoration(
                counterText: '',
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                filled: false,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
