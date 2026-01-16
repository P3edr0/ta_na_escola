enum FrequencyMenuType {
  latest,
  custom;

  bool get isLatest => this == latest;
  bool get isCustom => this == custom;
}
