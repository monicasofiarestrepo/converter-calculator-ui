class ExchangeRateModel {
  final double fiatToCryptoExchangeRate;

  ExchangeRateModel({required this.fiatToCryptoExchangeRate});

  factory ExchangeRateModel.fromJson(Map<String, dynamic> json) {
    return ExchangeRateModel(
      fiatToCryptoExchangeRate: json['data']['byPrice']['fiatToCryptoExchangeRate']?.toDouble() ?? 0.0,
    );
  }
}
