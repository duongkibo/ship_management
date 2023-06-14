import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:ship_management/services/shared_data/storage_service.dart';
import 'package:ship_management/utils/exception.dart';

extension DateTimeX on DateTime {
  String format([String format = 'dd/MM/yyyy HH:mm']) {
    return DateFormat(format).format(this);
  }
}

extension LocationDataX on LocationData {
  String get format {
    return '${this.latitude}, ${this.longitude}';
  }
}

extension StringX on String {
  DateTime? toDate([String format = 'dd/MM/yyyy HH:mm']) {
    try {
      return DateFormat(format).parse(this);
    } catch (_) {
      return null;
    }
  }

  Color get color {
    final isHex = RegExp(r'^#(?:[0-9a-fA-F]{3}){1,2}$').hasMatch(this);
    if (!isHex) throw AppException('Not hex color');

    final value = int.parse('0xFF${this.substring(1)}');
    return Color(value);
  }

  String get toShipType {
    switch (this) {
      case '0':
        return 'Khai thác thuỷ sản';
      case '1':
        return 'Vận tải hàng hoá';
      case '2':
        return 'Vận tải hành khách';
      default:
        return '';
    }
  }

  String get toFishName {
    final fishes = StorageService.fishes;
    final target = fishes.firstWhereOrNull((e) => e.id == this);
    return target?.name ?? '';
  }
}

extension DoubleX on double {
  String get _degree {
    final tmp = this.toString().split('.');
    final __degree = tmp[0];

    final _minutes = double.parse('0.${tmp[1]}');
    final _minutesTmp = (_minutes * 60).toString().split('.');
    final __minutes = _minutesTmp[0];

    final _seconds = double.parse('0.${_minutesTmp[1]}');
    final __seconds = (_seconds * 60).toStringAsFixed(0);

    return "$__degree°$__minutes\'$__seconds\"";
  }

  String get degreeLat {
    final suffix = this > 0 ? 'N' : 'S';
    return this._degree + suffix;
  }

  String get degreeLng {
    final suffix = this > 0 ? 'E' : 'W';
    return this._degree + suffix;
  }
}
