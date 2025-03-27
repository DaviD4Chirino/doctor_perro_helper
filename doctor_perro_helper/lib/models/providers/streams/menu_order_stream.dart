import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_perro_helper/models/abstracts/database_paths.dart';
import 'package:doctor_perro_helper/models/order/menu_order.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final AutoDisposeStreamProvider<List<MenuOrder>> menuOrderStream =
    StreamProvider.autoDispose(
  (ref) {
    return FirebaseFirestore.instance
        .collection(CollectionsPaths.orders)
        .orderBy("time-made", descending: true)
        .limit(30)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map(
                (doc) => MenuOrder.fromJson(doc.data()),
              )
              .toList(),
        );
  },
);
