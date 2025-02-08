import 'package:doctor_perro_helper/models/plate_quantity.dart';
import 'package:doctor_perro_helper/models/side_dish.dart';

class Ingredient {
  Ingredient({
    required this.title,
    required this.cost,
    this.quantity,
  });

  /// Returns this same [Ingredient] with the initial amount changed
  SideDish amount(double amount) {
    return SideDish(
      title: title,
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

  double get price => (quantity?.amount ?? 1) * cost;

  String title;
  double cost;
  PlateQuantity? quantity = PlateQuantity();
}
