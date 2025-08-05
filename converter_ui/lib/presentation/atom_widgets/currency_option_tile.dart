import 'package:converter_ui/core/theme/dorado_colors.dart';
import 'package:flutter/material.dart';

class CurrencyOptionTile extends StatelessWidget {
  final String currencyCode;
  final String currencyName;
  final String flagAsset;
  final bool selected;
  final VoidCallback onTap;

  const CurrencyOptionTile({
    super.key,
    required this.currencyCode,
    required this.currencyName,
    required this.flagAsset,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: DoradoColors.backgroundWhite,
      child: ListTile(
        onTap: onTap,
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(
            flagAsset,
            width: 40,
            height: 40,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(
          currencyCode,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: DoradoColors.textColor,
          ),
        ),
        subtitle: Text(
          currencyName,
          style: TextStyle(color: DoradoColors.textColor),
        ),
        trailing: selected
            ? Icon(Icons.radio_button_checked, color: DoradoColors.textColor)
            : const Icon(Icons.radio_button_unchecked, color: Colors.grey),
      ),
    );
  }
}
