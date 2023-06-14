import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:path_provider/path_provider.dart';
import 'package:ship_management/models/employee_info.dart';
import 'package:ship_management/models/nhanvien.dart';
import 'package:ship_management/models/port.dart';
import 'package:ship_management/repositories/location_repository.dart';
import 'package:ship_management/repositories/req_port_repository.dart';
import 'package:ship_management/services/shared_data/storage_service.dart';
import 'package:ship_management/utils/constants.dart';
import 'package:ship_management/utils/dialog_helper.dart';
import 'package:ship_management/utils/exception.dart';
import 'package:ship_management/utils/extensions.dart';

class ReqPortController extends GetxController {
  final ReqType reqType;
  final avaiablePorts = <Port>[].obs;

  final timeEditor = TextEditingController();
  final lyDoNhapCang = TextEditingController();

  final selectedPort = Rx<Port?>(null);
  final focusTime = Rx<DateTime?>(null);
  late File myFile;

  ReqPortController({required this.reqType});

  @override
  void onInit() {
    super.onInit();
    getProfileEmployee();
  }

  @override
  void onReady() {
    super.onReady();
    fetchAvaiablePorts();
  }

  List<int> listNhanVien = [];
  List<EmployeeInfo> profileEmployee = [];

  void getProfileEmployee() {
    profileEmployee = StorageService.profileEmployee;
  }

  void addNhanVien(int id) {
    listNhanVien.add(id);
    update();
  }

  void removeNhanVien(int? id) {
    listNhanVien.removeWhere(
      (element) {
        return element == id;
      },
    );
    update();
  }

  void change(EmployeeInfo item) {
    profileEmployee.forEach((element) {
      if (item == element) {
        element = item;
      }
    });
    update();
  }

  Future fetchAvaiablePorts() async {
    try {
      DialogHelper.loading();
      await Future.delayed(Duration(seconds: 2));
      final res = await ReqPortRepository.listPorts;
      avaiablePorts.assignAll(res);
      DialogHelper.dissmisLoading();
    } catch (e) {
      DialogHelper.dissmisLoading();
      await handleException(e);
    }
  }

  void changePort(Port? port) => selectedPort.value = port;

  void changeTime(DateTime? time) {
    focusTime.value = time;
    timeEditor.text = time?.format() ?? '';
  }

  Future<bool> request() async {
    switch (reqType) {
      case ReqType.import:
        await writeData();
        return await _requestImport();
      case ReqType.export:
        return await _requestExport();
    }
  }

  Future<bool> _requestExport() async {
    try {
      DialogHelper.loading();
      if (listNhanVien.isEmpty) {
        DialogHelper.dissmisLoading();
        DialogHelper.confirm(message: 'Nhân Viên Không được trống');

        return false;
      }
      final res = await ReqPortRepository.requestExport(
          portId: selectedPort.value!.id,
          exportTime: focusTime.value!,
          listNhanVien: listNhanVien,
          lydo: lyDoNhapCang.text);
      await StorageService.saveReqPortId(res);
      await StorageService.saveTripStatus(TripStatus.waitExport);

      DialogHelper.dissmisLoading();
      await DialogHelper.confirm(message: 'Đã gửi yêu cầu xuất cảng.');
      return true;
    } catch (e) {
      DialogHelper.dissmisLoading();
      await handleException(e);
      return false;
    }
  }

  Future<String> getDirPath() async {
    final dir = await getApplicationDocumentsDirectory();

    return dir.path;
  }

  Future writeData() async {
    final dirPath = await getDirPath();
    final listLC = await LocationRepository.locations;
    String data = '';
    listLC.forEach((element) {
      print(element.toString());
      data = data +
          '${element.lat},${element.lng},${element.time.format('ddMMyyyyHHmm')};';
    });
    myFile = File(
        '$dirPath/QN${StorageService.profile?.soHieuTau}_${StorageService.profile?.chuyenBienSo}.txt');

    await myFile.writeAsString(data);
  }

  Future<bool> _requestImport() async {
    try {
      DialogHelper.loading();
      final res = await ReqPortRepository.requestImport(
          portId: selectedPort.value!.id,
          importTime: focusTime.value!,
          lyDo: lyDoNhapCang.text,
          file: myFile);

      await StorageService.saveReqPortId(res);
      await StorageService.saveTripStatus(TripStatus.waitImport);

      DialogHelper.dissmisLoading();
      await DialogHelper.confirm(message: 'Đã gửi yêu cầu nhập cảng.');
      return true;
    } catch (e) {
      DialogHelper.dissmisLoading();
      await handleException(e);
      return false;
    }
  }
}
