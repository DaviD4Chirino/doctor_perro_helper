import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_perro_helper/models/abstracts/database_paths.dart';
import 'package:doctor_perro_helper/models/order/menu_order.dart';
import 'package:doctor_perro_helper/utils/database/document_helper.dart';
import 'package:doctor_perro_helper/utils/database/shared.dart';

Future<bool> hasOrder(MenuOrder order) async {
  return await hasDocument(CollectionsPaths.orders, order.id);
}

Future<MenuOrder?> getOrder(String id) async {
  try {
    DocumentSnapshot snapshot =
        await getDocument(CollectionsPaths.users, id).get();

    if (!snapshot.exists) {
      return null;
    }

    return MenuOrder.fromJson(snapshot.data() as Map<String, dynamic>);
  } catch (e) {
    return null;
  }
}

Future<DocumentReference> uploadOrder(MenuOrder order) async {
  await db
      .collection(CollectionsPaths.orders)
      .doc(order.id)
      .set(order.toJson());
  return getDocument(CollectionsPaths.users, order.id);
}
