import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ship_management/env/env.dart';
import 'package:ship_management/models/license_details.dart';
import 'package:ship_management/screens/profile/controlller/profile_page_controller.dart';
import 'package:ship_management/screens/profile/custom_expansion_panel_list.dart';
import 'package:ship_management/services/shared_data/storage_service.dart';
import 'package:ship_management/theme/theme.dart';
import 'package:ship_management/utils/extensions.dart';
import 'package:ship_management/utils/utils.dart';

class ProfilePage extends StatelessWidget {
  final profile = StorageService.profile;
  final license = StorageService.licenseDetails;
  final user = StorageService.user;
  late final ProfilePageController controller;

  ProfilePage({Key? key}) : super(key: key) {
    controller = Get.put(ProfilePageController());
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(16.dp),
      children: [
        buildTextField(label: 'HỌ VÀ TÊN', content: profile?.tenChuPhuongTien),
        buildTextField(label: 'ĐIỆN THOẠI', content: profile?.soDienThoai),
        buildTextField(label: 'ĐỊA CHỈ', content: profile?.diaChi),
        buildTextField(label: 'CCCD/CMND', content: profile?.soCCCD),


        buildTextField(label: 'TÊN TÀU', content: profile?.tenTau),
        buildTextField(label: 'SỐ HIỆU TÀU', content: profile?.soHieuTau),
        buildTextField(label: 'SỐ ĐĂNG KÝ', content: profile?.soDangKy),
        buildTextField(
          label: 'NGÀY ĐĂNG KÝ',
          content: profile?.ngayDangKy?.format('dd/MM/yyyy'),
          suffix: Icon(Icons.calendar_month),
        ),
        buildTextField(
          label: 'NGÀY HẾT HẠN ĐĂNG KÝ',
          content: profile?.ngayHetHanDangKy?.format('dd/MM/yyyy'),
          suffix: Icon(Icons.calendar_month),
        ),
        buildTextField(label: 'SỐ ĐĂNG KIỂM', content: profile?.soDangKiem),
        buildTextField(
          label: 'NGÀY ĐĂNG KIỂM',
          content: profile?.ngayDangKiem?.format('dd/MM/yyyy'),
          suffix: Icon(Icons.calendar_month),
        ),
        buildTextField(
          label: 'NGÀY HẾT HẠN ĐĂNG KIỂM',
          content: profile?.ngayHetHanDangKiem?.format('dd/MM/yyyy'),
          suffix: Icon(Icons.calendar_month),
        ),
        buildTextField(label: 'NHÓM TÀU', content: profile?.loaiTau.toShipType),
        licenseDetail(),
      ],
    );
  }

  Widget buildTextField({
    String? label,
    String? content,
    Widget? suffix,
  }) {
    return InputDecorator(
      decoration: InputDecoration(
        enabled: false,
        labelText: label,
        labelStyle: AppStyles.t20w400(),
        suffixIcon: suffix,
      ),
      child: content != null
          ? Text(
              content,
              style: AppStyles.t20w700(),
              maxLines: 1,
            )
          : null,
    );
  }

  Widget licenseDetail() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 8,
        ),
        Text(
          'Danh sách giấy phép',
          style: AppStyles.t20w700(),
          maxLines: 1,
        ),
        SizedBox(
          height: 8,
        ),
        _renderSteps(),
        SizedBox(
          height: 16,
        ),
      ],
    );
  }

  Widget _renderSteps() {
    return GetBuilder<ProfilePageController>(
      builder: (_) => CustomExpansionPanelList(
        expansionCallback: (int index, bool isExpanded) {
          controller.license[index].isExpanded = !isExpanded;

          controller.change(controller.license[index]);
        },
        children:
            controller.license.map<ExpansionPanel>((LicenseDetail license) {
          return ExpansionPanel(
            headerBuilder: (BuildContext context, bool isExpanded) {
              return _header(license.tenLoaiHinhGiayPhep ?? '');
            },
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _item(
                  key: 'Tên loại hình giấy phép',
                  value: license.tenLoaiHinhGiayPhep,
                ),
                _item(
                  key: 'Tên văn bản đính kèm',
                  value: license.tenVanBanDinhKem,
                ),
                _item(
                  key: 'Ngày cấp phép',
                  value: license.ngayCapPhep?.format('dd/MM/yyyy'),
                ),
                _item(
                  key: 'Ngày hết hạn',
                  value: license.ngayHetHan?.format('dd/MM/yyyy'),
                ),
                InkWell(
                  onTap: () {
                    launchHttps('${Env.domain.replaceAll('/api', '')}${(license.fileUrl??'')}');
                  },
                  child: _item(
                    key: 'File:',
                    value: '${Env.domain.replaceAll('/api', '')}${(license.fileUrl??'')}',
                  ),
                ),
              ],
            ),
            isExpanded: license.isExpanded ?? false,
          );
        }).toList(),
      ),
    );
  }

  Widget _item({
    String? key,
    String? value,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.dp, horizontal: 16.dp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            key ?? '',
            style: AppStyles.t20w400(),
          ),
          SizedBox(
            width: 4,
          ),
          Text(
            value ?? '',
            style: AppStyles.t20w700(),
          ),
        ],
      ),
    );
  }

  Widget _header(String name) => Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          name,
          style: AppStyles.t20w400(),
        ),
      );
}
