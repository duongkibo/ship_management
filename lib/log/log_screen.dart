import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ship_management/models/ship_location.dart';
import 'package:ship_management/repositories/location_repository.dart';
import 'package:ship_management/theme/theme.dart';
import 'package:ship_management/utils/extensions.dart';
import 'package:ship_management/utils/widget/common.dart';

class LogScreen extends StatefulWidget {
  @override
  State<LogScreen> createState() => _LogScreenState();
}

class _LogScreenState extends State<LogScreen> {
  final items = <ShipLocation>[];

  @override
  void initState() {
    super.initState();
    loaddata();
  }

  Future loaddata() async {
    try {
      final res = await LocationRepository.locations;
      items.assignAll(res);
      setState(() {});
    } catch (e) {
      if (kDebugMode) print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('NK HẢI TRÌNH')),
      body: ListView.separated(
        padding: EdgeInsets.all(32.dp),
        itemBuilder: (context, i) {
          final item = items[i];
          return Text(
            '''${i + 1}. ${item.lat.degreeLat}, ${item.lng.degreeLng} - ${item.time.format('hh:mm')}''',
          );
        },
        separatorBuilder: (_, __) => space(h: 4.dp),
        itemCount: items.length,
      ),
    );
  }
}
