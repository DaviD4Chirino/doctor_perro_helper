import 'package:doctor_perro_helper/models/abstracts/ingredients_list.dart';
import 'package:doctor_perro_helper/models/plate_quantity.dart';
import 'package:doctor_perro_helper/models/side_dish.dart';
import 'package:doctor_perro_helper/utils/string_math.dart';

class Ingredient {
  Ingredient({
    required this.name,
    required this.cost,
    this.maxName = "",
    this.minName = "",
    this.quantity,
    this.quantifiable = true,
  });

  Map<String, dynamic> toJson() => {
        "name": name,
        "cost": cost,
        "max-name": maxName,
        "min-name": minName,
        "quantity": quantity?.toJson(),
        "quantifiable": quantifiable,
      };

  Ingredient.fromJson(Map<String, dynamic> json)
      : name = json["name"] as String,
        cost = json["cost"] as double,
        maxName = json["max-name"] as String,
        minName = json["min-name"] as String,
        quantity = json["quantity"] != null
            ? PlateQuantity.fromJson(json["quantity"])
            : null,
        quantifiable = json["quantifiable"] as bool;

  /// Returns this same [Ingredient] with the initial amount changed
  Ingredient amount(double amount, {bool exponential = false}) {
    double prevAmount = quantity?.amount ?? 1.0;

    return copyWith(
      quantity: quantity?.copyWith(
          amount: exponential ? prevAmount * amount : amount),
    );
  }

  SideDish toSideDish() {
    return SideDish(
      name: name,
      cost: cost,
      quantity: quantity,
      maxName: maxName,
      minName: minName,
    );
  }

  Ingredient copyWith({
    String? name,
    double? cost,
    String? maxName,
    String? minName,
    PlateQuantity? quantity,
  }) {
    return Ingredient(
      name: name ?? this.name,
      cost: cost ?? this.cost,
      maxName: maxName ?? this.maxName,
      minName: minName ?? this.minName,
      quantity: quantity ?? this.quantity,
    );
  }

  Ingredient get base => IngredientsList.getByCode(name)!;

  bool get hasChanged => IngredientsList.getByCode(name) != null
      ? (IngredientsList.getByCode(name)!.quantity?.amount ?? 1.0) !=
          (quantity?.amount ?? 1.0)
      : false;

  double get price => cost * (quantity?.amount ?? 1);

  String get title {
    String suffix = this.quantity?.suffix ?? "";
    String prefix = this.quantity?.prefix ?? "";
    double amount = this.quantity?.amount ?? 1.0;
    double count = this.quantity?.count ?? 1.0;

    double quantity = count * amount;

    if (maxName.isNotEmpty &&
        this.quantity != null &&
        amount >= this.quantity!.max.toDouble()) {
      return maxName;
    }
    if (minName.isNotEmpty &&
        this.quantity != null &&
        amount <= this.quantity!.min.toDouble()) {
      return minName;
    }

    return amount > 1
        ? "$name $prefix${removePaddingZero(quantity.toString())}$suffix"
        : name;
  }

  /// Is the minimum amount posible for this [Ingredient]?
  bool get isTheMinimum =>
      quantity != null && quantity!.amount <= quantity!.min;

  /// Is the maximum amount posible for this [Ingredient]?
  bool get isTheMaximum =>
      quantity != null && quantity!.amount >= quantity!.max;

  double initialAmount = 0.0;

  String name;
  double cost;

  /// The name to be displayed when the amount is the maximum
  String maxName;

  /// The name to be displayed when the amount is the minimum
  String minName;

  PlateQuantity? quantity = PlateQuantity();

  /// this dictates if, when you call [Plate.amount()]
  /// the quantity should increase as well
  bool quantifiable = true;
}
