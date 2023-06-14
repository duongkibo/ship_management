import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:ship_management/env/env.dart';

import 'app_interceptor.dart';

class Network extends DioMixin {
  static final Network _service = Network._internal();

  Network._internal() {
    options = BaseOptions(
      baseUrl: Env.domain,
      connectTimeout: Env.timeout,
    );
    interceptors.addAll([AppInterceptor(), PrettyDioLogger()]);
    httpClientAdapter = DefaultHttpClientAdapter();
  }

  factory Network() => _service;
}
