import 'package:doctor_perro_helper/models/order/menu_order_status.dart';
import 'package:doctor_perro_helper/models/plate.dart';
import 'package:doctor_perro_helper/models/plate_pack.dart';
import 'package:doctor_perro_helper/utils/extensions/double_extensions.dart';

/// Order as in; an order of french fries
class MenuOrder {
  MenuOrder({
    required this.plates,
    required this.packs,
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

  /// The combined length of [plates] and [packs]
  int get length => plates.length + packs.length;

  MenuOrder create() {
    return MenuOrder(plates: plates, packs: packs);
  }

  List<Plate> plates;
  List<PlatePack> packs;

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
