// import 'package:CHATS/domain/locator.dart';
// import 'package:CHATS/providers/base_provider_model.dart';
// import 'package:CHATS/services/local_auth_service.dart';
// import 'package:CHATS/services/local_storage_service.dart';
import 'package:CHATS_Vendor/core/provider_model/base_provider_model.dart';
import 'package:CHATS_Vendor/core/services/local_auth_service.dart';
import 'package:CHATS_Vendor/core/services/local_storage_service.dart';
import 'package:CHATS_Vendor/theme_changer.dart';
import 'package:CHATS_Vendor/ui/shared/TEXT.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:snack/snack.dart';

class LocalAuthVM extends BaseProviderModel {
  final keyStore = Modular.get<SharedPref>();
  final isFPEnabledKey = 'isFingerprintEnabled';
  bool isEnabled = false;

  setUp() async {
    isEnabled = await keyStore.getFromDisk(isFPEnabledKey);
    notifyListeners();
  }

  Future<bool?> toggle(bool value, BuildContext context) async {
    isEnabled = value;
    keyStore.saveToDisk(isFPEnabledKey, value);
    if (value) {
      var snackBar = SnackBar(
        content: TEXT(
          text:
              'Touch ID is required to continue using the app. Scan fingerprint to unlock',
          color: ThemeBuilder.of(context)!.getCurrentTheme() == Brightness.light
              ? Colors.white
              : Colors.black,
        ),
      );
      snackBar.show(context);
      if (await Modular.get<LocalAuthService>().authenticate()) {
        isEnabled = true;
        notifyListeners();
        return true;
      } else {
        isEnabled = false;
        notifyListeners();
        return false;
      }
    }
    notifyListeners();
    return false;
  }
}
