import 'package:doctor_perro_helper/models/plate.dart';
import 'package:doctor_perro_helper/models/plate_quantity.dart';
import 'package:doctor_perro_helper/models/side_dish.dart';
import 'package:doctor_perro_helper/utils/string_transform.dart';

/// This is a Plate Class with other Plates inside
class PlatePack {
  PlatePack({
    required this.code,
    required this.title,
    required this.plates,
    required this.cost,
    required this.quantity,
    this.extras,
    this.prefix = "x",
    this.suffix = "",
  });

  String get plateTitleList {
    List<String> list = [];
    for (var ingredient in plates) {
      list.add(ingredient.title);
    }
    return formatDuplicatedSentences(list.join(", "));
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

  double get price {
    double amount = cost;

    for (var extra in extras!) {
      amount += extra.price;
    }
    return amount;
  }

  String code;
  String title;
  List<Plate> plates;
  double cost;
  PlateQuantity quantity;
  String prefix;
  String suffix;
  List<SideDish>? extras = [];
}
