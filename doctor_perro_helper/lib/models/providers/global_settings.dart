import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_perro_helper/models/abstracts/database_paths.dart';
import 'package:doctor_perro_helper/models/dolar_price_in_bs.dart';
import 'package:doctor_perro_helper/utils/database/document_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part "global_settings.g.dart";

@riverpod
class GlobalSettingsNotifier extends _$GlobalSettingsNotifier {
  @override
  GlobalSettings build() {
    return GlobalSettings(dolarPrice: DolarPriceInBsDoc(history: []));
  }

  Future<void> init() async {
    CollectionReference collection =
        getCollection(CollectionsPaths.globalSettings);
    DocumentReference docRef =
        collection.doc(GlobalSettingsPaths.dolarPriceInBs);
    DocumentSnapshot docSnap = await docRef.get();
    var data = docSnap.data();

    DolarPriceInBsDoc dolarPriceInBsDoc =
        DolarPriceInBsDoc.fromJson(data as Map<String, dynamic>);

    state = GlobalSettings(dolarPrice: dolarPriceInBsDoc);
  }

  Future<void> changeDolarPriceInBs(double amount) async {
    try {
      DolarPriceInBsDoc? dolarPriceDoc =
          DolarPriceInBsDoc(history: state.dolarPrice?.history ?? []);

      dolarPriceDoc.history
          .add(DolarPriceInBs(value: amount, updateTime: DateTime.now()));

      if (kDebugMode) {
        print(dolarPriceDoc);
        print(state.dolarPrice);
      }

      DocumentReference docRef = getDocument(
        CollectionsPaths.globalSettings,
        GlobalSettingsPaths.dolarPriceInBs,
      );

      await docRef.set(dolarPriceDoc.toJson());
      if (kDebugMode) {
        print(state);
      }

      // Update the state only if the database operation succeeds
      // state = GlobalSettings(dolarPrice: newDolarPriceInBs);
    } catch (e) {
      if (kDebugMode) {
        print("ERROR ON -> $e");
      }
      return;
    }
  }
}

class GlobalSettings {
  GlobalSettings({
    this.dolarPrice,
  });
  DolarPriceInBsDoc? dolarPrice;
}
