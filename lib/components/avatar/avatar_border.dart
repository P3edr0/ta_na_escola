import 'package:flutter/material.dart';

import '../../responsiveness/responsive.dart';
import '../../theme/colors.dart';

class TneAvatarBorder extends StatelessWidget {
  const TneAvatarBorder({
    super.key,
    required this.image,
    required this.radius,
    this.hasBottomPadding = false,
  });
  final ImageProvider image;
  final double radius;
  final bool hasBottomPadding;
  @override
  Widget build(BuildContext context) {
    final handledPadding = hasBottomPadding
        ? EdgeInsets.only(bottom: Responsive.getSize(10))
        : EdgeInsets.zero;
    return Padding(
      padding: handledPadding,
      child: Row(
        children: [
          const Spacer(),
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: transparent,
              border: Border.all(width: 2, color: accentColor),
            ),
            padding: EdgeInsets.all(2),
            child: CircleAvatar(
              radius: Responsive.getSize(radius),
              backgroundImage: image,
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
