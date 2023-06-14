import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:ship_management/models/seafood.dart';
import 'package:ship_management/models/tranmission.dart';
import 'package:ship_management/repositories/transmissing_repository.dart';
import 'package:ship_management/services/location/location_service.dart';
import 'package:ship_management/services/shared_data/storage_service.dart';
import 'package:ship_management/utils/dialog_helper.dart';
import 'package:ship_management/utils/extensions.dart';

class TransmissingContrller extends GetxController {
  final log = ThongTinThuMuaTruyenTaiModel().obs;

  final dateTimeController = TextEditingController();
  final latController = TextEditingController();
  final longController = TextEditingController();
  final tauId = TextEditingController();
  final tauMuaId = TextEditingController();
  final chuyenBienSo = TextEditingController();
  final noteController = TextEditingController();
  late final LocationData location;

  TransmissingContrller({required ThongTinThuMuaTruyenTaiModel? log}) {
    if (log != null) {
      this.log.value = log;
    }
  }

  Future initData() async {
    DialogHelper.loading();
    location = await LocationService.current;
    dateTimeController.text = DateTime.now().format().toString();
    latController.text = (location.latitude ?? 0).degreeLat.toString() +
        (location.longitude ?? 0).degreeLng.toString();
    //todo check
    tauId.text = StorageService.profile?.soHieuTau.toString() ?? '';
    chuyenBienSo.text = StorageService.profile?.chuyenBienSo.toString() ?? '';
    DialogHelper.dissmisLoading();
    log.value.copyWith(
      kinhDo: (location.latitude ?? 0).degreeLat.toString(),
      viDo: (location.longitude ?? 0).degreeLng.toString(),
      thoiGianThuMuaChuyenTai: dateTimeController.text,
      nhatKyKhaiThacId: int.tryParse(tauMuaId.text) ?? 0,
    );
  }

  Future initDataUpdate() async {
    DialogHelper.loading();
    dateTimeController.text = log.value.thoiGianThuMuaChuyenTai ?? '';
    latController.text = (double.parse(log.value.kinhDo ?? '').degreeLat) +
        (double.parse(log.value.viDo ?? '').degreeLng);
    //todo check
    tauId.text = StorageService.profile?.soHieuTau.toString() ?? '';
    chuyenBienSo.text = StorageService.profile?.chuyenBienSo.toString() ?? '';
    tauMuaId.text = log.value.nhatKyKhaiThacId.toString();
    noteController.text = log.value.note ?? '';
    DialogHelper.dissmisLoading();
  }

  Future addSeafood(Seafood seafood) async {
    List<Seafood> seafoods = [
      ...log.value.sanLuongThuMuaChuyenTais ?? [],
      seafood
    ];
    log.value = log.value.copyWith(sanLuongThuMuaChuyenTais: seafoods);
  }

  Future removeSeafood(Seafood seafood) async {
    List<Seafood> seafoods = [...log.value.sanLuongThuMuaChuyenTais ?? []];
    seafoods.remove(seafood);
    log.value = log.value.copyWith(sanLuongThuMuaChuyenTais: seafoods);
  }

  Future<void> createTransmissing() async {
    if (log.value.sanLuongThuMuaChuyenTais == null ||
        log.value.sanLuongThuMuaChuyenTais!.isEmpty ||
        tauMuaId.text.isEmpty) {
      DialogHelper.confirm(message: 'Yêu cầu điền đầy đủ thông tin');
      return;
    }
    int index = (await TransmissingRepository.list).length;
    DialogHelper.loading();
    try {
      await TransmissingRepository.create(ThongTinThuMuaTruyenTaiModel(
        stt: index + 1,
        note: noteController.text,
        kinhDo: (location.latitude ?? 0).toString(),
        viDo: (location.longitude ?? 0).toString(),
        thoiGianThuMuaChuyenTai: DateTime.now().format('yyyy-MM-ddTHH:mm:ss'),
        nhatKyKhaiThacId: int.tryParse(tauMuaId.text) ?? 0,
        sanLuongThuMuaChuyenTais: log.value.sanLuongThuMuaChuyenTais,
      ));
      DialogHelper.dissmisLoading();
      Get.back();
    } catch (e) {
      DialogHelper.dissmisLoading();
      DialogHelper.confirm(message: 'Có lỗi xảy ra');
    }
  }

  Future<void> updateTransmissing() async {
    if (log.value.sanLuongThuMuaChuyenTais == null ||
        log.value.sanLuongThuMuaChuyenTais!.isEmpty ||
        tauMuaId.text.isEmpty) {
      DialogHelper.confirm(message: 'Yêu cầu điền đầy đủ thông tin');
      return;
    }
    DialogHelper.loading();
    try {
      await TransmissingRepository.update(ThongTinThuMuaTruyenTaiModel(
        stt: log.value.stt,
        note: noteController.text,
        kinhDo: log.value.kinhDo,
        viDo: log.value.viDo,
        thoiGianThuMuaChuyenTai: log.value.thoiGianThuMuaChuyenTai,
        nhatKyKhaiThacId: int.tryParse(tauMuaId.text) ?? 0,
        sanLuongThuMuaChuyenTais: log.value.sanLuongThuMuaChuyenTais,
      ));
      DialogHelper.dissmisLoading();
      Get.back();
    } catch (e) {
      DialogHelper.dissmisLoading();
      DialogHelper.confirm(message: 'Có lỗi xảy ra');
    }
  }
}
