import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_perro_helper/models/abstracts/database_paths.dart';
import 'package:doctor_perro_helper/models/dolar_price_in_bs.dart';
import 'package:doctor_perro_helper/utils/database/document_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

final StreamProvider<DolarPriceInBsDoc> dolarPriceProvider =
    StreamProvider<DolarPriceInBsDoc>((ref) {
  CollectionReference collection =
      getCollection(CollectionsPaths.globalSettings);
  DocumentReference docRef = collection.doc(GlobalSettingsPaths.dolarPriceInBs);

  return docRef.snapshots().map((docSnap) {
    var data = docSnap.data();
    if (data != null) {
      return DolarPriceInBsDoc.fromJson(data as Map<String, dynamic>);
    } else {
      throw Exception("Document data is null");
    }
  });
});

Future<DolarPriceInBsDoc?> getDolar() async {
  try {
    CollectionReference collection =
        getCollection(CollectionsPaths.globalSettings);
    DocumentReference docRef =
        collection.doc(GlobalSettingsPaths.dolarPriceInBs);
    DocumentSnapshot docSnap = await docRef.get();
    var data = docSnap.data();
    DolarPriceInBsDoc dolarPriceInBsDoc =
        DolarPriceInBsDoc.fromJson(data as Map<String, dynamic>);
    return dolarPriceInBsDoc;
  } catch (e) {
    if (kDebugMode) {
      print(e);
    }
  }
  return null;
}
