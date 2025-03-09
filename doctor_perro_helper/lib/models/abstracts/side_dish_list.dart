import 'package:doctor_perro_helper/models/plate_quantity.dart';
import 'package:doctor_perro_helper/models/side_dish.dart';

abstract class SideDishList {
  static SideDish pepsiCola = SideDish(
    name: "Pepsi Cola",
    cost: 2.5,
    quantity: PlateQuantity(),
    minName: "Sin Pepsi Cola",
  );

  static SideDish frenchFries = SideDish(
    name: "Papas Fritas",
    cost: 0.5,
    quantity: PlateQuantity(
      count: 50.0,
      prefix: "",
      suffix: "g",
    ),
    minName: "Sin Papas Fritas",
  );

  static List<SideDish> list = [frenchFries, pepsiCola];
}
