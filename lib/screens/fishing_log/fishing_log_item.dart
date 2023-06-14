import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ship_management/models/fishing_log.dart';
import 'package:ship_management/models/seafood.dart';
import 'package:ship_management/theme/theme.dart';
import 'package:ship_management/utils/extensions.dart';
import 'package:ship_management/utils/widget/common.dart';
import 'package:ship_management/utils/widget/svg_icon.dart';

class FishingLogItem extends StatelessWidget {
  const FishingLogItem({
    super.key,
    required this.log,
    this.onTap,
    required this.index,
  });

  final FishingLog log;
  final VoidCallback? onTap;
  final int index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [buildHeader(), buildBody()],
      ),
    );
  }

  Container buildBody() {
    return Container(
      padding: EdgeInsets.all(12.dp),
      decoration: BoxDecoration(
        color: AppColors.ghostWhite,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(8.dp),
          bottomRight: Radius.circular(8.dp),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text('Thả lưới: '),
              Text(log.releaseTime?.format() ?? ''),
              Expanded(child: SizedBox()),
              Text(log.releaseLocation),
            ],
          ),
          space(h: 8.dp),
          Row(
            children: [
              Text('Thu lưới: '),
              Text(log.collectionTime?.format() ?? ''),
              Expanded(child: SizedBox()),
              Text(log.collectionLocation),
            ],
          ),
          space(h: 12.dp),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: List.generate(
              min(2, log.sortedSeafoods.length),
              (i) => Expanded(child: buildSeafood(log.sortedSeafoods[i])),
            ),
          )
        ],
      ),
    );
  }

  Widget buildSeafood(Seafood seafood) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgIcon(path: IconSrc.ship, autoScale: true),
        space(w: 16.dp),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                seafood.type.toFishName,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              space(h: 8.dp),
              Text('${seafood.quantity} KG'),
            ],
          ),
        ),
      ],
    );
  }

  Container buildHeader() {
    final time = log.releaseTime?.format('yyyy/M/d-HH:mm');
    final total = '(Tổng: ${log.total}KG)';
    return Container(
      padding: EdgeInsets.all(12.dp),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8.dp),
          topRight: Radius.circular(8.dp),
        ),
      ),
      child: Text(
        'MẺ LƯỚI $index: $time $total',
        style: AppStyles.t16w700(AppColors.white),
      ),
    );
  }
}
