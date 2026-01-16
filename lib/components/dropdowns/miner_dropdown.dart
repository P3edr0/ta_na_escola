import 'package:flutter/material.dart';
import 'package:ta_na_escola/responsiveness/leg_font_style.dart';
import 'package:ta_na_escola/responsiveness/responsive.dart';
import 'package:ta_na_escola/theme/colors.dart';

class TneSecondaryDropdown extends StatefulWidget {
  const TneSecondaryDropdown({
    super.key,
    required this.selectedItem,
    required this.items,
    required this.textColor,
    this.onChanged,
    this.fontSize = 12,
  });
  final String selectedItem;
  final List<String> items;
  final Color textColor;
  final double fontSize;
  final Function(String? value)? onChanged;
  @override
  State<TneSecondaryDropdown> createState() => _TneSecondaryDropdownState();
}

class _TneSecondaryDropdownState extends State<TneSecondaryDropdown> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: Responsive.getSize(8.0)),
      width: double.infinity,
      decoration: BoxDecoration(
        color: secondaryColor,

        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: blueGrey, width: 1),
      ),
      height: Responsive.getSize(40),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          dropdownColor: secondaryColor,
          icon: Icon(
            Icons.keyboard_arrow_down_outlined,
            color: accentColor,
            size: Responsive.getSize(24),
          ),
          focusColor: accentColor.withValues(alpha: 0.1),
          value: widget.selectedItem,
          items: widget.items
              .map(
                (item) => DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: TneFontStyle.bodySec.copyWith(color: accentColor),
                  ),
                ),
              )
              .toList(),
          onChanged: (item) {
            if (widget.onChanged == null) return;
            widget.onChanged!(item);
          },
        ),
      ),
    );
  }
}
