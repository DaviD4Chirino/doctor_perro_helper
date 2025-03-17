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
