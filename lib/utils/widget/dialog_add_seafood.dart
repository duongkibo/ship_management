import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ship_management/models/fish.dart';
import 'package:ship_management/models/group_fish.dart';
import 'package:ship_management/models/seafood.dart';
import 'package:ship_management/services/shared_data/storage_service.dart';
import 'package:ship_management/theme/theme.dart';
import 'package:ship_management/utils/dropdown/dropdown_model.dart';
import 'package:ship_management/utils/dropdown/rounded_dropdown.dart';
import 'package:ship_management/utils/utils.dart';
import 'package:ship_management/utils/widget/common.dart';
import 'package:ship_management/utils/widget/dialog_rare_ish_warning.dart';

class AddSeafoodDialog extends StatefulWidget {
  @override
  State<AddSeafoodDialog> createState() => _AddSeafoodDialogState();
}

class _AddSeafoodDialogState extends State<AddSeafoodDialog> {
  Fish? type;
  double? quantity;
  final ValueNotifier<GroupFish?> _selectedType = ValueNotifier(null);
  List<FilterGroupOfFishItem> listIDGroupFish = [];
  List<Fish> listFish = StorageService.fishes;
  List<Fish> selectFishes = [];
  List<GroupFish> listGroupFish = StorageService.groupFish;
  bool isGroupFishes = false;
  GroupFish allFishes = GroupFish(tenNhomCa: 'Tất cả');

  @override
  void initState() {
    selectFishes = listFish;
    for (var element in listGroupFish) {
      if (element.tenNhomCa == allFishes.tenNhomCa) {
        isGroupFishes = true;
        break;
      }
    }
    if (!isGroupFishes) {
      listGroupFish.add(allFishes);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => clearFocus,
      child: Container(
        color: AppColors.background,
        height: Get.height,
        padding: EdgeInsets.all(32.dp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _filterType(),
            space(h: 16.dp),
            Text('LOÀI'),
            ValueListenableBuilder(
                valueListenable: _selectedType,
                builder: (_, __, ___) {
                  return DropdownSearch<Fish>(
                    items: selectFishes,
                    itemAsString: (item) => item.name,
                    onChanged: (v) => setState(() => type = v),
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
                  );
                }),
            space(h: 16.dp),
            Text('SẢN LƯỢNG (KG)'),
            TextField(
              onChanged: (v) => setState(() => quantity = double.tryParse(v)),
              keyboardType: TextInputType.number,
            ),
            Expanded(child: SizedBox()),
            ElevatedButton(
              onPressed: validate() ? submit : null,
              child: Text('THÊM'),
            )
          ],
        ),
      ),
    );
  }

  Widget _filterType() {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            'Chọn Nhóm Cá :',
          ),
        ),
        Expanded(
          flex: 3,
          child: ValueListenableBuilder(
            valueListenable: _selectedType,
            builder: (_, __, ___) {
              return RoundedDropDown<GroupFish>(
                borderRadius: 10,
                hintText: 'Nhóm cá',
                value: _selectedType.value,
                items: listGroupFish,
                onChanged: (value) {
                  if (value?.tenNhomCa == 'Tất cả') {
                    selectFishes = listFish;
                  } else {
                    selectFishes = listFish
                        .where((element) => element.nhomCaId == value?.id)
                        .toList();
                  }

                  _selectedType.value = value;
                  _selectedType.notifyListeners();
                },
              );
            },
          ),
        ),
      ],
    );
  }

  bool validate() => type != null && quantity != null;

  void submit() async {
    // final res = await Get.dialog<Seafood>(
    //   DialogRareFishWarning(
    //     fish: type!,
    //   ),
    // );
    // print('--------res');
    // print(res?.quantity);
    // print(res?.TinhTrangBatGap);
    // print(res?.ThongTinBoSung);
    // print(res?.ThoiDiemBatGap);
    // Get.back(
    //   result: res,
    // );
    if (type?.isQuyHiem == true) {
      final res = await Get.dialog<Seafood>(
        DialogRareFishWarning(
          fish: type!,
        ),
      );
      Get.back(
        result: res,
      );
    } else {
      Get.back(
        result: Seafood(
          id: UniqueKey().toString(),
          type: type!.id,
          quantity: quantity!,
        ),
      );
    }
  }
}
