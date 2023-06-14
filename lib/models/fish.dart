import 'package:ship_management/utils/extensions.dart';

class Fish {
  final String id;
  final String name;
  final bool? isQuyHiem;
  final int? enumLoaiCa;
  final String? ghiChu;
  final int? nhomCaId;
  final String? tenNhomCa;
  final DateTime? ngayHieuLuc;
  final DateTime? ngayHetHieuLuc;
  final dynamic imageUrl;
  final dynamic moTa;

  Fish({
    required this.id,
    required this.name,
    this.isQuyHiem,
    this.enumLoaiCa,
    this.ghiChu,
    this.nhomCaId,
    this.tenNhomCa,
    this.ngayHieuLuc,
    this.ngayHetHieuLuc,
    this.imageUrl,
    this.moTa,
  });

  factory Fish.fromMap(Map<String, dynamic> map) {
    return Fish(
      id: map['id'].toString(),
      name: map['tenLoaiCa'].toString(),
      isQuyHiem: map['isQuyHiem'],
      enumLoaiCa: map['enumLoaiCa'],
      ghiChu: map['ghiChu'].toString(),
      nhomCaId: map['nhomCaId'],
      tenNhomCa: map['tenNhomCa'],
      ngayHetHieuLuc:
      map['ngayHetHieuLuc'].toString().toDate('yyyy-MM-ddTHH:mm:ss'),
      ngayHieuLuc: map['ngayHieuLuc'].toString().toDate('yyyy-MM-ddTHH:mm:ss'),
      imageUrl: map['imageUrl'],
      moTa: map['moTa'],
    );
  }

  Map<String, dynamic> get toMap {
    return {
      'id': id,
      'tenLoaiCa': name,
      "isQuyHiem": isQuyHiem,
      "enumLoaiCa": enumLoaiCa,
      "ghiChu": ghiChu,
      "nhomCaId": nhomCaId,
      "tenNhomCa": tenNhomCa,
      "ngayHieuLuc": ngayHieuLuc?.format('yyyy-MM-ddTHH:mm:ss'),
      "ngayHetHieuLuc": ngayHetHieuLuc?.format('yyyy-MM-ddTHH:mm:ss'),
      "imageUrl": imageUrl,
      "moTa": moTa,
    };
  }

  @override
  String toString() {
    return 'Student: {id: ${id}, name: ${name}, isQuyHiem: ${isQuyHiem}, ghiChu: ${ghiChu}, enumLoaiCa: ${enumLoaiCa}, nhomCaId: ${nhomCaId}, tenNhomCa: ${tenNhomCa}, ngayHieuLuc: ${ngayHieuLuc}, tenNhomCa: ${tenNhomCa},}'
    ;
}}
