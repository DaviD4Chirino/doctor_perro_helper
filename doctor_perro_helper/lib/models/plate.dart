import 'package:doctor_perro_helper/models/ingredient.dart';
import 'package:doctor_perro_helper/models/plate_quantity.dart';
import 'package:doctor_perro_helper/models/side_dish.dart';
import 'package:doctor_perro_helper/utils/string_math.dart';
import 'package:uuid/uuid.dart';

class Plate {
  Plate({
    required this.id,
    required this.code,
    required this.name,
    required this.ingredients,
    required this.cost,
    required this.quantity,
    this.extras,
  });
  String get uid => Uuid().v4();

  Plate amount(double amount) {
    // to add the extras with the same amount as the plate
    List<SideDish>? newExtras;
    if (extras != null) {
      newExtras = [];
      for (var extra in extras!) {
        newExtras.add(extra.amount((extra.quantity?.amount ?? 1) * amount));
      }
    }

    return Plate(
      id: id,
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
      extras: newExtras,
    );
  }

  Plate withUniqueId({
    List<SideDish>? extras,
  }) {
    return Plate(
      id: Uuid().v4(),
      code: code,
      name: name,
      ingredients: ingredients,
      cost: cost,
      quantity: quantity,
      extras: extras,
    );
  }

  Plate withoutExtras() {
    return Plate(
      code: code,
      name: name,
      ingredients: ingredients,
      cost: cost,
      quantity: quantity,
      id: id,
    );
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

  void replaceIngredient(Ingredient oldIngredient, Ingredient newIngredient) {
    final int index = ingredients
        .indexWhere((Ingredient ing) => ing.name == oldIngredient.name);

    if (index != -1) {
      ingredients[index] = newIngredient;
    }
  }

  void replaceExtra(SideDish oldExtra, SideDish newExtra) {
    if (extras == null) return;

    final int index =
        extras!.indexWhere((SideDish ext) => ext.name == oldExtra.name);

    if (index != -1) {
      extras![index] = newExtra;
    }
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

    /// TODO: FIX THE PRICES IN THE LIST
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

  String id = "";
  String code;
  String name;
  List<Ingredient> ingredients;
  List<SideDish>? extras = [];

  /// The monetary cost that takes to make this plate, not counting the extras
  double cost;
  PlateQuantity quantity;
}
