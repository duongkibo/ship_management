import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ship_management/models/fish.dart';
import 'package:ship_management/models/seafood.dart';
import 'package:ship_management/routes/args.dart';
import 'package:ship_management/screens/fishing/seafood_items.dart';
import 'package:ship_management/screens/tranmissing/transmissing_controller.dart';
import 'package:ship_management/theme/theme.dart';
import 'package:ship_management/utils/utils.dart';
import 'package:ship_management/utils/widget/common.dart';
import 'package:ship_management/utils/widget/dialog_add_seafood.dart';

class TransmissingScreen extends StatefulWidget {
  const TransmissingScreen({Key? key}) : super(key: key);

  @override
  State<TransmissingScreen> createState() => _TransmissingScreenState();
}

class _TransmissingScreenState extends State<TransmissingScreen> {
  late final TransmissingContrller controller;
  Fish? type;
  Seafood? seafood;

  @override
  void initState() {
    final args = getScreenArgs();
    seafood = args[''];
    controller = Get.put(TransmissingContrller(log: args['dataTransmissing']));

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await controller.initData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1D8BC2),
      appBar: AppBar(
        backgroundColor: Color(0xff1D8BC2),
        title: Text('Thêm Nhật Ký Chuyền Tải'),
      ),
      body: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            )),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Mã số tàu mua'),
                        TextField(
                          enabled: false,
                          controller: controller.tauId,
                        )
                      ],
                    ),
                  ),
                  space(w: 20.dp),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Mã số tàu bán'),
                        TextField(
                          controller: controller.tauMuaId,
                        )
                      ],
                    ),
                  ),
                ],
              ),
              space(h: 20.dp),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Thời gian chuyền tải'),
                        TextField(
                          enabled: false,
                          controller: controller.dateTimeController,
                        )
                      ],
                    ),
                  ),
                  space(w: 20.dp),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Vị trí chuyền tải'),
                        TextField(
                          enabled: false,
                          controller: controller.latController,
                        )
                      ],
                    ),
                  ),
                ],
              ),
              space(h: 20.dp),
              Text(
                'Ghi chú',
                textAlign: TextAlign.left,
              ),
              TextField(
                controller: controller.noteController,
              ),
              space(h: 36.dp),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                      child:
                          Text(lang.listSeafood, style: AppStyles.t18w700())),
                  buildAddSeafoodBtn(),
                ],
              ),
              space(h: 12.dp),
              Obx(() {
                final seafoods = controller.log.value.sanLuongThuMuaChuyenTais;
                return ListView.separated(
                  shrinkWrap: true,
                  padding: EdgeInsets.only(bottom: 32.dp),
                  itemBuilder: (_, i) {
                    final item = seafoods![i];
                    return SeafoodItem(
                      seafood: item,
                      onRemovePressed: () => controller.removeSeafood(item),
                    );
                  },
                  separatorBuilder: (_, __) => space(h: 4.dp),
                  itemCount: seafoods?.length ?? 0,
                );
              }),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () async {
            await controller.createTransmissing();
          },
          child: Text('Thêm'),
          style: ElevatedButton.styleFrom(
              minimumSize: Size(double.infinity, 44.dp)),
        ),
      ),
    );
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
}
