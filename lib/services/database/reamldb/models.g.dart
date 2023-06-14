// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

class Seafood extends _Seafood with RealmEntity, RealmObjectBase, RealmObject {
  Seafood(
    String id,
    DateTime created, {
    String? type,
    double? quantity,
  }) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'type', type);
    RealmObjectBase.set(this, 'quantity', quantity);
    RealmObjectBase.set(this, 'created', created);
  }

  Seafood._();

  @override
  String get id => RealmObjectBase.get<String>(this, 'id') as String;

  @override
  set id(String value) => RealmObjectBase.set(this, 'id', value);

  @override
  String? get type => RealmObjectBase.get<String>(this, 'type') as String?;

  @override
  set type(String? value) => RealmObjectBase.set(this, 'type', value);

  @override
  double? get quantity =>
      RealmObjectBase.get<double>(this, 'quantity') as double?;

  @override
  set quantity(double? value) => RealmObjectBase.set(this, 'quantity', value);

  @override
  DateTime get created =>
      RealmObjectBase.get<DateTime>(this, 'created') as DateTime;

  @override
  set created(DateTime value) => RealmObjectBase.set(this, 'created', value);

  @override
  Stream<RealmObjectChanges<Seafood>> get changes =>
      RealmObjectBase.getChanges<Seafood>(this);

  @override
  Seafood freeze() => RealmObjectBase.freezeObject<Seafood>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;

  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(Seafood._);
    return const SchemaObject(ObjectType.realmObject, Seafood, 'Seafood', [
      SchemaProperty('id', RealmPropertyType.string, primaryKey: true),
      SchemaProperty('type', RealmPropertyType.string, optional: true),
      SchemaProperty('quantity', RealmPropertyType.double, optional: true),
      SchemaProperty('created', RealmPropertyType.timestamp),
    ]);
  }
}

class FishingLog extends _FishingLog
    with RealmEntity, RealmObjectBase, RealmObject {
  FishingLog(
    String id,
    DateTime created,
    int stt, {
    String? releaseTime,
    String? collectionTime,
    double? releaseLatitude,
    double? releaseLongitude,
    double? collectionLatitude,
    double? collectionLongitude,
    String? note,
    Iterable<Seafood> seafoods = const [],
  }) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'releaseTime', releaseTime);
    RealmObjectBase.set(this, 'collectionTime', collectionTime);
    RealmObjectBase.set(this, 'releaseLatitude', releaseLatitude);
    RealmObjectBase.set(this, 'releaseLongitude', releaseLongitude);
    RealmObjectBase.set(this, 'collectionLatitude', collectionLatitude);
    RealmObjectBase.set(this, 'collectionLongitude', collectionLongitude);
    RealmObjectBase.set(this, 'note', note);
    RealmObjectBase.set(this, 'created', created);
    RealmObjectBase.set(this, 'stt', stt);
    RealmObjectBase.set<RealmList<Seafood>>(
        this, 'seafoods', RealmList<Seafood>(seafoods));
  }

  FishingLog._();

  @override
  String get id => RealmObjectBase.get<String>(this, 'id') as String;

  @override
  set id(String value) => RealmObjectBase.set(this, 'id', value);

  @override
  String? get releaseTime =>
      RealmObjectBase.get<String>(this, 'releaseTime') as String?;

  @override
  set releaseTime(String? value) =>
      RealmObjectBase.set(this, 'releaseTime', value);

  @override
  String? get collectionTime =>
      RealmObjectBase.get<String>(this, 'collectionTime') as String?;

  @override
  set collectionTime(String? value) =>
      RealmObjectBase.set(this, 'collectionTime', value);

  @override
  double? get releaseLatitude =>
      RealmObjectBase.get<double>(this, 'releaseLatitude') as double?;

  @override
  set releaseLatitude(double? value) =>
      RealmObjectBase.set(this, 'releaseLatitude', value);

  @override
  double? get releaseLongitude =>
      RealmObjectBase.get<double>(this, 'releaseLongitude') as double?;

  @override
  set releaseLongitude(double? value) =>
      RealmObjectBase.set(this, 'releaseLongitude', value);

  @override
  double? get collectionLatitude =>
      RealmObjectBase.get<double>(this, 'collectionLatitude') as double?;

  @override
  set collectionLatitude(double? value) =>
      RealmObjectBase.set(this, 'collectionLatitude', value);

  @override
  double? get collectionLongitude =>
      RealmObjectBase.get<double>(this, 'collectionLongitude') as double?;

  @override
  set collectionLongitude(double? value) =>
      RealmObjectBase.set(this, 'collectionLongitude', value);

  @override
  String? get note => RealmObjectBase.get<String>(this, 'note') as String?;

  @override
  set note(String? value) => RealmObjectBase.set(this, 'note', value);

  @override
  RealmList<Seafood> get seafoods =>
      RealmObjectBase.get<Seafood>(this, 'seafoods') as RealmList<Seafood>;

  @override
  set seafoods(covariant RealmList<Seafood> value) =>
      throw RealmUnsupportedSetError();

  @override
  DateTime get created =>
      RealmObjectBase.get<DateTime>(this, 'created') as DateTime;

  @override
  set created(DateTime value) => RealmObjectBase.set(this, 'created', value);

  @override
  int get stt => RealmObjectBase.get<int>(this, 'stt') as int;

  @override
  set stt(int value) => RealmObjectBase.set(this, 'stt', value);

  @override
  Stream<RealmObjectChanges<FishingLog>> get changes =>
      RealmObjectBase.getChanges<FishingLog>(this);

  @override
  FishingLog freeze() => RealmObjectBase.freezeObject<FishingLog>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;

  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(FishingLog._);
    return const SchemaObject(
        ObjectType.realmObject, FishingLog, 'FishingLog', [
      SchemaProperty('id', RealmPropertyType.string, primaryKey: true),
      SchemaProperty('releaseTime', RealmPropertyType.string, optional: true),
      SchemaProperty('collectionTime', RealmPropertyType.string,
          optional: true),
      SchemaProperty('releaseLatitude', RealmPropertyType.double,
          optional: true),
      SchemaProperty('releaseLongitude', RealmPropertyType.double,
          optional: true),
      SchemaProperty('collectionLatitude', RealmPropertyType.double,
          optional: true),
      SchemaProperty('collectionLongitude', RealmPropertyType.double,
          optional: true),
      SchemaProperty('note', RealmPropertyType.string, optional: true),
      SchemaProperty('seafoods', RealmPropertyType.object,
          linkTarget: 'Seafood', collectionType: RealmCollectionType.list),
      SchemaProperty('created', RealmPropertyType.timestamp),
      SchemaProperty('stt', RealmPropertyType.int),
    ]);
  }
}

