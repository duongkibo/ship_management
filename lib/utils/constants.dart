import 'package:ship_management/utils/utils.dart';

enum EnvType { dev, stg, prd }

enum ProfileType { notification, information, profileEmployee }

extension ProfileTypeX on ProfileType {
  String get label {
    switch (this) {
      case ProfileType.notification:
        return lang.notification;
      case ProfileType.information:
        return lang.information;
      case ProfileType.profileEmployee:
        return lang.employee;
    }
  }
}

enum ReqType { import, export }

enum EmployeeType { created, update }

extension ReqTypeX on ReqType {
  String get appbarTitle {
    switch (this) {
      case ReqType.import:
        return lang.reqImportTitle;

      case ReqType.export:
        return lang.reqExportTitle;
    }
  }
}

extension EmployeeTypeText on EmployeeType {
  String get titleAppbar {
    switch (this) {
      case EmployeeType.created:
        return lang.createInfoEmployee;

      case EmployeeType.update:
        return lang.updateInfoEmployee;
    }
  }
}

enum TripStatus {
  waitExport,
  waitImport,
  declineExport,
  declineImport,
  inprogress,
  unknown,
  deli
}
