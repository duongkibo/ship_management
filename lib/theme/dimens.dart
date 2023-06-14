import 'dart:math';

import 'package:get/get.dart';

/// Auto resize based in designed screen viewport.
/// This project is [W: 375 pixel, H: 812 pixel] - iphoneX
class Dimens {
  static const _defaultScreenWidth = 375.0;
  static const _defaultScreenHeight = 812.0;
  static double _ratio = 0.0;

  static double get _getRatio {
    if (!_ratio.isEqual(0.0)) {
      return _ratio;
    }

    double ratioWidth = Get.width / _defaultScreenWidth;
    double ratioHeight = Get.height / _defaultScreenHeight;
    _ratio = ratioWidth >= ratioHeight ? ratioWidth : ratioHeight;
    _ratio = min(1, _ratio);
    return _ratio;
  }

  static double dimen(double value) => value * _getRatio;
}

extension NumX on num {
  double get dp => Dimens.dimen(this.toDouble());
}

extension NumNullX on num? {
  double? get dp => this?.dp;
}
