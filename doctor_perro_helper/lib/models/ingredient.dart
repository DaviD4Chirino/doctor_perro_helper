import 'package:doctor_perro_helper/models/plate_quantity.dart';

class Ingredient {
  Ingredient({
    required this.title,
    required this.cost,
    this.quantity,
  });

  String title;
  double cost;
  PlateQuantity? quantity = PlateQuantity();
}
