import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:get/route_manager.dart';
import 'package:ship_management/models/fishing_log.dart';
import 'package:ship_management/repositories/auth_repository.dart';
import 'package:ship_management/repositories/fishing_log_repository.dart';
import 'package:ship_management/repositories/location_repository.dart';
import 'package:ship_management/repositories/req_port_repository.dart';
import 'package:ship_management/repositories/transmissing_repository.dart';
import 'package:ship_management/routes/routes.dart';
import 'package:ship_management/services/location/location_service.dart';
import 'package:ship_management/services/shared_data/storage_service.dart';
import 'package:ship_management/theme/theme.dart';
import 'package:ship_management/utils/constants.dart';
import 'package:ship_management/utils/dialog_helper.dart';
import 'package:ship_management/utils/exception.dart';
import 'package:ship_management/utils/utils.dart';
import 'package:ship_management/utils/widget/common.dart';
import 'package:ship_management/utils/widget/svg_icon.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final profile = StorageService.profile;
  late TripStatus tripStatus;

  @override
  void initState() {
    super.initState();
    tripStatus = StorageService.tripStatus;
    LocationService.startRecord();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/icons/bg_home.png'))),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Stack(
              children: [
                Column(
                  children: [
                    space(h: kToolbarHeight),
                    Align(
                      alignment: Alignment.center,
                      child: SvgIcon(path: IconSrc.flag, autoScale: true),
                    ),
                    space(h: 32.dp),
                    buildQr(),
                    Expanded(child: SizedBox()),
                    buildActions(constraints),
                  ],
                ),
                Positioned(
                  top: kToolbarHeight + 16.dp,
                  right: 16.dp,
                  child: buildRefreshBtn(),
                )
              ],
            );
          },
        ),
      ),
    );
  }

  Widget buildRefreshBtn() {
    return GestureDetector(
      onTap: () async {
        try {
          DialogHelper.loading();
          if (tripStatus == TripStatus.waitExport) {
            final res = await ReqPortRepository.checkReqExportStatus();
            DialogHelper.dissmisLoading();

            await checkExportStatus(res['trangThaiXuatCang'],
                content: res['lyDoTuChoi']);
          } else if (tripStatus == TripStatus.waitImport) {
            final res = await ReqPortRepository.checkReqImportStatus();
            DialogHelper.dissmisLoading();

            await checkImportStatus(res['trangThaiNhapCang'],
                content: res['lyDoTuChoiNhapCang']);
          } else {
            await Future.delayed(Duration(milliseconds: 500));
            DialogHelper.dissmisLoading();
          }
        } catch (e) {
          DialogHelper.dissmisLoading();
          await handleException(e);
        }
      },
      child: Container(
        width: 36.dp,
        height: 36.dp,
        child: Icon(Icons.refresh, color: AppColors.perlorous),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(100.dp),
          border: Border.all(width: 2, color: AppColors.slateGrey),
        ),
      ),
    );
  }


  Future pushNhatKyHanhTrinh() async {
    try {
      DialogHelper.loading();

      await FishingLogRepository.createNhatKyKhaiThac();
      await TransmissingRepository.pushNhatKyTruyenTai();
      DialogHelper.dissmisLoading();
    } catch (e) {
      DialogHelper.dissmisLoading();
    }
  }

  Future checkImportStatus(dynamic value, {String? content}) async {
    print('----.>>> $value');
    if (value == 2) {
      await DialogHelper.confirm(
        message: 'Yêu cầu nhập cảng đã được duyệt.',
      );
      await pushNhatKyHanhTrinh();

      updateTripStatus(TripStatus.unknown);
      LocationService.stopRecord;

      await AuthRepository.logout();
      Get.offNamed(RouteName.login);
    } else if (value == 3) {
      await DialogHelper.confirm(
        message: 'Yêu cầu nhập cảng đã bị từ chối.\n Lý do từ chối:$content',
      );
      updateTripStatus(TripStatus.declineImport);
    }
    await StorageService.saveTripStatus(tripStatus);
  }

  Future checkExportStatus(dynamic value, {String? content}) async {
    if (value == 2) {
      final profile = await AuthRepository.profile(StorageService.user?.tauId);
      await StorageService.saveProfile(profile);

      updateTripStatus(TripStatus.inprogress);
      LocationService.startRecord(isStart: true);
      await DialogHelper.confirm(
        message: 'Yêu cầu xuất cảng đã được duyệt.',
      );
    } else if (value == 3) {
      await DialogHelper.confirm(
        message: 'Yêu cầu xuất cảng đã bị từ chối.\n Lý do từ chối:$content',
      );
      updateTripStatus(TripStatus.declineExport);
    }
    await StorageService.saveTripStatus(tripStatus);
  }

  Container buildActions(BoxConstraints constraints) {
    return Container(
      height: constraints.maxHeight / 2,
      padding: EdgeInsets.all(32.dp),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            flex: 2,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(child: buildRequestExport()),
                space(h: 8.dp),
                Expanded(child: buildRequestImport()),
              ],
            ),
          ),
          space(w: 8.dp),
          Expanded(
            flex: 3,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(child: buildFishing()),
                space(h: 8.dp),
                Expanded(
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(child: buildFishingLog()),
                      space(w: 8.dp),
                      Expanded(child: buildProfile())
                    ],
                  ),
                ),
                space(h: 8.dp),
                Expanded(
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(child: buildExchangeLog()),
                      space(w: 8.dp),
                      Expanded(child: buildTransmissionLog())
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container buildQr() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.slateGrey,
        borderRadius: BorderRadius.circular(100.dp),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(100.dp),
            ),
            margin: EdgeInsets.all(4.dp),
            padding: EdgeInsets.all(6.dp),
            child: Icon(Icons.qr_code),
          ),
          space(w: 4.dp),
          Text(
            profile?.soHieuTau ?? '',
            style: AppStyles.t18w700(AppColors.white),
          ),
          space(w: 12.dp),
        ],
      ),
    );
  }

  Widget buildTransmissionLog() => buildFeature(
      label: lang.transmissionLog,
      icon: SvgIcon(
        path: IconSrc.icTransLogs,
        width: 32.dp,
        height: 32.dp,
      ),
      disable: false,
      onPressed: () async {
        await Get.toNamed(RouteName.map);
      });

  Widget buildExchangeLog() => buildFeature(
        label: lang.exchangeLog,
        icon: SvgIcon(
          path: IconSrc.icTradeLogs,
          width: 32.dp,
          height: 32.dp,
        ),
        // disable: true,
        // label: 'NK HÀNH TRÌNH',
        onPressed: () async {
          await Get.toNamed(RouteName.noteTransaction);
        },
      );

  Widget buildProfile() => buildFeature(
        label: lang.profile,
        icon: SvgIcon(
          path: IconSrc.icShip,
          width: 44.dp,
          height: 44.dp,
        ),
        onPressed: () async {
          await Get.toNamed(RouteName.profile);
        },
      );

  Widget buildFishingLog() => buildFeature(
        label: lang.fishingLog,
        icon: SvgIcon(
          path: IconSrc.icLogs,
          width: 32.dp,
          height: 32.dp,
        ),
        onPressed: () async {
          await Get.toNamed(RouteName.fishingLog);
        },
      );

  Widget buildFishing() => buildFeature(
        label: lang.fishing,
        icon: SvgIcon(
          path: IconSrc.icFishing,
          width: 48.dp,
          height: 48.dp,
        ),
        onPressed: () async {
          final data = await getFishingLogData();
          await Get.toNamed(RouteName.fishing, arguments: {'log': data});
        },
      );

  Widget buildRequestImport() {
    return Stack(
      children: [
        buildFeature(
          label: lang.reqImport,
          icon: SvgIcon(
            path: IconSrc.icImport,
            width: 48.dp,
            height: 48.dp,
          ),
          onPressed: () async {
            final data = await getFishingLogData();
            if (tripStatus == TripStatus.waitImport) {
              await DialogHelper.confirm(
                message: 'Đã gửi yêu cầu cập cảng.',
              );
            } else if (data != null) {
              await DialogHelper.confirm(
                message: 'Không thể cập cảng khi chưa thu lưới.',
              );
            } else {
              await Get.toNamed(
                RouteName.reqPort,
                arguments: {'req': 'import'},
              );
              updateTripStatus();
            }
          },
        ),
        if (tripStatus == TripStatus.waitImport)
          Positioned(
            left: 0,
            right: 0,
            child: buildBadge('ĐANG CHỜ DUYỆT', false),
          ),
        if (tripStatus == TripStatus.declineImport)
          Positioned(
            left: 0,
            right: 0,
            child: buildBadge('TỪ CHỐI DUYỆT', false),
          ),
      ],
    );
  }

  Widget buildRequestExport() {
    return Stack(
      children: [
        buildFeature(
          label: lang.reqExport,
          icon: SvgIcon(
            path: IconSrc.icExport,
            width: 48.dp,
            height: 48.dp,
          ),
          onPressed: () async {
            print('${StorageService.profile?.enumTrangThaiTau}');
            if (tripStatus == TripStatus.waitExport) {
              await DialogHelper.confirm(
                message: 'Đã gửi yêu cầu xuất cảng.',
              );
            } else if (tripStatus == TripStatus.unknown) {
              await Get.toNamed(
                RouteName.reqPort,
                arguments: {'req': 'export'},
              );
              updateTripStatus();
            } else if (StorageService.profile?.enumTrangThaiTau == 2) {
              return;
            } else {
              await Get.toNamed(
                RouteName.reqPort,
                arguments: {'req': 'export'},
              );
              updateTripStatus();
              // await DialogHelper.confirm(
              //   message: 'Không thể gửi yêu cầu xuất cảng.',
              // );
            }
          },
        ),
        if (tripStatus == TripStatus.inprogress)
          Positioned(
            left: 0,
            right: 0,
            child: buildBadge('TRONG CHUYẾN BIỂN', true),
          ),
        if (tripStatus == TripStatus.waitExport)
          Positioned(
            left: 0,
            right: 0,
            child: buildBadge('ĐANG CHỜ DUYỆT', false),
          ),
        if (tripStatus == TripStatus.declineExport)
          Positioned(
            left: 0,
            right: 0,
            child: buildBadge('TỪ CHỐI DUYỆT', false),
          ),
      ],
    );
  }

  Widget buildBadge(String label, bool succeed) {
    return Container(
      decoration: BoxDecoration(
        color: succeed ? AppColors.mountaiMeadow : AppColors.froly,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12.dp),
          topRight: Radius.circular(12.dp),
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16.dp, vertical: 4.dp),
      child: Text(
        label,
        style: AppStyles.t14w700(AppColors.white),
        textAlign: TextAlign.center,
      ),
      alignment: Alignment.center,
    );
  }

  Widget buildFeature({
    String? label,
    VoidCallback? onPressed,
    bool disable = false,
    Widget? icon,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            children: [
              Container(
                width: constraints.maxWidth,
                height: constraints.maxHeight,
                alignment: Alignment.center,
                padding: EdgeInsets.all(8.dp),
                decoration: BoxDecoration(
                  color: AppColors.perlorous.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(12.dp),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (icon != null) ...[icon, space(h: 8.dp)],
                    Text(
                      label ?? '',
                      style: AppStyles.t16w700(AppColors.white),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              if (disable)
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.anakiwa.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(12.dp),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  Future<FishingLog?> getFishingLogData() async {
    final logs = await FishingLogRepository.list;
    final data = logs.firstOrNull;

    if (data != null && !data.canEdit) return data;
    return null;
  }

  void updateTripStatus([TripStatus? status]) {
    setState(() => tripStatus = status ?? StorageService.tripStatus);
  }
}
