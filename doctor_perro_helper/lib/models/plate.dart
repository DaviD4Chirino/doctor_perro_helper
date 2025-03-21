import 'package:doctor_perro_helper/models/abstracts/plate_list.dart';
import 'package:doctor_perro_helper/models/ingredient.dart';
import 'package:doctor_perro_helper/models/plate_quantity.dart';
import 'package:doctor_perro_helper/models/side_dish.dart';
import 'package:doctor_perro_helper/utils/string_math.dart';
import 'package:uuid/uuid.dart';

String get uid => Uuid().v4();

class Plate {
  Plate({
    required this.id,
    required this.code,
    required this.name,
    required this.ingredients,
    required this.cost,
    required this.quantity,
    this.extras,
    this.modified = false,
  });

  Plate amount(double amount, {bool exponential = false}) {
    /* List<Ingredient> newIngredients = ingredients.map((ingredient) {
      return ingredient.amount((ingredient.quantity?.amount ?? 1.0) * amount);
    }).toList();

    // Update extras with the same multiplier
    List<SideDish>? newExtras;
    if (extras != null) {
      newExtras = extras!.map((extra) {
        return extra.amount((extra.quantity?.amount ?? 1.0) * amount);
      }).toList();
    } */

    double prevAmount = quantity.amount;

    return copyWith(
      ingredients: ingredients
          .map((Ingredient ing) => ing.amount(amount, exponential: true))
          .toList(),
      extras: extras
          ?.map((SideDish ing) => ing.amount(amount, exponential: true))
          .toList(),
      quantity: PlateQuantity(
        amount: exponential ? prevAmount * amount : amount,
      ),
    );
  }

  Plate withUniqueId({
    List<SideDish>? extras,
  }) {
    return copyWith(
      id: uid,
    );
  }

  Plate withoutExtras() {
    return copyWith(
      extras: [],
    );
  }

  Plate getDifferences(Plate otherPlate) {
    List<Ingredient> ingredientDifferences = [];
    List<SideDish>? extraDifferences;

    // Map ingredients by title for quick lookup
    /* Map<String, Ingredient> ingredientMap = {
      for (var ingredient in ingredients) ingredient.title: ingredient
    }; */
    Map<String, Ingredient> otherIngredientMap = {
      for (var ingredient in otherPlate.ingredients)
        ingredient.title: ingredient
    };

    // Find ingredients that are in this plate but not in the other plate
    for (var ingredient in ingredients) {
      if (!otherIngredientMap.containsKey(ingredient.title) ||
          (ingredient.quantity?.amount ?? 1.0) !=
              otherIngredientMap[ingredient.title]?.quantity?.amount) {
        ingredientDifferences.add(ingredient);
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

    if (extras != null && otherPlate.extras != null) {
      extraDifferences = [];

      // Map extras by name for quick lookup
      /*  Map<String, SideDish> extraMap = {
        for (var extra in extras!) extra.name: extra
      }; */
      Map<String, SideDish> otherExtraMap = {
        for (var extra in otherPlate.extras!) extra.name: extra
      };

      // Find extras that are in this plate but not in the other plate
      for (var extra in extras!) {
        if (!otherExtraMap.containsKey(extra.name) ||
            (extra.quantity?.amount ?? 1.0) !=
                otherExtraMap[extra.name]?.quantity?.amount) {
          extraDifferences.add(extra);
        }
      }

      // Find extras that are in the other plate but not in this plate
      /*  for (var extra in otherPlate.extras!) {
        if (!extraMap.containsKey(extra.name) ||
            (extra.quantity?.amount ?? 1.0) !=
                extraMap[extra.name]?.quantity?.amount) {
          extraDifferences.add(extra);
        }
      } */
    } else if (extras != null) {
      extraDifferences = List.from(extras!);
    } else if (otherPlate.extras != null) {
      extraDifferences = List.from(otherPlate.extras!);
    }

    return Plate(
      id: otherPlate.id,
      code: otherPlate.code,
      name: otherPlate.name,
      ingredients: ingredientDifferences,
      extras: extraDifferences,
      cost:
          0.0, // Cost can be set to 0.0 or calculated based on the differences
      quantity: PlateQuantity(amount: 1), // Default quantity
    );
  }

  void replaceIngredient(Ingredient oldIngredient, Ingredient newIngredient) {
    final int index = ingredients.indexOf(oldIngredient);

    if (index != -1) {
      // Create a new list to ensure immutability
      List<Ingredient> newIngredients = List.from(ingredients);
      newIngredients[index] = newIngredient;
      ingredients = newIngredients;
    }
  }

  void replaceExtra(SideDish oldExtra, SideDish newExtra) {
    if (extras == null) return;

    final int index =
        extras!.indexWhere((SideDish ext) => ext.name == oldExtra.name);

    if (index != -1) {
      // Create a new list to ensure immutability
      List<SideDish> newExtras = List.from(extras!);
      newExtras[index] = newExtra;
      extras = newExtras;
    }
  }

  /// Returns this same plate as its written on the [PlateList]
  Plate get base {
    Plate? basePlate = PlateList.getPlateByCode(code);

    if (basePlate == null) {
      throw Exception("This plate of code: $code does not exist in PlateList");
    }
    return basePlate;
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
  /// ????????
  double get price {
    double amount = cost * quantity.amount;

    if (extras != null) {
      for (var extra in extras!) {
        amount += extra.price;
      }
    }

    for (var ing in ingredients) {
      amount += ing.price;
    }

    return amount;
  }

  String get title {
    String suffix = this.quantity.suffix;
    String prefix = this.quantity.prefix;
    double amount = this.quantity.amount;
    double count = this.quantity.count;

    double quantity = count * amount;

    return amount > 1
        ? "$name $prefix${removePaddingZero(quantity.toString())}$suffix"
        : name;
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

  List<Ingredient> get modifiedIngredients {
    List<Ingredient> modifiedIng = [];
    for (Ingredient ingredient in ingredients) {
      if (ingredient.title != ingredient.base.title) {
        modifiedIng.add(ingredient);
      }
    }
    return modifiedIng;
  }

  Plate copyWith({
    String? id,
    String? code,
    String? name,
    List<Ingredient>? ingredients,
    List<SideDish>? extras,
    double? cost,
    PlateQuantity? quantity,
  }) {
    return Plate(
      id: id ?? this.id,
      code: code ?? this.code,
      name: name ?? this.name,
      ingredients: ingredients ?? this.ingredients,
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

  String id = "";
  String code;
  String name;
  List<Ingredient> ingredients;
  List<SideDish>? extras = [];

  /// The monetary cost that takes to make this plate, not counting the extras
  double cost;
  PlateQuantity quantity;

  /// To be set manually when modifying this plate
  bool modified;
}
