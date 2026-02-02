enum ExclusivityType {
  free,
  fromClass;

  bool get isFree => this == free;
  bool get isFromClass => this == fromClass;
  static ExclusivityType translate(String content) {
    switch (content.toLowerCase()) {
      case 'geral':
        return free;

      default:
        return fromClass;
    }
  }
}
