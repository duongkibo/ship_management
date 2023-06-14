import 'package:dio/dio.dart';
import 'package:ship_management/models/auth.dart';
import 'package:ship_management/models/employee_info.dart';
import 'package:ship_management/models/license_details.dart';
import 'package:ship_management/models/profile.dart';
import 'package:ship_management/services/database/reamldb/db.dart';
import 'package:ship_management/services/network/api_path.dart';
import 'package:ship_management/services/network/api_service.dart';
import 'package:ship_management/services/shared_data/storage_service.dart';

class AuthRepository {
  AuthRepository._init();

  static Future<Auth> login(String username, String pw) async {
    final res = await Network().post(
      ApiPath.login,
      queryParameters: {'UserName': username.trim(), 'Password': pw.trim()},
    );

    if (res.data['succeeded'] != true) {
      throw DioError(
        requestOptions: res.requestOptions,
        error: res.data,
        type: DioErrorType.response,
      );
    }

    return Auth.fromMap(res.data['data'] ?? {});
  }

  static Future logout() async {
    await RealmDb.deleteAllFishingLog();
    await RealmDb.deleteShipLocations();
    await RealmDb.deleteAllTransaction();
    await StorageService.saveToken('');
  }

  static Future<Profile> profile(dynamic tauId) async {
    final res = await Network().get(ApiPath.profile(tauId));
    if (res.data['succeeded'] != true) {
      throw DioError(
        requestOptions: res.requestOptions,
        error: res.data,
        type: DioErrorType.response,
      );
    }

    return Profile.fromMap(res.data['data'] ?? {});
  }
  static Future<List<EmployeeInfo>> profileEmployee(dynamic tauId) async {
    final res = await Network().get(ApiPath.profileEmployee(tauId));
    if (res.data['succeeded'] != true) {
      throw DioError(
        requestOptions: res.requestOptions,
        error: res.data,
        type: DioErrorType.response,
      );
    }
    return [...res.data['data'].map((e) => EmployeeInfo.fromJson(e))];
  }

  static Future<List<LicenseDetail>> licenseDetail({
    dynamic tauId,
    dynamic enumGiayPhep,
  }) async {
    final res =
    await Network().get(ApiPath.getLicenseByTauId(tauId, enumGiayPhep));
    if (res.data['succeeded'] != true) {
      throw DioError(
        requestOptions: res.requestOptions,
        error: res.data,
        type: DioErrorType.response,
      );
    }
    return [...res.data['data'].map((e) => LicenseDetail.fromJson(e))];
  }
}
