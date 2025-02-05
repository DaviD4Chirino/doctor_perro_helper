import 'package:doctor_perro_helper/models/plate.dart';
import 'package:doctor_perro_helper/models/plate_quantity.dart';
import 'package:doctor_perro_helper/utils/string_transform.dart';

/// This is a Plate Class with other Plates inside
class PlatePack {
  PlatePack({
    required this.code,
    required this.title,
    required this.plates,
    required this.price,
    required this.quantity,
    this.prefix = "x",
    this.suffix = "",
  });

  get plateTitleList {
    List<String> list = [];
    for (var ingredient in plates) {
      list.add(ingredient.title);
    }
    return formatDuplicatedSentences(list.join(", "));
  }

  String code;
  String title;
  List<Plate> plates;
  double price;
  PlateQuantity quantity;
  String prefix;
  String suffix;
}
