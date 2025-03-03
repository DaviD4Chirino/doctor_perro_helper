import 'package:doctor_perro_helper/models/order/menu_order.dart';
import 'package:doctor_perro_helper/models/plate.dart';
import 'package:doctor_perro_helper/models/plate_pack.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part "menu_order_provider.g.dart";

@riverpod
class MenuOrderProvider extends _$MenuOrderProvider {
  @override
  List<MenuOrder> build() {
    return [];
  }

  addOrder(MenuOrder newOrder) {}
}
