extension DoubleExtensions on double {
  String removePaddingZero() {
    final RegExp regex = RegExp(r'([.]*0)(?!.*\d)');
    return double.parse(toStringAsFixed(2)).toString().replaceAll(regex, "");
  }
}
