import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ship_management/models/fish.dart';
import 'package:ship_management/models/seafood.dart';
import 'package:ship_management/routes/args.dart';
import 'package:ship_management/screens/tranmissing/add_info_rare_fish_controller.dart';
import 'package:ship_management/theme/dimens.dart';
import 'package:ship_management/utils/dialog_helper.dart';
import 'package:ship_management/utils/dropdown/dropdown_model.dart';
import 'package:ship_management/utils/dropdown/rounded_dropdown.dart';
import 'package:ship_management/utils/widget/common.dart';

import '../../utils/utils.dart';

class AddInfoRareFish extends StatefulWidget {
  const AddInfoRareFish({
    Key? key,
  }) : super(key: key);

  @override
  State<AddInfoRareFish> createState() => _AddInfoRareFishState();
}

List<QuaTrinhKhaiThac> listQuaTrinh = [
  QuaTrinhKhaiThac(value: 1, display: 'Thả lưới hoặc câu'),
  QuaTrinhKhaiThac(value: 2, display: 'Kéo lưới'),
  QuaTrinhKhaiThac(value: 3, display: 'Khác'),
];
List<TinhTrangBatGap> listTinhTrang = [
  TinhTrangBatGap(value: 1, display: 'Sống'),
  TinhTrangBatGap(value: 2, display: 'Chết'),
  TinhTrangBatGap(value: 3, display: 'Bị thương'),
];

class _AddInfoRareFishState extends State<AddInfoRareFish> {
  late final InfoRareFishController controller;

  final ValueNotifier<QuaTrinhKhaiThac?> _selectedQuaTrinh =
      ValueNotifier(null);
  final ValueNotifier<TinhTrangBatGap?> _selectedTinhTrang =
      ValueNotifier(null);
  late Fish fish;
  int? quantity;
  int? size;
  int? mass;
  String? date;

  List<Fish> listFish = [];

  @override
  void initState() {
    final args = getScreenArgs();
    fish = args['infoRareFish'];
    controller = Get.put(InfoRareFishController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1D8BC2),
      appBar: AppBar(
        backgroundColor: Color(0xff1D8BC2),
        title: Text('Thêm Thông Tin Cá Quý Hiếm'),
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
                        Text('Khối lượng ước tính'),
                        TextField(
                          // enabled: false,
                          onChanged: (v) =>
                              setState(() => mass = int.tryParse(v)),
                          keyboardType: TextInputType.number,
                          controller: controller.massController,
                        )
                      ],
                    ),
                  ),
                  space(w: 20.dp),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Số lượng ước tính'),
                        TextField(
                          onChanged: (v) =>
                              setState(() => quantity = int.tryParse(v)),
                          keyboardType: TextInputType.number,
                          controller: controller.quantityController,
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
                        Text('Thời điểm bắt gặp'),
                        ...buidlDatetimeField(),
                      ],
                    ),
                  ),
                  space(w: 20.dp),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Kích thước ước tính'),
                        TextField(
                          // enabled: false,
                          onChanged: (v) =>
                              setState(() => size = int.tryParse(v)),
                          keyboardType: TextInputType.number,
                          controller: controller.sizeController,
                        )
                      ],
                    ),
                  ),
                ],
              ),
              space(h: 20.dp),
              _selectQuaTrinh(),
              space(h: 20.dp),
              _selectTinhTrang(),
              space(h: 20.dp),
              Text(
                'Thông tin bổ sung',
                textAlign: TextAlign.left,
              ),
              TextField(
                controller: controller.additionalInformation,
              ),
              space(h: 12.dp),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: ValueListenableBuilder(
          valueListenable: _selectedTinhTrang,
          builder: (_, __, ___) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ValueListenableBuilder(
                  valueListenable: _selectedQuaTrinh,
                  builder: (_, __, ___) {
                    return ElevatedButton(
                      onPressed: () {
                        controller.checkValid(
                          fish: fish,
                          quatrinhKhaiThac: _selectedQuaTrinh.value?.value,
                          tinhTrangBatGap: _selectedTinhTrang.value?.value,
                        );
                        Get.back(result: {
                          'backValue': Seafood(
                            ThoiDiemBatGap: controller.dateTimeController.text,
                            KhoiLuongCon:
                                int.tryParse(controller.massController.text) ??
                                    0,
                            SoLuongUocTinhCon: int.tryParse(
                                    controller.quantityController.text) ??
                                0,
                            KichThuocUocTinh:
                                int.tryParse(controller.sizeController.text) ??
                                    0,
                            QuaTrinhKhaiThac: _selectedQuaTrinh.value?.value,
                            TinhTrangBatGap: _selectedTinhTrang.value?.value,
                            ThongTinBoSung:
                                controller.additionalInformation.text,
                            type: fish.enumLoaiCa?.toString() ?? '',
                            quantity: double.tryParse(
                                    controller.massController.text) ??
                                0,
                          ),
                        });
                      },
                      child: Text('Thêm'),
                      style: ElevatedButton.styleFrom(
                          minimumSize: Size(double.infinity, 44.dp)),
                    );
                  }),
            );
          }),
    );
  }

  Widget _selectQuaTrinh() {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            'Quá trình khai thác',
          ),
        ),
        Expanded(
          flex: 3,
          child: ValueListenableBuilder(
            valueListenable: _selectedQuaTrinh,
            builder: (_, __, ___) {
              return RoundedDropDown<QuaTrinhKhaiThac>(
                borderRadius: 10,
                hintText: 'Quá trình',
                value: _selectedQuaTrinh.value,
                items: listQuaTrinh,
                onChanged: (value) {
                  _selectedQuaTrinh.value = value;
                  _selectedQuaTrinh.notifyListeners();
                },
              );
            },
          ),
        ),
      ],
    );
  }

  List<Widget> buidlDatetimeField() {
    return [
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
          controller: controller.dateTimeController,
          onTap: () async {
            clearFocus;
            final time = await DialogHelper.pickTime();
            if (time != null) controller.changeTime(time);
          },
          onChanged: (v) => setState(() => date = v),
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

  Widget _selectTinhTrang() {
    return Row(
      children: [
        Expanded(
          child: Text(
            'Tình trạng bắt gặp',
          ),
        ),
        Expanded(
          child: ValueListenableBuilder(
            valueListenable: _selectedTinhTrang,
            builder: (_, __, ___) {
              return RoundedDropDown<TinhTrangBatGap>(
                borderRadius: 10,
                hintText: 'Tình trạng',
                value: _selectedTinhTrang.value,
                items: listTinhTrang,
                onChanged: (value) {
                  _selectedTinhTrang.value = value;
                  _selectedTinhTrang.notifyListeners();
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
