import 'package:dio/dio.dart';
import 'package:ship_management/models/fish.dart';
import 'package:ship_management/models/tranmission.dart';
import 'package:ship_management/services/database/reamldb/db.dart';
import 'package:ship_management/services/network/api_path.dart';
import 'package:ship_management/services/network/api_service.dart';
import 'package:ship_management/services/shared_data/storage_service.dart';

class TransmissingRepository {
  TransmissingRepository._init();

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

  static Future<List<ThongTinThuMuaTruyenTaiModel>> get list async {
    final res = await RealmDb.getAllTransmission();
    return [
      ...res['data'].map((e) => ThongTinThuMuaTruyenTaiModel.fromJson(e))
    ];
  }

  static Future create(ThongTinThuMuaTruyenTaiModel log) async {
    try {
      final res = await RealmDb.insertTransmission(
        stt: log.stt,
        note: log.note,
        nhatKyKhaiThacId: log.nhatKyKhaiThacId,
        tongSanLuong: log.tongSanLuong ?? '0',
        kinhDo: log.kinhDo,
        viDo: log.viDo,
        thoiGianThuMuaChuyenTai: log.thoiGianThuMuaChuyenTai,
        seafoods: log.sanLuongThuMuaChuyenTais == []
            ? []
            : [
                ...log.sanLuongThuMuaChuyenTais!.map(
                  (e) => {
                    'type': e.type,
                    'quantity': e.quantity,
                    'ThoiDiemBatGap': e.ThoiDiemBatGap,
                    'KhoiLuongCon': e.KhoiLuongCon,
                    'SoLuongUocTinhCon': e.SoLuongUocTinhCon,
                    'KichThuocUocTinh': e.KichThuocUocTinh,
                    'QuaTrinhKhaiThac': e.QuaTrinhKhaiThac,
                    'TinhTrangBatGap': e.TinhTrangBatGap,
                    'ThongTinBoSung': e.ThongTinBoSung,
                  },
                )
              ],
      );
      return ThongTinThuMuaTruyenTaiModel.fromJson(res);
    } catch (e) {
      print(e);
    }
  }

  static Future delete(int id) async {
    return await RealmDb.deleteThongTinTruyenTai(id: id);
  }

  static Future get deleteAllFishingLog async {
    return await RealmDb.deleteAllFishingLog();
  }

  static Future update(ThongTinThuMuaTruyenTaiModel log) async {
    await RealmDb.updateTransmission(
      stt: log.stt,
      note: log.note,
      nhatKyKhaiThacId: log.nhatKyKhaiThacId,
      tongSanLuong: log.tongSanLuong ?? '0',
      kinhDo: log.kinhDo,
      viDo: log.viDo,
      thoiGianThuMuaChuyenTai: log.thoiGianThuMuaChuyenTai,
      seafoods: log.sanLuongThuMuaChuyenTais == []
          ? []
          : [
              ...log.sanLuongThuMuaChuyenTais!.map(
                (e) => {
                  'type': e.type,
                  'quantity': e.quantity,
                  'ThoiDiemBatGap': e.ThoiDiemBatGap,
                  'KhoiLuongCon': e.KhoiLuongCon,
                  'SoLuongUocTinhCon': e.SoLuongUocTinhCon,
                  'KichThuocUocTinh': e.KichThuocUocTinh,
                  'QuaTrinhKhaiThac': e.QuaTrinhKhaiThac,
                  'TinhTrangBatGap': e.TinhTrangBatGap,
                  'ThongTinBoSung': e.ThongTinBoSung,
                },
              )
            ],
    );
  }

  static Future pushNhatKyTruyenTai() async {
    final dataThongTin = await RealmDb.getAllTransmission();
    List<ThongTinThuMuaTruyenTaiModel> listThongTin = [
      ...dataThongTin['data']
          .map((e) => ThongTinThuMuaTruyenTaiModel.fromJson(e))
    ];
    print('${{
      'chuyenBienSo': StorageService.profile?.chuyenBienSo,
      'tauId': StorageService.user?.tauId,
      'thongTinThuMuaChuyenTais':
          listThongTin.map((e) => e.toJsonV2()).toList(),
    }}');
    try {
      final res = await Network().post(
        ApiPath.nhatKyTruyenTai,
        data: {
          'tauId': StorageService.user?.tauId,
          'thongTinThuMuaChuyenTais':
              listThongTin.map((e) => e.toJsonV2()).toList(),
        },
      );

      return res.data['data'];
    } catch (e) {
      return e.toString();
    }
  }
}
