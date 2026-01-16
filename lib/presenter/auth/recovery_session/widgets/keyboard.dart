import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ta_na_escola/responsiveness/leg_font_style.dart';
import 'package:ta_na_escola/shared/utils/routes/app_navigator.dart';
import 'package:ta_na_escola/shared/utils/routes/app_routes.dart';
import 'package:ta_na_escola/theme/colors.dart';

import '../../../../components/dialogs/error_dialog.dart';
import '../../../../responsiveness/responsive.dart';
import '../../../core/store/core_controller.dart';

class Keyboard extends StatelessWidget {
  Keyboard({super.key});

  final AppNavigator navigator = AppNavigator();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(Responsive.getSize(16)),
      child: Column(
        children: [
          SizedBox(height: Responsive.getSize(20)),
          const Expanded(
            child: Row(
              children: [
                KeyboardButton(value: '1'),
                SizedBox(width: 10),
                KeyboardButton(value: '2'),
                SizedBox(width: 10),
                KeyboardButton(value: '3'),
              ],
            ),
          ),
          const SizedBox(height: 10),
          const Expanded(
            child: Row(
              children: [
                KeyboardButton(value: '4'),
                SizedBox(width: 10),
                KeyboardButton(value: '5'),
                SizedBox(width: 10),
                KeyboardButton(value: '6'),
              ],
            ),
          ),
          const SizedBox(height: 10),
          const Expanded(
            child: Row(
              children: [
                KeyboardButton(value: '7'),
                SizedBox(width: 10),
                KeyboardButton(value: '8'),
                SizedBox(width: 10),
                KeyboardButton(value: '9'),
              ],
            ),
          ),
          const SizedBox(height: 10),
          const Expanded(
            child: Row(
              children: [
                KeyboardButton(
                  value: 'backspace',
                  icon: Icon(Icons.backspace, size: 20, color: primaryColor),
                ),
                SizedBox(width: 10),
                KeyboardButton(value: '0'),
                SizedBox(width: 10),
                KeyboardButton(
                  value: 'done',
                  icon: Icon(Icons.done_all, size: 20, color: primaryColor),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class KeyboardButton extends StatefulWidget {
  const KeyboardButton({super.key, required this.value, this.icon});
  final String value;
  final Widget? icon;

  @override
  State<KeyboardButton> createState() => _KeyboardButtonState();
}

class _KeyboardButtonState extends State<KeyboardButton> {
  bool taped = false;
  final AppNavigator _navigator = AppNavigator();

  @override
  Widget build(BuildContext context) {
    final bool haveIcon = widget.icon != null;
    return Expanded(
      child: InkWell(
        onTap: () async {
          setState(() {
            taped = true;
          });
          final controller = context.read<CoreController>();
          if (haveIcon) {
            if (widget.value == 'done') {
              final response = await controller.loginSession();
              if (response != null) {
                ErrorDialog.show(
                  "Falha ao fazer login",
                  "Senha inválida",
                  context,
                );
              } else {
                controller.clearRecovererPasswordContent();

                _navigator.goto(TneRoutes.home, clearStack: true);
              }
            } else {
              controller.setRecoverPassword(widget.value, true);
            }
          } else {
            final length = controller.setRecoverPassword(widget.value);
            if (length == 6) {
              final response = await controller.loginSession();
              if (response != null) {
                ErrorDialog.show(
                  "Falha ao fazer login",
                  "Senha inválida",
                  context,
                );
              } else {
                if (context.mounted) {
                  controller.clearRecovererPasswordContent();

                  _navigator.goto(TneRoutes.home, clearStack: true);
                }
              }
            }
          }
          log(widget.value);
          Future.delayed(
            Durations.medium2,

            () => setState(() {
              taped = false;
            }),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            color: taped ? accentColor.withValues(alpha: 0.2) : secondaryColor,
            boxShadow: taped
                ? null
                : [
                    BoxShadow(
                      color: mediumGrey,
                      offset: Offset(0, 1),
                      blurRadius: 0.5,
                      spreadRadius: 0.5,
                    ),
                    BoxShadow(
                      color: lightGrey,
                      offset: Offset(0, -1),
                      blurRadius: 0.5,
                      spreadRadius: 0.5,
                    ),
                  ],
            borderRadius: BorderRadius.circular(16),
            border: taped ? Border.all(width: 2, color: lightGrey) : null,
          ),

          alignment: Alignment.center,
          child: haveIcon
              ? widget.icon
              : Text(
                  widget.value,
                  style: TneFontStyle.h3Bold.copyWith(color: primaryColor),
                ),
        ),
      ),
    );
  }
}
