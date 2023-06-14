import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ship_management/models/fishing_log.dart';
import 'package:ship_management/models/seafood.dart';
import 'package:ship_management/routes/args.dart';
import 'package:ship_management/screens/fishing/fishing_controller.dart';
import 'package:ship_management/services/shared_data/storage_service.dart';
import 'package:ship_management/theme/theme.dart';
import 'package:ship_management/utils/constants.dart';
import 'package:ship_management/utils/dialog_helper.dart';
import 'package:ship_management/utils/extensions.dart';
import 'package:ship_management/utils/utils.dart';
import 'package:ship_management/utils/widget/common.dart';
import 'package:ship_management/utils/widget/dialog_add_seafood.dart';

import 'seafood_items.dart';

class FishingScreen extends StatelessWidget {
  late final FishingController controller;
  final status = StorageService.tripStatus;

  FishingScreen({Key? key}) : super(key: key) {
    final args = getScreenArgs();
    controller = Get.put(FishingController(log: args['log']));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => clearFocus,
      child: Scaffold(
        appBar: AppBar(title: Text(lang.fishingTitle)),
        body: ListView(
          padding: EdgeInsets.all(32.dp).copyWith(bottom: 0),
          children: [
            buildDropField(),
            space(h: 24.dp),
            buildCollectField(),
            if (controller.log.value.canEdit) ...[
              space(h: 24.dp),
              ...buildNoteField(),
              space(h: 30.dp),
              ...buildListSeafood(),
              ElevatedButton(
                onPressed: () async {
                  final succeeded = await controller.updateLog();
                  if (succeeded) Get.back();
                },
                child: Text(lang.updateFishingLog),
              ),
            ]
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: buildScreenActions(),
      ),
    );
  }

  Widget buildScreenActions() {
    return Obx(() {
      final state = controller.log.value.state;
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.dp),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (state.isEmpty)
              ElevatedButton(
                onPressed: () async {
                  controller.dropNets();
                },
                child: Text(lang.dropNets),
              ),
            if (state.isDropped)
              ElevatedButton(
                onPressed: () async {
                  await controller.collectNets();
                  Get.back();
                },
                child: Text(lang.collectNets),
              ),
          ],
        ),
      );
    });
  }

  List<Widget> buildListSeafood() {
    return [
      Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(child: Text(lang.listSeafood, style: AppStyles.t18w700())),
          buildAddSeafoodBtn(),
        ],
      ),
      space(h: 12.dp),
      Obx(() {
        final seafoods = controller.log.value.seafoods;
        return ListView.separated(
          shrinkWrap: true,
          padding: EdgeInsets.only(bottom: 32.dp),
          itemBuilder: (_, i) {
            final item = seafoods[i];
            return SeafoodItem(
              seafood: item,
              onRemovePressed: () => controller.removeSeafood(item),
            );
          },
          separatorBuilder: (_, __) => space(h: 4.dp),
          itemCount: seafoods.length,
        );
      }),
    ];
  }

  Widget buildAddSeafoodBtn() {
    return GestureDetector(
      onTap: () async {
        final result = await Get.bottomSheet<Seafood>(AddSeafoodDialog());

        if (result == null) return;
        await controller.addSeafood(result);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24.dp),
          color: AppColors.primary,
        ),
        padding: EdgeInsets.all(4.dp),
        child: Row(children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24.dp),
              color: AppColors.ghostWhite,
            ),
            child: Icon(Icons.add, color: AppColors.primary),
          ),
          space(w: 8.dp),
          Text(
            lang.addSeafood,
            style: AppStyles.t14w400(AppColors.ghostWhite),
          ),
          space(w: 8.dp),
        ]),
      ),
    );
  }

  List<Widget> buildNoteField() {
    return [
      Text(lang.logNote),
      TextField(
        controller: controller.noteEditor,
        onChanged: controller.changeNote,
      ),
    ];
  }

  Widget buildCollectField() {
    return Obx(() {
      final log = controller.log.value;
      return Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(lang.collectLocation),
                InputDecorator(
                  decoration: InputDecoration(),
                  child: Text(log.collectionLocation),
                ),
              ],
            ),
          ),
          space(w: 20.dp),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(lang.collectTime),
                InputDecorator(
                  decoration: InputDecoration(),
                  child: Text(log.collectionTime?.format() ?? ''),
                ),
              ],
            ),
          ),
        ],
      );
    });
  }

  Widget buildDropField() {
    return Obx(() {
      final log = controller.log.value;
      return Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(lang.dropLocation),
                InputDecorator(
                  decoration: InputDecoration(),
                  child: Text(log.releaseLocation),
                ),
              ],
            ),
          ),
          space(w: 20.dp),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(lang.dropTime),
                InputDecorator(
                  decoration: InputDecoration(),
                  child: Text(log.releaseTime?.format() ?? ''),
                ),
              ],
            ),
          ),
        ],
      );
    });
  }
}
