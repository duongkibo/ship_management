import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class RoundedDropDown<T> extends StatelessWidget {
  final List<T> items;
  final T? value;
  final ValueChanged<T?>? onChanged;
  final String? hintText;
  final Color? borderColor;
  final double? borderRadius;
  final EdgeInsetsGeometry? paddingStyleData;
  final EdgeInsetsGeometry? paddingMenuItem;

  const RoundedDropDown({
    Key? key,
    required this.items,
    this.value,
    this.onChanged,
    this.hintText,
    this.borderColor,
    this.borderRadius,
    this.paddingStyleData,
    this.paddingMenuItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButton2<T>(
      underline: Container(
        height: 1.0,
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.black,
              width: 0.0,
            ),
          ),
        ),
      ),
      isExpanded: true,
      hint: Text(
        hintText ?? '',
        style: TextStyle(color: Colors.black.withOpacity(0.6)),
      ),
      selectedItemBuilder: (_) {
        return items
            .map((item) => DropdownMenuItem<T>(
                  value: item,
                  child: Text(
                    value.toString(),
                    style: TextStyle(color: Colors.black.withOpacity(0.6)),
                  ),
                ))
            .toList();
      },
      items: items
          .map((item) => DropdownMenuItem<T>(
                value: item,
                child: Text(
                  item.toString(),
                  style: TextStyle(color: Colors.black.withOpacity(0.6)),
                ),
              ))
          .toList(),
      buttonStyleData: ButtonStyleData(
        elevation: 1,
      ),
      iconStyleData: IconStyleData(
        icon: Icon(
          Icons.keyboard_arrow_down_rounded,
          color: Colors.black54,
        ),
        iconSize: 28,
        openMenuIcon: Icon(
          Icons.keyboard_arrow_up_rounded,
          color: Colors.black54,
        ),
      ),
      dropdownStyleData: DropdownStyleData(
        maxHeight: 270,
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.fromBorderSide(
            BorderSide(
              color: borderColor ?? Colors.grey,
              width: 1,
            ),
          ),
          borderRadius: const BorderRadius.all(Radius.circular(12)),
        ),
        elevation: 4,
      ),
      menuItemStyleData: MenuItemStyleData(
        padding: paddingMenuItem ?? const EdgeInsets.only(left: 20, right: 20),
      ),
      value: value,
      onChanged: onChanged,
    );
  }
}
