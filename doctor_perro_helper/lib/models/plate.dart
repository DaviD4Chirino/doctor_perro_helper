import 'package:doctor_perro_helper/models/ingredient.dart';
import 'package:doctor_perro_helper/models/plate_quantity.dart';
import 'package:doctor_perro_helper/models/side_dish.dart';
import 'package:doctor_perro_helper/utils/string_transform.dart';

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
      list.add(ingredient.title);
    }

    return formatDuplicatedSentences(list.join(", "));
  }

  double get price {
    double amount = 0;
    amount += cost;

    ingredients.map((ingredient) => amount += ingredient.cost);
    extras?.map((extra) => amount += extra.cost);

    return amount;
  }

  String code;
  String title;
  List<Ingredient> ingredients;
  List<SideDish>? extras = [];
  double cost;
  PlateQuantity quantity;
}
