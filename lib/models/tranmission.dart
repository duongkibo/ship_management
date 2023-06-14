import 'package:ship_management/models/seafood.dart';

class SanLuongThuMuaChuyenTaiModel {
  int? loaiCaId;
  int? sanLuong;
  String? ThoiDiemBatGap;
  int? KhoiLuongCon;
  int? SoLuongUocTinhCon;
  int? KichThuocUocTinh;
  int? QuaTrinhKhaiThac;
  int? TinhTrangBatGap;
  String? ThongTinBoSung;

  SanLuongThuMuaChuyenTaiModel({
    this.loaiCaId,
    this.sanLuong,
    this.KhoiLuongCon,
    this.KichThuocUocTinh,
    this.QuaTrinhKhaiThac,
    this.SoLuongUocTinhCon,
    this.ThoiDiemBatGap,
    this.TinhTrangBatGap,
    this.ThongTinBoSung,
  });

  SanLuongThuMuaChuyenTaiModel.fromJson(Map<String, dynamic> json) {
    loaiCaId = json['loaiCaId'];
    sanLuong = json['sanLuong'];
    KhoiLuongCon = json['KhoiLuongCon'];
    KichThuocUocTinh = json['KichThuocUocTinh'];
    QuaTrinhKhaiThac = json['QuaTrinhKhaiThac'];
    SoLuongUocTinhCon = json['SoLuongUocTinhCon'];
    ThoiDiemBatGap = json['ThoiDiemBatGap'];
    TinhTrangBatGap = json['TinhTrangBatGap'];
    ThongTinBoSung = json['ThongTinBoSung'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['loaiCaId'] = loaiCaId;
    data['sanLuong'] = sanLuong;
    data['KhoiLuongCon'] = KhoiLuongCon;
    data['KichThuocUocTinh'] = KichThuocUocTinh;
    data['QuaTrinhKhaiThac'] = QuaTrinhKhaiThac;
    data['SoLuongUocTinhCon'] = SoLuongUocTinhCon;
    data['ThoiDiemBatGap'] = ThoiDiemBatGap;
    data['TinhTrangBatGap'] = TinhTrangBatGap;
    data['ThongTinBoSung'] = ThongTinBoSung;
    return data;
  }

  SanLuongThuMuaChuyenTaiModel copyWith({
    int? loaiCaId,
    int? sanLuong,
    String? ThoiDiemBatGap,
    int? KhoiLuongCon,
    int? SoLuongUocTinhCon,
    int? KichThuocUocTinh,
    int? QuaTrinhKhaiThac,
    int? TinhTrangBatGap,
    String? ThongTinBoSung,
  }) {
    return SanLuongThuMuaChuyenTaiModel(
      loaiCaId: loaiCaId ?? this.loaiCaId,
      sanLuong: sanLuong ?? this.sanLuong,
      ThoiDiemBatGap: ThoiDiemBatGap ?? this.ThoiDiemBatGap,
      SoLuongUocTinhCon: SoLuongUocTinhCon ?? this.SoLuongUocTinhCon,
      KichThuocUocTinh: KichThuocUocTinh ?? this.KichThuocUocTinh,
      QuaTrinhKhaiThac: QuaTrinhKhaiThac ?? this.QuaTrinhKhaiThac,
      TinhTrangBatGap: TinhTrangBatGap ?? this.TinhTrangBatGap,
      ThongTinBoSung: ThongTinBoSung,
    );
  }
}

class ThongTinThuMuaTruyenTaiModel {
  int? stt;
  int? nhatKyKhaiThacId;
  String? thoiGianThuMuaChuyenTai;
  String? viDo;
  String? kinhDo;
  String? note;
  String? tongSanLuong;
  List<Seafood>? sanLuongThuMuaChuyenTais;

  double get total =>
      sanLuongThuMuaChuyenTais!.fold(0.0, (v, e) => v + (e?.quantity ?? 0));

  ThongTinThuMuaTruyenTaiModel({
    this.stt,
    this.nhatKyKhaiThacId,
    this.thoiGianThuMuaChuyenTai,
    this.viDo,
    this.kinhDo,
    this.tongSanLuong,
    this.sanLuongThuMuaChuyenTais,
    this.note,
  });

  ThongTinThuMuaTruyenTaiModel.fromJson(Map<String, dynamic> json) {
    nhatKyKhaiThacId = json['nhatKyKhaiThacId'];
    stt = json['stt'];
    thoiGianThuMuaChuyenTai = json['thoiGianThuMuaChuyenTai'];
    viDo = json['viDo'];
    kinhDo = json['kinhDo'];
    note = json['note'];
    tongSanLuong = json['tongSanLuong'];
    sanLuongThuMuaChuyenTais = [
      ...json['seafoods'].map((e) => Seafood.fromMap(e))
    ];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['nhatKyKhaiThacId'] = nhatKyKhaiThacId;
    data['thoiGianThuMuaChuyenTai'] = thoiGianThuMuaChuyenTai;
    data['viDo'] = viDo;
    data['kinhDo'] = kinhDo;
    data['stt'] = stt;
    data['tongSanLuong'] = tongSanLuong;
    data['note'] = note;
    data['sanLuongThuMuaChuyenTais'] = sanLuongThuMuaChuyenTais != null
        ? sanLuongThuMuaChuyenTais!.map((v) => v.toJsonV2()).toList()
        : null;

    return data;
  }

  Map<String, dynamic> toJsonV2() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['soDangKyTauBan'] = nhatKyKhaiThacId.toString();
    data['thoiGianThuMuaChuyenTai'] = thoiGianThuMuaChuyenTai;
    data['viDo'] = viDo;
    data['kinhDo'] = kinhDo;
    data['tongSanLuong'] = total.toInt();
    data['ghiChu'] = note;
    data['sanLuongThuMuaChuyenTais'] = sanLuongThuMuaChuyenTais != null
        ? sanLuongThuMuaChuyenTais!.map((v) => v.toJsonV2()).toList()
        : null;

    return data;
  }

  ThongTinThuMuaTruyenTaiModel copyWith({
    int? stt,
    int? nhatKyKhaiThacId,
    String? thoiGianThuMuaChuyenTai,
    String? viDo,
    String? kinhDo,
    String? tongSanLuong,
    String? note,
    List<Seafood>? sanLuongThuMuaChuyenTais,
  }) {
    return ThongTinThuMuaTruyenTaiModel(
      stt: stt ?? this.stt,
      nhatKyKhaiThacId: nhatKyKhaiThacId ?? this.nhatKyKhaiThacId,
      thoiGianThuMuaChuyenTai:
          thoiGianThuMuaChuyenTai ?? this.thoiGianThuMuaChuyenTai,
      viDo: viDo ?? this.viDo,
      kinhDo: kinhDo ?? this.kinhDo,
      note: note,
      tongSanLuong: tongSanLuong ?? this.tongSanLuong,
      sanLuongThuMuaChuyenTais:
          sanLuongThuMuaChuyenTais ?? this.sanLuongThuMuaChuyenTais,
    );
  }
}
