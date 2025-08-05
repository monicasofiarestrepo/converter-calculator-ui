import 'package:flutter/material.dart';
import 'package:converter_ui/core/theme/dorado_colors.dart';
import 'package:intl/intl.dart';

class AmountInput extends StatefulWidget {
  final String prefix;
  final VoidCallback onSuffixTap;
  final TextEditingController controller;

  const AmountInput({
    super.key,
    required this.prefix,
    required this.onSuffixTap,
    required this.controller,
  });

  @override
  State<AmountInput> createState() => _AmountInputState();
}

class _AmountInputState extends State<AmountInput> {
  final NumberFormat numberFormat = NumberFormat('#,##0.##', 'en_US');
  bool _isFormatting = false;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_formatText);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_formatText);
    super.dispose();
  }

  void _formatText() {
    if (_isFormatting) return;

    final original = widget.controller.text;

    // Permitir puntos decimales incompletos como "5." o "1,000.2"
    if (original.endsWith('.') || original.contains(RegExp(r'\.\d{0,2}$'))) {
      return;
    }

    _isFormatting = true;

    // Limpiar comas (miles) para parsear
    final cleanText = original.replaceAll(',', '');

    final number = double.tryParse(cleanText);
    if (number != null) {
      final formatted = numberFormat.format(number);
      widget.controller.value = TextEditingValue(
        text: formatted,
        selection: TextSelection.collapsed(offset: formatted.length),
      );
    }

    _isFormatting = false;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      cursorColor: DoradoColors.primary,
      style: const TextStyle(
        fontSize: 16,
        color: Colors.black,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide:  BorderSide(color: DoradoColors.primary, width: 1.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide:  BorderSide(color: DoradoColors.primary, width: 1.5),
        ),
        prefix: GestureDetector(
          onTap: widget.onSuffixTap,
          child: Text(
            "${widget.prefix}  ",
            style:  TextStyle(
              color: DoradoColors.primary,
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
