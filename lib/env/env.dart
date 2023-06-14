import 'package:ship_management/utils/constants.dart';

class Env {
  static _EnvBase _env = _DevEnv();
  static void configWith(EnvType type) {
    switch (type) {
      case EnvType.dev:
      case EnvType.stg:
        _env = _DevEnv();
        break;

      case EnvType.prd:
        _env = _PrdEnv();
        break;
    }
  }

  static String get domain => _env.domain;
  static int get timeout => 10000;
}

abstract class _EnvBase {
  String get name;

  String get domain;
}

class _DevEnv extends _EnvBase {
  @override
  String get domain => 'https://tauca-api.vnptquangninh.vn/api';

  @override
  String get name => EnvType.dev.name;
}

class _PrdEnv extends _EnvBase {
  @override
  String get domain => '';

  @override
  String get name => EnvType.prd.name;
}
