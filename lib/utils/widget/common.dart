import 'package:flutter/material.dart';
import 'package:ship_management/theme/theme.dart';

Widget space({double? w, double? h}) {
  return SizedBox(
    width: w,
    height: h,
  );
}

Widget divider({
  double height = 1,
  double? thickness,
  Color? color = AppColors.black,
  double? indent,
  double? endIndent,
  EdgeInsetsGeometry? margin,
}) {
  var divider = Divider(
    height: height,
    thickness: thickness ?? height,
    color: color,
    indent: indent,
    endIndent: endIndent ?? indent,
  );

  if (margin == null) return divider;

  return Padding(padding: margin, child: divider);
}

Widget loadingWidget() {
  return WillPopScope(
    onWillPop: () async => false, // block button back
    child: Material(
      type: MaterialType.transparency,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 34.dp),
            child: itemLoading(),
          ),
        ),
      ),
    ),
  );
}

Widget itemLoading() {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16.dp),
    ),
    padding: EdgeInsets.all(24.dp),
    child: IntrinsicHeight(
      child: Center(
        child: SizedBox(
          width: 80.dp,
          height: 80.dp,
          child: CircularProgressIndicator(
            color: AppColors.primary,
            strokeWidth: 7,
          ),
        ),
      ),
    ),
  );
}
