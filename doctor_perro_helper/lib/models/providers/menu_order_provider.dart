import 'package:doctor_perro_helper/models/order/menu_order.dart';
import 'package:doctor_perro_helper/models/plate.dart';
import 'package:doctor_perro_helper/models/plate_pack.dart';
import 'package:doctor_perro_helper/screens/orders/new_order.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part "menu_order_provider.g.dart";

@riverpod
class MenuOrderProvider extends _$MenuOrderProvider {
  @override
  MenuOrderData build() {
    return MenuOrderData(history: []);
  }

  addOrder(MenuOrder newOrder) {}
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
