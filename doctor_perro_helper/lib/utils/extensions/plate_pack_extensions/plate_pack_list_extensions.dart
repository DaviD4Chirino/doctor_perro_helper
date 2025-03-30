import 'package:doctor_perro_helper/models/plate_pack.dart';

extension PlatePackListExtensions on List<PlatePack> {
  replaceWhere(PlatePack oldPack, PlatePack newPack) {
    final int index = indexWhere((PlatePack pack) => pack.id == oldPack.id);

    if (index != -1) {
      this[index] = newPack;
    }
    return this;
  }
}