class ShipLocation extends _ShipLocation
    with RealmEntity, RealmObjectBase, RealmObject {
  ShipLocation(
    String id,
    double lat,
    double lng,
    String time,
  ) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'lat', lat);
    RealmObjectBase.set(this, 'lng', lng);
    RealmObjectBase.set(this, 'time', time);
  }

  ShipLocation._();

  @override
  String get id => RealmObjectBase.get<String>(this, 'id') as String;

  @override
  set id(String value) => RealmObjectBase.set(this, 'id', value);

  @override
  double get lat => RealmObjectBase.get<double>(this, 'lat') as double;

  @override
  set lat(double value) => RealmObjectBase.set(this, 'lat', value);

  @override
  double get lng => RealmObjectBase.get<double>(this, 'lng') as double;

  @override
  set lng(double value) => RealmObjectBase.set(this, 'lng', value);

  @override
  String get time => RealmObjectBase.get<String>(this, 'time') as String;

  @override
  set time(String value) => RealmObjectBase.set(this, 'time', value);

  @override
  Stream<RealmObjectChanges<ShipLocation>> get changes =>
      RealmObjectBase.getChanges<ShipLocation>(this);

  @override
  ShipLocation freeze() => RealmObjectBase.freezeObject<ShipLocation>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;

  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(ShipLocation._);
    return const SchemaObject(
        ObjectType.realmObject, ShipLocation, 'ShipLocation', [
      SchemaProperty('id', RealmPropertyType.string, primaryKey: true),
      SchemaProperty('lat', RealmPropertyType.double),
      SchemaProperty('lng', RealmPropertyType.double),
      SchemaProperty('time', RealmPropertyType.string),
    ]);
  }
}

