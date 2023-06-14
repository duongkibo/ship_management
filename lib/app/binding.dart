import 'package:get/get.dart';
import 'package:ship_management/services/location/location_service.dart';
import 'package:ship_management/services/shared_data/storage_service.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    StorageService.init();
    LocationService.requestService();
  }
}
