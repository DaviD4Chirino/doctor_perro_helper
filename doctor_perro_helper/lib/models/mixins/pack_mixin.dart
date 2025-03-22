import 'package:doctor_perro_helper/models/abstracts/plate_list.dart';
import 'package:doctor_perro_helper/models/plate_pack.dart';

mixin PackMixin {
  /// Combines the same packs into a single pack of the correct amount,
  /// and makes a new pack on the array if it's different
  List<PlatePack> mergePack(List<PlatePack> packs) {
    Map<String, PlatePack> packMap = {};

    print(PlateList.r1.amount(2).amount(3).ingredientsTitles);

    for (PlatePack pack in packs) {
      List<String> platesListTitles =
          pack.plates.map((e) => e.ingredientsTitles).toList();
      String searchString =
          "${pack.plateTitleList}${platesListTitles.join()}${pack.extrasTitleList.join()}";

      PlatePack? existingPack = packMap[searchString];
      if (existingPack != null) {
        double newAmount = existingPack.quantity.amount + pack.quantity.amount;
        packMap[searchString] = existingPack.amount(newAmount);
      } else {
        packMap[searchString] = pack;
      }
    }

    return packMap.values.toList();
  }

  /// Combines all the packs with the same code into a single pack
  /// Perro Especial, Perro Especial, Perro Especial, Perro EspecialSalchicha, Ensalada, Papas, Salsa de Tomate, Salsa de Ajo, Tocino, Queso KraftSalchicha, Ensalada, Papas, Salsa de Tomate, Salsa de Ajo, Tocino, Queso KraftSalchicha, Ensalada, Papas, Salsa de Tomate, Salsa de Ajo, Tocino, Queso KraftSalchicha, Ensalada, Papas, Salsa de Tomate, Salsa de Ajo, Tocino, Queso KraftPepsi ColaPapas Fritas 200g
  ///
  /// with the numbered amount
  List<PlatePack> flattenPack(List<PlatePack> packs) {
    if (packs.isEmpty) {
      return packs;
    }

    List<PlatePack> flattenedPacks = [packs.first.base.amount(0)];

    for (PlatePack pack in packs) {
      bool found = false;

      for (int i = 0; i < flattenedPacks.length; i++) {
        PlatePack flatPack = flattenedPacks[i];

        if (flatPack.code == pack.code) {
          double newAmount = flatPack.quantity.amount + pack.quantity.amount;
          flattenedPacks[i] = flatPack = flatPack.base.amount(newAmount);
          found = true;
          break;
        }
      }

      if (!found) {
        flattenedPacks.add(pack);
      }
    }

    return flattenedPacks;
  }
}
