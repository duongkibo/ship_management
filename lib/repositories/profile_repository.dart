import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:ship_management/models/employee_info.dart';
import 'package:ship_management/models/nhanvien.dart';
import 'package:ship_management/models/port.dart';
import 'package:ship_management/services/network/api_path.dart';
import 'package:ship_management/services/network/api_service.dart';
import 'package:ship_management/services/shared_data/storage_service.dart';
import 'package:ship_management/utils/extensions.dart';

class ProfileRepository {
  ProfileRepository._init();

  static Future requestProfileEmployee({
    required String tenThuyenVien,
    required int enumViTriThuyenVien,
    required int gioiTinh,
    required String cccd,
    required String noiCap,
    required DateTime ngayCap,
    required String soDienThoai,
    required String diaChis,
    required String diaChi,
  }) async {
    final profile = StorageService.profile;

    final formData = FormData.fromMap({
      'CCCD': cccd,
      'NgayCap': ngayCap.format('yyyy-MM-ddTHH:mm:ss'),
      'TauId': profile?.id,
      'ThuyenVienImg': '<string>',
      'DiaChi': diaChi,
      'NoiCap': noiCap,
      'GioiTinh': gioiTinh,
      'DiaChiIds': diaChis,
      'fileUrl': '<string>',
      'EnumViTriThuyenVien': enumViTriThuyenVien,
      'imageUrl': '<string>',
      'ThuyenVienFile': '<string>',
      'SoDienThoai': soDienThoai,
      'TenThuyenVien': tenThuyenVien,
    });
    final res = await Network().post(ApiPath.employee, data: formData);

    if (res.data['succeeded'] != true) {
      throw DioError(
        requestOptions: res.requestOptions,
        error: res.data,
        type: DioErrorType.response,
      );
    }

    return res.data['data'];
  }

  static Future updateProfileEmployee({
    required int id,
    required String tenThuyenVien,
    required int enumViTriThuyenVien,
    required int gioiTinh,
    required String cccd,
    required String noiCap,
    required DateTime ngayCap,
    required String soDienThoai,
    required String diaChis,
    required String diaChi,
  }) async {
    final profile = StorageService.profile;

    final formData = FormData.fromMap({
      'Id': id,
      'CCCD': cccd,
      'NgayCap': ngayCap.format('yyyy-MM-ddTHH:mm:ss'),
      'TauId': profile?.id,
      'ThuyenVienImg': '<string>',
      'DiaChi': diaChi,
      'NoiCap': noiCap,
      'GioiTinh': gioiTinh,
      'DiaChiIds': diaChis,
      'fileUrl': '<string>',
      'EnumViTriThuyenVien': enumViTriThuyenVien,
      'imageUrl': '<string>',
      'ThuyenVienFile': '<string>',
      'SoDienThoai': soDienThoai,
      'TenThuyenVien': tenThuyenVien,
    });
    final res = await Network().put(ApiPath.employee, data: formData);

    if (res.data['succeeded'] != true) {
      throw DioError(
        requestOptions: res.requestOptions,
        error: res.data,
        type: DioErrorType.response,
      );
    }

    return res.data['data'];
  }

  static Future deleteProfileEmployee({
    required int id,
  }) async {
    final formData = FormData.fromMap({
      'id': id,
    });
    final res = await Network().delete(ApiPath.deleteInfo(id), data: formData);

    if (res.data['succeeded'] != true) {
      throw DioError(
        requestOptions: res.requestOptions,
        error: res.data,
        type: DioErrorType.response,
      );
    }

    return res.data['data'];
  }

  static Future<List<EmployeeInfo>> profileEmployee() async {
    final profile = StorageService.user;
    print('-------profile');
    print(profile?.tauId);
    final res = await Network().get(ApiPath.profileEmployee(profile?.tauId));
    if (res.data['succeeded'] != true) {
      throw DioError(
        requestOptions: res.requestOptions,
        error: res.data,
        type: DioErrorType.response,
      );
    }
    return [...res.data['data'].map((e) => EmployeeInfo.fromJson(e))];
  }
}
