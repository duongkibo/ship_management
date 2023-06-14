import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SvgIcon extends StatelessWidget {
  final String? path;
  final Widget? child;
  final double width;
  final double height;
  final Color? color;
  final bool autoScale;
  final bool padding;

  const SvgIcon({
    super.key,
    this.path,
    this.child,
    this.width = 24,
    this.height = 24,
    this.color,
    this.autoScale = false,
    this.padding = false,
  }) : assert(path != null || child != null);

  @override
  Widget build(BuildContext context) {
    if (padding) {
      return Container(
        width: 48,
        height: 48,
        alignment: Alignment.center,
        child: _child(),
      );
    } else {
      return _child();
    }
  }

  Widget _child() {
    if (child != null) {
      return autoScale
          ? child!
          : SizedBox(
              width: width,
              height: height,
              child: child,
            );
    }

    return SvgPicture.asset(
      path!,
      width: autoScale ? null : width,
      height: autoScale ? null : height,
      color: color,
    );
  }
}
