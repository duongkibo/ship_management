class ApiPath {
  static const login = '/Account/Login';
  static const port = '/CangCa/GetAll';
  static const reqExport = '/XuatCang';
  static const reqImport = '/NhapCang';
  static const employee = '/ThuyenVien';

  static String deleteInfo(dynamic id) => '/ThuyenVien/$id';

  static String profile(dynamic id) => '/Tau/GetTau/$id';

  static String profileEmployee(dynamic tauId) =>
      '/ThuyenVien/getByTauId/$tauId';

  static String getLicenseByTauId(dynamic tauId, dynamic enumGiayPhep) =>
      '/GiayPhep/GetGiayPhepByTauId?tauId=$tauId&enumGiayPhep=$enumGiayPhep';

  static String getReqExport(dynamic id) => '/XuatCang/$id';

  static String getReqImport(dynamic id) => '/NhapCang/$id';
  static const pushLocation = '/LogHanhTrinh';
  static const nhatKyKhaiThac = '/NhatKyKhaiThac';
  static const nhatKyKhaiThacAll = '/NhatKyKhaiThac/CreateNhatKyKhaiThacAll';
  static const nhatKyTruyenTai =
      '/NhatKyThuMuaChuyenTai/CreateNhatKyThuMuaChuyenTaiAll';
  static const sanLuongKhaiThac = '/SanLuongKhaiThac';
  static const thongTinKhaiThac = '/ThongTinKhaiThac';
  static const loaiCa = '/LoaiCa/GetAll';
}
