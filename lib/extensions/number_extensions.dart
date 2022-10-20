extension DoubleExtensions on double {
  String removeDecimalZeroFormat() {
    return toStringAsFixed(truncateToDouble() == this ? 0 : 2);
  }
}
