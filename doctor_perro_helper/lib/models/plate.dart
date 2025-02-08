import 'package:doctor_perro_helper/models/ingredient.dart';
import 'package:doctor_perro_helper/models/plate_quantity.dart';
import 'package:doctor_perro_helper/models/side_dish.dart';

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

    for (Ingredient ingredient in ingredients) {
      list.add(ingredient.title);
    }

    return list.join(", ");
  }

  /// The cost of the plate + their extras, ingredient cost are ignore bc
  /// Kory is an lazy MF
  double get price {
    double amount = cost;
    /* for (var ingredient in ingredients) {
      amount += ingredient.price;
    } */

    if (extras == null) {
      return amount;
    }

    for (var extra in extras!) {
      amount += extra.price;
    }

    return amount;
  }

  List<String> get extrasTitleList {
    List<String> list = [];
    if (extras == null) {
      return list;
    }

    for (SideDish extra in extras!) {
      list.add(extra.title);
    }

    return list;
  }

  String code;
  String title;
  List<Ingredient> ingredients;
  List<SideDish>? extras = [];
  double cost;
  PlateQuantity quantity;
}
