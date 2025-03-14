import 'package:doctor_perro_helper/models/abstracts/plate_list.dart';
import 'package:doctor_perro_helper/models/plate.dart';

extension PlateExtensions on Plate {
  /// Returns a new list of length of the amount,
  /// and for each amount this plate but brand new
  List<Plate> spread() {
    if (quantity.amount <= 1) {
      return [this];
    }

    List<Plate> list = [];

    for (var i = 0; i < quantity.amount; i++) {
      // We know this is a real plate
      list.add(
        (PlateList.getPlateByCode(code) as Plate).amount(1).withUniqueId(),
      );
    }

    return list;
  }
}
