import 'package:flutter/material.dart';

import '../../responsiveness/responsive.dart';
import '../../theme/colors.dart';

class TneAvatarBorder extends StatelessWidget {
  const TneAvatarBorder({
    super.key,
    required this.image,
    required this.radius,
    required this.color,
    this.hasBottomPadding = false,
  }) : withColor = false;
  const TneAvatarBorder.withColor({
    super.key,
    required this.radius,
    this.hasBottomPadding = false,
    required this.color,
  }) : image = null,
       withColor = true;
  final ImageProvider? image;
  final double radius;
  final bool hasBottomPadding;
  final bool withColor;
  final Color color;
  @override
  Widget build(BuildContext context) {
    final handledPadding = hasBottomPadding
        ? EdgeInsets.only(bottom: Responsive.getSize(10))
        : EdgeInsets.zero;
    return Padding(
      padding: handledPadding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: transparent,
              border: Border.all(width: 2, color: color),
            ),
            padding: EdgeInsets.all(2),
            child: CircleAvatar(
              radius: Responsive.getSize(radius),
              backgroundImage: image,
              backgroundColor: withColor ? color : null,
            ),
          ),
        ],
      ),
    );
  }
}
