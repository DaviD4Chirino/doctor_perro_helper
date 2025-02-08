import 'dart:developer';

import 'package:doctor_perro_helper/models/ingredient.dart';
import 'package:doctor_perro_helper/models/plate_quantity.dart';
import 'package:doctor_perro_helper/models/side_dish.dart';
import 'package:doctor_perro_helper/utils/string_math.dart';

class Plate {
  Plate({
    required this.code,
    required this.title,
    required this.ingredients,
    required this.cost,
    required this.quantity,
    this.extras,
  });

  String get ingredientsTitles {
    List<String> list = [];

    for (var ingredient in ingredients) {
      String suffix = ingredient.quantity?.suffix ?? "";
      String prefix = ingredient.quantity?.prefix ?? "";
      double amount = ingredient.quantity?.amount ?? 1.0;
      double count = ingredient.quantity?.count ?? 1.0;

      double quantity = count * amount;

      list.add(amount > 1.0
          ? "${ingredient.title} $prefix${removePaddingZero(quantity.toString())}$suffix"
          : ingredient.title);
    }

    return list.join(", ");
  }

  double get price {
    double amount = 0;
    amount += cost;
    for (var ingredient in ingredients) {
      amount += ingredient.price;
    }
    if (extras == null) {
      return amount;
    }

    for (var extra in extras!) {
      amount += extra.price;
    }

    return amount;
  }

  String code;
  String title;
  List<Ingredient> ingredients;
  List<SideDish>? extras = [];
  double cost;
  PlateQuantity quantity;
}
