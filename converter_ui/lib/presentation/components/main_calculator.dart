import 'package:flutter/material.dart';
import 'package:converter_ui/core/theme/dorado_colors.dart';
import 'package:converter_ui/presentation/atom_widgets/button.dart';
import 'package:converter_ui/presentation/atom_widgets/textfield.dart';
import 'package:converter_ui/presentation/atom_widgets/currency_selector.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:converter_ui/data/providers/selector_currency_provider.dart';

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
  double get amount => double.tryParse(amountController.text) ?? 0.0;

  double? exchangeRate;
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

    print('🔗 URL completa: $uri');

    try {
      final response = await Dio().get(uri.toString());

      print('📥 Respuesta completa: ${response.data}');

      final rate = response.data['data']?['byPrice']?['fiatToCryptoExchangeRate'];
      setState(() => exchangeRate = double.tryParse(rate.toString()));
    } catch (e) {
      setState(() => exchangeRate = null);
      debugPrint('❌ Error fetching exchange rate: $e');
    } finally {
      setState(() => loading = false);
    }
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
          color: DoradoColors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: const [
            BoxShadow(color: Colors.black12, blurRadius: 12, offset: Offset(0, 4)),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CurrencySelector(),
            const SizedBox(height: 20),
            AmountInput(
              prefix: fromCode,
              controller: amountController,
              onSuffixTap: () {},
            ),
            const SizedBox(height: 20),
            if (loading)
              const Text('Cargando tasa...')
            else ...[
              _buildSummaryRow('Tasa estimada', exchangeRate != null ? '${exchangeRate!.toStringAsFixed(2)} $toCode' : '--'),
              const SizedBox(height: 8),
              _buildSummaryRow('Recibirás', exchangeRate != null ? '${total.toStringAsFixed(2)} $toCode' : '--'),
            ],
            const SizedBox(height: 8),
            _buildSummaryRow('Tiempo estimado', '≈ 10 Min'),
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
        Text(label, style: const TextStyle(fontSize: 16, color: Colors.black87)),
        Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
      ],
    );
  }
}
