import 'package:flutter/material.dart';
import 'package:ship_management/theme/theme.dart';
import 'package:ship_management/utils/widget/common.dart';

class DialogBase extends StatelessWidget {
  const DialogBase({
    Key? key,
    required this.builder,
    this.positiveLabel,
    this.negativeLabel,
    this.showNegativeButton = false,
    this.showPositionButton = true,
    required this.onPositionPressed,
    this.onNegativePressed,
  }) : super(key: key);

  final String? positiveLabel;
  final String? negativeLabel;
  final bool showNegativeButton;
  final bool showPositionButton;
  final Widget Function(BuildContext context) builder;

  final VoidCallback? onPositionPressed;
  final VoidCallback? onNegativePressed;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false, // block button back
      child: Material(
        type: MaterialType.transparency,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 34.dp),
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: _borderRadius,
                    ),
                    padding: EdgeInsets.all(24.dp),
                    child: IntrinsicHeight(
                      child: Center(
                        child: content(context),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget content(BuildContext context) {
    return Column(
      children: [
        builder(context),
        space(h: 16.dp),
        actionButtons(context),
      ],
    );
  }

  Widget actionButtons(BuildContext context) {
    if (showNegativeButton && showPositionButton) {
      return Row(
        children: [
          Expanded(child: positiveButton(context)),
          space(w: 12.dp),
          Expanded(child: negativeButton(context)),
        ],
      );
    } else if (showNegativeButton) {
      return FractionallySizedBox(
        child: negativeButton(context),
        widthFactor: 0.5,
      );
    } else if (showPositionButton) {
      return FractionallySizedBox(
        child: positiveButton(context),
        widthFactor: 0.5,
      );
    }

    return Container();
  }

  Widget negativeButton(BuildContext context) {
    return OutlinedButton(
      onPressed: onNegativePressed?.call,
      child: Text(negativeLabel ?? 'Cancel'),
      style: OutlinedButton.styleFrom(
        textStyle: AppStyles.t14w400(),
        padding: EdgeInsets.all(13.dp),
      ),
    );
  }

  Widget positiveButton(BuildContext context) {
    return ElevatedButton(
      onPressed: onPositionPressed?.call,
      child: Text(positiveLabel ?? 'Ok'),
      style: ElevatedButton.styleFrom(
        textStyle: AppStyles.t14w400(),
        padding: EdgeInsets.all(13.dp),
      ),
    );
  }

  BorderRadiusGeometry get _borderRadius => BorderRadius.circular(16.dp);

  bool get cancelable => true;
}
