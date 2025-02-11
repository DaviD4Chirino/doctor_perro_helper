import 'package:doctor_perro_helper/models/ingredient.dart';
import 'package:doctor_perro_helper/models/plate_quantity.dart';
import 'package:doctor_perro_helper/models/side_dish.dart';

class Plate {
  Plate({
    required this.code,
    required this.name,
    required this.ingredients,
    required this.cost,
    required this.quantity,
    this.extras,
    this.id,
  });
  Plate amount(double amount) {
    return Plate(
      code: code,
      name: name,
      cost: cost,
      ingredients: ingredients,
      quantity: PlateQuantity(
        // count: quantity != null ? quantity?.count as double : 1,
        count: quantity.count,
        amount: amount,
        max: quantity.max,
        min: quantity.min,
        prefix: quantity.prefix,
        suffix: quantity.suffix,
      ),
    );
  }

  // double get price => (quantity.amount) * cost;

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
    double amount = cost * quantity.amount;

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

  String? id = "";
  String code;
  String name;
  List<Ingredient> ingredients;
  List<SideDish>? extras = [];
  double cost;
  PlateQuantity quantity;
}
