class TneValueHandler {
  static String smallNumberToShow(int value) {
    final content = value < 10 ? '0$value' : value.toString();
    return content;
  }
}