class ThongTinThuMuaTruyenTai extends _ThongTinThuMuaTruyenTai
    with RealmEntity, RealmObjectBase, RealmObject {
  ThongTinThuMuaTruyenTai(
    int? stt, {
    int? nhatKyKhaiThacId,
    String? thoiGianThuMuaChuyenTai,
    String? viDo,
    String? kinhDo,
    String? tongSanLuong,
    String? note,
    Iterable<Seafood> seafoods = const [],
  }) {
    RealmObjectBase.set(this, 'stt', stt);
    RealmObjectBase.set(this, 'nhatKyKhaiThacId', nhatKyKhaiThacId);
    RealmObjectBase.set(
        this, 'thoiGianThuMuaChuyenTai', thoiGianThuMuaChuyenTai);
    RealmObjectBase.set(this, 'viDo', viDo);
    RealmObjectBase.set(this, 'kinhDo', kinhDo);
    RealmObjectBase.set(this, 'tongSanLuong', tongSanLuong);
    RealmObjectBase.set(this, 'note', note);
    RealmObjectBase.set<RealmList<Seafood>>(
        this, 'seafoods', RealmList<Seafood>(seafoods));
  }

  ThongTinThuMuaTruyenTai._();

  @override
  int? get stt => RealmObjectBase.get<int>(this, 'stt') as int?;

  @override
  set stt(int? value) => RealmObjectBase.set(this, 'stt', value);

  @override
  int? get nhatKyKhaiThacId =>
      RealmObjectBase.get<int>(this, 'nhatKyKhaiThacId') as int?;

  @override
  set nhatKyKhaiThacId(int? value) =>
      RealmObjectBase.set(this, 'nhatKyKhaiThacId', value);

  @override
  String? get thoiGianThuMuaChuyenTai =>
      RealmObjectBase.get<String>(this, 'thoiGianThuMuaChuyenTai') as String?;

  @override
  set thoiGianThuMuaChuyenTai(String? value) =>
      RealmObjectBase.set(this, 'thoiGianThuMuaChuyenTai', value);

  @override
  String? get viDo => RealmObjectBase.get<String>(this, 'viDo') as String?;

  @override
  set viDo(String? value) => RealmObjectBase.set(this, 'viDo', value);

  @override
  String? get kinhDo => RealmObjectBase.get<String>(this, 'kinhDo') as String?;

  @override
  set kinhDo(String? value) => RealmObjectBase.set(this, 'kinhDo', value);

  @override
  String? get tongSanLuong =>
      RealmObjectBase.get<String>(this, 'tongSanLuong') as String?;

  @override
  set tongSanLuong(String? value) =>
      RealmObjectBase.set(this, 'tongSanLuong', value);

  @override
  String? get note => RealmObjectBase.get<String>(this, 'note') as String?;

  @override
  set note(String? value) => RealmObjectBase.set(this, 'note', value);

  @override
  RealmList<Seafood> get seafoods =>
      RealmObjectBase.get<Seafood>(this, 'seafoods') as RealmList<Seafood>;

  @override
  set seafoods(covariant RealmList<Seafood> value) =>
      throw RealmUnsupportedSetError();

  @override
  Stream<RealmObjectChanges<ThongTinThuMuaTruyenTai>> get changes =>
      RealmObjectBase.getChanges<ThongTinThuMuaTruyenTai>(this);

  @override
  ThongTinThuMuaTruyenTai freeze() =>
      RealmObjectBase.freezeObject<ThongTinThuMuaTruyenTai>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;

  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(ThongTinThuMuaTruyenTai._);
    return const SchemaObject(ObjectType.realmObject, ThongTinThuMuaTruyenTai,
        'ThongTinThuMuaTruyenTai', [
      SchemaProperty('stt', RealmPropertyType.int,
          optional: true, primaryKey: true),
      SchemaProperty('nhatKyKhaiThacId', RealmPropertyType.int, optional: true),
      SchemaProperty('thoiGianThuMuaChuyenTai', RealmPropertyType.string,
          optional: true),
      SchemaProperty('viDo', RealmPropertyType.string, optional: true),
      SchemaProperty('kinhDo', RealmPropertyType.string, optional: true),
      SchemaProperty('tongSanLuong', RealmPropertyType.string, optional: true),
      SchemaProperty('note', RealmPropertyType.string, optional: true),
      SchemaProperty('seafoods', RealmPropertyType.object,
          linkTarget: 'Seafood', collectionType: RealmCollectionType.list),
    ]);
  }
}

