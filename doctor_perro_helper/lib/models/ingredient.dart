import 'package:doctor_perro_helper/models/plate_quantity.dart';
import 'package:doctor_perro_helper/models/side_dish.dart';
import 'package:doctor_perro_helper/utils/string_math.dart';

class Ingredient {
  Ingredient({
    required this.name,
    required this.cost,
    this.quantity,
  });

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

  double get price => (quantity?.amount ?? 1) * cost;

  String get title {
    String suffix = this.quantity?.suffix ?? "";
    String prefix = this.quantity?.prefix ?? "";
    double amount = this.quantity?.amount ?? 1.0;
    double count = this.quantity?.count ?? 1.0;

    double quantity = count * amount;

    return amount > 1
        ? "$name $prefix${removePaddingZero(quantity.toString())}$suffix"
        : name;
  }

  String name = "";
  double cost;
  PlateQuantity? quantity = PlateQuantity();
}
