import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ship_management/utils/dialog_helper.dart';

class AppException implements Exception {
  final String message;

  AppException([this.message = 'Lôĩ không xác định.']);

  factory AppException.system() => AppException('Lỗi hệ thống.');

  factory AppException.server() => AppException('Lỗi máy chủ.');

  factory AppException.notfound() => AppException('Nội dung không tồn tại.');

  factory AppException.unknown() => AppException('Lôĩ không xác định.');

  factory AppException.network() => AppException('Lỗi kết nối.');

  @override
  String toString() {
    return '$message';
  }
}

Future handleException(
  Object e, {
  Future Function(int? statusCode, ApiError error)? onReponse,
  VoidCallback? onClose,
}) async {
  if (e is AppException) {
    await DialogHelper.confirm(
      message: e.message,
      onPositionPressed: onClose,
    );
  } else if (e is SocketException) {
    await DialogHelper.confirm(
      message: AppException.network().message,
      onPositionPressed: onClose,
    );
  } else if (e is DioError) {
    try {
      await _handleHttpDioError(e, callback: onReponse);
    } catch (e) {
      await handleException(e);
    }
  } else {
    await DialogHelper.confirm(
      message: e.toString(),
      onPositionPressed: onClose,
    );
  }
}

Future _handleHttpDioError(
  DioError e, {
  Future Function(int? statusCode, ApiError error)? callback,
  VoidCallback? onClose,
}) async {
  switch (e.type) {
    case DioErrorType.cancel:
      throw AppException.system();

    case DioErrorType.connectTimeout:
    case DioErrorType.sendTimeout:
    case DioErrorType.receiveTimeout:
      throw AppException.network();

    case DioErrorType.other:
      throw e.error;

    case DioErrorType.response:
      final res = e.response;
      if (res != null) {
        switch (res.statusCode) {
          case 500:
            throw AppException.server();

          case 404:
            throw AppException.notfound();

          default:
            final err = ApiError.fromMap(res.data);
            if (callback != null) {
              return await callback(res.statusCode, err);
            } else {
              return await DialogHelper.confirm(
                message: err.message,
                onPositionPressed: onClose,
              );
            }
        }
      } else if (e.error != null) {
        final err = ApiError.fromMap(e.error);
        return await DialogHelper.confirm(
          message: err.message,
          onPositionPressed: onClose,
        );
      }

      throw AppException.unknown();
  }
}

class ApiError {
  final String message;
  ApiError(this.message);

  factory ApiError.fromMap(Map<String, dynamic> map) {
    final data = map['errors'];
    if (data is Iterable) {
      return ApiError(data.join(r' '));
    }
    return ApiError(data.toString());
  }
}
