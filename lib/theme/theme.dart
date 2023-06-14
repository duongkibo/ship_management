import 'package:flutter/material.dart';
import 'package:ship_management/theme/theme.dart';

export 'colors.dart';
export 'dimens.dart';
export 'styles.dart';
export 'icons.dart';

class AppTheme {
  static AppTheme? _instance;

  static late final ThemeData _defaultThemeData;

  factory AppTheme.base(ThemeData theme) {
    if (_instance != null) return _instance!;

    _instance = AppTheme._init(theme);
    return _instance!;
  }

  AppTheme._init(ThemeData theme) {
    _defaultThemeData = theme;
  }

  ThemeData get appTheme {
    return _defaultThemeData.copyWith(
      primaryColor: AppColors.primary,
      elevatedButtonTheme: elevatedButtonTheme,
      // outlinedButtonTheme: outlinedButtonTheme,
      // primaryColor: AppColors.black,
      // primaryColorDark: AppColors.black,
      // primaryColorLight: AppColors.black,
      appBarTheme: appBarTheme,
      // iconTheme: IconThemeData(color: AppColors.black),
      scaffoldBackgroundColor: AppColors.background,
      // dialogTheme: dialogTheme,
      // inputDecorationTheme: inputDecorationTheme,
      // tabBarTheme: tabbarTheme,
    );
  }

  AppBarTheme get appBarTheme => AppBarTheme(
        backgroundColor: AppColors.primary,
        titleTextStyle: AppStyles.t20w700(AppColors.white),
        titleSpacing: 0,
        elevation: 0,
      );

  ElevatedButtonThemeData get elevatedButtonTheme {
    return ElevatedButtonThemeData(
      style: ButtonStyle(
        shape: MaterialStateProperty.resolveWith(
          (_) => RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100.dp),
          ),
        ),
        padding: MaterialStateProperty.resolveWith(
          (_) => EdgeInsets.all(16.dp),
        ),
        elevation: MaterialStateProperty.resolveWith((_) => 0),
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.disabled))
            return AppColors.primary.withOpacity(0.5);

          return AppColors.primary;
        }),
      ),
    );
  }
}
