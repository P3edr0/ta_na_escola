import 'package:flutter/material.dart';

import '../../responsiveness/responsive.dart';
import '../../theme/colors.dart';

class TneCircularButton extends StatefulWidget {
  const TneCircularButton({
    required this.onTap,
    required this.size,
    required this.child,
    this.gradient = primaryGradient,
    super.key,
  });

  final VoidCallback onTap;
  final double size;
  final Widget child;
  final Gradient? gradient;

  @override
  State<TneCircularButton> createState() => _TneCircularButtonState();
}

class _TneCircularButtonState extends State<TneCircularButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: Container(
          height: Responsive.getSize(widget.size),
          width: Responsive.getSize(widget.size),
          alignment: Alignment.center,
          decoration: BoxDecoration(gradient: widget.gradient),
          child: widget.child,
        ),
      ),
    );
  }
}
