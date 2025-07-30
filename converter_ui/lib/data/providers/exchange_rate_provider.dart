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
