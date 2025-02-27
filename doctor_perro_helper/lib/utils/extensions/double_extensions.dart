extension DoubleExtensions on double {
  String removePaddingZero() {
    final RegExp regex = RegExp(r'([.]*0)(?!.*\d)');
    return toString().replaceAll(regex, "");
  }
}
