import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:converter_ui/core/theme/dorado_colors.dart';

final isDarkModeActivatedProvider = StateProvider<bool>((ref) {
  DoradoColors.setLightTheme(); 
  return false;
});
