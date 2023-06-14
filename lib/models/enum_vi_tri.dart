class EnumVitriNhanVien {
  String? name = 'Vị trí';
  bool? isExpanded;

  List<EnumVitri> enumVitri = [
    EnumVitri(
      idVitri: 0,
      enumViTriThuyenVien: 'Thuyền Trưởng',
    ),
    EnumVitri(
      idVitri: 1,
      enumViTriThuyenVien: 'Thuyền Phó',
    ),
    EnumVitri(
      idVitri: 2,
      enumViTriThuyenVien: 'Máy Trưởng',
    ),
    EnumVitri(
      idVitri: 3,
      enumViTriThuyenVien: 'Thuyền Viên',
    ),
  ];

  EnumVitriNhanVien({
    this.isExpanded = false,
  });
}

class EnumVitri {
  int? idVitri;

  String? enumViTriThuyenVien;

  EnumVitri({
    this.idVitri,
    this.enumViTriThuyenVien,
  });
}
