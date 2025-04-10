import 'package:doctor_perro_helper/models/order/menu_order.dart';
import 'package:doctor_perro_helper/models/order/menu_order_status.dart';
import 'package:doctor_perro_helper/utils/database/orders_helper.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part "drafted_order_provider.g.dart";

@riverpod
class DraftedOrderNotifier extends _$DraftedOrderNotifier {
  @override
  MenuOrder build() {
    return MenuOrder(packs: [], plates: []);
  }

  void addOrder(MenuOrder newOrder) {
    pushOrder(newOrder, OrderStatus.pending);
    state = MenuOrder(plates: [], packs: []);
  }

  void setOrder(MenuOrder newOrder) {
    state = newOrder;
  }

  void editOrder(MenuOrder order) {
    state = pushOrder(order, OrderStatus.pending);
  }

  /// Changes the status of the order as cancelled and updates the database
  void cancelOrder(MenuOrder order) {
    state = pushOrder(order, OrderStatus.cancelled);
  }

  void serveOrder(MenuOrder order) {
    state = pushOrder(order, OrderStatus.completed);
  }

  MenuOrder pushOrder(MenuOrder order, OrderStatus status) {
    MenuOrder copiedOrder = order..status = status;
    copiedOrder.status = status;
    uploadOrder(copiedOrder);
    return copiedOrder;
  }
}

class MenuOrderData {
  MenuOrderData(
      {this.draftedOrder, required this.history, this.fetchingData = false});

  MenuOrderData copyWith({
    MenuOrder? draftedOrder,
    List<MenuOrder>? history,
    bool? fetchingData,
  }) {
    return MenuOrderData(
      draftedOrder: draftedOrder ?? this.draftedOrder,
      history: history ?? this.history,
      fetchingData: fetchingData ?? this.fetchingData,
    );
  }

  List<MenuOrder> whereStatus(OrderStatus status) =>
      history.where((element) => element.status == status).toList();

  MenuOrder? draftedOrder;
  List<MenuOrder> history = [];

  bool fetchingData = false;
}
