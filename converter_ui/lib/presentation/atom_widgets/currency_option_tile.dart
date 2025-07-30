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
    return ListTile(
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
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        currencyName,
        style: TextStyle(color: Colors.grey.shade600),
      ),
      trailing: selected
          ? const Icon(Icons.radio_button_checked, color: Colors.black87)
          : const Icon(Icons.radio_button_unchecked, color: Colors.grey),
    );
  }
}
