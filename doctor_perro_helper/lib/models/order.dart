import 'package:doctor_perro_helper/models/plate.dart';
import 'package:doctor_perro_helper/models/plate_pack.dart';

class Order {
  Order({
    this.plates,
    this.packs,
  });

  double get platesPrice {
    double amount = 0.0;

    if (plates != null) {
      for (Plate plate in plates!) {
        amount += plate.price;
      }
    }

    return amount;
  }

  double get packsPrice {
    double amount = 0.0;

    if (packs != null) {
      for (PlatePack pack in packs!) {
        amount += pack.price;
      }
    }

    return amount;
  }

  List<Plate>? plates = [];
  List<PlatePack>? packs = [];
}
