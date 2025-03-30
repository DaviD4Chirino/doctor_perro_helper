import 'package:doctor_perro_helper/models/use_shared_preferences.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part "settings.g.dart";

@riverpod
class DolarPriceNotifier extends _$DolarPriceNotifier {
  @override
  double build() {
    return UseSharedPreferences.preferences.getDouble("dolar_price") ?? 0.0;
  }

  void changePrice(double amount) {
    state = amount;
    UseSharedPreferences.preferences.setDouble("dolar_price", amount);
  }

  /// Easy calculation of the price
  double calculate(double amount) {
    return amount *
        (UseSharedPreferences.preferences.getDouble("dolar_price") ?? 60.0);
  }
}
