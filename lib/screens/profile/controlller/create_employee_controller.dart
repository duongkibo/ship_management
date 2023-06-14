import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ship_management/models/employee_info.dart';
import 'package:ship_management/models/enum_vi_tri.dart';
import 'package:ship_management/repositories/profile_repository.dart';
import 'package:ship_management/services/shared_data/storage_service.dart';
import 'package:ship_management/utils/constants.dart';
import 'package:ship_management/utils/dialog_helper.dart';
import 'package:ship_management/utils/exception.dart';

class CreateEmployeeController extends GetxController {
  final EmployeeType reqType;

  List<EmployeeInfo> profileEmployee = [];
  EmployeeInfo employeeInfo;
  final ngayCap = Rx<DateTime?>(null);
  EnumVitriNhanVien vitri = EnumVitriNhanVien();
  EnumVitri? enumVitri;
  final nameController = TextEditingController();
  final gioiTinhController = TextEditingController();
  final diaChiController = TextEditingController();
  final cccdController = TextEditingController();
  final noiCapController = TextEditingController();
  final soDienThoaiController = TextEditingController();
  final ngayCapController = TextEditingController();
  int? gioiTinhNumber;
   File? file;
   File? fileGiayPhep;
  final List<String> gioiTinh = <String>[
    'Nam',
    'Nữ',
  ];
  String gioiTinhText = 'Nam';

  CreateEmployeeController({required this.reqType, required this.employeeInfo});

  @override
  void onInit() {
    super.onInit();
    getProfileEmployee();
    setInput();
  }
  Future<void> openImageFile() async {
    // #docregion SingleOpen
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
       file = File(result.files.single.path??'');
    }
    update();

  }

  Future<void> openImageFileGiayPhep() async {
    // #docregion SingleOpen
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      fileGiayPhep = File(result.files.single.path??'');
    }
    update();

  }
  void setInput() {
    nameController.text = employeeInfo.tenThuyenVien ?? '';
    gioiTinhController.text = (employeeInfo.gioiTinh == null)
        ? ''
        : (employeeInfo.gioiTinh == 0)
            ? 'Nam'
            : 'Nữ';
    gioiTinhNumber = employeeInfo.gioiTinh;
    diaChiController.text = employeeInfo.diaChi ?? '';
    cccdController.text = employeeInfo.cccd ?? '';
    noiCapController.text = employeeInfo.noiCap ?? '';
    soDienThoaiController.text = employeeInfo.soDienThoai == null
        ? ''
        : employeeInfo.soDienThoai.toString();
    ngayCap.value =
        (employeeInfo.ngayCap == null ? null : employeeInfo.ngayCap!);
    ngayCapController.text = employeeInfo.ngayCap == null
        ? ''
        : DateFormat('dd/MM/yyyy').format(employeeInfo.ngayCap!);
    vitri.enumVitri.forEach((element) {
      if (employeeInfo.enumViTriThuyenVien == element.idVitri) {
        enumVitri = element;
      }
    });
  }

  void getProfileEmployee() {
    profileEmployee = StorageService.profileEmployee;
  }

  Future<bool> getList() async {
    try {
      final result = await ProfileRepository.profileEmployee();
      profileEmployee = result;


      return true;
    } catch (e) {

      await handleException(e);
      return false;
    }
  }

  void change(EnumVitriNhanVien item) {
    vitri = item;

    update();
  }

  void selectVitri(EnumVitri item) {
    enumVitri = item;
    vitri.isExpanded = !(vitri.isExpanded ?? false);

    update();
  }

  void selectGioiTinh(String gioiTinh) {
    gioiTinhNumber = (gioiTinh == 'Nam') ? 0 : 1;
    gioiTinhText = gioiTinh;
    gioiTinhController.text = gioiTinh;
    update();
  }

  void changeTime(DateTime? time) {
    ngayCap.value = time;
    ngayCapController.text = DateFormat('dd/MM/yyyy').format(time!);
  }

  void onConfirm(EmployeeType reqType) {
    switch (reqType) {
      case EmployeeType.created:
        createdProfileEmployee();
        break;
      case EmployeeType.update:
        updateProfileEmployee();
        break;
    }
  }

  Future<void> updateProfileEmployee() async {
    try {
      DialogHelper.loading();
      await ProfileRepository.updateProfileEmployee(
        tenThuyenVien: nameController.text,
        enumViTriThuyenVien: enumVitri!.idVitri!,
        gioiTinh: gioiTinhNumber ?? 0,
        cccd: cccdController.text,
        noiCap: noiCapController.text,
        ngayCap: ngayCap.value!,
        soDienThoai: soDienThoaiController.text,
        diaChis: diaChiController.text,
        diaChi: diaChiController.text,
        id: employeeInfo.id!,
      );
      DialogHelper.dissmisLoading();
      await DialogHelper.confirm(
          message: 'Thành công',
          onPositionPressed: () {
            Get.back(
              result: Container(),
            );
          });
    } catch (e) {
      DialogHelper.dissmisLoading();
      await handleException(e);
    }
  }

  Future<void> createdProfileEmployee() async {
    try {
      DialogHelper.loading();
      await ProfileRepository.requestProfileEmployee(
        tenThuyenVien: nameController.text,
        enumViTriThuyenVien: enumVitri!.idVitri!,
        gioiTinh: gioiTinhNumber ?? 0,
        cccd: cccdController.text,
        noiCap: noiCapController.text,
        ngayCap: ngayCap.value!,
        soDienThoai: soDienThoaiController.text,
        diaChis: diaChiController.text,
        diaChi: diaChiController.text,
      );
      DialogHelper.dissmisLoading();
      await DialogHelper.confirm(
          message: 'Thành công',
          onPositionPressed: () {
            Get.back(
              result: Container(),
            );
          });
    } catch (e) {
      DialogHelper.dissmisLoading();
      await handleException(e);
    }
  }
}
