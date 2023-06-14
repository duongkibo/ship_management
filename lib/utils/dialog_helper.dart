import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import 'package:ship_management/utils/utils.dart';
import 'package:ship_management/utils/widget/common.dart';
import 'package:ship_management/utils/widget/dialog.dart';

class DialogHelper {
  DialogHelper._init();

  static bool get isLoading => Get.isDialogOpen ?? false;

  static Future loading() {
    return Get.dialog(loadingWidget());
  }

  static void dissmisLoading() {
    if (isLoading) Get.back();
  }

  static Future<DateTime?> pickTime() async {
    return await showOmniDateTimePicker(
      context: globalContext,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 3652)),
      is24HourMode: true,
      isShowSeconds: false,
      minutesInterval: 1,
      secondsInterval: 1,
      borderRadius: BorderRadius.all(Radius.circular(16)),
      constraints: BoxConstraints(
        maxWidth: 350,
        maxHeight: 650,
      ),
      barrierDismissible: false,
    );
  }

  static Future<DateTime?> selectTime() async {
    return await showOmniDateTimePicker(
      context: globalContext,
      initialDate: DateTime.now(),
      firstDate: DateTime(1930),
      lastDate: DateTime(2030),
      is24HourMode: true,
      isShowSeconds: false,
      minutesInterval: 1,
      secondsInterval: 1,
      borderRadius: BorderRadius.all(Radius.circular(16)),
      constraints: BoxConstraints(
        maxWidth: 350,
        maxHeight: 650,
      ),
      barrierDismissible: false,
    );
  }

  static Future confirm({
    required String message,
    VoidCallback? onPositionPressed,
    VoidCallback? onNegativesPressed,
  }) async {
    return await Get.dialog(
      DialogBase(
        builder: (context) {
          return Text(
            message,
            maxLines: 20,
          );
        },
        onPositionPressed: () {
          Get.back();
          onPositionPressed?.call();
        },
        onNegativePressed: (){
          Get.back();
          onNegativesPressed?.call();
        },
      ),
    );
  }
}
