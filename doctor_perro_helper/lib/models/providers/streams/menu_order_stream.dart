import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_perro_helper/models/abstracts/database_paths.dart';
import 'package:doctor_perro_helper/models/order/menu_order.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final StreamProvider<List<MenuOrder>> menuOrderStreamProvider = StreamProvider(
  (ref) {
    return FirebaseFirestore.instance
        .collection(CollectionsPaths.orders)
        .orderBy("time-made", descending: true)
        .limit(10)
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

final Stream<List<MenuOrder>> menuOrderStream = FirebaseFirestore.instance
    .collection(CollectionsPaths.orders)
    .orderBy("time-made", descending: true)
    .limit(5)
    .snapshots()
    .map(
      (snapshot) => snapshot.docs
          .map(
            (doc) => MenuOrder.fromJson(doc.data()),
          )
          .toList(),
    );
