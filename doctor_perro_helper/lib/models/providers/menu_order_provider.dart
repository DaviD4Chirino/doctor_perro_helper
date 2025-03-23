import 'package:doctor_perro_helper/models/order/menu_order.dart';
import 'package:doctor_perro_helper/models/order/menu_order_status.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part "menu_order_provider.g.dart";

@riverpod
class MenuOrderNotifier extends _$MenuOrderNotifier {
  @override
  MenuOrderData build() {
    return MenuOrderData(history: []);
  }

  addOrder(MenuOrder newOrder) {
    List<MenuOrder> newHistory = state.history ?? [];
    MenuOrder order = newOrder;
    order.status = OrderStatus.pending;
    newHistory.add(order);

    state = state.copyWith(history: newHistory);
  }

  void setDraftedOrder(MenuOrder newOrder) {
    state = state.copyWith(draftedOrder: newOrder);
  }

  /// Makes the current drafted order
  void pushDraftedOrder() {
    if (state.draftedOrder == null) {
      return;
    }
    addOrder(state.draftedOrder!);
  }
}

class MenuOrderData {
  MenuOrderData({this.draftedOrder, this.history});

  MenuOrder? draftedOrder;
  List<MenuOrder>? history = [];

  MenuOrderData copyWith({
    MenuOrder? draftedOrder,
    List<MenuOrder>? history,
  }) {
    return MenuOrderData(
      draftedOrder: draftedOrder ?? this.draftedOrder,
      history: history ?? this.history,
    );
  }
}
