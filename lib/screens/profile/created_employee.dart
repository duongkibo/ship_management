import 'package:flutter/material.dart';
import 'package:ship_management/models/employee_info.dart';
import 'package:ship_management/models/enum_vi_tri.dart';
import 'package:ship_management/routes/args.dart';
import 'package:ship_management/screens/profile/controlller/create_employee_controller.dart';
import 'package:ship_management/theme/colors.dart';
import 'package:ship_management/theme/dimens.dart';
import 'package:ship_management/theme/styles.dart';
import 'package:ship_management/utils/constants.dart';
import 'package:ship_management/utils/dialog_helper.dart';
import 'package:ship_management/utils/utils.dart';
import 'package:get/get.dart';

class CreatedEmployee extends StatefulWidget {
  late EmployeeType reqType;
  late EmployeeInfo employeeInfo;

  CreatedEmployee({Key? key}) {
    final args = getScreenArgs();
    reqType = args?['employee'] == 'created'
        ? EmployeeType.created
        : EmployeeType.update;
    employeeInfo =
        args?['employee'] == 'created' ? EmployeeInfo() : args?['employeeInfo'];
  }

  @override
  State<CreatedEmployee> createState() => _CreatedEmployeeState();
}

class _CreatedEmployeeState extends State<CreatedEmployee> {
  late CreateEmployeeController controller;

