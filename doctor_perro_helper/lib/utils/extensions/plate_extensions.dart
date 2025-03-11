import 'package:doctor_perro_helper/models/plate.dart';

extension PlateExtensions on Plate {
  List<Plate> spread() {
    if (quantity.amount <= 1) {
      return [this];
    }

    List<Plate> list = [];

    for (var i = 0; i < quantity.amount; i++) {
      list.add(withNewId().amount(1));
    }

    return list;
  }
}
