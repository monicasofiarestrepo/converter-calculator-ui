import 'package:flutter/material.dart';
import 'package:converter_ui/core/theme/dorado_colors.dart';
import 'package:converter_ui/presentation/atom_widgets/button.dart';
import 'package:converter_ui/presentation/atom_widgets/textfield.dart';
import 'package:converter_ui/presentation/atom_widgets/currency_selector.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:converter_ui/data/providers/selector_currency_provider.dart';
import 'package:intl/intl.dart';

class ExchangeRateParams {
  final int type;
  final String cryptoCurrencyId;
  final String fiatCurrencyId;
  final double amount;
  final String amountCurrencyId;

  ExchangeRateParams({
    required this.type,
    required this.cryptoCurrencyId,
    required this.fiatCurrencyId,
    required this.amount,
    required this.amountCurrencyId,
  });
}

class MainCalculator extends ConsumerStatefulWidget {
  const MainCalculator({super.key});

  @override
  ConsumerState<MainCalculator> createState() => _MainCalculatorState();
}

class _MainCalculatorState extends ConsumerState<MainCalculator> {
  final numberFormat = NumberFormat.decimalPattern('es');
  late final TextEditingController amountController;
  double get amount {
  final rawText = amountController.text.replaceAll(',', '');
  return double.tryParse(rawText) ?? 0.0;
}


  double? exchangeRate;
  double? estimatedTime;
  bool loading = false;

Future<void> _fetchExchangeRate() async {
  setState(() => loading = true);

  final isLeftCrypto = ref.read(isLeftCryptoProvider);
  final selectedFIATCode = ref.read(selectedFiatCurrencyCodeProvider);
  final selectedCriptoCode = ref.read(selectedCryptoCurrencyCodeProvider);

  final fromCode = isLeftCrypto ? selectedCriptoCode : selectedFIATCode;

  final cryptoCurrencyId = selectedCriptoCode == 'USDT' ? 'TATUM-TRON-USDT' : selectedCriptoCode;
  final amountCurrencyId = fromCode == 'USDT' ? 'TATUM-TRON-USDT' : fromCode;

  final queryParams = {
    'type': isLeftCrypto ? 0 : 1,
    'cryptoCurrencyId': cryptoCurrencyId,
    'fiatCurrencyId': selectedFIATCode,
    'amount': amount,
    'amountCurrencyId': amountCurrencyId,
  };

  final uri = Uri.https(
    '74j6q7lg6a.execute-api.eu-west-1.amazonaws.com',
    '/stage/orderbook/public/recommendations',
    queryParams.map((k, v) => MapEntry(k, v.toString())),
  );

  try {
    final response = await Dio().get(uri.toString());
    final data = response.data['data'];
    final rate = data?['byPrice']?['fiatToCryptoExchangeRate'];

    if (data == null || rate == null) {
      if(mounted) {
        _showError(context, 'No se pudo obtener la tasa de cambio para esta combinación. :( \nPor favor intenta con otro valor.');
      }
      setState(() {
        exchangeRate = null;
        estimatedTime = null;
      });
      return;
    }

    final releaseTime = (data['byPrice']?['offerMakerStats']?['releaseTime'] as num?)?.toDouble() ?? 0.0;
    final payTime = (data['byPrice']?['offerMakerStats']?['payTime'] as num?)?.toDouble() ?? 0.0;

    setState(() {
      exchangeRate = double.tryParse(rate.toString());
      estimatedTime = releaseTime + payTime;
    });
  } catch (e) {
    setState(() {
      exchangeRate = null;
      estimatedTime = null;
    });
    if(mounted) {
      _showError(context, 'Ocurrió un error al consultar la tasa de cambio.');
    }
  } finally {
    setState(() => loading = false);
  }
}


  void _resetCalculator() {
    setState(() {
      exchangeRate = null;
      estimatedTime = null;

      final isLeftCrypto = ref.read(isLeftCryptoProvider);
      final currencyCode = isLeftCrypto ? ref.read(selectedCryptoCurrencyCodeProvider) : ref.read(selectedFiatCurrencyCodeProvider);

      amountController.text = getDefaultAmountForCurrency(currencyCode);
    });
  }

  String getDefaultAmountForCurrency(String currencyCode) {
    switch (currencyCode.toUpperCase()) {
      case 'COP':
        return '20000';
      case 'VES':
        return '180';
      case 'PEN':
        return '30';
      case 'BRL':
        return '25';
      case 'TATUM-TRON-USDT':
      case 'USDT':
        return '5';
      default:
        return '5';
    }
  }

  @override
  void initState() {
    super.initState();

    final isLeftCrypto = ref.read(isLeftCryptoProvider);
    final currencyCode = isLeftCrypto ? ref.read(selectedCryptoCurrencyCodeProvider) : ref.read(selectedFiatCurrencyCodeProvider);

    amountController = TextEditingController(
      text: getDefaultAmountForCurrency(currencyCode),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isLeftCrypto = ref.watch(isLeftCryptoProvider);
    final selectedFIATCode = ref.watch(selectedFiatCurrencyCodeProvider);
    final selectedCriptoCode = ref.watch(selectedCryptoCurrencyCodeProvider);

    final fromCode = isLeftCrypto ? selectedCriptoCode : selectedFIATCode;
    final toCode = isLeftCrypto ? selectedFIATCode : selectedCriptoCode;

    final total = (exchangeRate ?? 0) * amount;

    return Center(
      child: Container(
        margin: const EdgeInsets.all(24),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: DoradoColors.backgroundWhite,
          borderRadius: BorderRadius.circular(24),
          boxShadow: const [
            BoxShadow(color: Colors.black12, blurRadius: 12, offset: Offset(0, 4)),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CurrencySelector(
              onSwap: _resetCalculator,
              onChanged: _resetCalculator,
            ),
            const SizedBox(height: 20),
            AmountInput(
              prefix: fromCode,
              controller: amountController,
              onSuffixTap: () {},
            ),
            const SizedBox(height: 20),
            if (loading)
             CircularProgressIndicator(color: DoradoColors.primary)
            else ...[
              _buildSummaryRow(
                'Tasa estimada',
                exchangeRate != null ? '${numberFormat.format(exchangeRate)} $toCode' : '--',
              ),
              const SizedBox(height: 8),
              _buildSummaryRow('Recibirás', exchangeRate != null ? '${numberFormat.format(total)} $toCode' : '--'),
              const SizedBox(height: 8),
              _buildSummaryRow('Tiempo estimado', '≈ ${estimatedTime?.toStringAsFixed(0) ?? '--'} Min'),
            ],
            const SizedBox(height: 24),
            DoradoButton(
              text: 'Cambiar',
              onTap: _fetchExchangeRate,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style:  TextStyle(fontSize: 16,fontWeight: FontWeight.w400, color: DoradoColors.mutedTextColor)),
        Text(value, style:  TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: DoradoColors.textColor)),
      ],
    );
  }

  void _showError(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: DoradoColors.error,
      duration: const Duration(seconds: 3),
    ),
  );
}

}
