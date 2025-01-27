import 'dart:developer';

import 'package:doctor_perro_helper/models/use_shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsModel extends ChangeNotifier {
  double _dolarPrice = 0.0;

  get dolarPrice =>
      UseSharedPreferences.preferences.getDouble("dolar_price") ?? 60.0;

  /* Future<double> get dolarPrice async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    double price = preferences.getDouble("dolar_price") ?? 0.0;
    return price;
  } */

  void changeDolarPrice(double amount) async {
    UseSharedPreferences.preferences.setDouble("dolar_price", amount);
    _dolarPrice = amount;
    log("changeDolarPrice - ${UseSharedPreferences.preferences.getDouble("dolar_price")}");
    log("changeDolarPrice - ${UseSharedPreferences.preferences.getDouble("dolar_price")}");
    notifyListeners();
  }

  Future<void> fetchDolarPrice() async {
    _dolarPrice =
        UseSharedPreferences.preferences.getDouble("dolar_price") ?? 0.0;
    log("fetchDolarPrice - ${UseSharedPreferences.preferences.getDouble("dolar_price")}");
    log("fetchDolarPrice - dolarPrice: $dolarPrice");

    notifyListeners();
  }

  void init() {
    fetchDolarPrice();
  }
}
