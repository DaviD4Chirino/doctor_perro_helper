import 'package:doctor_perro_helper/models/plate.dart';

mixin PlateMixin {
  /// Combines the same plates into a single plate of the correct amount,
  /// and makes a new plate on the array if its different
  List<Plate> merge(List<Plate> plates) {
    if (plates.isEmpty) {
      return plates;
    }

    /// Plates that haven't changed compared on their base
    List<Plate> samePlates = [];

    /// Plates that have changed
    List<Plate> uniquePlates = [];

    for (Plate plate in plates) {
      Plate basePlate = plate.base;

      for (Plate uniquePlate in uniquePlates) {}

      if (hasChanges(basePlate, plate)) {
        uniquePlates.add(plate);
      } else {
        samePlates.add(plate);
      }
    }

    return uniquePlates;
  }

  /// Combines all the plates with the same code into a single plate
  /// with the numbered amount
  List<Plate> flatten(List<Plate> plates) {
    if (plates.isEmpty) {
      return plates;
    }

    List<Plate> flattenedPlates = [plates.first.base.amount(0)];

    for (Plate plate in plates) {
      bool found = false;

      for (int i = 0; i < flattenedPlates.length; i++) {
        Plate flatPlate = flattenedPlates[i];

        if (flatPlate.code == plate.code) {
          flattenedPlates[i] = flatPlate.base
              .amount(flatPlate.quantity.amount + (plate.quantity.amount));
          found = true;
          break;
        }
      }

      // a second check
      /*  if (!found) {
        bool foundInPlatesToAdd = false;
        for (int j = 0; j < platesToAdd.length; j++) {
          if (platesToAdd[j].code == plate.code) {
            platesToAdd[j] = platesToAdd[j].base.amount(
                platesToAdd[j].quantity.amount + (plate.quantity.amount + 1));
            foundInPlatesToAdd = true;
            break;
          }
        }
        if (!foundInPlatesToAdd) {
          platesToAdd.add(plate.base);
        }
      } */

      if (!found) {
        flattenedPlates.add(plate);
      }
    }

    return flattenedPlates;
  }

  bool hasChanges(Plate plate1, Plate plate2) {
    if (plate1.code != plate2.code ||
            plate1.name != plate2.name ||
            plate1.cost != plate2.cost
        // quantity needs their own function
        // || plate1.quantity != plate2.quantity
        ) {
      return true;
    }

    if (plate1.ingredients.length != plate2.ingredients.length ||
        !plate1.ingredients.every(
          (ingredient) =>
              plate2.ingredients.any((ing) => ing.name == ingredient.name),
        )) {
      return true;
    }

    if ((plate1.extras?.length ?? 0) != (plate2.extras?.length ?? 0) ||
        !plate1.extras!.every(
          (extra) => plate2.extras!.any((ext) => ext.name == extra.name),
        )) {
      return true;
    }

    return false;
  }
}
