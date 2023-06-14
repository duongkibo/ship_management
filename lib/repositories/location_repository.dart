import 'dart:io';

import 'package:dio/dio.dart';
import 'package:ship_management/models/ship_location.dart';
import 'package:ship_management/services/database/reamldb/db.dart';
import 'package:ship_management/services/network/api_path.dart';
import 'package:ship_management/services/network/api_service.dart';
import 'package:ship_management/services/shared_data/storage_service.dart';
import 'package:ship_management/utils/extensions.dart';
import 'package:http_parser/http_parser.dart';

class LocationRepository {
  LocationRepository._init();

  static Future insert({required double lat, required double lng}) async {
    final res = await RealmDb.insertShipLocation(
      lat: lat,
      lng: lng,
      time: DateTime.now().format(),
    );

    return res;
  }

  static Future<List<ShipLocation>> get locations async {
    final res = await RealmDb.getShipLocations();
    return [...res['data'].map((e) => ShipLocation.fromMap(e))];
  }

  static Future get delete async {
    final res = await RealmDb.deleteShipLocations();
    return res;
  }

  static Future pushLocation(File file) async {
    final shipId = StorageService.profile?.id;
    final formData = FormData.fromMap({
      'tauId': shipId,
      'fileLogHanhTrinh': await MultipartFile.fromFile(file.path,
          filename:
              'QN${StorageService.profile?.soHieuTau}_${StorageService.profile?.chuyenBienSo}.txt',
          contentType: MediaType('String', 'txt'))
    });
    final res = await Network().post(ApiPath.pushLocation, data: formData);
    if (res.data['succeeded'] != true) {
      throw DioError(
        requestOptions: res.requestOptions,
        error: res.data,
        type: DioErrorType.response,
      );
    }

    return res.data['data'];
  }
}
