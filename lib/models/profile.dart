import 'package:ship_management/utils/extensions.dart';

class Profile {
  final String id;
  final String soHieuTau;
  final String soDangKy;
  final DateTime? ngayDangKy;
  final String tenChuPhuongTien;
  final String soDienThoai;
  final String diaChi;
  final String tenTau;
  final String nganhNgheId;
  final String xaPhuongId;
  final String ngheChinh;
  final String tongSoThuyenVien;
  final String namDongThuyen;
  final String lmax;
  final String bmax;
  final String dmax;
  final String d;
  final String manKhoF;
  final String tongDungTich;
  final String chieuDaiThietKe;
  final String chieuRongThietKe;
  final String tocDo;
  final String vatLieuVo;
  final String soLuongMayTau;
  final String enumTinhTrangTau;
  final String soGiayCNDinhKy;
  final String hoHieu;
  final String ghiChu;
  final String urlFile;
  final String enumTinhTrangDangKy;
  final int? enumTrangThaiTau;
  final String userId;
  final String congDungTauId;
  final String phanCapId;
  final String mayTauIds;
  final String congSuatCV;
  final String congSuatKW;
  final String soCCCD;
  final String soLuongGiayPhep;
  final String loaiTau;
  final String? soDangKiem;
  final DateTime? ngayHetHanDangKy;
  final DateTime? ngayDangKiem;
  final DateTime? ngayHetHanDangKiem;
  final String? noiDangKy;
  final String? tenTinh;
  final String? noiDongThuyen;
  final int? nganhNghePhuId;
  final String? tongCongSuatMayCV;
  final String? tongCongSuatMayKW;
  final int? chuyenBienSo;

  Profile({
    required this.id,
    required this.soHieuTau,
    required this.soDangKy,
    required this.ngayDangKy,
    required this.tenChuPhuongTien,
    required this.soDienThoai,
    required this.diaChi,
    required this.tenTau,
    required this.nganhNgheId,
    required this.xaPhuongId,
    required this.ngheChinh,
    required this.tongSoThuyenVien,
    required this.namDongThuyen,
    required this.lmax,
    required this.bmax,
    required this.dmax,
    required this.d,
    required this.manKhoF,
    required this.tongDungTich,
    required this.chieuDaiThietKe,
    required this.chieuRongThietKe,
    required this.tocDo,
    required this.vatLieuVo,
    required this.soLuongMayTau,
    required this.enumTinhTrangTau,
    required this.soGiayCNDinhKy,
    required this.hoHieu,
    required this.ghiChu,
    required this.urlFile,
    required this.enumTinhTrangDangKy,
    required this.userId,
    required this.congDungTauId,
    required this.phanCapId,
    required this.mayTauIds,
    required this.congSuatCV,
    required this.congSuatKW,
    required this.soCCCD,
    required this.soLuongGiayPhep,
    required this.loaiTau,
    required this.soDangKiem,
    required this.ngayHetHanDangKy,
    required this.ngayDangKiem,
    required this.ngayHetHanDangKiem,
    required this.noiDangKy,
    required this.tenTinh,
    required this.noiDongThuyen,
    required this.nganhNghePhuId,
    required this.tongCongSuatMayCV,
    required this.tongCongSuatMayKW,
    required this.chuyenBienSo,
     this.enumTrangThaiTau,
  });

