import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ship_management/routes/routes.dart';
import 'package:ship_management/screens/fishing_log/fishing_log_controller.dart';
import 'package:ship_management/screens/fishing_log/fishing_log_item.dart';
import 'package:ship_management/theme/theme.dart';
import 'package:ship_management/utils/utils.dart';
import 'package:ship_management/utils/widget/common.dart';
import 'package:ship_management/utils/widget/refresh_view.dart';

class FishingLogScreen extends StatelessWidget {
  final controller = Get.put(FishingLogController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(lang.fishingLogTitle)),
      floatingActionButton: buildFishingBtn(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: Obx(() {
        final logs = controller.logs;
        return RefreshView(
          onRefesh: controller.loadData,
          padding: EdgeInsets.all(32.dp).copyWith(bottom: 128.dp),
          itemBuilder: (_, i) => FishingLogItem(
            log: logs[i],
            index: i + 1,
            onTap: () async {
              await Get.toNamed(
                RouteName.fishing,
                arguments: {'log': logs[i]},
              );
              await controller.loadData();
            },
          ),
          separatorBuilder: (_, __) => space(h: 18.dp),
          itemCount: logs.length,
        );
      }),
    );
  }

  Widget buildFishingBtn() {
    return ElevatedButton(
      onPressed: () async {
        final data = controller.logs.firstOrNull;
        final needPass = data != null && !data.canEdit;

        await Get.toNamed(RouteName.fishing,
            arguments: {'log': needPass ? data : null});
        await controller.loadData();
      },
      child: Text(lang.dropNets),
    );
  }
}
