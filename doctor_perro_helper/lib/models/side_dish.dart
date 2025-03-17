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
