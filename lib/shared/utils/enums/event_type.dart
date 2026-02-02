enum EventType {
  extra,
  outClass;

  bool get isExtra => this == extra;
  bool get isOutClass => this == outClass;

  static EventType translate(String content) {
    switch (content.toLowerCase()) {
      case 'extra':
        return extra;

      default:
        return outClass;
    }
  }
}
