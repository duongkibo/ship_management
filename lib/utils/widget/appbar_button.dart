import 'package:flutter/material.dart';
import 'package:ship_management/theme/theme.dart';

class AppbarButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;

  const AppbarButton({
    super.key,
    required this.onPressed,
    required this.child,
  });

  @override
  Widget build(Object context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Container(
        child: child,
        padding: EdgeInsets.symmetric(horizontal: 12.dp, vertical: 6.dp),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.white),
          borderRadius: BorderRadius.circular(32.dp),
        ),
      ),
      style: OutlinedButton.styleFrom(
        padding: EdgeInsets.zero,
        splashFactory: NoSplash.splashFactory,
      ),
    );
  }
}
