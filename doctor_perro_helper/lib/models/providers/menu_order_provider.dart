import 'package:doctor_perro_helper/models/order/menu_order.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part "menu_order_provider.g.dart";

@riverpod
class MenuOrderNotifier extends _$MenuOrderNotifier {
  @override
  MenuOrderData build() {
    return MenuOrderData(history: []);
  }

  addOrder(MenuOrder newOrder) {}

  void setDraftedOrder(MenuOrder newOrder) {
    state.draftedOrder = newOrder;
    state = state;
  }
}

class MenuOrderData {
  MenuOrderData({this.draftedOrder, this.history});

  MenuOrder? draftedOrder;
  List<MenuOrder>? history = [];

  MenuOrderData copyWith({
    MenuOrder? newDraftedOder,
    List<MenuOrder>? newHistory,
  }) {
    return MenuOrderData(
      draftedOrder: draftedOrder ?? newDraftedOder,
      history: history ?? newHistory,
    );
  }
}
