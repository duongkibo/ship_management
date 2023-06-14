import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ship_management/routes/routes.dart';
import 'package:ship_management/services/shared_data/storage_service.dart';
import 'package:ship_management/theme/colors.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 1), checkSession);
  }

  Future checkSession() async {
    final token = StorageService.token;

    if (token.isNotEmpty) {
      Get.offNamed(RouteName.home);
    } else {
      Get.offNamed(RouteName.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ColoredBox(color: AppColors.white);
  }
}
