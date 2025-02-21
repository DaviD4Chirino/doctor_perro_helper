import 'package:doctor_perro_helper/models/order/order_status.dart';
import 'package:doctor_perro_helper/models/plate.dart';

class Order {
  Order({
    required this.plates,
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

  Order create() {
    return Order(plates: plates);
  }

  List<Plate> plates;
  // TODO: add PackPlate when I merge

  // this should be controlled by changing the status
  DateTime timeMade = DateTime.timestamp();
  DateTime timeFinished = DateTime.timestamp();
  DateTime timeCancelled = DateTime.timestamp();
  DateTime timeOrdered = DateTime.timestamp();
}
