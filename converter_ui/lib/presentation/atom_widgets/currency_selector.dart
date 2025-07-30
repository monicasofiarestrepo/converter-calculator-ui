import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:converter_ui/core/theme/dorado_colors.dart';
import 'package:converter_ui/data/providers/selector_currency_provider.dart';
import 'package:converter_ui/presentation/components/FIAT_bottom_sheet.dart';
import 'package:converter_ui/presentation/components/cripto_bottom_sheet.dart';

class CurrencySelector extends ConsumerStatefulWidget {
  const CurrencySelector({super.key});

  @override
  ConsumerState<CurrencySelector> createState() => _CurrencySelectorState();
}

class _CurrencySelectorState extends ConsumerState<CurrencySelector> {
  late bool _leftIsCrypto;

  @override
  void initState() {
    super.initState();
    _leftIsCrypto = ref.read(isLeftCryptoProvider);
  }

  void _swapCurrencies() {
    setState(() {
      _leftIsCrypto = !_leftIsCrypto;
      ref.read(isLeftCryptoProvider.notifier).state = _leftIsCrypto;
    });
  }

  void _handleFiatTap() {
    final selectedCode = ref.read(selectedFiatCurrencyCodeProvider);
    showFiatCurrencySelectorSheet(
      context: context,
      selectedCurrencyCode: selectedCode,
      onSelected: (newCode) {
        print(newCode);
        ref.read(selectedFiatCurrencyCodeProvider.notifier).state = newCode;
        ref.read(selectedFiatCurrencyFlagProvider.notifier).state = 'lib/core/assets/fiat_currencies/${newCode.toUpperCase()}.png';
      },
    );
  }

  void _handleCryptoTap() {
    final selectedCode = ref.read(selectedCryptoCurrencyCodeProvider);
    showCriptoCurrencySelectorSheet(
      context: context,
      selectedCurrencyCode: selectedCode,
      onSelected: (newCode) {
        print(newCode);
        ref.read(selectedCryptoCurrencyCodeProvider.notifier).state = newCode;
        ref.read(selectedCryptoCurrencyFlagProvider.notifier).state = 'lib/core/assets/cripto_currencies/${newCode.toUpperCase()}.png';
      },
    );
  }

  Widget _buildCurrencyColumn({
    required String label,
    required String code,
    required String flag,
    required VoidCallback onTap,
  }) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: DoradoColors.gray900,
            ),
          ),
        ),
        const SizedBox(height: 2),
        GestureDetector(
          onTap: onTap,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.asset(
                  flag,
                  width: 24,
                  height: 24,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                code,
                style: const TextStyle(
                  color: DoradoColors.gray900,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              const SizedBox(width: 4),
              const Icon(Icons.keyboard_arrow_down_rounded, size: 24, color: DoradoColors.gray900),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final fiatCode = ref.watch(selectedFiatCurrencyCodeProvider);
    final fiatFlag = ref.watch(selectedFiatCurrencyFlagProvider);
    final cryptoCode = ref.watch(selectedCryptoCurrencyCodeProvider);
    final cryptoFlag = ref.watch(selectedCryptoCurrencyFlagProvider);

    final leftWidget = _leftIsCrypto
        ? _buildCurrencyColumn(
            label: 'TENGO',
            code: cryptoCode,
            flag: cryptoFlag,
            onTap: _handleCryptoTap,
          )
        : _buildCurrencyColumn(
            label: 'TENGO',
            code: fiatCode,
            flag: fiatFlag,
            onTap: _handleFiatTap,
          );

    final rightWidget = _leftIsCrypto
        ? _buildCurrencyColumn(
            label: 'QUIERO',
            code: fiatCode,
            flag: fiatFlag,
            onTap: _handleFiatTap,
          )
        : _buildCurrencyColumn(
            label: 'QUIERO',
            code: cryptoCode,
            flag: cryptoFlag,
            onTap: _handleCryptoTap,
          );

    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Container(
          height: 45,
          decoration: BoxDecoration(
            border: Border.all(color: DoradoColors.primary, width: 2),
            borderRadius: BorderRadius.circular(999),
          ),
        ),
        Positioned(left: 20, bottom: 10, child: leftWidget),
        Positioned(right: 20, bottom: 10, child: rightWidget),
        Center(
          child: GestureDetector(
            onTap: _swapCurrencies,
            child: Container(
              width: 48,
              height: 48,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: DoradoColors.primary,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: const Icon(Icons.compare_arrows_rounded, color: Colors.white, size: 32),
            ),
          ),
        ),
      ],
    );
  }
}
