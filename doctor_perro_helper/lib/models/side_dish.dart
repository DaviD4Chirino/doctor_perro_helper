import 'package:doctor_perro_helper/models/ingredient.dart';
import 'package:doctor_perro_helper/models/plate_quantity.dart';

class SideDish extends Ingredient {
  SideDish({
    required super.name,
    required super.cost,
    required super.quantity,
    super.quantifiable,
    super.maxName,
    super.minName,
  });

  @override
  Map<String, dynamic> toJson() => {
        "name": name,
        "cost": cost,
        "max-name": maxName,
        "min-name": minName,
        "quantity": quantity?.toJson(),
        "quantifiable": quantifiable,
      };

  SideDish.fromJson(Map<String, dynamic> json)
      : super(
          name: json["name"] as String,
          cost: json["cost"] as double,
          maxName: json["max-name"] as String,
          minName: json["min-name"] as String,
          quantity: json["quantity"] != null
              ? PlateQuantity.fromJson(json["quantity"])
              : null,
          quantifiable: json["quantifiable"] as bool,
        );

  Ingredient toIngredient() {
    return Ingredient(
      name: name,
      cost: cost,
      quantity: quantity,
      maxName: maxName,
      minName: minName,
    );
  }

  /// Returns this same [SideDish] with the initial amount changed
  @override
  SideDish amount(double amount, {bool exponential = false}) {
    double prevAmount = quantity?.amount ?? 1.0;
    return copyWith(
      quantity: quantity?.copyWith(
          amount: exponential ? prevAmount * amount : amount),
    );
  }

  @override
  SideDish copyWith({
    String? name,
    double? cost,
    String? maxName,
    String? minName,
    PlateQuantity? quantity,
  }) {
    return SideDish(
      name: name ?? this.name,
      cost: cost ?? this.cost,
      maxName: maxName ?? this.maxName,
      minName: minName ?? this.minName,
      quantity: quantity ?? this.quantity,
    );
  }
}
