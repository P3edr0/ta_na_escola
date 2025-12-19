import 'package:flutter/material.dart';

class FaceDetectorViewModel {
  String state;
  Color foregroundColor;
  Color backgroundColor;
  bool isLoading;
  IconData? icon;
  Duration duration = const Duration(milliseconds: 300);

  FaceDetectorViewModel(
    this.state, {
    this.icon,
    this.foregroundColor = Colors.black,
    this.backgroundColor = Colors.white,
    this.isLoading = false,
  });
}
