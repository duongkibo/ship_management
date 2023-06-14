import 'package:equatable/equatable.dart';

class Seafood extends Equatable {
  final String? id;
  final String type;
  final double quantity;
  final String? ThoiDiemBatGap;
  final int? KhoiLuongCon;
  final int? SoLuongUocTinhCon;
  final int? KichThuocUocTinh;
  final int? QuaTrinhKhaiThac;
  final int? TinhTrangBatGap;
  final String? ThongTinBoSung;

  Seafood({
    this.id,
    required this.type,
    required this.quantity,
    this.ThoiDiemBatGap,
    this.KhoiLuongCon,
    this.SoLuongUocTinhCon,
    this.KichThuocUocTinh,
    this.QuaTrinhKhaiThac,
    this.TinhTrangBatGap,
    this.ThongTinBoSung,
  });

  @override
  List<Object?> get props => [id, type, quantity];

  factory Seafood.fromMap(Map<String, dynamic> map) {
    return Seafood(
      id: map['id'],
      type: map['type'],
      quantity: map['quantity'],
      ThoiDiemBatGap: map['ThoiDiemBatGap'],
      KhoiLuongCon: map['KhoiLuongCon'],
      SoLuongUocTinhCon: map['SoLuongUocTinhCon'],
      KichThuocUocTinh: map['KichThuocUocTinh'],
      QuaTrinhKhaiThac: map['QuaTrinhKhaiThac'],
      TinhTrangBatGap: map['TinhTrangBatGap'],
      ThongTinBoSung: map['ThongTinBoSung'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['type'] = type;
    data['quantity'] = quantity;

    return data;
  }

  Map<String, dynamic> toJsonV2() {
    final Map<String, dynamic> data = Map<String, dynamic>();

    data['loaiCaId'] = int.parse(type);
    data['sanLuong'] = quantity.toInt();
    data['ThoiDiemBatGap'] = ThoiDiemBatGap;
    data['KhoiLuongCon'] = KhoiLuongCon;
    data['SoLuongUocTinhCon'] = SoLuongUocTinhCon;
    data['KichThuocUocTinh'] = KichThuocUocTinh;
    data['QuaTrinhKhaiThac'] = QuaTrinhKhaiThac;
    data['TinhTrangBatGap'] = TinhTrangBatGap;
    data['ThongTinBoSung'] = ThongTinBoSung;
    return data;
  }
}
