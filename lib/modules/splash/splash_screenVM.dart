import 'package:CHATS_Vendor/core/provider_model/base_provider_model.dart';
import 'package:CHATS_Vendor/core/services/local_storage_service.dart';
import 'package:CHATS_Vendor/theme_changer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SplashScreenViewModel extends BaseProviderModel {
  final keyStore = Modular.get<SharedPref>();

  Future startUp(BuildContext context) async {
    var result = await keyStore.getFromDisk('isDarkModeEnabled');
    if (result != null)
      ThemeBuilder.of(context)!.changeTheme(result);
    else
      print("Value has not been set yet");
    if (await keyStore.myFirst!) {
      print(keyStore.myFirst);
      await Future.delayed(Duration(seconds: 5));
      keyStore.setIsFirstTime(false);
      // Navigator.pushNamed(context, 'onboard');
      Modular.to.navigate('/onboard/');
    } else {
      await Future.delayed(Duration(seconds: 5));
      // Navigator.pushNamed(context, 'login');
      Modular.to.navigate('/onboard/login');
      // await Future.delayed(Duration(seconds: 2));
      // Navigator.pushNamed(context, home);
    }
  }
}
