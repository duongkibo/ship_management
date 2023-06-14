import 'package:ship_management/utils/extensions.dart';

class ShipLocation {
  final double lat;
  final double lng;
  final DateTime time;

  ShipLocation({required this.lat, required this.lng, required this.time});

  factory ShipLocation.fromMap(Map<String, dynamic> map) {
    return ShipLocation(
      lat: double.tryParse(map['lat'].toString()) ?? 0,
      lng: double.tryParse(map['lng'].toString()) ?? 0,
      time: map['time']?.toString().toDate() ?? DateTime.now(),
    );
  }
}
