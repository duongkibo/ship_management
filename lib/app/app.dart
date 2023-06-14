import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:ship_management/app/binding.dart';
import 'package:ship_management/lang/config.dart';
import 'package:ship_management/routes/routes.dart';
import 'package:ship_management/theme/theme.dart';
import 'package:ship_management/utils/utils.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: globalKey,
      theme: AppTheme.base(Get.theme).appTheme,
      onGenerateRoute: AppRoutes.generateRoute,
      initialRoute: RouteName.splash,
      initialBinding: AppBinding(),
      enableLog: true,
      localizationsDelegates: [
        L.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: L.delegate.supportedLocales,
    );
  }
}
