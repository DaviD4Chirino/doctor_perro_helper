import 'package:doctor_perro_helper/models/plate.dart';
import 'package:doctor_perro_helper/models/plate_quantity.dart';
import 'package:doctor_perro_helper/models/side_dish.dart';
import 'package:doctor_perro_helper/utils/string_transform.dart';

/// This is a Plate Class with other Plates inside
class PlatePack {
  PlatePack({
    required this.code,
    required this.name,
    required this.plates,
    required this.cost,
    required this.quantity,
    this.extras,
    this.prefix = "x",
    this.suffix = "",
  });
  PlatePack amount(double amount) {
    return PlatePack(
      code: code,
      name: name,
      cost: cost,
      plates: plates,
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

  String get plateTitleList {
    List<String> list = [];
    for (var ingredient in plates) {
      list.add(ingredient.name);
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
    double amount = cost * quantity.amount;

    for (var extra in extras!) {
      amount += extra.price;
    }
    return amount;
  }

  String code;
  String name;
  List<Plate> plates;
  double cost;
  PlateQuantity quantity;
  String prefix;
  String suffix;
  List<SideDish>? extras = [];
}
