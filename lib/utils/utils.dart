import 'package:flutter/widgets.dart';
import 'package:ship_management/lang/config.dart';
import 'package:ship_management/lang/constants.dart';
import 'package:url_launcher/url_launcher.dart';

LanguageBase get lang => L.of(globalContext);

GlobalKey<NavigatorState> _globalKey = GlobalKey<NavigatorState>();
GlobalKey<NavigatorState> get globalKey => _globalKey;

BuildContext get globalContext => globalKey.currentContext!;

void get clearFocus => FocusScope.of(globalContext).requestFocus(FocusNode());

Future<void> launchHttps(String urlHttps) async {
  try {
    final url = Uri.parse(urlHttps);
    await launchUrl(url, mode: LaunchMode.externalApplication);
  } catch (e) {
    print(e);
  }
}
