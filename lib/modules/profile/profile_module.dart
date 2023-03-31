import 'package:CHATS_Vendor/core/services/local_auth_service.dart';
import 'package:CHATS_Vendor/core/services/local_storage_service.dart';
import 'package:CHATS_Vendor/core/services/vendor_service.dart';
import 'package:CHATS_Vendor/modules/profile/screens/account.dart';
import 'package:CHATS_Vendor/modules/profile/screens/change_password_view.dart';
import 'package:CHATS_Vendor/modules/profile/screens/change_pin_view.dart';
import 'package:CHATS_Vendor/modules/profile/screens/help_support_view.dart';
import 'package:CHATS_Vendor/modules/profile/screens/kyc_status.dart';
import 'package:CHATS_Vendor/modules/profile/screens/personal_info_view.dart';
import 'package:CHATS_Vendor/modules/profile/screens/profile_view.dart';
import 'package:CHATS_Vendor/modules/profile/screens/security_view.dart';
import 'package:CHATS_Vendor/modules/profile/screens/set_pin_view.dart';
import 'package:CHATS_Vendor/modules/profile/screens/settings_view.dart';
import 'package:CHATS_Vendor/ui/view_model/local_auth_vm.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ProfileModule extends Module {
  @override
  // TODO: implement binds
  List<Bind<Object>> get binds => [
        Bind.instance(SharedPref()),
        Bind.instance((i) => VendorService()),
        Bind.lazySingleton((i) => LocalAuthVM()),
        Bind.lazySingleton((i) => LocalAuthService()),
      ];

  @override
  // TODO: implement routes
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (_, args) => ProfileView()),
        ChildRoute('/personal_info', child: (_, args) => PersonalInfo()),
        ChildRoute('/account', child: (_, args) => Account()),
        ChildRoute('/kyc', child: (_, args) => KYCstatus()),
        ChildRoute('/security', child: (_, args) => SecurityView()),
        ChildRoute('/security/change_password',
            child: (_, args) => ChangePasswordView()),
        ChildRoute('/security/set_pin', child: (_, args) => SetPINView()),
        ChildRoute('/security/change_pin', child: (_, args) => ChangePINView()),
        ChildRoute('/settings', child: (_, args) => SettingsView()),
        ChildRoute('/support', child: (_, args) => HelpSupportView()),
      ];
}
