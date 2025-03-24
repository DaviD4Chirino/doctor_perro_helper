import 'package:doctor_perro_helper/models/order/menu_order.dart';
import 'package:doctor_perro_helper/models/order/menu_order_status.dart';
import 'package:flutter/cupertino.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part "menu_order_provider.g.dart";

@Riverpod(keepAlive: true)
class MenuOrderNotifier extends _$MenuOrderNotifier {
  @override
  MenuOrderData build() {
    return MenuOrderData(history: []);
  }

  void addOrder(MenuOrder newOrder) {
    List<MenuOrder> newHistory = state.history;
    MenuOrder order = newOrder;
    order.status = OrderStatus.pending;
    newHistory.add(order);
    newHistory.sort(
      (a, b) => b.timeMade.isAfter(a.timeMade) ? 1 : 0,
    );

    state = state.copyWith(
      history: newHistory,
      draftedOrder: MenuOrder(plates: [], packs: []),
    );
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

  void editOrder(MenuOrder order) {
    order.status = OrderStatus.pending;

    state = state.copyWith(draftedOrder: order);
  }

  void cancelOrder(MenuOrder order) {
    List<MenuOrder> history = state.history;

    final index = history.indexWhere(
        (MenuOrder oldOrder) => oldOrder.codeList == order.codeList);
    if (index == -1) {
      throw Exception(
        "Order with the CodeList of ${order.codeList} was not found in the history",
      );
    }

    MenuOrder copiedOrder = order;
    copiedOrder.status = OrderStatus.cancelled;
    history[index] = copiedOrder;

    state = state.copyWith(history: history);
  }

  void serveOrder(MenuOrder order) {
    List<MenuOrder> history = state.history;
    final index = history.indexWhere(
        (MenuOrder oldOrder) => oldOrder.codeList == order.codeList);
    if (index == -1) {
      throw Exception(
        "Order with the CodeList of ${order.codeList} was not found in the history",
      );
    }
    MenuOrder copiedOrder = order;

    copiedOrder.status = OrderStatus.completed;

    history[index] = copiedOrder;

    state = state.copyWith(history: history);
  }
}

class MenuOrderData {
  MenuOrderData({this.draftedOrder, required this.history});

  MenuOrderData copyWith({
    MenuOrder? draftedOrder,
    List<MenuOrder>? history,
  }) {
    return MenuOrderData(
      draftedOrder: draftedOrder ?? this.draftedOrder,
      history: history ?? this.history,
    );
  }

  List<MenuOrder> ordersWhere(OrderStatus status) =>
      history.where((element) => element.status == status).toList();

  MenuOrder? draftedOrder;
  List<MenuOrder> history = [];
}
