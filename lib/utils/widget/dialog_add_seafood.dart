import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ship_management/models/fish.dart';
import 'package:ship_management/models/seafood.dart';
import 'package:ship_management/routes/routes.dart';
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
  final ValueNotifier<FilterGroupOfFishItem?> _selectedType =
      ValueNotifier(null);
  List<FilterGroupOfFishItem> listIDGroupFish = [];
  List<Fish> listFish = [];
  Map<int?, List<Fish>> groupFish = {};

  @override
  Widget build(BuildContext context) {
    groupFish = groupByObj(
      StorageService.fishes,
      (Fish object) => object.enumLoaiCa,
    );
    listFish = StorageService.fishes;

    for (var e in groupFish.keys) {
      if (listIDGroupFish.every((element) => element.value != e)) {
        listIDGroupFish
            .add(FilterGroupOfFishItem(value: e!, display: e.toString()));
      }
    }

    print(groupFish.keys.toList());
    for (var item in StorageService.fishes) {
      print(item.toString());
    }

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
                    items: listFish,
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
          child: Text(
            'Chọn Nhóm Cá :',
          ),
        ),
        Expanded(
          child: ValueListenableBuilder(
            valueListenable: _selectedType,
            builder: (_, __, ___) {
              return RoundedDropDown<FilterGroupOfFishItem>(
                borderRadius: 10,
                hintText: 'Nhóm cá',
                value: _selectedType.value,
                items: listIDGroupFish,
                onChanged: (value) {
                  listFish = groupFish[value?.value] ?? StorageService.fishes;
                  _selectedType.value = value;
// ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
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

Map<int, List<Fish>> groupByObj<Fish, int>(
  List<Fish> values,
  int Function(Fish) key,
) {
  var map = <int, List<Fish>>{};
  for (var element in values) {
    (map[key(element)] ??= []).add(element);
  }

  return map;
}