  @override
  void initState() {
    controller = Get.put(CreateEmployeeController(
      reqType: widget.reqType,
      employeeInfo: widget.employeeInfo,
    ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.perlorous,
        title: Text(widget.reqType.titleAppbar),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            body(),
            SizedBox(
              height: 40,
            ),
            InkWell(
              onTap: () {
                controller.onConfirm(widget.reqType);
              },
              child: Container(
                alignment: Alignment.center,
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                margin: EdgeInsets.symmetric(
                  horizontal: 24,
                ),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.all(Radius.circular(40)),
                ),
                child: Text('Xác nhận'),
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget body() {
    return Column(
      children: [
        SizedBox(
          height: 16,
        ),
        _input(
          text: 'Tên Thuyền Viên',
          hintText: 'Tên Thuyền viên',
          controller: controller.nameController,
        ),
        SizedBox(
          height: 20,
        ),
        _dropdownVitri(),
        // _renderSteps(),
        SizedBox(
          height: 20,
        ),
        _input(
          text: 'Địa Chỉ',
          hintText: 'Địa chỉ',
          controller: controller.diaChiController,
        ),
        SizedBox(
          height: 20,
        ),
        _input(
          keyboardType: TextInputType.number,
          text: 'Số Điện Thoại',
          hintText: 'Số điện thoại',
          controller: controller.soDienThoaiController,
        ),
        SizedBox(
          height: 20,
        ),

        _input(
          keyboardType: TextInputType.number,
          text: 'CCCD/CMT',
          hintText: 'CCCD/CMT',
          controller: controller.cccdController,
        ),
        SizedBox(
          height: 20,
        ),
        buidlDatetimeField(),

        SizedBox(
          height: 20,
        ),
        _input(
          text: 'Nơi Cấp',
          hintText: 'Nơi cấp',
          controller: controller.noiCapController,
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          children: [
            Expanded(
              child: _input(
                text: 'Giới Tính',
                hintText: 'Giới tính',
                controller: controller.gioiTinhController,
                enabled: false,
              ),
            ),
            SizedBox(
              width: 12,
            ),
            _dropdown(),
            SizedBox(
              width: 12,
            ),

          ],
        ),
        SizedBox(
          height: 12,
        ),
        GetBuilder<CreateEmployeeController>(builder: (context) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                Row(
                  children: [
                    RichText(
                      text: TextSpan(
                        text: 'CCCD :',
                        style: AppStyles.t14w400(Colors.black),
                        children: const <TextSpan>[
                          TextSpan(
                            text: ' *',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                    SizedBox(
                      width: 120.dp,
                      child: ElevatedButton(
                        onPressed: () async {
                          await controller.openImageFile();
                        },
                        child: Text((controller.file?.path ?? '').isNotEmpty
                            ? controller.file!.path
                            : 'Thêm file',overflow: TextOverflow.ellipsis,),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 12,
                ),
                Row(
                  children: [
                    RichText(
                      text: TextSpan(
                        text: 'Giấy phép :',
                        style: AppStyles.t14w400(Colors.black),
                        children: const <TextSpan>[
                          TextSpan(
                            text: ' *',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                    SizedBox(
                      width: 120.dp,
                      child: ElevatedButton(
                        onPressed: () async {
                          await controller.openImageFileGiayPhep();
                        },
                        child: Text((controller.file?.path ?? '').isNotEmpty
                            ? controller.file!.path
                            : 'Thêm file',overflow: TextOverflow.ellipsis,),
                      ),
                    )
                  ],
                ),
              ],
            ),
          );
        })
      ],
    );
  }

  Widget _renderSteps() {
    final vitri = controller.vitri;
    return GetBuilder<CreateEmployeeController>(
      builder: (_) => ExpansionPanelList(
        expansionCallback: (int index, bool isExpanded) {
          controller.vitri.isExpanded = !isExpanded;

          controller.change(controller.vitri);
        },
        children: [
          ExpansionPanel(
            headerBuilder: (BuildContext context, bool isExpanded) {
              return _header(
                vitri.name ?? '',
                controller.enumVitri?.enumViTriThuyenVien ?? '',
              );
            },
            body: ListView.builder(
              primary: false,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: vitri.enumVitri.length,
              itemBuilder: (_, index) {
                return _item(
                  key: vitri.enumVitri[index].enumViTriThuyenVien ?? '',
                  onTap: () {
                    controller.selectVitri(vitri.enumVitri[index]);
                  },
                );
              },
            ),
            isExpanded: vitri.isExpanded ?? false,
          ),
        ],
      ),
    );
  }

  Widget buidlDatetimeField() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.dp),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              text: '${lang.ngayCap} :',
              style: AppStyles.t14w400(Colors.black),
              children: const <TextSpan>[
                TextSpan(
                  text: ' *',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ),
          Obx(() {
            Widget suffixIcon = Icon(Icons.today);
            if (controller.ngayCap.value != null) {
              suffixIcon = GestureDetector(
                onTap: () => controller.changeTime(null),
                child: Icon(Icons.close),
              );
            }

            return TextFormField(
              readOnly: true,
              controller: controller.ngayCapController,
              onTap: () async {
                clearFocus;
                final time = await DialogHelper.selectTime();
                if (time != null) controller.changeTime(time);
              },
              decoration: InputDecoration(
                hintText: 'Ngày cấp',
                suffixIcon: suffixIcon,
              ),
              validator: (value) {
                if (value?.isEmpty ?? true) return '';
                return null;
              },
            );
          })
        ],
      ),
    );
  }

  Widget _input({
    required String text,
    required String hintText,
    required TextEditingController controller,
    FocusNode? focusNode,
    bool? enabled,
    TextInputType? keyboardType,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.dp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              text: '$text :',
              style: AppStyles.t14w400(Colors.black),
              children: const <TextSpan>[
                TextSpan(
                  text: ' *',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ),
          TextFormField(
            keyboardType: keyboardType,
            enabled: enabled ?? true,
            focusNode: focusNode ?? FocusNode(),
            controller: controller,
            decoration: InputDecoration(
              hintText: hintText,
              helperStyle: AppStyles.t14w400(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _dropdown() => Container(
        margin: EdgeInsets.symmetric(horizontal: 16.dp),
        padding: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        child: GetBuilder<CreateEmployeeController>(
          builder: (_) => DropdownButton<String>(
            alignment: AlignmentDirectional.centerEnd,
            value: controller.gioiTinhText,
            icon: const Icon(Icons.arrow_drop_down),
            elevation: 16,
            style: const TextStyle(color: Colors.black),
            onChanged: (String? value) {
              controller.selectGioiTinh(value!);
            },
            items: controller.gioiTinh
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                    ),
                    child: Text(value)),
              );
            }).toList(),
          ),
        ),
      );

  Widget _dropdownVitri() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            Expanded(
              child: RichText(
                text: TextSpan(
                  text: 'Vị Trí :',
                  style: AppStyles.t14w400(Colors.black),
                  children: const <TextSpan>[
                    TextSpan(
                      text: ' *',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(8),
                ),
              ),
              child: GetBuilder<CreateEmployeeController>(
                builder: (_) => DropdownButton<EnumVitri>(
                  alignment: AlignmentDirectional.centerEnd,
                  value: controller.enumVitri,
                  icon: const Icon(Icons.arrow_drop_down),
                  elevation: 16,
                  style: const TextStyle(color: Colors.black),
                  onChanged: (value) {
                    print('---------${value?.idVitri}');
                    controller.selectVitri(value!);
                  },
                  items: controller.vitri.enumVitri
                      .map<DropdownMenuItem<EnumVitri>>((EnumVitri value) {
                    return DropdownMenuItem<EnumVitri>(
                      value: value,
                      child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(8),
                            ),
                          ),
                          child: Text(value.enumViTriThuyenVien ?? '')),
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      );

  Widget _item({
    String? key,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.dp, horizontal: 16.dp),
        child: Text(
          key ?? '',
          style: AppStyles.t20w400(),
        ),
      ),
    );
  }

  Widget _header(String name, value) => Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Text(
              name,
              style: AppStyles.t16w400(),
            ),
            SizedBox(
              width: 4,
            ),
            Text(
              value != null ? ' : ${value}' : '',
              style: AppStyles.t16w400(),
            ),
          ],
        ),
      );
}
