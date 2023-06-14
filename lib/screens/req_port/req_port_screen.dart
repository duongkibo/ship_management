import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ship_management/models/employee_info.dart';
import 'package:ship_management/models/port.dart';
import 'package:ship_management/routes/args.dart';
import 'package:ship_management/screens/profile/custom_expansion_panel_list.dart';
import 'package:ship_management/screens/req_port/req_port_controller.dart';
import 'package:ship_management/theme/theme.dart';
import 'package:ship_management/utils/constants.dart';
import 'package:ship_management/utils/dialog_helper.dart';
import 'package:ship_management/utils/extensions.dart';
import 'package:ship_management/utils/utils.dart';
import 'package:ship_management/utils/widget/common.dart';

class ReqPortScreen extends StatefulWidget {
  late final ReqType reqType;

  ReqPortScreen({super.key}) {
    final args = getScreenArgs();
    reqType = args?['req'] == 'import' ? ReqType.import : ReqType.export;
  }

  @override
  State<ReqPortScreen> createState() => _ReqPortScreenState();
}

class _ReqPortScreenState extends State<ReqPortScreen> {
  final _formKey = GlobalKey<FormState>();
  late final ReqPortController controller;

  @override
  void initState() {
    controller = Get.put(ReqPortController(reqType: widget.reqType));
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => clearFocus,
      child: Scaffold(
        floatingActionButton: buildSubmitBtn(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        appBar: AppBar(
          title: Text(widget.reqType.appbarTitle),
        ),
        body: Padding(
          padding: EdgeInsets.all(36.dp),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.always,
            child: ListView(
              children: [
                ...buildPortDropdownField(),
                space(h: 24.dp),
                ...buildAddressField(),
                space(h: 24.dp),
                ...buidlDatetimeField(),
                space(h: 32.dp),
                Text(  widget.reqType == ReqType.export?'Lý do xuất cảng':'Lý do cập cảng'),
                TextField(
                  controller: controller.lyDoNhapCang ,
                ),
                space(h: 32.dp),
                widget.reqType == ReqType.export ? _renderSteps() : SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildSubmitBtn() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(minimumSize: Size(double.infinity, 44)),
        onPressed: () async {

          if (!_formKey.currentState!.validate()) return;
          final succeeded = await controller.request();
          if (!succeeded) return;
          Get.back();
        },
        child: Text(lang.createReq),
      ),
    );
  }

  Widget _renderSteps() {
    return GetBuilder<ReqPortController>(
      builder: (_) => CustomExpansionPanelList(
        expansionCallback: (int index, bool isExpanded) {
          controller.profileEmployee[index].isExpanded = !isExpanded;

          controller.change(controller.profileEmployee[index]);
        },
        children: controller.profileEmployee
            .map<ExpansionPanel>((EmployeeInfo employeeInfo) {
          return ExpansionPanel(
            headerBuilder: (BuildContext context, bool isExpanded) {
              return _header(employeeInfo.tenThuyenVien ?? '', employeeInfo);
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
                  value: employeeInfo.ngayCap?.format(),
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
              ],
            ),
            isExpanded: employeeInfo.isExpanded ?? false,
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

  Widget _header(String name, EmployeeInfo employeeInfo) => Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
             Checkbox(value: employeeInfo.isSelect, onChanged: (value){
              setState(() {
                print(value);
                employeeInfo.isSelect = value!;
                if(value==true)
                  {
                       controller.addNhanVien(
                         employeeInfo.id!,
                        );
                  } else if(value == false){
                  controller.removeNhanVien(employeeInfo.id);
                }
              });
            }),
            Text(
              name,
              style: AppStyles.t20w400(),
            ),
          ],
        ),
      );

  List<Widget> buidlDatetimeField() {
    return [
      Text(lang.time),
      Obx(() {
        Widget suffixIcon = Icon(Icons.today);
        if (controller.focusTime.value != null) {
          suffixIcon = GestureDetector(
            onTap: () => controller.changeTime(null),
            child: Icon(Icons.close),
          );
        }

        return TextFormField(
          readOnly: true,
          controller: controller.timeEditor,
          onTap: () async {
            clearFocus;
            final time = await DialogHelper.pickTime();
            if (time != null) controller.changeTime(time);
          },
          decoration: InputDecoration(
            suffixIcon: suffixIcon,
          ),
          validator: (value) {
            if (value?.isEmpty ?? true) return '';
            return null;
          },
        );
      })
    ];
  }

  List<Widget> buildAddressField() {
    return [
      Text(lang.address),
      Obx(() {
        return InputDecorator(
          decoration: InputDecoration(enabled: false),
          child: Text(controller.selectedPort.value?.address ?? ''),
        );
      })
    ];
  }

  List<Widget> buildPortDropdownField() {
    return [
      Text(lang.port),
      Obx(() {
        return DropdownSearch<Port>(
          // ignore: invalid_use_of_protected_member
          items: controller.avaiablePorts.value,
          itemAsString: (item) => item.name,
          onChanged: controller.changePort,
          dropdownDecoratorProps: DropDownDecoratorProps(
            dropdownSearchDecoration: InputDecoration(),
          ),
          clearButtonProps: ClearButtonProps(isVisible: true),
          compareFn: (item1, item2) => item1 == item2,
          popupProps: PopupProps.dialog(
            showSearchBox: true,
            searchDelay: Duration(milliseconds: 200),
            showSelectedItems: true,
          ),
          validator: (value) {
            if (value == null) return '';
            return null;
          },
        );
      })
    ];
  }
}
