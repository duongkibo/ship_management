import 'dart:convert';

import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ship_management/models/auth.dart';
import 'package:ship_management/models/employee_info.dart';
import 'package:ship_management/models/fish.dart';
import 'package:ship_management/models/license_details.dart';
import 'package:ship_management/models/profile.dart';
import 'package:ship_management/utils/constants.dart';
import 'package:ship_management/utils/exception.dart';

enum _StorageKey {
  token,
  user,
  profile,
  trip,
  reqId,
  fishes,
  profileEmployee,
  licenseDetail,
  pathFile,
  isSavePassWork,
  userName,
  passWord,
}

class StorageService {
  static SharedPreferences? _prefs;
  static final StorageService _service = StorageService._internal();

  StorageService._internal();

  static StorageService get instance {
    if (_prefs == null) {
      throw AppException('Storage service was not initialized');
    }
    return _service;
  }

  static Future init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future saveToken(String value) async {
    await _prefs!.setString(_StorageKey.token.name, value);
  }

  static String get token => _prefs!.getString(_StorageKey.token.name) ?? '';

  static Future saveUser(User user) async {
    await _prefs!.setString(_StorageKey.user.name, json.encode(user.toMap));
  }

  static User? get user {
    final data = json.decode(_prefs!.getString(_StorageKey.user.name) ?? '');
    return User.fromMap(data);
  }

  static Future saveProfile(Profile profile) async {
    await _prefs!.setString(
      _StorageKey.profile.name,
      json.encode(profile.toMap),
    );
  }

  static Future saveUserName(String value) async {
    await _prefs!.setString(
      _StorageKey.userName.name,
      value,
    );
  }

  static String getUserName() {
    final data = _prefs!.getString(
      _StorageKey.userName.name,
    ) ?? '';

    return data;
  }

  static String getPassWord() {
    final data = _prefs!.getString(
      _StorageKey.passWord.name,
    ) ?? '';

    return data;
  }

  static Future savePassWord(String value) async {
    await _prefs!.setString(
      _StorageKey.passWord.name,
      value,
    );
  }

  static Future saveIsSavePassWork(bool value) async {
    await _prefs!.setBool(
      _StorageKey.isSavePassWork.name,
      value,
    );
  }

  static bool getIsSavePass() {
    final data = _prefs!.getBool(_StorageKey.isSavePassWork.name) ?? false;
    return data;
  }

  static Future saveDirFile() async {
    final dir = await getApplicationDocumentsDirectory();
    await _prefs!.setString(
      _StorageKey.pathFile.name,
      '$dir/QN${StorageService.profile?.soHieuTau}_${StorageService.profile
          ?.chuyenBienSo}.txt',
    );
  }

  static String? get pathFile {
    final data = _prefs!.getString(_StorageKey.pathFile.name) ?? '';
    return data;
  }

  static Profile? get profile {
    final data = json.decode(_prefs!.getString(_StorageKey.profile.name) ?? '');
    return Profile.fromMap(data);
  }

  static TripStatus get tripStatus {
    final data = _prefs!.getString(_StorageKey.trip.name) ?? '';
    return TripStatus.values.firstWhere(
          (e) => e.name == data,
      orElse: () => TripStatus.unknown,
    );
  }

  static Future saveTripStatus(TripStatus status) async {
    await _prefs!.setString(_StorageKey.trip.name, status.name);
  }

  static String get reqPortId {
    return _prefs!.getString(_StorageKey.reqId.name) ?? '';
  }

  static Future saveReqPortId(dynamic status) async {
    await _prefs!.setString(_StorageKey.reqId.name, status?.toString() ?? '');
  }

  static List<Fish> get fishes {
    final data = _prefs!.getStringList(_StorageKey.fishes.name) ?? [];
    return [...data.map((e) => Fish.fromMap(jsonDecode(e)))];
  }

  static Future saveFishes(List<Fish> fishes) async {
    final data = [...fishes.map((e) => jsonEncode(e.toMap))];
    await _prefs!.setStringList(_StorageKey.fishes.name, data);
  }

  static Future saveProfileEmployee(List<EmployeeInfo> profile) async {
    final data = [...profile.map((e) => jsonEncode(e.toJson()))];
    await _prefs!.setStringList(_StorageKey.profileEmployee.name, data);
  }

  static Future saveLicenseDetail(List<LicenseDetail> license) async {
    final data = [...license.map((e) => jsonEncode(e.toJson()))];
    await _prefs!.setStringList(_StorageKey.licenseDetail.name, data);
  }

  static List<EmployeeInfo> get profileEmployee {
    final data = _prefs!.getStringList(_StorageKey.profileEmployee.name) ?? [];
    return [...data.map((e) => EmployeeInfo.fromJson(jsonDecode(e)))];
  }

  static List<LicenseDetail> get licenseDetails {
    final data = _prefs!.getStringList(_StorageKey.licenseDetail.name) ?? [];
    return [...data.map((e) => LicenseDetail.fromJson(jsonDecode(e)))];
  }
}
