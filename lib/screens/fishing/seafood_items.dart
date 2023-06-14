import 'package:flutter/material.dart';
import 'package:ship_management/models/seafood.dart';
import 'package:ship_management/theme/theme.dart';
import 'package:ship_management/utils/extensions.dart';
import 'package:ship_management/utils/widget/common.dart';
import 'package:ship_management/utils/widget/svg_icon.dart';

class SeafoodItem extends StatelessWidget {
  SeafoodItem({
    super.key,
    required this.seafood,
    required this.onRemovePressed,
  });

  final Seafood seafood;
  final VoidCallback onRemovePressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.dp),
      decoration: BoxDecoration(
        color: AppColors.ghostWhite,
        borderRadius: BorderRadius.circular(8.dp),
      ),
      child: Row(
        children: [
          SvgIcon(path: IconSrc.ship, autoScale: true),
          space(w: 16.dp),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(seafood.type.toFishName),
              space(h: 8.dp),
              Text('${seafood.quantity} KG'),
            ],
          )),
          space(w: 16.dp),
          GestureDetector(
            onTap: onRemovePressed,
            child: Icon(
              Icons.cancel_outlined,
              color: AppColors.linkWater,
            ),
          )
        ],
      ),
    );
  }
}
