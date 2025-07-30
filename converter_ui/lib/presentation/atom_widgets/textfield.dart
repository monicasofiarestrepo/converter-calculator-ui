import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:converter_ui/core/theme/dorado_colors.dart';

class AmountInput extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      cursorColor: DoradoColors.primary,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
      ],
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
          borderSide: const BorderSide(color: DoradoColors.primary, width: 1.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: DoradoColors.primary, width: 1.5),
        ),
        prefix: GestureDetector(
          onTap: onSuffixTap,
          child: Text(
            "$prefix  ",
            style: const TextStyle(
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
