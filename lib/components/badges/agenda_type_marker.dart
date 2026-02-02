import 'package:flutter/material.dart';

import '../../responsiveness/responsive.dart';

class AgendaTypeMarker extends StatelessWidget {
  const AgendaTypeMarker({required this.color, this.topMargin = 0, super.key});
  final Color color;
  final double topMargin;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: Responsive.getSize(topMargin)),
      width: Responsive.getSize(8),
      height: Responsive.getSize(8),
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}
