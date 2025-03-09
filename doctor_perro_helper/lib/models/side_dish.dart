import 'package:doctor_perro_helper/models/ingredient.dart';
import 'package:doctor_perro_helper/models/plate_quantity.dart';

class SideDish extends Ingredient {
  SideDish({
    required super.name,
    required super.cost,
    required super.quantity,
    super.maxName,
    super.minName,
  });
  @override

  /// Returns this same [Ingredient] with the initial amount changed
  SideDish amount(double amount) {
    return SideDish(
      name: name,
      cost: cost,
      quantity: PlateQuantity(
        // count: quantity != null ? quantity?.count as double : 1,
        count: quantity?.count ?? 1.0,
        amount: amount,
        max: quantity?.max ?? double.maxFinite,
        min: quantity?.min ?? 0,
        prefix: quantity?.prefix ?? "x",
        suffix: quantity?.suffix ?? "",
      ),
    );
  }
}
