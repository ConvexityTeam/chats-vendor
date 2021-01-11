import 'package:CHATS_Vendor/core/constants/view_state.dart';
import 'package:CHATS_Vendor/core/provider_model/base_provider_model.dart';
import 'package:CHATS_Vendor/core/services/local_storage_service.dart';
import 'package:flutter/material.dart';

import '../../locator.dart';

class SplashScreenViewModel extends BaseProviderModel {
  final keyStore = locator<SharedPref>();

  Future startUp(BuildContext context) async {
    setViewState(ViewState.BUSY);
    if (await keyStore.myFirst ?? true) {
      print(keyStore.myFirst);
      await Future.delayed(Duration(seconds: 4));
      keyStore.setIsFirstTime(false);
      Navigator.pushNamed(context, 'onboard');
    } else {
      await Future.delayed(Duration(seconds: 4));
      Navigator.pushNamed(context, 'login');
    }
  }
}
