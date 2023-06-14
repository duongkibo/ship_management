import 'package:equatable/equatable.dart';
import 'package:location/location.dart';
import 'package:ship_management/models/seafood.dart';
import 'package:ship_management/utils/extensions.dart';

class FishingLog extends Equatable {
  final String? id;
  final DateTime? releaseTime;
  final double? releaseLat;
  final double? releaseLong;
  final DateTime? collectionTime;
  final double? collectionLat;
  final double? collectionLong;
  final String? note;
  final List<Seafood> seafoods;
  final  int? stt;

  FishingLog({
    this.id,
    this.releaseTime,
    this.releaseLat,
    this.releaseLong,
    this.collectionTime,
    this.collectionLat,
    this.collectionLong,
    this.note,
    this.seafoods = const [],
    this.stt,
  });

  double get total => seafoods.fold(0.0, (v, e) => v + e.quantity);

  String get releaseLocation {
    if (releaseLat == null || releaseLong == null) return '';
    return '${releaseLat?.degreeLat}, ${releaseLong?.degreeLng}';
  }

  String get collectionLocation {
    if (collectionLat == null || collectionLong == null) return '';
    return '${collectionLat?.degreeLat}, ${collectionLong?.degreeLng}';
  }

  bool get canEdit {
    return releaseLat != null && releaseLong != null 
    && collectionLat != null && collectionLong != null;
  }

  List<Seafood> get sortedSeafoods {
    return seafoods..sort((a, b) => b.quantity.compareTo(a.quantity));
  }

  factory FishingLog.fromMap(Map<String, dynamic> map) {
    print('======>>>>$map');
    return FishingLog(
      id: map['id'],
      releaseTime: map['release_time'].toString().toDate(),
      releaseLat: map['release_lat'],
      releaseLong: map['release_long'],
      collectionTime: map['collection_time'].toString().toDate(),
      collectionLat: map['collection_lat'],
      collectionLong: map['collection_long'],
      note: map['note'] ?? '',
      stt: map['stt'] ?? '',
      seafoods: [...map['seafoods'].map((e) => Seafood.fromMap(e))],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();

    data['meSo'] = stt;
    data['thoiDiemThaLuoi'] = releaseTime?.format('yyyy-MM-ddTHH:mm:ss');
    data['viDoTha'] = releaseLat.toString();
    data['kinhDoTha'] = releaseLong.toString();
    data['ghiChu'] = note;
    data['thoiDiemThuLuoi'] = collectionTime?.format('yyyy-MM-ddTHH:mm:ss');
    data['viDoThu'] = collectionLat.toString();
    data['kinhDoThu'] = collectionLong.toString();
    data['tongSanLuong'] = total.toInt();

    if (seafoods != null) {
      data['sanLuongKhaiThacs'] = seafoods.map((v) => v.toJsonV2()).toList();
    } else {
      data['sanLuongKhaiThacs'] = null;
    }

    return data;
  }

  FishingLogState get state {
    if (releaseTime != null && releaseLat != null && releaseLong != null) {
      if (collectionTime != null &&
          collectionLat != null &&
          collectionLong != null) {
        return FishingLogState.collected;
      } else {
        return FishingLogState.dropped;
      }
    } else {
      return FishingLogState.empty;
    }
  }

  FishingLog copyWith({
    DateTime? releaseTime,
    LocationData? releaseLocation,
    DateTime? collectionTime,
    LocationData? collectionLocation,
    String? note,
    List<Seafood>? seafoods,
    int? stt,
  }) {
    return FishingLog(
      id: id,
      releaseTime: releaseTime ?? this.releaseTime,
      releaseLat: releaseLocation?.latitude ?? releaseLat,
      releaseLong: releaseLocation?.longitude ?? releaseLong,
      collectionTime: collectionTime ?? this.collectionTime,
      collectionLat: collectionLocation?.latitude ?? collectionLat,
      collectionLong: collectionLocation?.longitude ?? collectionLong,
      note: note ?? this.note,
      seafoods: seafoods ?? this.seafoods,
      stt: stt ?? this.stt,
    );
  }

  @override
  List<Object?> get props {
    return [
      this.id,
      this.releaseTime,
      this.collectionTime,
      this.note,
      this.seafoods,
    ];
  }
}

enum FishingLogState { empty, dropped, collected }

extension FishingLogStateX on FishingLogState {
  bool get isEmpty => this == FishingLogState.empty;
  bool get isDropped => this == FishingLogState.dropped;
  bool get isCollected => this == FishingLogState.collected;
}
