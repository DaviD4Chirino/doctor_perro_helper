import 'package:doctor_perro_helper/models/plate.dart';

mixin PlateMixin {
  /// Combines the same plates into a single plate of the correct amount,
  /// and makes a new plate on the array if its different
  Map<String, List<Plate>> merge(List<Plate> plates) {
    List<Plate> samePlates = [];
    List<Plate> uniquePlates = [];

    for (Plate plate in plates) {
      for (int i = 0; i < samePlates.length; i++) {
        Plate samePlate = samePlates[i];
        // safety
        if (samePlate.code != plate.code) continue;
        if (samePlate.title != plate.title) continue;
        if (samePlate.ingredientsTitles != plate.ingredientsTitles) continue;

        Plate newPlate = samePlate
            .withUniqueId()
            .amount(samePlate.quantity.amount + plate.quantity.amount);
        samePlates.removeAt(i);
        samePlates[i] = newPlate;
      }
      /* bool found = false;
      for (int i = 0; i < samePlates.length; i++) {
        Plate mergedPlate = samePlates[i];

        if (plate.ingredientsTitles == mergedPlate.ingredientsTitles) {
          Plate newPlate = samePlates
              .removeAt(i)
              .amount(mergedPlate.quantity.amount + plate.quantity.amount);
          samePlates.add(newPlate);
          found = true;
          break;
        }
      }

      if (!found) {
        uniquePlates.add(plate);
      } */
    }

    return {
      'merged_plates': samePlates,
      'unique_plates': flatten(uniquePlates),
    };
  }

  /// Combines all the plates with the same code into a single plate
  /// with the numbered amount
  List<Plate> flatten(List<Plate> plates) {
    if (plates.isEmpty) {
      return plates;
    }

    List<Plate> flattenedPlates = [plates.first.base.amount(0)];
    List<Plate> platesToAdd = [];

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
    flattenedPlates.addAll(platesToAdd);

    return flattenedPlates;
  }
}
