class NhanVien{
  final int? id;
  final String? tenThuyenVien;

  NhanVien({this.id, this.tenThuyenVien});


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
   data['thuyenVienRaKhoiIds'] = id;

    return data;
  }
}