class SanLuongThuMuaChuyenTai extends _SanLuongThuMuaChuyenTai
    with RealmEntity, RealmObjectBase, RealmObject {
  SanLuongThuMuaChuyenTai({
    int? loaiCaId,
    int? sanLuong,
    String? ThoiDiemBatGap,
    int? KhoiLuongCon,
    int? SoLuongUocTinhCon,
    int? KichThuocUocTinh,
    int? QuaTrinhKhaiThac,
    int? TinhTrangBatGap,
    String? ThongTinBoSung,
  }) {
    RealmObjectBase.set(this, 'loaiCaId', loaiCaId);
    RealmObjectBase.set(this, 'sanLuong', sanLuong);
    RealmObjectBase.set(this, 'ThoiDiemBatGap', ThoiDiemBatGap);
    RealmObjectBase.set(this, 'KhoiLuongCon', KhoiLuongCon);
    RealmObjectBase.set(this, 'SoLuongUocTinhCon', SoLuongUocTinhCon);
    RealmObjectBase.set(this, 'KichThuocUocTinh', KichThuocUocTinh);
    RealmObjectBase.set(this, 'QuaTrinhKhaiThac', QuaTrinhKhaiThac);
    RealmObjectBase.set(this, 'TinhTrangBatGap', TinhTrangBatGap);
    RealmObjectBase.set(this, 'ThongTinBoSung', ThongTinBoSung);
  }

  SanLuongThuMuaChuyenTai._();

  @override
  int? get loaiCaId => RealmObjectBase.get<int>(this, 'loaiCaId') as int?;

  @override
  set loaiCaId(int? value) => RealmObjectBase.set(this, 'loaiCaId', value);

  @override
  int? get sanLuong => RealmObjectBase.get<int>(this, 'sanLuong') as int?;

  @override
  set sanLuong(int? value) => RealmObjectBase.set(this, 'sanLuong', value);

  @override
  String? get ThoiDiemBatGap =>
      RealmObjectBase.get<String>(this, 'ThoiDiemBatGap') as String?;

  @override
  set ThoiDiemBatGap(String? value) =>
      RealmObjectBase.set(this, 'ThoiDiemBatGap', value);

  @override
  int? get KhoiLuongCon =>
      RealmObjectBase.get<int>(this, 'KhoiLuongCon') as int?;

  @override
  set KhoiLuongCon(int? value) =>
      RealmObjectBase.set(this, 'KhoiLuongCon', value);

  @override
  int? get SoLuongUocTinhCon =>
      RealmObjectBase.get<int>(this, 'SoLuongUocTinhCon') as int?;

  @override
  set SoLuongUocTinhCon(int? value) =>
      RealmObjectBase.set(this, 'SoLuongUocTinhCon', value);

  @override
  int? get KichThuocUocTinh =>
      RealmObjectBase.get<int>(this, 'KichThuocUocTinh') as int?;

  @override
  set KichThuocUocTinh(int? value) =>
      RealmObjectBase.set(this, 'KichThuocUocTinh', value);

  @override
  int? get QuaTrinhKhaiThac =>
      RealmObjectBase.get<int>(this, 'QuaTrinhKhaiThac') as int?;

  @override
  set QuaTrinhKhaiThac(int? value) =>
      RealmObjectBase.set(this, 'QuaTrinhKhaiThac', value);

  @override
  int? get TinhTrangBatGap =>
      RealmObjectBase.get<int>(this, 'TinhTrangBatGap') as int?;

  @override
  set TinhTrangBatGap(int? value) =>
      RealmObjectBase.set(this, 'TinhTrangBatGap', value);

  @override
  String? get ThongTinBoSung =>
      RealmObjectBase.get<String>(this, 'ThongTinBoSung') as String?;

  @override
  set ThongTinBoSung(String? value) =>
      RealmObjectBase.set(this, 'ThongTinBoSung', value);

  @override
  Stream<RealmObjectChanges<SanLuongThuMuaChuyenTai>> get changes =>
      RealmObjectBase.getChanges<SanLuongThuMuaChuyenTai>(this);

  @override
  SanLuongThuMuaChuyenTai freeze() =>
      RealmObjectBase.freezeObject<SanLuongThuMuaChuyenTai>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;

  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(SanLuongThuMuaChuyenTai._);
    return const SchemaObject(ObjectType.realmObject, SanLuongThuMuaChuyenTai,
        'SanLuongThuMuaChuyenTai', [
      SchemaProperty('loaiCaId', RealmPropertyType.int,
          optional: true, primaryKey: true),
      SchemaProperty('sanLuong', RealmPropertyType.int, optional: true),
      SchemaProperty('ThoiDiemBatGap', RealmPropertyType.string,
          optional: true),
      SchemaProperty('KhoiLuongCon', RealmPropertyType.int, optional: true),
      SchemaProperty('SoLuongUocTinhCon', RealmPropertyType.int,
          optional: true),
      SchemaProperty('KichThuocUocTinh', RealmPropertyType.int, optional: true),
      SchemaProperty('QuaTrinhKhaiThac', RealmPropertyType.int, optional: true),
      SchemaProperty('TinhTrangBatGap', RealmPropertyType.int, optional: true),
      SchemaProperty('ThongTinBoSung', RealmPropertyType.string,
          optional: true),
    ]);
  }
}