  factory Profile.fromMap(Map<String, dynamic> map) {
    return Profile(
      id: map['id']?.toString() ?? '',
      soHieuTau: map['soHieuTau']?.toString() ?? '',
      soDangKy: map['soDangKy']?.toString() ?? '',
      ngayDangKy: map['ngayDangKy']?.toString().toDate('yyyy-MM-ddTHH:mm:ss'),
      tenChuPhuongTien: map['tenChuPhuongTien']?.toString() ?? '',
      soDienThoai: map['soDienThoai']?.toString() ?? '',
      diaChi: map['diaChi']?.toString() ?? '',
      tenTau: map['tenTau']?.toString() ?? '',
      nganhNgheId: map['nganhNgheId']?.toString() ?? '',
      xaPhuongId: map['xaPhuongId']?.toString() ?? '',
      ngheChinh: map['ngheChinh']?.toString() ?? '',
      tongSoThuyenVien: map['tongSoThuyenVien']?.toString() ?? '',
      namDongThuyen: map['namDongThuyen']?.toString() ?? '',
      lmax: map['lmax']?.toString() ?? '',
      bmax: map['bmax']?.toString() ?? '',
      dmax: map['dmax']?.toString() ?? '',
      d: map['d']?.toString() ?? '',
      manKhoF: map['manKhoF']?.toString() ?? '',
      tongDungTich: map['tongDungTich']?.toString() ?? '',
      chieuDaiThietKe: map['chieuDaiThietKe']?.toString() ?? '',
      chieuRongThietKe: map['chieuRongThietKe']?.toString() ?? '',
      tocDo: map['tocDo']?.toString() ?? '',
      vatLieuVo: map['vatLieuVo']?.toString() ?? '',
      soLuongMayTau: map['soLuongMayTau']?.toString() ?? '',
      enumTinhTrangTau: map['enumTinhTrangTau']?.toString() ?? '',
      soGiayCNDinhKy: map['soGiayCNDinhKy']?.toString() ?? '',
      hoHieu: map['hoHieu']?.toString() ?? '',
      ghiChu: map['ghiChu']?.toString() ?? '',
      urlFile: map['urlFile']?.toString() ?? '',
      enumTinhTrangDangKy: map['enumTinhTrangDangKy']?.toString() ?? '',
      userId: map['userId']?.toString() ?? '',
      congDungTauId: map['congDungTauId']?.toString() ?? '',
      phanCapId: map['phanCapId']?.toString() ?? '',
      mayTauIds: map['mayTauIds']?.toString() ?? '',
      congSuatCV: map['congSuatCV']?.toString() ?? '',
      congSuatKW: map['congSuatKW']?.toString() ?? '',
      soCCCD: map['soCCCD']?.toString() ?? '',
      soLuongGiayPhep: map['soLuongGiayPhep']?.toString() ?? '',
      loaiTau: map['loaiTau']?.toString() ?? '',
      soDangKiem: map['soDangKiem']?.toString() ?? '',
      ngayHetHanDangKy:
      map['ngayHetHanDangKy']?.toString().toDate('yyyy-MM-ddTHH:mm:ss'),
      ngayDangKiem:
      map['ngayDangKiem']?.toString().toDate('yyyy-MM-ddTHH:mm:ss'),
      ngayHetHanDangKiem:
      map['ngayHetHanDangKiem']?.toString().toDate('yyyy-MM-ddTHH:mm:ss'),
      noiDangKy: map['noiDangKy']?.toString() ?? '',
      tenTinh: map['tenTinh']?.toString() ?? '',
      noiDongThuyen: map['noiDongThuyen']?.toString() ?? '',
      nganhNghePhuId: map['nganhNghePhuId'] ?? null,
      tongCongSuatMayCV: map['tongCongSuatMayCV']?.toString() ?? '',
      tongCongSuatMayKW: map['tongCongSuatMayKW']?.toString() ?? '',
      chuyenBienSo: map['chuyenBienSo'] ?? null,
      enumTrangThaiTau: map['enumTrangThaiTau'] ?? null,
    );
  }

  Map<String, dynamic> get toMap {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['soHieuTau'] = this.soHieuTau;
    data['soDangKy'] = this.soDangKy;
    data['ngayDangKy'] = this.ngayDangKy?.format('yyyy-MM-ddTHH:mm:ss');
    data['tenChuPhuongTien'] = this.tenChuPhuongTien;
    data['diaChi'] = this.diaChi;
    data['tenTau'] = this.tenTau;
    data['nganhNgheId'] = this.nganhNgheId;
    data['xaPhuongId'] = this.xaPhuongId;
    data['ngheChinh'] = this.ngheChinh;
    data['tongSoThuyenVien'] = this.tongSoThuyenVien;
    data['namDongThuyen'] = this.namDongThuyen;
    data['lmax'] = this.lmax;
    data['bmax'] = this.bmax;
    data['dmax'] = this.dmax;
    data['enumTrangThaiTau'] = this.enumTrangThaiTau;
    data['d'] = this.d;
    data['manKhoF'] = this.manKhoF;
    data['tongDungTich'] = this.tongDungTich;
    data['chieuDaiThietKe'] = this.chieuDaiThietKe;
    data['chieuRongThietKe'] = this.chieuRongThietKe;
    data['tocDo'] = this.tocDo;
    data['vatLieuVo'] = this.vatLieuVo;
    data['soLuongMayTau'] = this.soLuongMayTau;
    data['enumTinhTrangTau'] = this.enumTinhTrangTau;
    data['soGiayCNDinhKy'] = this.soGiayCNDinhKy;
    data['hoHieu'] = this.hoHieu;
    data['ghiChu'] = this.ghiChu;
    data['urlFile'] = this.urlFile;
    data['enumTinhTrangDangKy'] = this.enumTinhTrangDangKy;
    data['userId'] = this.userId;
    data['congDungTauId'] = this.congDungTauId;
    data['phanCapId'] = this.phanCapId;
    data['mayTauIds'] = this.mayTauIds;
    data['congSuatCV'] = this.congSuatCV;
    data['congSuatKW'] = this.congSuatKW;
    data['soCCCD'] = this.soCCCD;
    data['soLuongGiayPhep'] = this.soLuongGiayPhep;
    data['soDienThoai'] = this.soDienThoai;
    data['loaiTau'] = this.loaiTau;
    data['soDangKiem'] = this.soDangKiem;
    data['ngayHetHanDangKy'] =
        this.ngayHetHanDangKy?.format('yyyy-MM-ddTHH:mm:ss');
    data['ngayDangKiem'] = this.ngayDangKiem?.format('yyyy-MM-ddTHH:mm:ss');
    data['ngayHetHanDangKiem'] =
        this.ngayHetHanDangKiem?.format('yyyy-MM-ddTHH:mm:ss');
    data['noiDangKy'] = this.noiDangKy;
    data['noiDongThuyen'] = this.noiDongThuyen;
    data['nganhNghePhuId'] = this.nganhNghePhuId;
    data['tongCongSuatMayCV'] = this.tongCongSuatMayCV;
    data['tongCongSuatMayKW'] = this.tongCongSuatMayKW;
    data['chuyenBienSo'] = this.chuyenBienSo;
    return data;
  }
}
