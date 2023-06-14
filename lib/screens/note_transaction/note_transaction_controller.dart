import 'package:get/get.dart';
import 'package:ship_management/models/fishing_log.dart';
import 'package:ship_management/models/tranmission.dart';
import 'package:ship_management/repositories/fishing_log_repository.dart';
import 'package:ship_management/repositories/transmissing_repository.dart';

class NoteTransactionController extends GetxController {
  var listThongTinThuMua = <ThongTinThuMuaTruyenTaiModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  Future loadData() async {
    try {
      final res = await TransmissingRepository.list;
      listThongTinThuMua.assignAll(res);
    } catch (e) {
      print(e);
    }
  }

  Future delete(int? id) async{
     TransmissingRepository.delete(id??0);
     await loadData();
  }

}
