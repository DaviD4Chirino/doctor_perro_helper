import 'package:cloud_firestore/cloud_firestore.dart';

class DolarPriceInBs {
  DolarPriceInBs({
    this.value = 0.0,
    this.updateTime,
  });
  double value;
  DateTime? updateTime;

  Map<String, dynamic> toJson() {
    return {
      "value": value,
      "update-time": updateTime,
    };
  }

  DolarPriceInBs.fromJson(Map<String, dynamic> json)
      : value = json["value"] as double,
        updateTime = (json["update-time"] as Timestamp?)?.toDate();
}

class DolarPriceInBsDoc {
  DolarPriceInBsDoc({required this.history});
  List<DolarPriceInBs> history = [];

  Map<String, dynamic> toJson() {
    return {
      "value": List.generate(history.length, (int i) => history[i].toJson()),
    };
  }
  //[{value: 0.0, update-time: 2025-02-23 17:24:35.983198Z}, {value: 0.0, update-time: 2025-02-23 17:24:35.983729Z}, {value: 0.0, update-time: 2025-02-23 17:24:35.983734Z}, {value: 0.0, update-time: 2025-02-23 17:24:35.983739Z}, {value: 0.0, update-time: 2025-02-23 17:24:35.983742Z}, {value: 0.0, update-time: 2025-02-23 17:24:35.983746Z}]

  DolarPriceInBsDoc.fromJson(Map<String, dynamic> json)
      : history = List.generate(
          (json["value"] as List<dynamic>).length,
          (int i) {
            Timestamp? upTime = json["value"][i]["update-time"];
            return DolarPriceInBs(
              value: (json["value"][i]["value"]),
              updateTime: (upTime)?.toDate(),
            );
          },
        );

  //* These may be called the "Latests" but thats just looking into the end of
  //* the array, proper sorting is not needed at the moment

  DolarPriceInBs? get latestDolarPrice {
    if (history.isNotEmpty) {
      return history[history.length - 1];
    }
    return null;
  }

  double get latestValue => latestDolarPrice?.value ?? 0.0;

  DateTime? get latestUpdateTime => latestDolarPrice?.updateTime;
}
