import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ship_management/repositories/auth_repository.dart';
import 'package:ship_management/repositories/fishing_log_repository.dart';
import 'package:ship_management/routes/routes.dart';
import 'package:ship_management/services/shared_data/storage_service.dart';
import 'package:ship_management/theme/theme.dart';
import 'package:ship_management/utils/dialog_helper.dart';
import 'package:ship_management/utils/exception.dart';
import 'package:ship_management/utils/utils.dart';
import 'package:ship_management/utils/widget/common.dart';
import 'package:ship_management/utils/widget/svg_icon.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _userEditor = TextEditingController();

  final _pwEditor = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool isSelected = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final isSavePass = StorageService.getIsSavePass();
      if (isSavePass) {
        setState(() {
          _userEditor.text = StorageService.getUserName();
          _pwEditor.text = StorageService.getPassWord();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => clearFocus,
      child: Scaffold(
        body: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.always,
          child: ListView(
            padding: EdgeInsets.all(32.dp).copyWith(
              top: kToolbarHeight + 32.dp,
            ),
            children: [
              Align(
                alignment: Alignment.center,
                child: SvgIcon(path: IconSrc.flag, autoScale: true),
              ),
              space(h: 34.dp),
              Text(lang.id),
              TextFormField(
                controller: _userEditor,
                validator: (value) {
                  if (value?.isEmpty ?? true) return '';
                  return null;
                },
              ),
              space(h: 12.dp),
              Text(lang.password),
              TextFormField(
                controller: _pwEditor,
                obscureText: true,
                validator: (value) {
                  if (value?.isEmpty ?? true) return '';
                  return null;
                },
              ),
              space(h: 36.dp),
              Row(
                children: [
                  Text('Lưu mật khẩu'),
                  Checkbox(
                      value: isSelected,
                      onChanged: (e) async {
                        setState(() {
                          isSelected = e ?? false;
                        });
                        await StorageService.saveIsSavePassWork(isSelected);
                      }),
                ],
              ),
              FractionallySizedBox(
                widthFactor: 1,
                child: ElevatedButton(
                  onPressed: () async {
                    if (!_formKey.currentState!.validate()) return;

                    final success = await login();
                    if (isSelected) {
                      await StorageService.savePassWord(_pwEditor.text);
                      await StorageService.saveUserName(_userEditor.text);
                    }
                    if (success) Get.offNamed(RouteName.home);
                  },
                  child: Text(lang.login),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> login() async {
    try {
      DialogHelper.loading();

      final res = await AuthRepository.login(_userEditor.text, _pwEditor.text);
      await StorageService.saveToken(res.token);
      await StorageService.saveUser(res.user);

      FutureGroup futureGroup = FutureGroup();
      futureGroup.add(AuthRepository.profile(res.user.tauId));
      futureGroup.add(AuthRepository.profileEmployee(res.user.tauId));
      futureGroup.add(FishingLogRepository.listFishes);
      futureGroup.add(AuthRepository.licenseDetail(
        tauId: res.user.tauId,
        enumGiayPhep: 10,
      ));
      futureGroup.add(FishingLogRepository.groupFish);

      futureGroup.close();
      final result = await futureGroup.future;
      StorageService.saveProfile(result[0]);
      StorageService.saveProfileEmployee(result[1]);
      StorageService.saveFishes(result[2]);
      StorageService.saveLicenseDetail(result[3]);
      StorageService.saveGroupFishes(result[4]);
      print('-------group fish');
      for (var item in StorageService.fishes) {
        print(item.toString());
      }
      for (var item in StorageService.groupFish) {
        print(item.toString());
      }

      DialogHelper.dissmisLoading();
      return true;
    } catch (e) {
      DialogHelper.dissmisLoading();
      await StorageService.saveToken('');
      await handleException(e);
      return false;
    }
  }
}
