class PlateQuantity {
  PlateQuantity({
    this.max = double.maxFinite,
    this.min = 0,
    this.count = 1,
    double amount = 1,
    this.prefix = "x",
    this.suffix = "",
  }) : _amount = amount;

  double _amount = 1.0;
  double get amount => _amount;

  set amount(double value) {
    _amount = value.clamp(min, max);
  }

  double max;
  double min;
  double count;

  String prefix;
  String suffix;
}
