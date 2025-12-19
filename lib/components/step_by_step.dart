import 'package:flutter/material.dart';
import 'package:ta_na_escola/responsiveness/responsive.dart';
import 'package:ta_na_escola/theme/icons.dart';

import '../theme/colors.dart';

class StepByStep extends StatelessWidget {
  const StepByStep({super.key, required this.steps, required this.currentStep});
  final int steps;
  final int currentStep;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: steps,
      itemBuilder: (context, index) {
        if (index == 0) {
          return _step(true);
        }

        if (index <= currentStep - 1) {
          return Row(
            children: [
              Container(
                height: 3,
                width: Responsive.getSize(60),
                color: primaryColor,
              ),
              _step(true),
            ],
          );
        } else {
          return Row(
            children: [
              Container(
                height: 1,
                width: Responsive.getSize(60),
                color: primaryFocusColor,
              ),
              _step(false),
            ],
          );
        }
      },
    );
  }

  Widget _step(bool isSelected) {
    if (isSelected) {
      return CircleAvatar(
        backgroundColor: primaryColor,
        radius: 15,
        child: CircleAvatar(
          backgroundColor: primaryFocusColor,
          radius: 12,
          child: Icon(TneIcons.check, color: secondaryColor, size: 16),
        ),
      );
    }

    return CircleAvatar(
      backgroundColor: primaryFocusColor,
      radius: 15,
      child: CircleAvatar(
        backgroundColor: secondaryColor,
        radius: 14,
        child: CircleAvatar(backgroundColor: primaryFocusColor, radius: 6),
      ),
    );
  }
}
