import 'package:ship_management/models/group_fish.dart';

class FilterGroupOfFishItem {
  final GroupFish value;
  final String display;

  FilterGroupOfFishItem({
    required this.value,
    required this.display,
  });

  @override
  String toString() => display;
}

class QuaTrinhKhaiThac {
  final int value;
  final String display;

  QuaTrinhKhaiThac({
    required this.value,
    required this.display,
  });

  @override
  String toString() => display;
}

class TinhTrangBatGap {
  final int value;
  final String display;

  TinhTrangBatGap({
    required this.value,
    required this.display,
  });

  @override
  String toString() => display;
}
