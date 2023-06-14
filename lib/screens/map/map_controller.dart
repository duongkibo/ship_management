import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:ship_management/models/fishing_log.dart';
import 'package:ship_management/repositories/location_repository.dart';

class MapFishingController extends GetxController {
  List<LatLng> listLatLng = [];
  @override
  void onInit() {
    loadPolyGone();
    super.onInit();

  }
  updateListLatLng(LatLng latLng) {
    listLatLng.add(latLng);
    update();
  }

  Future<void> loadPolyGone()  async{
    final listLC = await LocationRepository.locations;
    if(listLC.isNotEmpty){
      listLC.forEach((element) {
        listLatLng.add(LatLng(element.lat,element.lng));
        update();
      });
    }
  }
}
