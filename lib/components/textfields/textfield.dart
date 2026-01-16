import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../responsiveness/leg_font_style.dart';
import '../../responsiveness/responsive.dart';
import '../../theme/colors.dart';
import '../../theme/icons.dart';

class TneTextfield extends StatefulWidget {
  const TneTextfield({
    super.key,
    required this.controller,
    required this.hint,
    this.onFieldSubmitted,
    this.isObscureText = false,
    this.label,
    this.enable = true,
    this.hasLabel = false,
    this.suffix,
    this.formatter,
    this.onChanged,
    this.validator,
    this.onEditingComplete,
    this.inputType = TextInputType.emailAddress,
    this.inputAction = TextInputAction.done,
    this.maxLength,
    this.radius = 10,
    this.maxLines = 1,
    this.alignment = Alignment.center,
    this.padding = EdgeInsets.zero,
  });
  final TextEditingController controller;
  final String hint;
  final AlignmentGeometry alignment;
  final Widget? suffix;
  final FormFieldValidator? validator;
  final String? label;
  final bool isObscureText;
  final bool enable;
  final bool hasLabel;
  final TextInputType inputType;
  final TextInputAction inputAction;
  final double radius;
  final int? maxLength;
  final int? maxLines;
  final List<TextInputFormatter>? formatter;
  final Function(String)? onChanged;
  final Function()? onEditingComplete;
  final EdgeInsets padding;

  final Function(String value)? onFieldSubmitted;

  @override
  State<TneTextfield> createState() => _TneTextfieldState();
}

class _TneTextfieldState extends State<TneTextfield> {
  bool isObscure = true;

  @override
  void initState() {
    super.initState();
    isObscure = widget.isObscureText;
  }

  bool hasError = false;
  @override
  Widget build(BuildContext context) {
    final hasSuffix = widget.isObscureText;
    EdgeInsets contentPadding = EdgeInsets.only(
      top: hasError
          ? Responsive.getSize(18)
          : hasSuffix
          ? Responsive.getSize(8)
          : Responsive.getSize(0),
      left: Responsive.getSize(6),
    );
    EdgeInsets suffixPadding = EdgeInsets.only(
      top: hasError ? Responsive.getSize(18) : Responsive.getSize(0),
      left: Responsive.getSize(6),
    );
    Widget? handledSuffix;
    if (widget.isObscureText) {
      handledSuffix = Padding(
        padding: suffixPadding,
        child: InkWell(
          onTap: () {
            setState(() {
              isObscure = !isObscure;
            });
          },
          child: Icon(isObscure ? TneIcons.visibleOff : TneIcons.visible),
        ),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) ...[
          Padding(
            padding: EdgeInsets.only(left: Responsive.getSize(2.0)),
            child: Text(widget.label!, style: TneFontStyle.titleBold),
          ),
          SizedBox(height: Responsive.getSize(10)),
        ],
        Container(
          alignment: widget.alignment,
          padding: widget.padding,
          height: Responsive.getSize(56.0 * widget.maxLines!),
          decoration: BoxDecoration(
            color: lightGrey,

            border: Border(
              bottom: BorderSide(color: primaryFocusColor, width: 1),
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(widget.radius),
              topRight: Radius.circular(widget.radius),
            ),
          ),
          width: double.infinity,
          child: TextFormField(
            style: TneFontStyle.bodyLargeBoldSec.copyWith(color: primaryColor),

            onEditingComplete: widget.onEditingComplete,
            enabled: widget.enable,
            textInputAction: widget.inputAction,
            maxLines: widget.maxLines,
            decoration: InputDecoration(
              hintText: widget.hint,
              hintStyle: TneFontStyle.bodyLargeSec.copyWith(color: grey),
              border: InputBorder.none,
              labelStyle: TneFontStyle.bodyLargeBoldSec.copyWith(
                color: primaryColor,
              ),
              suffixIcon: handledSuffix,

              contentPadding: contentPadding,
            ),
            keyboardType: widget.inputType,
            obscureText: isObscure,
            inputFormatters: widget.formatter,
            onFieldSubmitted: widget.onFieldSubmitted,
            controller: widget.controller,
            validator: (value) {
              final isValid = widget.validator?.call(value);
              if (isValid != null) {
                setState(() {
                  hasError = true;
                });
              } else {
                setState(() {
                  hasError = false;
                });
              }
              return isValid;
            },
            onChanged: widget.onChanged,
            maxLength: widget.maxLength,
          ),
        ),
      ],
    );
  }
}
