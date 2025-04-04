import 'package:doctor_perro_helper/models/abstracts/plate_list.dart';
import 'package:doctor_perro_helper/models/plate.dart';
import 'package:doctor_perro_helper/models/plate_quantity.dart';
import 'package:doctor_perro_helper/models/side_dish.dart';
import 'package:doctor_perro_helper/utils/extensions/double_extensions.dart';
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
  Map<String, dynamic> toJson() => {
        "id": id,
        "code": code,
        "name": name,
        "plates": plates.map((plate) => plate.toJson()).toList(),
        "extras": extras?.map((extra) => extra.toJson()).toList(),
        "cost": cost,
        "quantity": quantity.toJson(),
        "type": "pack",
      };

  PlatePack.fromJson(Map<String, dynamic> json)
      : id = json["id"] as String,
        code = json["code"] as String,
        name = json["name"] as String,
        plates = (json["plates"] as List)
            .map((plateJson) => Plate.fromJson(plateJson))
            .toList(),
        extras = json["extras"] != null
            ? (json["extras"] as List)
                .map((extraJson) => SideDish.fromJson(extraJson))
                .toList()
            : null,
        cost = json["cost"] as double,
        quantity =
            PlateQuantity.fromJson(json["quantity"] as Map<String, dynamic>);

  PlatePack amount(
    double amount, {
    bool exponential = false,
    bool exponentialIngredient = true,

    /// If true, the ingredients (and extras) will be treated as if
    /// the amount is 1
    bool ingredientsAsSinglePlate = false,
  }) {
    double prevAmount = quantity.amount;

    return copyWith(
      plates: plates
          .map((Plate plate) => plate.amount(
                ingredientsAsSinglePlate ? plate.quantity.amount : amount,
                exponential: exponentialIngredient,
              ))
          .toList(),
      extras: extras
          ?.map((SideDish extra) => extra.amount(
                ingredientsAsSinglePlate
                    ? (extra.quantity?.amount ?? 1.0)
                    : amount,
                exponential: exponentialIngredient,
              ))
          .toList(),
      quantity: PlateQuantity(
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

  PlatePack getDifferences(PlatePack otherPack) {
    List<Plate> plateDifferences = [];
    List<SideDish>? extraDifferences;

    // Map ingredients by title for quick lookup
    /* Map<String, Ingredient> ingredientMap = {
      for (var ingredient in ingredients) ingredient.title: ingredient
    }; */
    Map<String, Plate> otherIngredientMap = {
      for (Plate plate in otherPack.plates) plate.title: plate
    };

    // Find ingredients that are in this plate but not in the other plate
    for (var plate in plates) {
      if (!otherIngredientMap.containsKey(plate.title) ||
          plate.quantity.amount !=
              otherIngredientMap[plate.title]?.quantity.amount) {
        plateDifferences.add(plate);
      }
    }

    // Find ingredients that are in the other plate but not in this plate
    /* for (var ingredient in otherPlate.ingredients) {
      if (!ingredientMap.containsKey(ingredient.title) ||
          (ingredient.quantity?.amount ?? 1.0) !=
              ingredientMap[ingredient.title]?.quantity?.amount) {
        ingredientDifferences.add(ingredient);
      }
    } */

    if (extras != null && otherPack.extras != null) {
      extraDifferences = [];

      // Map extras by name for quick lookup
      /*  Map<String, SideDish> extraMap = {
        for (var extra in extras!) extra.name: extra
      }; */
      Map<String, SideDish> otherExtraMap = {
        for (var extra in otherPack.extras!) extra.name: extra
      };

      // Find extras that are in this plate but not in the other plate
      for (var extra in extras!) {
        if (!otherExtraMap.containsKey(extra.name) ||
            (extra.quantity?.amount ?? 1.0) !=
                otherExtraMap[extra.name]?.quantity?.amount) {
          extraDifferences.add(extra);
        }
      }
    } else if (extras != null) {
      extraDifferences = List.from(extras!);
    } else if (otherPack.extras != null) {
      extraDifferences = List.from(otherPack.extras!);
    }

    return PlatePack(
      id: otherPack.id,
      code: otherPack.code,
      name: otherPack.name,
      plates: plateDifferences,
      extras: extraDifferences,
      cost:
          0.0, // Cost can be set to 0.0 or calculated based on the differences
      quantity: PlateQuantity(amount: 1), // Default quantity
    );
  }

  PlatePack get base {
    PlatePack? basePack = PlateList.getPackByCode(code);

    if (basePack == null) {
      throw Exception("This plate of code: $code does not exist in PlateList");
    }
    return basePack;
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

  String get extrasTitles {
    if (extras == null) {
      return "";
    }
    List<String> list = [];

    for (SideDish extra in extras!) {
      list.add(extra.title);
    }

    return list.join(", ");
  }

  /// [Plate] has it and [PlatePack] should too
  String get title {
    String suffix = this.quantity.suffix;
    String prefix = this.quantity.prefix;
    double amount = this.quantity.amount;
    double count = this.quantity.count;

    double quantity = count * amount;

    return amount > 1
        ? "$name $prefix${quantity.removePaddingZero()}$suffix"
        : name;
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

  List<Plate> get platesSpread {
    List<Plate> newPlates = [];
    for (Plate plate in plates) {
      newPlates.addAll(plate.spread(withExtras: false));
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
