import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ship_management/routes/routes.dart';
import 'package:ship_management/screens/profile/controlller/profile_employee_controller.dart';
import 'package:ship_management/screens/profile/notification_page.dart';
import 'package:ship_management/screens/profile/profile_employee.dart';
import 'package:ship_management/screens/profile/profile_page.dart';
import 'package:ship_management/theme/theme.dart';
import 'package:ship_management/utils/constants.dart';
import 'package:ship_management/utils/utils.dart';
import 'package:ship_management/utils/widget/custom_tab_view.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late ProfileEmployeeController controller;

  @override
  void initState() {
    controller = Get.put(ProfileEmployeeController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.perlorous,
        title: Text(lang.profileTitle),
      ),
      backgroundColor: AppColors.white,
      body: GetBuilder<ProfileEmployeeController>(
        builder: (_) => Column(
          children: [
            Expanded(child: customForm(context)),
            float(),
          ],
        ),
      ),
    );
  }

  Widget float() => InkWell(
        onTap: () async {
          final result = await Get.toNamed(
            RouteName.employee,
            arguments: {
              'employee': 'created',
            },
          );
          if (result != null) {
            controller.getProfileEmployee();
          }
        },
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.all(Radius.circular(40)),
          ),
          child: Text(
            'Thêm thuyền viên',
            style: TextStyle(color: Colors.white, fontSize: 18.0),
          ),
        ),
      );

  Widget customForm(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: AppColors.perlorous,
          width: MediaQuery.of(context).size.width,
          height: 35.0,
          child: Center(
            child: Text(
              'Home',
              style: TextStyle(color: Colors.white, fontSize: 18.0),
            ),
          ),
        ),
        CustomTabView(
          borderColor: Colors.white,
          itemCount: ProfileType.values.length,
          backgroundColor: Colors.transparent,
          elevation: 0,
          labelStyle: TextStyle(fontWeight: FontWeight.w500, fontSize: 14.dp),
          labelPadding: EdgeInsets.all(16.dp),
          tabBuilder: (context, index) {
            return Text(
              ProfileType.values[index].label,
              textAlign: TextAlign.center,
            );
          },
          selectedColor: AppColors.black,
          unselectedLabelColor: AppColors.white,
          indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(
              100,
            ),
            border: Border.all(
              color: AppColors.linkWater,
              width: 3,
            ),
            color: AppColors.white,
          ),
          pageBuilder: (context, index) {
            switch (ProfileType.values[index]) {
              case ProfileType.notification:
                return NotificationPage();
              case ProfileType.information:
                return ProfilePage();
              case ProfileType.profileEmployee:
                return ProfileEmployee();
            }
          },
        )
      ],
    );
  }
}
