class PlateQuantity {
  PlateQuantity({
    this.max = double.maxFinite,
    this.min = 0,
    this.count = 1,
    this.initialAmount = 1,
    this.prefix = "x",
    this.suffix = "",
  });

  double max;
  double min;
  double count;
  double initialAmount;

  String prefix;
  String suffix;
}
