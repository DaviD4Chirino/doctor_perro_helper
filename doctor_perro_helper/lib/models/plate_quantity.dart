//TODO: Implement the quantity as INTEGERS or deal with the fixed point doubles
class PlateQuantity {
  PlateQuantity({
    this.max = double.maxFinite,
    this.min = 0,
    this.count = 1,
    this.amount = 1,
    this.prefix = "x",
    this.suffix = "",
  });

  Map<String, dynamic> toJson() => {
        "max": max,
        "min": min,
        "count": count,
        "amount": amount,
        "prefix": prefix,
        "suffix": suffix,
      };

  PlateQuantity.fromJson(Map<String, dynamic> json)
      : max = json["max"] as double,
        min = json["min"] as double,
        count = json["count"] as double,
        amount = json["amount"] as double,
        prefix = json["prefix"] as String,
        suffix = json["suffix"] as String;

  double amount = 1.0;

  PlateQuantity copyWith({
    double? max,
    double? min,
    double? count,
    double? amount,
    String? prefix,
    String? suffix,
  }) {
    return PlateQuantity(
      max: max ?? this.max,
      min: min ?? this.min,
      count: count ?? this.count,
      amount: amount ?? this.amount,
      prefix: prefix ?? this.prefix,
      suffix: suffix ?? this.suffix,
    );
  }

  double max;
  double min;
  double count;

  String prefix;
  String suffix;
}
