import 'package:doctor_perro_helper/models/plate.dart';
import 'package:doctor_perro_helper/models/plate_quantity.dart';
import 'package:doctor_perro_helper/models/side_dish.dart';

class PlatePack {
  PlatePack({
    required this.code,
    required this.name,
    required this.plates,
    required this.cost,
    required this.quantity,
    this.extras,
    this.id = "",
  });

  PlatePack amount(double amount) {
    List<SideDish>? newExtras;
    List<Plate> newPlates = [];

    if (extras != null) {
      newExtras = [];
      for (var extra in extras!) {
        newExtras.add(extra.amount((extra.quantity?.amount ?? 1) * amount));
      }
    }

    for (Plate plate in plates) {
      newPlates.add(plate.amount(plate.quantity.amount * amount));
    }

    return PlatePack(
      code: code,
      name: name,
      cost: cost,
      plates: newPlates,
      quantity: PlateQuantity(
        count: quantity.count,
        amount: amount,
        max: quantity.max,
        min: quantity.min,
        prefix: quantity.prefix,
        suffix: quantity.suffix,
      ),
      extras: newExtras,
    );
  }

  PlatePack withoutExtras() => PlatePack(
      code: code,
      name: name,
      plates: plates,
      cost: cost,
      quantity: quantity,
      id: id);

  String get plateTitleList {
    List<String> list = [];
    for (var plate in plates) {
      list.add(plate.title);
    }
    return list.join(", ");
  }

  String get plateCodeList {
    List<String> list = [];
    for (var plate in plates) {
      list.add(plate.code);
    }
    return list.join(", ");
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
    double totalAmount = cost * quantity.amount;

    for (Plate plate in plates) {
      totalAmount += plate.price;
    }

    if (extras != null) {
      for (var extra in extras!) {
        totalAmount += extra.price;
      }
    }
    return totalAmount;
  }

  String id;
  String code;
  String name;
  List<Plate> plates;

  /// The monetary cost that takes to make this pack, not counting the extras
  double cost;
  PlateQuantity quantity;
  List<SideDish>? extras = [];
}
