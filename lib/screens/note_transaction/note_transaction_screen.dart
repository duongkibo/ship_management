import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:realm/realm.dart';
import 'package:ship_management/models/seafood.dart';
import 'package:ship_management/models/tranmission.dart';
import 'package:ship_management/routes/routes.dart';
import 'package:ship_management/screens/note_transaction/note_transaction_controller.dart';
import 'package:ship_management/services/shared_data/storage_service.dart';
import 'package:ship_management/theme/colors.dart';
import 'package:ship_management/theme/dimens.dart';
import 'package:ship_management/theme/icons.dart';
import 'package:ship_management/theme/styles.dart';
import 'package:ship_management/utils/dialog_helper.dart';
import 'package:ship_management/utils/extensions.dart';
import 'package:ship_management/utils/utils.dart';
import 'package:ship_management/utils/widget/common.dart';
import 'package:ship_management/utils/widget/svg_icon.dart';

class NoteTransactionScreen extends StatefulWidget {
  const NoteTransactionScreen({Key? key}) : super(key: key);

  @override
  State<NoteTransactionScreen> createState() => _NoteTransactionScreenState();
}

class _NoteTransactionScreenState extends State<NoteTransactionScreen> {
  final controller = Get.put(NoteTransactionController());

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await controller.loadData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: buildFishingBtn(),
      appBar: AppBar(
        title: Text(lang.transMissionLogContent),
      ),
      backgroundColor: AppColors.white,
      body: Obx(() {
        final listThongTin = controller.listThongTinThuMua;
        return ListView.builder(
            padding: EdgeInsets.all(16),
            itemCount: listThongTin.length,
            itemBuilder: (context, index) {
              final item = listThongTin[index];
              return Padding(
                padding: EdgeInsets.only(bottom: 24.dp),
                child: GestureDetector(
                  onTap: () async {
                    await Get.toNamed(
                      arguments: {'dataTransmissing': item},
                      RouteName.updateTransmissing,
                    );
                    await controller.loadData();
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [buildHeader(item), buildBody(item)],
                  ),
                ),
              );
            });
      }),
    );
  }

  Container buildBody(ThongTinThuMuaTruyenTaiModel item) {
    return Container(
      padding: EdgeInsets.all(12.dp),
      decoration: BoxDecoration(
        color: AppColors.ghostWhite,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(8.dp),
          bottomRight: Radius.circular(8.dp),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Thời gian: ${item.thoiGianThuMuaChuyenTai} '),
          space(h: 16.dp),
          Text(
              'Vị trí:  ${double.parse(item.kinhDo ?? '').degreeLat}${double.parse(item.viDo ?? '0').degreeLng}'),
          space(h: 16.dp),
          Row(
            children: [
              Text('Tàu mua: ${StorageService.profile?.soHieuTau ?? ''}'),
              Expanded(child: SizedBox()),
              Text('Tàu bán: ${item.nhatKyKhaiThacId}'),
            ],
          ),
          space(h: 12.dp),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: List.generate(
              min(2, item.sanLuongThuMuaChuyenTais!.length),
              (i) => Expanded(
                  child: buildSeafood(
                item.sanLuongThuMuaChuyenTais![i],
              )),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: Size(double.infinity, 44),
            ),
            onPressed: () async {
              controller.delete(item.stt ?? 0);
            },
            child: Text('xóa'),
          )
        ],
      ),
    );
  }

  Widget buildSeafood(Seafood seafood) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgIcon(path: IconSrc.ship, autoScale: true),
        space(w: 16.dp),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                seafood.type.toFishName,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              space(h: 8.dp),
              Text('${seafood.quantity} KG'),
            ],
          ),
        ),
      ],
    );
  }

  Container buildHeader(ThongTinThuMuaTruyenTaiModel item) {
    return Container(
      padding: EdgeInsets.all(12.dp),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8.dp),
          topRight: Radius.circular(8.dp),
        ),
      ),
      child: Row(
        children: [
          Text(
            'Nhật ký chuyền tải ${item.stt}',
            style: AppStyles.t16w700(AppColors.white),
          ),
          Spacer(),
          Text(
            '${item.total} kg',
            style: AppStyles.t16w700(AppColors.white),
          )
        ],
      ),
    );
  }

  Widget buildFishingBtn() {
    return ElevatedButton(
      onPressed: () async {
        print(StorageService.profile?.enumTrangThaiTau);
        await Get.toNamed(
          arguments: {'dataTransmissing': null},
          RouteName.transmissing,
        );
        await controller.loadData();
      },
      child: Text('+ Thêm mới'),
    );
  }
}
