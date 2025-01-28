import 'package:doctor_perro_helper/models/use_shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DolarPriceNotifier extends Notifier<double> {
  @override
  double build() {
    return 60.0;
  }
}

final dolarPriceProvider = NotifierProvider<DolarPriceNotifier, double>(() {
  return DolarPriceNotifier();
});

class SettingsModel extends ChangeNotifier {
  double get dolarPrice =>
      UseSharedPreferences.preferences.getDouble("dolar_price") ?? 60.0;
  set dolarPrice(double value) {
    dolarPrice = value;
  }

  void changeDolarPrice(double amount) async {
    UseSharedPreferences.preferences.setDouble("dolar_price", amount);
    dolarPrice = amount;
    notifyListeners();
  }

  Future<void> fetchDolarPrice() async {
    dolarPrice =
        UseSharedPreferences.preferences.getDouble("dolar_price") ?? 0.0;
    notifyListeners();
  }

  void init() {
    fetchDolarPrice();
  }
}
