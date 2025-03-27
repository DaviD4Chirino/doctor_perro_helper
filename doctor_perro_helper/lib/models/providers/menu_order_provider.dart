import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_perro_helper/models/abstracts/database_paths.dart';
import 'package:doctor_perro_helper/models/order/menu_order.dart';
import 'package:doctor_perro_helper/models/order/menu_order_status.dart';
import 'package:doctor_perro_helper/utils/database/orders_helper.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part "menu_order_provider.g.dart";

@Riverpod(keepAlive: true)
class MenuOrderNotifier extends _$MenuOrderNotifier {
  @override
  MenuOrderData build() {
    return MenuOrderData(history: []);
  }

  Future<void> fetchOrders() async {
    state = state.copyWith(fetchingData: true);

    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore
        .instance
        .collection(CollectionsPaths.orders)
        .get();

    List<MenuOrder> orders = querySnapshot.docs
        .map(
          (QueryDocumentSnapshot<Map<String, dynamic>> snapshot) =>
              MenuOrder.fromJson(
            snapshot.data(),
          ),
        )
        .toList();

    state.copyWith(history: orders, fetchingData: false);
  }

  void addOrder(MenuOrder newOrder) {
    List<MenuOrder> newHistory = state.history;
    MenuOrder order = newOrder;
    order.status = OrderStatus.pending;
    newHistory.add(order);
    newHistory.sort(
      (a, b) => b.timeMade.isAfter(a.timeMade) ? 1 : 0,
    );

    uploadOrder(order);

    state = state.copyWith(
      history: newHistory,
      draftedOrder: MenuOrder(plates: [], packs: []),
    );
  }

  void setDraftedOrder(MenuOrder newOrder) {
    state = state.copyWith(draftedOrder: newOrder);
  }

  /// Makes the current drafted order
  void pushDraftedOrder({String userId = "anonymous"}) {
    if (state.draftedOrder == null) {
      return;
    }
    MenuOrder draftedOrder = state.draftedOrder!;

    draftedOrder.madeBy = userId;

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
    uploadOrder(copiedOrder);
    state = state.copyWith(history: history);
  }

  void serveOrder(MenuOrder order) {
    List<MenuOrder> history = state.history;

    final index =
        history.indexWhere((MenuOrder oldOrder) => oldOrder.id == order.id);

    if (index == -1) {
      throw Exception(
        "Order with the id of ${order.id} was not found in the history",
      );
    }
    MenuOrder copiedOrder = order;

    copiedOrder.status = OrderStatus.completed;

    history[index] = copiedOrder;

    uploadOrder(copiedOrder);

    state = state.copyWith(history: history);
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

  List<MenuOrder> ordersWhere(OrderStatus status) =>
      history.where((element) => element.status == status).toList();

  MenuOrder? draftedOrder;
  List<MenuOrder> history = [];

  bool fetchingData = false;
}
