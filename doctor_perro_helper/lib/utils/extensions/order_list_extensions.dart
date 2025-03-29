import 'package:doctor_perro_helper/models/order/menu_order.dart';
import 'package:doctor_perro_helper/models/order/menu_order_status.dart';

extension OrderListExtensions on List<MenuOrder> {
  List<MenuOrder> whereStatus(OrderStatus status) =>
      where((element) => element.status == status).toList();
}
