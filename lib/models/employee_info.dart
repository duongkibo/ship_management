import 'package:ship_management/utils/extensions.dart';

class EmployeeInfo {
  int? id;
  String? tenThuyenVien;
  int? enumViTriThuyenVien;
  String? imageUrl;
  int? gioiTinh;
  String? cccd;
  String? noiCap;
  DateTime? ngayCap;
  int? soDienThoai;
  String? diaChiIds;
  String? diaChi;
  String? fileUrl;
  int? tauId;
  bool? isExpanded;
  bool isSelect = false;

  EmployeeInfo({
    this.id,
    this.tenThuyenVien,
    this.enumViTriThuyenVien,
    this.imageUrl,
    this.gioiTinh,
    this.cccd,
    this.noiCap,
    this.ngayCap,
    this.soDienThoai,
    this.diaChiIds,
    this.diaChi,
    this.fileUrl,
    this.tauId,
    this.isExpanded = false,
  });

  EmployeeInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tenThuyenVien = json['tenThuyenVien'];
    enumViTriThuyenVien = json['enumViTriThuyenVien'];
    imageUrl = json['imageUrl'];
    gioiTinh = json['gioiTinh'];
    cccd = json['cccd'];
    noiCap = json['noiCap'];
    ngayCap = json['ngayCap'].toString().toDate('yyyy-MM-ddTHH:mm:ss');
    soDienThoai = json['soDienThoai'];
    diaChiIds = json['diaChiIds'];
    diaChi = json['diaChi'];
    fileUrl = json['fileUrl'];
    tauId = json['tauId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    int i = 0;
    data['id'] = this.id;
    data['tenThuyenVien'] = this.tenThuyenVien;
    data['enumViTriThuyenVien'] = this.enumViTriThuyenVien;
    data['imageUrl'] = this.imageUrl;
    data['gioiTinh'] = this.gioiTinh;
    data['cccd'] = this.cccd;
    data['noiCap'] = this.noiCap;
    data['ngayCap'] = this.ngayCap?.format('yyyy-MM-ddTHH:mm:ss');
    data['soDienThoai'] = this.soDienThoai;
    data['diaChiIds'] = this.diaChiIds;
    data['diaChi'] = this.diaChi;
    data['fileUrl'] = this.fileUrl;
    data['tauId'] = this.tauId;

    data.forEach((key, value) {
      print('++++++++${i++}');
      print('$key: $value');
    });

    return data;
  }
}
