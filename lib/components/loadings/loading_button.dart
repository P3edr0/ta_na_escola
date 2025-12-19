import 'package:flutter/material.dart';
import 'package:ta_na_escola/theme/colors.dart';

import '../../responsiveness/responsive.dart';

class LoadingButton extends StatelessWidget {
  const LoadingButton({super.key, this.color = secondaryColor, this.size = 30});
  final Color? color;
  final double size;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Responsive.getSize(size + 10),
      width: Responsive.getSize(size + 10),
      child: Center(
        child: SizedBox(
          width: Responsive.getSize(size),
          height: Responsive.getSize(size),
          child: CircularProgressIndicator(strokeWidth: 4, color: color),
        ),
      ),
    );
  }
}
