import 'package:doctor_perro_helper/models/plate_quantity.dart';
import 'package:doctor_perro_helper/models/side_dish.dart';

abstract class SideDishList {
  static SideDish pepsiCola = SideDish(
    title: "Pepsi Cola",
    cost: 3.0,
    quantity: PlateQuantity(),
  );

  static SideDish frenchFries = SideDish(
    title: "Papas Fritas",
    cost: 0.5,
    quantity: PlateQuantity(
      amount: 1.0,
      count: 50.0,
      prefix: "",
      suffix: "g",
    ),
  );

  static List<SideDish> list = [frenchFries, pepsiCola];
}
