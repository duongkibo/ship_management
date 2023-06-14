import 'package:flutter/widgets.dart';
import 'package:ship_management/theme/colors.dart';
import 'package:ship_management/theme/dimens.dart';

class AppStyles {
  static TextStyle _common(
    double? fontSize,
    FontWeight? fontWeight,
    Color? color, [
    TextDecoration? decoration = TextDecoration.none,
    double? height = 1.25,
  ]) {
    return TextStyle(
      color: color ?? AppColors.black,
      fontWeight: fontWeight,
      fontSize: fontSize?.dp,
      decoration: decoration,
      height: height,
      fontFamily: 'NotoSansJP',
    );
  }

  static TextStyle t14w400([Color? color, double? height]) {
    return _common(14, FontWeight.w400, color, null, height);
  }

  static TextStyle t14w700([Color? color, double? height]) {
    return _common(14, FontWeight.w700, color, null, height);
  }

  static TextStyle t16w700([Color? color, double? height]) {
    return _common(16, FontWeight.w700, color, null, height);
  }

  static TextStyle t16w400([Color? color, double? height]) {
    return _common(16, FontWeight.w400, color, null, height);
  }

  static TextStyle t18w400([Color? color, double? height]) {
    return _common(18, FontWeight.w400, color, null, height);
  }

  static TextStyle t18w700([Color? color, double? height]) {
    return _common(18, FontWeight.w700, color, null, height);
  }

  static TextStyle t20w400([Color? color, double? height]) {
    return _common(20, FontWeight.w400, color, null, height);
  }

  static TextStyle t20w700([Color? color, double? height]) {
    return _common(20, FontWeight.w700, color, null, height);
  }

  static TextStyle t24w700([Color? color, double? height]) {
    return _common(24, FontWeight.w700, color, null, height);
  }
}
