import 'package:doctor_perro_helper/models/plate.dart';
import 'package:doctor_perro_helper/models/plate_quantity.dart';
import 'package:doctor_perro_helper/models/side_dish.dart';
import 'package:doctor_perro_helper/utils/extensions/plate/plate_extensions.dart';
import 'package:uuid/uuid.dart';

String get uid => Uuid().v4();

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

  PlatePack amount(double amount, {bool exponential = false}) {
    // This should always be non null
    // PlatePack thisPack = PlateList.getPackByCode(code) as PlatePack;s

    double prevAmount = quantity.amount;

    return copyWith(
      plates: plates
          .map((Plate plate) => plate.amount(amount, exponential: true))
          .toList(),
      extras: extras
          ?.map((SideDish extra) => extra.amount(amount, exponential: true))
          .toList(),
      quantity: quantity.copyWith(
        amount: exponential ? prevAmount * amount : amount,
      ),
    );
  }

  PlatePack withoutExtras() => copyWith(extras: []);

  PlatePack withUniqueId() {
    return copyWith(id: uid);
  }

  void replacePlate(Plate oldPlate, Plate newPlate) {
    final index = plates.indexWhere((Plate plate) => plate.id == oldPlate.id);

    if (index != -1) {
      plates[index] = newPlate;
    }
  }

  void replaceExtra(SideDish oldExtra, SideDish newExtra) {
    if (extras == null) return;
    final index =
        extras!.indexWhere((SideDish extra) => extra.name == oldExtra.name);
    if (index != -1) {
      extras![index] = newExtra;
    }
  }

  //* If anything goes wrong, look here
  PlatePack copyWith({
    String? id,
    String? code,
    String? name,
    List<Plate>? plates,
    List<SideDish>? extras,
    double? cost,
    PlateQuantity? quantity,
  }) {
    return PlatePack(
      id: id ?? this.id,
      code: code ?? this.code,
      name: name ?? this.name,
      plates: plates ?? this.plates,
      extras: extras ?? this.extras,
      cost: cost ?? this.cost,
      quantity: quantity != null
          ? this.quantity.copyWith(
                max: quantity.max,
                min: quantity.min,
                count: quantity.count,
                amount: quantity.amount,
                prefix: quantity.prefix,
                suffix: quantity.suffix,
              )
          : this.quantity,
    );
  }

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

  /// [Plate] has it and [PlatePack] should too
  String get title => name;

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

  List<Plate> get platesSpread {
    List<Plate> newPlates = [];
    for (Plate plate in plates) {
      newPlates.addAll(plate.spread());
    }
    id = uid;
    return newPlates;
  }

  String id = "";
  String code;
  String name;
  List<Plate> plates;

  /// The monetary cost that takes to make this pack, not counting the extras
  double cost;
  PlateQuantity quantity;
  List<SideDish>? extras = [];
}
