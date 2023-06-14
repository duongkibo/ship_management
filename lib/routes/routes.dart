import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ship_management/log/log_screen.dart';
import 'package:ship_management/screens/fishing/fishing_screen.dart';
import 'package:ship_management/screens/fishing_log/fishing_log_screen.dart';
import 'package:ship_management/screens/home/home_screen.dart';
import 'package:ship_management/screens/login/login_screen.dart';
import 'package:ship_management/screens/map/map_screen.dart';
import 'package:ship_management/screens/note_transaction/note_transaction_screen.dart';
import 'package:ship_management/screens/profile/created_employee.dart';
import 'package:ship_management/screens/profile/profile_screen.dart';
import 'package:ship_management/screens/req_port/req_port_screen.dart';
import 'package:ship_management/screens/splash/splash_screen.dart';
import 'package:ship_management/screens/tranmissing/add_information_rare_fish.dart';
import 'package:ship_management/screens/tranmissing/transmissing_screen.dart';
import 'package:ship_management/screens/tranmissing/update_transmissing_screen.dart';

class RouteName {
  static const String splash = '/';
  static const String login = '/login';
  static const String home = '/home';
  static const String reqPort = '/req-port';
  static const String fishingLog = '/fishing-log';
  static const String fishing = '/fishing';
  static const String profile = '/profile';
  static const String log = '/log';
  static const String noteTransaction = '/noteTransaction';
  static const String transmissing = '/transmissing';
  static const String updateTransmissing = '/updateTransmissing';
  static const String map = '/map';
  static const String employee = '/employee-port';
  static const String infoRareFish = '/information-rare-fish';
}

class AppRoutes {
  static final _screens = <String, Widget Function()>{
    RouteName.splash: () => SplashScreen(),
    RouteName.login: () => LoginScreen(),
    RouteName.home: () => HomeScreen(),
    RouteName.reqPort: () => ReqPortScreen(),
    RouteName.fishing: () => FishingScreen(),
    RouteName.fishingLog: () => FishingLogScreen(),
    RouteName.profile: () => ProfileScreen(),
    RouteName.log: () => LogScreen(),
    RouteName.noteTransaction: () => NoteTransactionScreen(),
    RouteName.transmissing: () => TransmissingScreen(),
    RouteName.updateTransmissing: () => UpdateTransmissingScreen(),
    RouteName.map: () => MapScreen(),
    RouteName.employee: () => CreatedEmployee(),
    RouteName.infoRareFish: () => AddInfoRareFish(),
  };

  static final _bindings = <String, List<Bindings> Function()>{};

  static Route<Widget> generateRoute(RouteSettings settings) {
    return GetPageRoute(
      settings: settings,
      page: _screens[settings.name] ?? _undefined,
      bindings: _bindings[settings.name]?.call(),
    );
  }

  static Widget _undefined() {
    return Scaffold(body: Center(child: Text('Undefined')));
  }
}
