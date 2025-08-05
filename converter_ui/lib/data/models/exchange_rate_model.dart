class ExchangeRateModel {
  final ByPrice byPrice;

  ExchangeRateModel({required this.byPrice});

  factory ExchangeRateModel.fromJson(Map<String, dynamic> json) {
    final byPriceJson = json['data']?['byPrice'];
    if (byPriceJson == null) {
      throw Exception('Missing "byPrice" in response');
    }

    return ExchangeRateModel(
      byPrice: ByPrice.fromJson(byPriceJson),
    );
  }
}

class ByPrice {
  final String offerId;
  final String cryptoCurrencyId;
  final String fiatCurrencyId;
  final String fiatToCryptoExchangeRate;
  final String description;
  final User user;
  final OfferMakerStats offerMakerStats;

  ByPrice({
    required this.offerId,
    required this.cryptoCurrencyId,
    required this.fiatCurrencyId,
    required this.fiatToCryptoExchangeRate,
    required this.description,
    required this.user,
    required this.offerMakerStats,
  });

  factory ByPrice.fromJson(Map<String, dynamic> json) {
    return ByPrice(
      offerId: json['offerId'] ?? '',
      cryptoCurrencyId: json['cryptoCurrencyId'] ?? '',
      fiatCurrencyId: json['fiatCurrencyId'] ?? '',
      fiatToCryptoExchangeRate: json['fiatToCryptoExchangeRate'] ?? '',
      description: json['description'] ?? '',
      user: User.fromJson(json['user'] ?? {}),
      offerMakerStats: OfferMakerStats.fromJson(json['offerMakerStats'] ?? {}),
    );
  }
}

class User {
  final String id;
  final String username;

  User({
    required this.id,
    required this.username,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? '',
      username: json['username'] ?? '',
    );
  }
}

class OfferMakerStats {
  final double releaseTime;
  final double payTime;
  final double responseTime;

  OfferMakerStats({
    required this.releaseTime,
    required this.payTime,
    required this.responseTime,
  });

  factory OfferMakerStats.fromJson(Map<String, dynamic> json) {
    return OfferMakerStats(
      releaseTime: (json['releaseTime'] as num?)?.toDouble() ?? 0.0,
      payTime: (json['payTime'] as num?)?.toDouble() ?? 0.0,
      responseTime: (json['responseTime'] as num?)?.toDouble() ?? 0.0,
    );
  }
}
