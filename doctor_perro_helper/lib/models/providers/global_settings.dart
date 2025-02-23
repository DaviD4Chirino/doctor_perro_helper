import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_perro_helper/models/abstracts/database_paths.dart';
import 'package:doctor_perro_helper/utils/database/document_helper.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part "global_settings.g.dart";

@riverpod
class GlobalSettingsNotifier extends _$GlobalSettingsNotifier {
  @override
  GlobalSettings build() {
    return GlobalSettings();
  }

  Future<void> init() async {
    CollectionReference collection =
        getCollection(CollectionsPaths.globalSettings);
  }
}

class GlobalSettings {
  GlobalSettings({
    this.dolarPrice = 0.0,
  });
  double dolarPrice;

  GlobalSettings merge({
    double? dolarPrice,
  }) {
    return GlobalSettings(dolarPrice: dolarPrice ?? this.dolarPrice);
  }
}
