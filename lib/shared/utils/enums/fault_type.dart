enum FaultType {
  health,
  another;

  bool get isHealth => this == health;
  bool get isAnother => this == another;

  @override
  String toString() {
    if (this == health) {
      return 'Médico';
    }
    return 'Outros';
  }

  static FaultType translate(String value) {
    if (value == 'Médico') {
      return health;
    }
    return another;
  }
}
