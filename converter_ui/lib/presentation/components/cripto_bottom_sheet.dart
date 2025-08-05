import 'package:converter_ui/core/theme/dorado_colors.dart';
import 'package:flutter/material.dart';
import 'package:converter_ui/presentation/atom_widgets/currency_option_tile.dart';

void showCriptoCurrencySelectorSheet({
  required BuildContext context,
  required String selectedCurrencyCode,
  required void Function(String newCode) onSelected,
}) {
  final criptoCurrencies = [
    {
      'code': 'USDT',
      'name': 'Tether (USDT)',
      'flag': 'lib/core/assets/cripto_currencies/TATUM-TRON-USDT.png',
    },
  ];

  showModalBottomSheet(
    context: context,
    backgroundColor: DoradoColors.backgroundWhite,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            Text(
              'CRIPTO',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: DoradoColors.textColor),
            ),
            const SizedBox(height: 12),
            ...criptoCurrencies.map((currency) {
              return CurrencyOptionTile(
                currencyCode: currency['code']!,
                currencyName: currency['name']!,
                flagAsset: currency['flag']!,
                selected: selectedCurrencyCode == currency['code'],
                onTap: () {
                  onSelected(currency['code']!);
                  Navigator.pop(context);
                },
              );
            }),
            const SizedBox(height: 8),
          ],
        ),
      );
    },
  );
}
