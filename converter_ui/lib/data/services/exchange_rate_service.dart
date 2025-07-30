import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/exchange_rate_model.dart';

class ExchangeRateService {
  final String _baseUrl = 'https://74j6q7lg6a.execute-api.eu-west-1.amazonaws.com/stage/orderbook/public/recommendations';

  Future<ExchangeRateModel> getExchangeRate({
    required int type,
    required String cryptoCurrencyId,
    required String fiatCurrencyId,
    required String amountCurrencyId,
    required double amount,
  }) async {
    final uri = Uri.parse(_baseUrl).replace(
      queryParameters: {
        'type': type.toString(),
        'cryptoCurrencyId': cryptoCurrencyId,
        'fiatCurrencyId': fiatCurrencyId,
        'amountCurrencyId': amountCurrencyId,
        'amount': amount.toString(),
      },
    );

    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return ExchangeRateModel.fromJson(jsonData);
    } else {
      throw Exception('Error al obtener la tasa de cambio');
    }
  }
}
