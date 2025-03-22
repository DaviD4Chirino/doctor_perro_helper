import 'package:doctor_perro_helper/models/abstracts/plate_list.dart';
import 'package:doctor_perro_helper/models/plate.dart';
import 'package:doctor_perro_helper/models/plate_pack.dart';
import 'package:doctor_perro_helper/models/plate_quantity.dart';
import 'package:doctor_perro_helper/models/side_dish.dart';

extension PlatePackExtensions on PlatePack {
  List<PlatePack> spread() {
    if (quantity.amount <= 1) {
      return [this];
    }

    List<PlatePack> list = [];

    for (var i = 0; i < quantity.amount; i++) {
      PlatePack pack = PlateList.getPackByCode(code)!.amount(1);

      pack.plates = pack.platesSpread;
      // We know this is a real Pack
      list.add(pack.withUniqueId());
    }

    return list;
  }
  /* List<PlatePack> spread() {
    return[
      ...plates.map((Plate plate)=>plate.spread())
    ];
  } */
}
