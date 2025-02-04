import 'package:doctor_perro_helper/models/ingredient.dart';
import 'package:doctor_perro_helper/models/plate_quantity.dart';
import 'package:doctor_perro_helper/utils/string_transform.dart';

class Plate {
  Plate({
    required this.code,
    required this.title,
    required this.ingredients,
    required this.price,
    required this.quantity,
    this.prefix = "x",
    this.suffix = "",
  });

  String get ingredientsTitles {
    List<String> list = [];
    for (var ingredient in ingredients) {
      list.add(ingredient.title);
    }

    return formatDuplicatedSentences(list.join(", "));
  }

  String code;
  String title;
  List<Ingredient> ingredients;
  double price;
  PlateQuantity quantity;
  String prefix;
  String suffix;
}
