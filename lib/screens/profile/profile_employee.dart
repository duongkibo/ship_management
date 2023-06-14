import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ship_management/models/employee_info.dart';
import 'package:ship_management/routes/routes.dart';
import 'package:ship_management/screens/profile/controlller/profile_employee_controller.dart';
import 'package:ship_management/screens/profile/custom_expansion_panel_list.dart';
import 'package:ship_management/services/shared_data/storage_service.dart';
import 'package:ship_management/theme/theme.dart';
import 'package:ship_management/utils/dialog_helper.dart';
import 'package:ship_management/utils/extensions.dart';

class ProfileEmployee extends StatefulWidget {
  const ProfileEmployee({Key? key}) : super(key: key);

  @override
  State<ProfileEmployee> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfileEmployee> {
  final profileEmployee = StorageService.profileEmployee;
  late ProfileEmployeeController controller;

  @override
  void initState() {
    controller = Get.put(ProfileEmployeeController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.dp),
        child: Column(
          children: [
            SizedBox(
              height: 12,
            ),
            _renderSteps(),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }

  Widget _renderSteps() {
    return GetBuilder<ProfileEmployeeController>(
      builder: (_) => CustomExpansionPanelList(
        expansionCallback: (int index, bool isExpanded) {
          controller.profileEmployee[index].isExpanded = !isExpanded;

          controller.change(controller.profileEmployee[index]);
        },
        children: controller.profileEmployee
            .map<ExpansionPanel>((EmployeeInfo employeeInfo) {
          return ExpansionPanel(
            headerBuilder: (BuildContext context, bool isExpanded) {
              return _header(employeeInfo.tenThuyenVien ?? '');
            },
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _item(
                  key: 'Họ và tên:',
                  value: employeeInfo.tenThuyenVien,
                ),
                _item(
                  key: 'Giới tính:',
                  value: employeeInfo.gioiTinh == 0 ? 'Nam' : 'Nữ',
                ),
                _item(
                  key: 'Số CCCD/CMT:',
                  value: employeeInfo.cccd,
                ),
                _item(
                  key: 'Nơi cấp:',
                  value: employeeInfo.noiCap,
                ),
                _item(
                  key: 'Ngày cấp:',
                  value: employeeInfo.ngayCap?.format('dd/MM/yyyy'),
                ),
                _item(
                  key: 'Số điện thoại:',
                  value: employeeInfo.soDienThoai.toString(),
                ),
                _item(
                  key: 'Địa chỉ:',
                  value: employeeInfo.diaChi,
                ),
                SizedBox(
                  height: 4,
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  color: AppColors.black,
                  width: double.infinity,
                  height: 1,
                ),
                SizedBox(
                  height: 12,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0.dp),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _button(
                          onTap: () {
                            _showMyDialog(employeeInfo.id??0);

                          },
                          title: 'Xóa thuyền viên'),
                      _button(
                          onTap: () async {
                            final result = await Get.toNamed(
                              RouteName.employee,
                              arguments: {
                                'employee': 'update',
                                'employeeInfo': employeeInfo,
                              },
                            );

                            if (result != null) {
                              controller.getProfileEmployee();
                            }
                          },
                          title: 'Sửa thông tin'),
                    ],
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
              ],
            ),
            isExpanded: employeeInfo.isExpanded ?? false,
          );
        }).toList(),
      ),
    );
  }
  Future<void> _showMyDialog(int id) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Cảnh báo'),
          content: const SingleChildScrollView(
            child: Text('Bạn có chắc muốn xóa thuyền viên')
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Đồng ý'),
              onPressed: () {
                Get.back();
                controller.deleteEmployee(id);

              },
            ),
            TextButton(
              child: const Text('Thoát'),
              onPressed: () {
                Get.back();
              },
            ),
          ],
        );
      },
    );
  }
  Widget _item({
    String? key,
    String? value,
    bool? isRequired,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.dp, horizontal: 16.dp),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Text(
          name,
          style: AppStyles.t20w400(),
        ),
      );

  Widget _button({required VoidCallback onTap, required String title}) =>
      InkWell(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.all(Radius.circular(40)),
          ),
          child: Text(
            title,
            style: TextStyle(color: Colors.white, fontSize: 16.0),
          ),
        ),
      );
}
