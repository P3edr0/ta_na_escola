import 'package:flutter/material.dart';

import '../../../theme/colors.dart';

enum AgendaType {
  event,
  notation;

  bool get isEvent => this == event;
  bool get isNotation => this == notation;

  Color getColor() {
    switch (this) {
      case event:
        return accentColor;
      default:
        return mediumDarkBlue;
    }
  }
}
