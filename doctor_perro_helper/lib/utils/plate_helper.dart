import 'package:doctor_perro_helper/models/plate.dart';
import 'package:doctor_perro_helper/models/plate_pack.dart';

/// [list] must be a class with [PlateQuantity] member called quantity
List amountSpreader(dynamic list) {
  List<dynamic> newList = [];
  assert(
    list is List<Plate> || list is List<PlatePack>,
    "You must provide a list of Plates or Packs",
  );

  for (var element in list) {
    if (element.quantity == null || element.quantity.amount <= 1) {
      newList.add(element);
      continue;
    }
    for (var i = 0; i < element.quantity.amount; i++) {
      newList.add(element.amount(1));
    }
  }

  return newList;
}

List<Plate> spreadPlate(Plate plate) {
  if (plate.quantity.amount <= 1) {
    return [plate];
  }

  List<Plate> list = [];

  for (var i = 0; i < plate.quantity.amount; i++) {
    list.add(plate.amount(1));
  }

  return list;
}

List<PlatePack> spreadPack(PlatePack pack) {
  if (pack.quantity.amount <= 1) {
    return [pack];
  }

  List<PlatePack> list = [];

  for (var i = 0; i < pack.quantity.amount; i++) {
    list.add(pack.amount(1));
  }

  return list;
}
