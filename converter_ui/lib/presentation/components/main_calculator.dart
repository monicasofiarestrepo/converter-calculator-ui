import 'package:flutter/material.dart';
import 'package:converter_ui/core/theme/dorado_colors.dart';
import 'package:converter_ui/presentation/atom_widgets/button.dart';
import 'package:converter_ui/presentation/atom_widgets/textfield.dart';
import 'package:converter_ui/presentation/atom_widgets/currency_selector.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';

final exchangeRateProvider = FutureProvider.family<double, ExchangeRateParams>((ref, params) async {
  final response = await Dio().get(
    'https://74j6q7lg6a.execute-api.eu-west-1.amazonaws.com/stage/orderbook/public/recommendations',
    queryParameters: {
      'type': params.type,
      'cryptoCurrencyId': params.cryptoCurrencyId,
      'fiatCurrencyId': params.fiatCurrencyId,
      'amount': params.amount,
      'amountCurrencyId': params.amountCurrencyId,
    },
  );

  final rate = response.data['data']['byPrice']['fiatToCryptoExchangeRate'];
  return double.tryParse(rate.toString()) ?? 0.0;
});

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
  final amountController = TextEditingController(text: '5.00');

  String fromCode = 'USDT';
  String toCode = 'VES';
  String fromFlag = 'lib/core/assets/cripto_currencies/USDT.png';
  String toFlag = 'lib/core/assets/fiat_currencies/VES.png';

  String selectedCurrency = 'VES';
  String selectedCriptoCode = 'USDT';

  double get amount => double.tryParse(amountController.text) ?? 0.0;


  @override
  Widget build(BuildContext context) {
    final params = ExchangeRateParams(
      type: 0, // 0 = CRYPTO -> FIAT
      cryptoCurrencyId: selectedCriptoCode,
      fiatCurrencyId: selectedCurrency,
      amount: amount,
      amountCurrencyId: fromCode,
    );

    final rateAsync = ref.watch(exchangeRateProvider(params));

    return Center(
      child: Container(
        margin: const EdgeInsets.all(24),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: DoradoColors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 12,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CurrencySelector(),
            const SizedBox(height: 20),
            AmountInput(
              prefix: fromCode,
              controller: amountController,
              onSuffixTap: () {},
            ),
            const SizedBox(height: 20),
            rateAsync.when(
              data: (rate) {
                final total = rate * amount;
                return Column(
                  children: [
                    _buildSummaryRow('Tasa estimada', '${rate.toStringAsFixed(2)} $toCode'),
                    const SizedBox(height: 8),
                    _buildSummaryRow('Recibirás', '${total.toStringAsFixed(2)} $toCode'),
                  ],
                );
              },
              loading: () => const Text('Cargando tasa...'),
              error: (e, _) => _buildSummaryRow('Error', 'No se pudo calcular'),
            ),
            const SizedBox(height: 8),
            _buildSummaryRow('Tiempo estimado', '≈ 10 Min'),
            const SizedBox(height: 24),
            DoradoButton(
              text: 'Cambiar',
              onTap: () {
                // ejecutar lógica de cambio
              },
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
        Text(label, style: const TextStyle(fontSize: 16, color: Colors.black87)),
        Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
      ],
    );
  }
}
