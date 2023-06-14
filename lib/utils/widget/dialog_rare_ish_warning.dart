import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ship_management/models/fish.dart';
import 'package:ship_management/models/seafood.dart';
import 'package:ship_management/screens/tranmissing/add_information_rare_fish.dart';
import 'package:ship_management/theme/colors.dart';
import 'package:ship_management/theme/dimens.dart';
import 'package:ship_management/theme/styles.dart';

class DialogRareFishWarning extends StatefulWidget {
  final Fish fish;

  const DialogRareFishWarning({
    Key? key,
    required this.fish,
  }) : super(key: key);

  @override
  State<DialogRareFishWarning> createState() => _DialogRareFishWarningState();
}

class _DialogRareFishWarningState extends State<DialogRareFishWarning> {
  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 34.dp),
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.ghostWhite,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              padding: EdgeInsets.all(24.dp),
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Cảnh báo',
                        style: AppStyles.t18w700(Colors.black),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Gặp phải loài cá quý hiếm cấm khác thác.',
                        style: AppStyles.t16w400(Colors.black),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 2,
                            child: InkWell(
                              onTap: () {
                                Get.back();
                              },
                              child: Container(
                                alignment: Alignment.center,
                                padding: EdgeInsets.symmetric(vertical: 12),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(24.dp),
                                  color: AppColors.linkWater.withOpacity(0.3),
                                ),
                                child: Text(
                                  'Thả cá',
                                  style: AppStyles.t14w400(AppColors.black),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            flex: 3,
                            child: InkWell(
                              onTap: () async {
                                print('------Fish');
                                print(widget.fish.toString());
                                final res = await Get.to(
                                    () => AddInfoRareFish(),
                                    arguments: {'infoRareFish': widget.fish});
                                print( res['backValue'].toString());
                                if (res != null) {
                                  Get.back<Seafood>(
                                    result: res['backValue'],
                                  );
                                }
                              },
                              child: Container(
                                alignment: Alignment.center,
                                padding: EdgeInsets.symmetric(vertical: 12),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(24.dp),
                                  color: AppColors.perlorous,
                                ),
                                child: Text(
                                  'Thêm thông tin ',
                                  style: AppStyles.t14w400(AppColors.white),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 20,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
