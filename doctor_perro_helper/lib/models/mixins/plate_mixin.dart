import 'package:doctor_perro_helper/models/abstracts/plate_list.dart';
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
    Map<String, List<Plate>> collectedPlates = {};

    List<Plate> flattenedPlates = [];

    for (Plate plate in plates) {
      Plate? existingPlate = PlateList.getPlateByCode(plate.code);
      if (existingPlate == null) continue;

      collectedPlates[existingPlate.code]?.add(existingPlate);
    }

    return flattenedPlates;
  }
}
