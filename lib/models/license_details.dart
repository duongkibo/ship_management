import 'package:ship_management/utils/extensions.dart';

class LicenseDetail {
  int? id;
  String? tenVanBanDinhKem;
  String? fileUrl;
  DateTime? ngayCapPhep;
  DateTime? ngayHetHan;
  String? tenLoaiHinhGiayPhep;
  int? so;
  bool? isExpanded;

  LicenseDetail({
    this.id,
    this.tenVanBanDinhKem,
    this.fileUrl,
    this.ngayCapPhep,
    this.ngayHetHan,
    this.tenLoaiHinhGiayPhep,
    this.so,
    this.isExpanded = true,
  });

  LicenseDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tenVanBanDinhKem = json['tenVanBanDinhKem'];
    fileUrl = json['fileUrl'];
    ngayCapPhep = json['ngayCapPhep'].toString().toDate('yyyy-MM-ddTHH:mm:ss');
    ngayHetHan = json['ngayHetHan'].toString().toDate('yyyy-MM-ddTHH:mm:ss');
    tenLoaiHinhGiayPhep = json['tenLoaiHinhGiayPhep'];
    so = json['so'] as int?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['tenVanBanDinhKem'] = this.tenVanBanDinhKem;
    data['fileUrl'] = this.fileUrl;
    data['ngayCapPhep'] = this.ngayCapPhep?.format('yyyy-MM-ddTHH:mm:ss');
    data['ngayHetHan'] = this.ngayHetHan?.format('yyyy-MM-ddTHH:mm:ss');
    data['tenLoaiHinhGiayPhep'] = this.tenLoaiHinhGiayPhep;
    data['so'] = this.so;
    data['isExpanded'] = this.isExpanded;
    data.forEach((key, value) {
      print('++++++++LicenseDetail');
      print('$key: $value');
    });
    return data;
  }
}
