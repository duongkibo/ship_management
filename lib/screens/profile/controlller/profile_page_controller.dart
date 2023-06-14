import 'package:get/get.dart';
import 'package:ship_management/models/license_details.dart';
import 'package:ship_management/services/shared_data/storage_service.dart';

class ProfilePageController extends GetxController {
  List<LicenseDetail> license = [];

  @override
  void onInit() {
    super.onInit();
    getListLicenseDetail();
  }

  void getListLicenseDetail() {
    license = StorageService.licenseDetails;
  }

  void change(LicenseDetail item) {
    license.forEach((element) {
      if (item == element) {
        element = item;
      }
    });
    update();
  }
}
