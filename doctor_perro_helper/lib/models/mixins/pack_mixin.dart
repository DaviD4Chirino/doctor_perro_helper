import 'package:doctor_perro_helper/models/plate_pack.dart';

mixin PackMixin {
  /// Combines the same packs into a single pack of the correct amount,
  /// and makes a new pack on the array if it's different
  List<PlatePack> mergePack(List<PlatePack> packs) {
    List<PlatePack> mergedPacks = [];

    for (PlatePack pack in packs) {
      bool found = false;
      for (int i = 0; i < mergedPacks.length; i++) {
        PlatePack mergedPack = mergedPacks[i];

        if (pack.plateCodeList == mergedPack.plateCodeList) {
          mergedPacks[i] = mergedPacks[i]
              .amount(mergedPacks[i].quantity.amount + pack.quantity.amount);
          found = true;
          break;
        }
      }

      if (!found) {
        mergedPacks.add(pack);
      }
    }

    return mergedPacks;
  }

  /// Combines all the packs with the same code into a single pack
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
