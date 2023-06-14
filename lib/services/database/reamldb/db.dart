import 'package:realm/realm.dart';
import 'package:ship_management/services/database/reamldb/models.dart';

class RealmDb {
  RealmDb._init();

  static final _config = Configuration.local(
    [
      Seafood.schema,
      FishingLog.schema,
      ShipLocation.schema,
      ThongTinThuMuaTruyenTai.schema
    ],
  );

  static Future<T> process<T>(Future<T> Function(Realm realm) callback) async {
    final realm = Realm(_config);
    final result = await callback(realm);
    realm.close();
    return result;
  }

  static Future insertFishingLog({
    int? id,
    String? releaseTime,
    double? releaseLatitude,
    double? releaseLongitude,
    String? collectionTime,
    double? collectionLatitude,
    double? collectionLongitude,
    String? note,
    Iterable<Map<String, dynamic>> seafoods = const [],
  }) async {
    print('==========>>>>>xxxxx$id');
    return updateFishingLog(
      releaseTime: releaseTime,
      releaseLatitude: releaseLatitude,
      releaseLongitude: releaseLongitude,
      collectionTime: collectionTime,
      collectionLatitude: collectionLatitude,
      collectionLongitude: collectionLongitude,
      note: note,
      stt: id!,
      seafoods: seafoods,
    );
  }

  static Future<Map<String, dynamic>> getAllFishingLogs() async {
    final result = await process((realm) async {
      final list = realm.query<FishingLog>('TRUEPREDICATE SORT(created ASC)');
      return {'data': list.map((e) => e.toMap).toList()};
    });

    return result;
  }

  static Future<Map<String, dynamic>> getAllTransmission() async {
    final result = await process((realm) async {
      final list = realm.all<ThongTinThuMuaTruyenTai>();

      return {'data': list.map((e) => e.toJson()).toList()};
    });

    return result;
  }

  static Future<Map<String, dynamic>> getAllSanLuong() async {
    final result = await process((realm) async {
      final list = realm.all<SanLuongThuMuaChuyenTai>();

      return {'data': list.map((e) => e.toJson()).toList()};
    });

    return result;
  }

  static Future<bool> deleteAllFishingLog() async {
    return await process<bool>((realm) async {
      return realm.write(() async {
        realm.deleteAll<Seafood>();
        realm.deleteAll<FishingLog>();
        return true;
      });
    });
  }

  static Future<bool> deleteFishingLog({String? id}) async {
    return await process<bool>((realm) async {
      final item = realm.find<FishingLog>(id);
      if (item == null) return false;

      return realm.write(() async {
        realm.deleteMany(item.seafoods);
        realm.delete(item);
        return true;
      });
    });
  }

  static Future<bool> deleteThongTinTruyenTai({int? id}) async {
    return await process<bool>((realm) async {
      final item = realm.find<ThongTinThuMuaTruyenTai>(id);
      if (item == null) return false;

      return realm.write(() async {
        realm.deleteMany(item.seafoods);
        realm.delete(item);
        return true;
      });
    });
  }

  static Future insertTransmission({
    int? stt,
    int? nhatKyKhaiThacId,
    String? thoiGianThuMuaChuyenTai,
    String? viDo,
    String? note,
    String? kinhDo,
    String? tongSanLuong,
    Iterable<Map<String, dynamic>> seafoods = const [],
  }) async {
    final _seafoods = seafoods.map(
      (e) => Seafood(
        Uuid.v4().toString(),
        DateTime.now(),
        type: e['type'],
        quantity: e['quantity'],
      ),
    );

    final realm = Realm(_config);
    realm.write(() {
      realm.add(ThongTinThuMuaTruyenTai(stt,
          note: note,
          nhatKyKhaiThacId: nhatKyKhaiThacId,
          thoiGianThuMuaChuyenTai: thoiGianThuMuaChuyenTai,
          viDo: viDo,
          kinhDo: kinhDo,
          tongSanLuong: tongSanLuong,
          seafoods: _seafoods));
    });
  }

  static Future updateTransmission({
    int? stt,
    int? nhatKyKhaiThacId,
    String? thoiGianThuMuaChuyenTai,
    String? viDo,
    String? note,
    String? kinhDo,
    String? tongSanLuong,
    Iterable<Map<String, dynamic>> seafoods = const [],
  }) async {
    final _seafoods = seafoods.map(
      (e) => Seafood(
        Uuid.v4().toString(),
        DateTime.now(),
        type: e['type'],
        quantity: e['quantity'],
      ),
    );

    final realm = Realm(_config);

    realm.write(() {
      final data = ThongTinThuMuaTruyenTai(stt,
          note: note,
          nhatKyKhaiThacId: nhatKyKhaiThacId,
          thoiGianThuMuaChuyenTai: thoiGianThuMuaChuyenTai,
          viDo: viDo,
          kinhDo: kinhDo,
          tongSanLuong: tongSanLuong,
          seafoods: _seafoods);
      realm.add(data, update: true);
    });
  }

  static Future updateFishingLog({
    String? id,
    required int stt,
    String? releaseTime,
    double? releaseLatitude,
    double? releaseLongitude,
    String? collectionTime,
    double? collectionLatitude,
    double? collectionLongitude,
    String? note,
    Iterable<Map<String, dynamic>> seafoods = const [],
  }) async {
    final _seafoods = seafoods.map(
      (e) => Seafood(
        Uuid.v4().toString(),
        DateTime.now(),
        type: e['type'],
        quantity: e['quantity'],
      ),
    );

    return await process((realm) async {
      return await realm.write(() async {
        final item = realm.find<FishingLog>(id);
        realm.deleteMany(item?.seafoods ?? <Seafood>[]);

        final data = FishingLog(
          item?.id ?? Uuid.v4().toString(),
          item?.created ?? DateTime.now(),
          stt,
          releaseTime: releaseTime,
          releaseLatitude: releaseLatitude,
          releaseLongitude: releaseLongitude,
          collectionTime: collectionTime,
          collectionLatitude: collectionLatitude,
          collectionLongitude: collectionLongitude,
          note: note,
          seafoods: _seafoods,
        );

        final res = realm.add<FishingLog>(data, update: true);
        return res.toMap;
      });
    });
  }

  static Future insertShipLocation({
    required double lat,
    required double lng,
    required String time,
  }) async {
    return await process((realm) async {
      return await realm.write(() async {
        final res = realm.add(ShipLocation(
          Uuid.v4().toString(),
          lat,
          lng,
          time,
        ));

        return res.toMap;
      });
    });
  }

  static Future<Map<String, dynamic>> getShipLocations() async {
    final result = await process((realm) async {
      final list = realm.query<ShipLocation>('TRUEPREDICATE SORT(time DESC)');
      return {'data': list.map((e) => e.toMap).toList()};
    });

    return result;
  }

  static Future deleteShipLocations() async {
    return await process<bool>((realm) async {
      return realm.write(() async {
        realm.deleteAll<ShipLocation>();
        return true;
      });
    });
  }

  static Future deleteAllTransaction() async {
    return await process<bool>((realm) async {
      return realm.write(() async {
        realm.deleteAll<ThongTinThuMuaTruyenTai>();
        return true;
      });
    });
  }
}
