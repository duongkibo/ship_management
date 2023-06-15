import 'package:get/get.dart';
import 'package:ship_management/models/fishing_log.dart';
import 'package:ship_management/repositories/fishing_log_repository.dart';

class FishingLogController extends GetxController {
  var logs = <FishingLog>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  Future loadData() async {
    try {
      final res = await FishingLogRepository.list;
      logs.assignAll(res);
      if(logs.isNotEmpty && logs.length>=2 )
        {
          logs.sort((a,b)=> (b.releaseTime??DateTime.now()).compareTo(a.releaseTime??DateTime.now()));
        }

      print(res.last.toJson());
    } catch (e) {}
  }
}
