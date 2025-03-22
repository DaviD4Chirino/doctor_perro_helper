import 'package:doctor_perro_helper/models/abstracts/plate_list.dart';
import 'package:doctor_perro_helper/models/plate.dart';

extension PlateExtensions on Plate {
  /// Returns a new list of length of the amount,
  /// and for each amount this plate but brand new
  List<Plate> spread({bool withExtras = true}) {
    if (quantity.amount <= 1) {
      return [this];
    }

    List<Plate> list = [];

    for (int i = 0; i < quantity.amount; i++) {
      Plate plate = PlateList.getPlateByCode(code)!;
      // We know this is a real plate
      list.add(
        (withExtras ? plate : plate.withoutExtras()).amount(1).withUniqueId(),
      );
    }

    return list;
  }
}
