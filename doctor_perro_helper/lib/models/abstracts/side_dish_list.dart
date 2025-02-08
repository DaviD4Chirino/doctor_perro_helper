import 'package:doctor_perro_helper/models/plate_quantity.dart';
import 'package:doctor_perro_helper/models/side_dish.dart';

abstract class SideDishList {
  static SideDish pepsiCola = SideDish(
    title: "Pepsi Cola",
    cost: 2.5,
    quantity: PlateQuantity(),
  );

  static SideDish frenchFries = SideDish(
    title: "Papas Fritas",
    cost: 0.5,
    quantity: PlateQuantity(
      count: 50.0,
      prefix: "",
      suffix: "g",
    ),
  );

  static List<SideDish> list = [frenchFries, pepsiCola];
}
