import 'package:realm/realm.dart';

part 'models.g.dart';

@RealmModel()
class _Seafood {
  @PrimaryKey()
  late String id;

  late String? type;
  late double? quantity;

  late DateTime created;

  Map<String, dynamic> get toMap {
    return {'id': id, 'type': type, 'quantity': quantity};
  }
}

@RealmModel()
class _FishingLog {
  @PrimaryKey()
  late String id;

  late String? releaseTime;
  late String? collectionTime;

  late double? releaseLatitude;
  late double? releaseLongitude;
  late double? collectionLatitude;
  late double? collectionLongitude;

  late String? note;
  late List<_Seafood> seafoods;

  late DateTime created;
  late int stt;

  Map<String, dynamic> get toMap {
    return {
      'id': id,
      'stt': stt,
      'release_time': releaseTime,
      'release_lat': releaseLatitude,
      'release_long': releaseLongitude,
      'collection_time': collectionTime,
      'collection_lat': collectionLatitude,
      'collection_long': collectionLongitude,
      'note': note,
      'seafoods': [...seafoods.map((e) => e.toMap)],
    };
  }
}

@RealmModel()
class _ShipLocation {
  @PrimaryKey()
  late String id;
  late double lat;
  late double lng;
  late String time;

  Map<String, dynamic> get toMap {
    return {
      'id': id,
      'lat': lat,
      'lng': lng,
      'time': time,
    };
  }
}

@RealmModel()
class _ThongTinThuMuaTruyenTai {
  @PrimaryKey()
  late int? stt;
  late int? nhatKyKhaiThacId;
  late String? thoiGianThuMuaChuyenTai;
  late String? viDo;
  late String? kinhDo;
  late String? tongSanLuong;
  late String? note;
  late List<_Seafood> seafoods;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['nhatKyKhaiThacId'] = nhatKyKhaiThacId;
    data['stt'] = stt;
    data['thoiGianThuMuaChuyenTai'] = thoiGianThuMuaChuyenTai;
    data['viDo'] = viDo;
    data['note'] = note;
    data['kinhDo'] = kinhDo;
    data['tongSanLuong'] = tongSanLuong;
    data['seafoods'] = [...seafoods.map((e) => e.toMap)];

    return data;
  }
}

@RealmModel()
class _SanLuongThuMuaChuyenTai {
  @PrimaryKey()
  late int? loaiCaId;
  late int? sanLuong;
  late String? ThoiDiemBatGap;
  late int? KhoiLuongCon;
  late int? SoLuongUocTinhCon;
  late int? KichThuocUocTinh;
  late int? QuaTrinhKhaiThac;
  late int? TinhTrangBatGap;
  late String? ThongTinBoSung;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['loaiCaId'] = loaiCaId;
    data['sanLuong'] = sanLuong;
    data['ThoiDiemBatGap'] = ThoiDiemBatGap;
    data['KhoiLuongCon'] = KhoiLuongCon;
    data['SoLuongUocTinhCon'] = SoLuongUocTinhCon;
    data['KichThuocUocTinh'] = KichThuocUocTinh;
    data['QuaTrinhKhaiThac'] = QuaTrinhKhaiThac;
    data['TinhTrangBatGap'] = TinhTrangBatGap;
    data['ThongTinBoSung'] = ThongTinBoSung;

    return data;
  }
}
