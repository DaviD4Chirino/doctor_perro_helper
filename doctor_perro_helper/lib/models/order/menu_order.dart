import 'package:doctor_perro_helper/models/order/menu_order_status.dart';
import 'package:doctor_perro_helper/models/plate.dart';
import 'package:doctor_perro_helper/models/plate_pack.dart';
import 'package:doctor_perro_helper/utils/extensions/double_extensions.dart';
import 'package:doctor_perro_helper/utils/extensions/plate_extensions.dart';
import 'package:doctor_perro_helper/utils/extensions/platepack_extensions.dart';

/// Order as in; an order of french fries
class MenuOrder {
  MenuOrder({
    required this.plates,
    required this.packs,
    this.direction = "",
  });

  OrderStatus _status = OrderStatus.pending;

  set status(OrderStatus newStatus) {
    switch (newStatus) {
      case OrderStatus.pending:
        timeOrdered = DateTime.timestamp();

      case OrderStatus.completed:
        timeFinished = DateTime.timestamp();

      case OrderStatus.cancelled:
        timeCancelled = DateTime.timestamp();
    }
    _status = newStatus;
  }

  OrderStatus get status => _status;

  double get price {
    double totalAmount = 0.0;
    totalAmount += getPrices(plates);
    totalAmount += getPrices(packs);
    return totalAmount;
  }

  String get codeList {
    List<String> list = [];

    if (plates.isNotEmpty) {
      for (Plate plate in plates) {
        list.add(plate.quantity.amount <= 1.0
            ? plate.code
            : "${plate.code}x${plate.quantity.amount.removePaddingZero()}");
      }
    }
    if (packs.isNotEmpty) {
      for (PlatePack pack in packs) {
        list.add(pack.quantity.amount <= 1.0
            ? pack.code
            : "${pack.code}x${pack.quantity.amount.removePaddingZero()}");
      }
    }
    list.sort();
    return list.join(" - ");
  }

  /// The combined amount of each [Plate] in [plates]
  /// and [PlatePack] in [packs]
  int get length {
    int amount = 0;
    for (Plate plate in plates) {
      amount += plate.quantity.amount.toInt();
    }
    for (PlatePack pack in packs) {
      amount += pack.quantity.amount.toInt();
    }
    return amount;
  }

  MenuOrder create() {
    return MenuOrder(plates: plates, packs: packs);
  }

  /// returns the [plate] array but with repeated [Plates]
  /// for each amount.
  /// Instead of an R3 plate with the amount of 3,
  /// Its 3 R3 with the amount of 1.
  List<Plate> get platesSpread {
    List<Plate> newPlates = [];
    for (Plate plate in plates) {
      newPlates.addAll(plate.spread());
    }
    return newPlates;
  }

  List<PlatePack> get packSpread {
    List<PlatePack> newPacks = [];
    for (PlatePack pack in packs) {
      newPacks.addAll(pack.spread());
    }
    return newPacks;
  }

  List<Plate> plates;
  List<PlatePack> packs;

  String direction;

  // this should be controlled by changing the status
  DateTime timeMade = DateTime.timestamp();
  DateTime timeFinished = DateTime.timestamp();
  DateTime timeCancelled = DateTime.timestamp();
  DateTime timeOrdered = DateTime.timestamp();
}

double getPrices(List arr) {
  double totalAmount = 0.0;
  if (arr.isNotEmpty) {
    for (var element in arr) {
      if (element is Plate || element is PlatePack) {
        totalAmount += element.price;
      }
    }
  }

  return totalAmount;
}
