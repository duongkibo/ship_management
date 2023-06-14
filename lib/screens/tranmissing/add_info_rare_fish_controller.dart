import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:ship_management/models/fish.dart';
import 'package:ship_management/utils/dialog_helper.dart';
import 'package:ship_management/utils/extensions.dart';

class InfoRareFishController extends GetxController {
  final dateTimeController = TextEditingController();
  final massController = TextEditingController();
  final quantityController = TextEditingController();
  final sizeController = TextEditingController();
  final additionalInformation = TextEditingController();
  final focusTime = Rx<DateTime?>(null);
  late final LocationData location;

  InfoRareFishController();

  void changeTime(DateTime? time) {
    focusTime.value = time;
    dateTimeController.text = time?.format('yyyy-MM-ddTHH:mm:ss') ?? '';
  }

  checkValid({
    Fish? fish,
    int? quatrinhKhaiThac,
    int? tinhTrangBatGap,
  }) {
    if (quatrinhKhaiThac == null ||
        tinhTrangBatGap == null && dateTimeController.text.isEmpty ||
        massController.text.isEmpty ||
        quantityController.text.isEmpty ||
        sizeController.text.isEmpty) {

      DialogHelper.confirm(message: 'Yêu cầu điền đầy đủ thông tin');

      return ;
    }
  }
}
