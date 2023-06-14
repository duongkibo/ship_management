import 'package:get/get.dart';
import 'package:ship_management/models/employee_info.dart';
import 'package:ship_management/repositories/profile_repository.dart';
import 'package:ship_management/services/shared_data/storage_service.dart';
import 'package:ship_management/utils/dialog_helper.dart';
import 'package:ship_management/utils/exception.dart';

class ProfileEmployeeController extends GetxController {
  List<EmployeeInfo> profileEmployee = [];

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    getProfileEmployee();
  }

  Future<bool> getProfileEmployee() async {
    try {
      DialogHelper.loading();

      final result = await ProfileRepository.profileEmployee();
      profileEmployee = result;
      StorageService.saveProfileEmployee(result);
      DialogHelper.dissmisLoading();

      update();

      return true;
    } catch (e) {
      profileEmployee = StorageService.profileEmployee;
      DialogHelper.dissmisLoading();
      await handleException(e);
      update();

      return false;
    }
  }

  Future<void> deleteEmployee(int id) async {
    try {
      DialogHelper.loading();
      await ProfileRepository.deleteProfileEmployee(id: id);
      profileEmployee = await ProfileRepository.profileEmployee();
      StorageService.saveProfileEmployee(profileEmployee);

      DialogHelper.dissmisLoading();
      await DialogHelper.confirm(message: 'Xóa Thành công');
      update();
    } catch (e) {
      profileEmployee = StorageService.profileEmployee;
      DialogHelper.dissmisLoading();
      await handleException(e);
      update();
    }
  }

  void change(EmployeeInfo item) {
    profileEmployee.forEach((element) {
      if (item == element) {
        element = item;
      }
    });

    update();
  }
}
