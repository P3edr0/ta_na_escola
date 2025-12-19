import 'package:flutter/material.dart';

import '../../responsiveness/responsive.dart';
import '../../theme/colors.dart';

class TneRoundedButton extends StatelessWidget {
  const TneRoundedButton({
    super.key,
    required this.child,
    required this.onTap,
    this.radius = 30,
    this.height = 48,
    this.padding = 20,
    this.width,
  }) : isSolid = false,
       color = null;
  const TneRoundedButton.solid({
    super.key,
    required this.child,
    required this.onTap,
    required this.color,
    this.height = 32,
    this.radius = 30,
    this.padding = 20,
    this.width,
  }) : isSolid = true;
  final VoidCallback? onTap;
  final Widget child;
  final double? width;
  final double height;
  final double padding;
  final double radius;
  final bool isSolid;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final handledWidth = width != null ? Responsive.getSize(width!) : null;
    return InkWell(
      onTap: onTap,
      child: Container(
        width: handledWidth,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: Responsive.getSize(padding)),
        height: Responsive.getSize(height),
        decoration: BoxDecoration(
          gradient: isSolid ? null : primaryGradient,
          color: isSolid ? color : null,
          borderRadius: BorderRadius.circular(radius),
        ),
        child: child,
      ),
    );
  }
}
