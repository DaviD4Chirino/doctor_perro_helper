import 'package:doctor_perro_helper/models/plate_pack.dart';

extension PlatePackExtensions on PlatePack {
  List<PlatePack> spread() {
    if (quantity.amount <= 1) {
      return [this];
    }

    List<PlatePack> list = [];

    for (var i = 0; i < quantity.amount; i++) {
      list.add(amount(1));
    }

    return list;
  }
  /* List<PlatePack> spread() {
    return[
      ...plates.map((Plate plate)=>plate.spread())
    ];
  } */
}
