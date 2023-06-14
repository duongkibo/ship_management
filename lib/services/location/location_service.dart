import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:location/location.dart';
import 'package:path_provider/path_provider.dart';
import 'package:ship_management/models/ship_location.dart';
import 'package:ship_management/repositories/location_repository.dart';
import 'package:ship_management/services/shared_data/storage_service.dart';
import 'package:ship_management/utils/constants.dart';
import 'package:ship_management/utils/dialog_helper.dart';
import 'package:ship_management/utils/extensions.dart';

class LocationService {
  static final _instance = LocationService._init();
  static final _location = Location();

  LocationService._init() {}

  static Location get instanceLocation => _location;

  static LocationService get instance => _instance;

  static Future<bool> requestService() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await _location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _location.requestService();
      await _location.requestPermission();
      if (!_serviceEnabled) {
        return false;
      }
    }

    _permissionGranted = await _location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _location.requestPermission();
      _location.enableBackgroundMode(enable: true);
      if (_permissionGranted != PermissionStatus.granted) {
        return false;
      }
    }

    return true;
  }

  static Future<LocationData> get current async {
    return await _location.getLocation();
  }

  static final _controller = StreamController<LocationData>.broadcast();

  static StreamSubscription<LocationData> listenLog(
      void Function(LocationData data) onData,
      ) {
    return _controller.stream.listen(onData);
  }

  static Timer startLog() {
    return Timer.periodic(
      Duration(seconds: 2),
          (timer) async => _controller.sink.add(await current),
    );
  }

  static Timer? _recordTimer;
  static var recording = false;

  static void startRecord({bool isStart = false}) {
    try {
      if (recording) return;
      recording = true;

      _recordTimer = Timer.periodic(Duration(minutes: 5), (timer) async {
        await _saveLocation();
        await pushLocation();

      });
      if (kDebugMode) print('Start record _recordTimerLocationLog');
    } catch (e) {
      stopRecord;
    }
  }

  static Future pushLocation() async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final listLC = await LocationRepository.locations;
      String data = '';
      listLC.forEach((element) {
        print(element.toString());
        data = data +
            '${element.lat},${element.lng},${element.time.format('ddMMyyyyHHmm')};';
      });
      final myFile = File(
          '${dir.path}/QN${StorageService.profile?.soHieuTau}_${StorageService.profile?.chuyenBienSo}.txt');

      await myFile.writeAsString(data);
      await LocationRepository.pushLocation(myFile);
    } catch (e) {
      print('e$e');
    }
  }

  static Future _saveLocation() async {
    try {
      final location = await current;

      await LocationRepository.insert(
        lat: location.latitude!,
        lng: location.longitude!,
      );

      if (kDebugMode) {
        print(
          'Inserted lat=${location.latitude!} lng=${location.longitude!}',
        );
      }
    } catch (e) {
      if (kDebugMode) print(e);
    }
  }

  static void get stopRecord {
    recording = false;

    if (kDebugMode) print('Stop record');
  }
}
