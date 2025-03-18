import 'package:doctor_perro_helper/models/abstracts/plate_list.dart';
import 'package:doctor_perro_helper/models/plate.dart';
import 'package:doctor_perro_helper/models/plate_pack.dart';
import 'package:doctor_perro_helper/models/plate_quantity.dart';
import 'package:doctor_perro_helper/models/side_dish.dart';

extension PlatePackExtensions on PlatePack {
  PlatePack altAmount(double amount) {
    PlatePack newPack = (PlateList.getPackByCode(code) as PlatePack);
    List<SideDish>? newExtras;

    if (newPack.extras != null) {
      newExtras = newPack.extras!.map((extra) {
        return extra.amount((extra.quantity?.amount ?? 1.0) * amount);
      }).toList();
    }

    List<Plate> newPlates = newPack.plates.map((plate) {
      return plate.amount(plate.quantity.amount * amount);
    }).toList();

    return newPack.copyWith(
      plates: newPlates,
      extras: newExtras,
      quantity: PlateQuantity(
        amount: amount,
      ),
    );
  }

  List<PlatePack> spread() {
    if (quantity.amount <= 1) {
      return [this];
    }

    List<PlatePack> list = [];

    for (var i = 0; i < quantity.amount; i++) {
      // we know for sure its a pack
      list.add(
        amount(1).withUniqueId(),
      );
    }

    return list;
  }
  /* List<PlatePack> spread() {
    return[
      ...plates.map((Plate plate)=>plate.spread())
    ];
  } */
}
