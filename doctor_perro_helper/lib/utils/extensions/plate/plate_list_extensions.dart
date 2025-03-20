import 'package:doctor_perro_helper/models/plate.dart';

extension PlateListExtensions on List<Plate> {
  List<Plate> replaceWhere(Plate oldPlate, Plate newPlate) {
    final int index = indexWhere((Plate plate) => plate.id == oldPlate.id);

    if (index != -1) {
      newPlate.modified = true;
      this[index] = newPlate;
      return this;
    }

    return this;
  }
}
