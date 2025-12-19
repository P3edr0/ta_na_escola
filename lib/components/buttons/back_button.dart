import 'package:flutter/material.dart';
import 'package:ta_na_escola/components/buttons/circular_button.dart';

import '../../responsiveness/responsive.dart';
import '../../theme/colors.dart';

class TneBackButton extends StatelessWidget {
  const TneBackButton({super.key, this.onTap});
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: EdgeInsets.only(top: 10.0, left: Responsive.getSize(20)),
        child: TneCircularButton(
          onTap: () async {
            if (onTap != null) {
              onTap!();
              return;
            }
            Navigator.pop(context);
          },
          size: 34,
          child: const Icon(Icons.arrow_back, color: secondaryColor),
        ),
      ),
    );
  }
}
