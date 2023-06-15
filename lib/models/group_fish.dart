class GroupFish {
  int? id;
  String? tenNhomCa;
  String? ghiChu;
  int? orderBy;
  String? ngayHieuLuc;
  String? ngayHetHieuLuc;

  GroupFish(
      {this.id,
      this.tenNhomCa,
      this.ghiChu,
      this.orderBy,
      this.ngayHieuLuc,
      this.ngayHetHieuLuc});

  GroupFish.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tenNhomCa = json['tenNhomCa'];
    ghiChu = json['ghiChu'];
    orderBy = json['orderBy'];
    ngayHieuLuc = json['ngayHieuLuc'];
    ngayHetHieuLuc = json['ngayHetHieuLuc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    int i = 0;
    data['id'] = this.id;
    data['tenNhomCa'] = this.tenNhomCa;
    data['ghiChu'] = this.ghiChu;
    data['orderBy'] = this.orderBy;
    data['ngayHieuLuc'] = this.ngayHieuLuc;
    data['ngayHetHieuLuc'] = this.ngayHetHieuLuc;
    data.forEach((key, value) {
      print('++++++++GroupFish:${i++}');
      print('$key: $value');
    });

    return data;
  }

  @override
  String toString() {
    return '$tenNhomCa';
  }
}
