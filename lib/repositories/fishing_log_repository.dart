import 'package:collection/collection.dart';
import 'package:dio/dio.dart';
import 'package:ship_management/models/fish.dart';
import 'package:ship_management/models/fishing_log.dart';
import 'package:ship_management/models/seafood.dart';
import 'package:ship_management/services/database/reamldb/db.dart';
import 'package:ship_management/services/network/api_path.dart';
import 'package:ship_management/services/network/api_service.dart';
import 'package:ship_management/services/shared_data/storage_service.dart';
import 'package:ship_management/utils/extensions.dart';

class FishingLogRepository {
  FishingLogRepository._init();

  static Future<List<Fish>> get listFishes async {
    final res = await Network().get(ApiPath.loaiCa);
    if (res.data['succeeded'] != true) {
      throw DioError(
        requestOptions: res.requestOptions,
        error: res.data,
        type: DioErrorType.response,
      );
    }

    return [...res.data['data'].map((e) => Fish.fromMap(e))];
  }

  static Future<List<FishingLog>> get list async {
    final res = await RealmDb.getAllFishingLogs();
    return [...res['data'].map((e) => FishingLog.fromMap(e))];
  }

  static Future create(FishingLog log) async {
    print('==============>>>>> ${log.stt}');
    final res = await RealmDb.insertFishingLog(
      id: log.stt,
      collectionTime: log.collectionTime?.format(),
      collectionLatitude: log.collectionLat,
      collectionLongitude: log.collectionLong,
      releaseTime: log.releaseTime?.format(),
      releaseLatitude: log.releaseLat,
      releaseLongitude: log.releaseLong,
      note: log.note,
      seafoods: [
        ...log.seafoods.map(
          (e) => {
            'type': e.type,
            'quantity': e.quantity,
          },
        )
      ],
    );

    return FishingLog.fromMap(res);
  }


  static Future delete(FishingLog log) async {
    return await RealmDb.deleteFishingLog(id: log.id);
  }

  static Future get deleteAllFishingLog async {
    return await RealmDb.deleteAllFishingLog();
  }

  static Future update(FishingLog log) async {
    await RealmDb.updateFishingLog(
      id: log.id,
      stt: log.stt!,
      collectionTime: log.collectionTime?.format(),
      collectionLatitude: log.collectionLat,
      collectionLongitude: log.collectionLong,
      releaseTime: log.releaseTime?.format(),
      releaseLatitude: log.releaseLat,
      releaseLongitude: log.releaseLong,
      note: log.note,
      seafoods: [
        ...log.seafoods.map(
          (e) => {
            'type': e.type,
            'quantity': e.quantity,
          },
        )
      ],
    );
  }

  static Future createNhatKyKhaiThac() async {
    final profile = StorageService.profile;
    final logs = await list;
    final res = await Network().post(
      ApiPath.nhatKyKhaiThacAll,
      data: {
        'NgheCauChieuDai': 100,
        'NgheCauSoLuoiCau': 50,
        'NgheLuoiVayReChieuDai': 80,
        'NgheLuoiVayReChieuCao': 20,
        'NgheLuoiChupChuVi': 120,
        'NgheLuoiChupChieuCao': 30,
        'NgheLuoiKeoChieuDaiGiengPhao': 60,
        'NgheLuoiKeoChieuDaiToanBo': 200,
        'NgheKhac': 'Các hoạt động khác',
        'TauId': profile?.id,
        'thongTinKhaiThacs': logs.map((e) => e.toJson()).toList()},
    );

    if (res.data['succeeded'] != true) {
      throw DioError(
        requestOptions: res.requestOptions,
        error: res.data,
        type: DioErrorType.response,
      );
    }

    print('======>> khai tacs>$res');
    return res.data['data'];
  }

  static Future _createThongTinKhaiThac({
    required String nhatKyKhaiThacId,
    required int meSo,
    required FishingLog log,
  }) async {
    final res = await Network().post(
      ApiPath.thongTinKhaiThac,
      data: {
        'MeSo': meSo,
        'ThoiDiemThaLuoi': log.releaseTime?.format('yyyy-MM-ddTHH:mm:ss'),
        'ViDoTha': log.releaseLat.toString(),
        'KinhDoTha': log.releaseLong.toString(),
        'ThoiDiemThuLuoi': log.collectionTime?.format('yyyy-MM-ddTHH:mm:ss'),
        'ViDoThu': log.collectionLat.toString(),
        'KinhDoThu': log.collectionLong.toString(),
        'TongSanLuong': log.total.toInt(),
        'NhatKyKhaiThacId': nhatKyKhaiThacId,
      },
    );

    if (res.data['succeeded'] != true) {
      throw DioError(
        requestOptions: res.requestOptions,
        error: res.data,
        type: DioErrorType.response,
      );
    }

    final thongTinKhaiThacId = res.data['data'].toString();
    await Future.wait(log.seafoods.map(
      (seafood) => _createSanLuongKhaiThac(
        thongTinKhaiThacId: thongTinKhaiThacId,
        seafood: seafood,
      ),
    ));
  }

  static Future _createSanLuongKhaiThac({
    required String thongTinKhaiThacId,
    required Seafood seafood,
  }) async {
    final res = await Network().post(
      ApiPath.sanLuongKhaiThac,
      data: {
        'SanLuong': seafood.quantity.toInt(),
        'LoaiCaId': seafood.type,
        'ThongTinKhaiThacId': thongTinKhaiThacId,
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
}
