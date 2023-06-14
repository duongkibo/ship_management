import 'package:get/get.dart';

T? getScreenArgs<T>() {
  var _args = Get.routing.args;
  return _args is T ? _args : null;
}
