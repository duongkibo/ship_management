import 'dart:io';
import 'package:dio/dio.dart';
import 'package:ship_management/models/port.dart';
import 'package:ship_management/services/network/api_path.dart';
import 'package:ship_management/services/network/api_service.dart';
import 'package:ship_management/services/shared_data/storage_service.dart';
import 'package:ship_management/utils/extensions.dart';
import 'package:http_parser/http_parser.dart';
class ReqPortRepository {
  ReqPortRepository._init();

  static Future<List<Port>> get listPorts async {
    final res = await Network().get(ApiPath.port);
    if (res.data['succeeded'] != true) {
      throw DioError(
        requestOptions: res.requestOptions,
        error: res.data,
        type: DioErrorType.response,
      );
    }

    return [...res.data['data'].map((e) => Port.fromMap(e))];
  }

  static Future requestImport({
    required dynamic portId,
    required DateTime importTime,
    required File file,
    required String lyDo,
  }) async {
    try {
      final profile = StorageService.profile;
      final formData = FormData.fromMap({
        'isSoNhatKyKhaiThac': false,
        'isSoNhatKyThuMua': false,
        'isBaoCaoThamDo': false,
        'ngayXuatCang': importTime.format('yyyy-MM-ddTHH:mm:ss'),
        'noiXuatCangId': portId,
        'soThuyenVien': 2,
        'vungBienKhaiThac': '<string>',
        'tongSoNgayDanhBat': 2,
        'lyDoNhapCang': lyDo,
        'cangCaId': portId,
        'tauId': profile?.id,
        'thoiGianYeuCau': importTime.format('yyyy-MM-ddTHH:mm:ss'),
        'thoiGianThucTe': importTime.format('yyyy-MM-ddTHH:mm:ss'),
        'thoiGianDangKy': importTime.format('yyyy-MM-ddTHH:mm:ss'),
        'noiDung': '<string>',
        'soBienBanKiemTra': '<string>',
        'ghiChu': '<string>',
        'ngheHoatDong': 1,
        'chieuDaiLonNhat': 1,
        'nguoiYeuCauNhapCang': '<string>',
        'thuyenTruongId': 1,
      });
      final res = await Network().post(ApiPath.reqImport, data: formData);

      if (res.data['succeeded'] != true) {
        throw DioError(
          requestOptions: res.requestOptions,
          error: res.data,
          type: DioErrorType.response,
        );
      }

      return res.data['data'];
    } catch(e)
    {
      print('=-==>>> $e');
    }
  }

  static Future requestExport({
    required dynamic portId,
    required DateTime exportTime,
    required List<int> listNhanVien,
    required String lydo,
  }) async {
    final profile = StorageService.profile;
    final res = await Network().post(
      ApiPath.reqExport,
      data: {
        'trangThaiXuatCang': 1,
        'ngayXuatCang': exportTime.format('yyyy-MM-ddTHH:mm:ss'),
        'cangCaId': portId,
        'soThuyenVien': '1',
        'lyDoXuatCang': lydo,
        'thoiGianDuyet': exportTime.format('yyyy-MM-ddTHH:mm:ss'),
        'tauId': profile?.id,
        'mongoDbId': '<string>',
        'noiDung': '<string>',
        'soBienBanKiemTra': '<string>',
        'ghiChu': '<string>',
        'thuyenVienRaKhoiIds': listNhanVien.map((e) => e).toList(),
        'thoiGianYeuCau': exportTime.format('yyyy-MM-ddTHH:mm:ss'),
        'thoiGianThucTe': exportTime.format('yyyy-MM-ddTHH:mm:ss'),
        'thoiGianDangKy': exportTime.format('yyyy-MM-ddTHH:mm:ss'),
        'ngheHoatDong': 1,
        'chieuDaiLonNhat': 1,
        'nguoiYeuCauXuatCang': '<string>',
      },
    );

    if (res.data['succeeded'] != true) {
      throw DioError(
        requestOptions: res.requestOptions,
        error: res.data,
        type: DioErrorType.response,
      );
    }

    return res.data['data'];
  }

  static Future<dynamic> checkReqExportStatus() async {
    final id = StorageService.reqPortId;
    final res = await Network().get(ApiPath.getReqExport(id));

    if (res.data['succeeded'] != true) {
      throw DioError(
        requestOptions: res.requestOptions,
        error: res.data,
        type: DioErrorType.response,
      );
    }
   print('=====>>>${res.data['data']}');
    return res.data['data'];
  }

  static Future<dynamic> checkReqImportStatus() async {
    final id = StorageService.reqPortId;
    final res = await Network().get(ApiPath.getReqImport(id));
   print('====>>>>>>$res');
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
