import 'package:riverpod_annotation/riverpod_annotation.dart';
part "global_settings.g.dart";

@riverpod
class GlobalSettingsNotifier extends _$GlobalSettingsNotifier {
  @override
  GlobalSettings build() {
    return GlobalSettings();
  }

  void init() {}
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
