import 'package:doctor_perro_helper/models/plate.dart';
import 'package:doctor_perro_helper/models/plate_quantity.dart';

mixin PlateMixin {
  List<Plate> mergePlates(List<Plate> plates) {
    Map<String, Plate> plateMap = {};

    for (var plate in plates) {
      Plate? existingPlate = plateMap[plate.ingredientsTitles];
      if (existingPlate != null) {
        double newAmount =
            existingPlate.quantity.amount + plate.quantity.amount;
        plateMap[plate.ingredientsTitles] = existingPlate.amount(newAmount);
      } else {
        plateMap[plate.ingredientsTitles] = plate;
      }
    }

    return plateMap.values.toList();
  }

  /// Combines the same plates into a single plate of the correct amount,
  /// and makes a new plate on the array if its different
  Map<String, List<Plate>> merge(List<Plate> plates) {
    /// Plates that haven't changed compared on their base
    List<Plate> samePlates = [];

    /// Plates that have changed
    List<Plate> uniquePlates = [];

    if (hasChanges(plates.first, plates.first.base)) {
      uniquePlates.add(plates.first);
    } else {
      samePlates.add(plates.first);
    }

    for (int k = 1; k < plates.length; k++) {
      Plate plate = plates[k];
      for (int i = 0; i < uniquePlates.length; i++) {
        Plate uniquePlate = uniquePlates[i];
        if (uniquePlate.ingredientsTitles == plate.ingredientsTitles) {
          uniquePlates[i] = uniquePlate
              .amount(uniquePlate.quantity.amount + plate.quantity.amount);
          break;
        }
      }

      for (int j = 0; j < samePlates.length; j++) {
        Plate samePlate = samePlates[j];

        if (samePlate.ingredientsTitles == plate.ingredientsTitles) {
          samePlates[j] = samePlate
              .amount(samePlate.quantity.amount + plate.quantity.amount);
          break;
        }
      }
    }

    return {
      "unique_plates": uniquePlates,
      "same_plates": samePlates,
    };
  }

  bool arePlatesSame(Plate plate1, Plate plate2) {
    return plate1.code == plate2.code &&
        plate1.ingredientsTitles == plate2.ingredientsTitles &&
        ((plate1.extras?.length ?? 0) == (plate2.extras?.length ?? 0) &&
            plate1.extras!.every((extra) =>
                plate2.extras!.any((ext) => ext.name == extra.name)));
  }

  /// Combines all the plates with the same code into a single plate
  /// with the numbered amount
  List<Plate> flattenPlates(List<Plate> plates) {
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
              .amount(flatPlate.quantity.amount + plate.quantity.amount);
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
