import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ship_management/models/fishing_log.dart';
import 'package:ship_management/models/seafood.dart';
import 'package:ship_management/repositories/fishing_log_repository.dart';
import 'package:ship_management/services/location/location_service.dart';
import 'package:ship_management/utils/dialog_helper.dart';
import 'package:ship_management/utils/exception.dart';

class FishingController extends GetxController {
  final log = FishingLog().obs;

  final noteEditor = TextEditingController();

  FishingController({required FishingLog? log}) {
    if (log != null) {
      this.log.value = log;
      noteEditor.text = log.note ?? '';
    }
  }

  Future dropNets() async {
    try {
      DialogHelper.loading();
      final stt = await FishingLogRepository.list;
      print('${stt.length+1}');
      log.value = log.value.copyWith(
          releaseTime: DateTime.now(),
          releaseLocation: await LocationService.current,
          stt: (stt.length + 1));
      print(log.value.stt);

      final res = await FishingLogRepository.create(log.value);
      log.value = res;
      DialogHelper.dissmisLoading();
    } catch (e) {
      DialogHelper.dissmisLoading();
      await handleException(e);
    }
  }

  Future collectNets() async {
    try {
      DialogHelper.loading();
      log.value = log.value.copyWith(
        collectionTime: DateTime.now(),
        collectionLocation: await LocationService.current,
      );

      await FishingLogRepository.update(log.value);
      DialogHelper.dissmisLoading();
    } catch (e) {
      DialogHelper.dissmisLoading();
      await handleException(e);
    }
  }

  Future<bool> updateLog() async {
    try {
      DialogHelper.loading();
      await FishingLogRepository.update(log.value);
      DialogHelper.dissmisLoading();
      return true;
    } catch (e) {
      DialogHelper.dissmisLoading();
      await handleException(e);
      return false;
    }
  }

  Future addSeafood(Seafood seafood) async {
    final seafoods = [...log.value.seafoods, seafood];
    log.value = log.value.copyWith(seafoods: seafoods);
  }

  Future removeSeafood(Seafood seafood) async {
    final seafoods = [...log.value.seafoods];
    seafoods.remove(seafood);
    log.value = log.value.copyWith(seafoods: seafoods);
  }

  Future<bool> deleteLog() async {
    try {
      DialogHelper.loading();
      final res = await FishingLogRepository.delete(log.value);
      DialogHelper.dissmisLoading();
      return res;
    } catch (e) {
      DialogHelper.dissmisLoading();
      await handleException(e);
      return false;
    }
  }

  void changeNote(String? value) {
    log.value = log.value.copyWith(note: value);
  }
}
