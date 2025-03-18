import 'package:doctor_perro_helper/models/plate.dart';
import 'package:doctor_perro_helper/models/plate_quantity.dart';

mixin PlateMixin {
  /// Combines the same plates into a single play of the correct amount,
  /// and makes a new plate on the array if its different
  List<Plate> merge(List<Plate> plates) {
    List<Plate> mergedPlates = [];

    for (Plate plate in plates) {
      bool found = false;
      for (int i = 0; i < mergedPlates.length; i++) {
        Plate mergedPlate = mergedPlates[i];

        if (plate.ingredientsTitles == mergedPlate.ingredientsTitles) {
          mergedPlates[i].quantity.amount += 1;
          found = true;
          break;
        }
      }

      if (!found) {
        mergedPlates.add(plate);
      }
    }

    return mergedPlates;
  }

  /// Combines all the plates with the same code into a single plate
  /// with the numbered amount
  List<Plate> flatten(List<Plate> plates) {
    if (plates.isEmpty) {
      return plates;
    }

    List<Plate> flattenedPlates = [];

    for (Plate plate in plates) {
      bool found = false;

      for (int i = 0; i < flattenedPlates.length; i++) {
        Plate flattenedPlate = flattenedPlates[i];

        if (flattenedPlate.code == plate.code) {
          double newAmount =
              flattenedPlate.quantity.amount + plate.quantity.amount;
          flattenedPlate = flattenedPlate.copyWith(
            quantity: flattenedPlate.quantity.copyWith(amount: newAmount),
          );
          found = true;
          break;
        }
      }

      if (!found) {
        flattenedPlates.add(plate);
      }
    }

    return flattenedPlates;
  }
}
