import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedFiatCurrencyCodeProvider = StateProvider<String>((ref) => 'VES');
final selectedFiatCurrencyFlagProvider = StateProvider<String>((ref) => 'lib/core/assets/fiat_currencies/VES.png');

final selectedCryptoCurrencyCodeProvider = StateProvider<String>((ref) => 'USDT');
final selectedCryptoCurrencyFlagProvider = StateProvider<String>((ref) => 'lib/core/assets/cripto_currencies/TATUM-TRON-USDT.png');

final isLeftCryptoProvider = StateProvider<bool>((ref) => true);
