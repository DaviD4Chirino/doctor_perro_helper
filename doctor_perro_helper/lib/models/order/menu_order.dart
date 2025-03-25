import 'package:doctor_perro_helper/models/mixins/pack_mixin.dart';
import 'package:doctor_perro_helper/models/mixins/plate_mixin.dart';
import 'package:doctor_perro_helper/models/order/menu_order_status.dart';
import 'package:doctor_perro_helper/models/plate.dart';
import 'package:doctor_perro_helper/models/plate_pack.dart';
import 'package:doctor_perro_helper/utils/extensions/double_extensions.dart';
import 'package:doctor_perro_helper/utils/extensions/plate/plate_extensions.dart';
import 'package:doctor_perro_helper/utils/extensions/platepack_extensions.dart';
import 'package:uuid/uuid.dart';

String get uid => Uuid().v4();

/// Order as in; an order of french fries
class MenuOrder with PlateMixin, PackMixin {
  MenuOrder({
    required this.plates,
    required this.packs,
    this.direction = "",
    this.madeBy = "",
  });

  void replacePlate(Plate oldPlate, Plate newPlate) {
    final int index =
        plates.indexWhere((Plate plate) => plate.id == oldPlate.id);

    if (index != -1) {
      plates[index] = newPlate;
    }
  }

  void replacePack(PlatePack oldPack, PlatePack newPack) {
    final int index =
        packs.indexWhere((PlatePack pack) => pack.id == oldPack.id);

    if (index != -1) {
      packs[index] = newPack;
    }
  }

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

  MenuOrder copyWith({
    List<Plate>? plates,
    List<PlatePack>? packs,
    String? direction,
    DateTime? timeMade,
    DateTime? timeFinished,
    DateTime? timeCancelled,
    DateTime? timeOrdered,
  }) {
    return MenuOrder(
        plates: plates ?? this.plates,
        packs: packs ?? this.packs,
        direction: direction ?? this.direction);
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

  MenuOrder get flatOrder => MenuOrder(
        packs: flattenPacks(packs),
        plates: flattenPlates(plates),
      );

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

  Map<String, dynamic> toJson() => {
        "id": id,
        "plates": plates,
        "packs": packs,
        "direction": direction,
        "madeBy": madeBy,
        "status": status.index,
        "time-made": timeMade,
        "time-finished": timeFinished,
        "time-cancelled": timeCancelled,
        "time-ordered": timeOrdered,
      };

  MenuOrder.fromJson(Map<String, dynamic> json)
      : id = json["id"] as String,
        plates = json['plates'] as List<Plate>,
        packs = json["packs"] as List<PlatePack>,
        direction = json["direction"] as String,
        madeBy = json["made-by"] as String,
        _status = OrderStatus.values[int.parse(json["status"])],
        timeFinished = json["time-finished"] as DateTime,
        timeCancelled = json["time-cancelled"] as DateTime,
        timeOrdered = json["time-ordered"] as DateTime;

  String id = uid;

  List<Plate> plates;
  List<PlatePack> packs;

  String direction;

  /// The id of the user that made this order
  String madeBy;

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
