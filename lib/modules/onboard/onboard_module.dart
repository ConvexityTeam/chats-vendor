import 'package:CHATS_Vendor/core/services/authentication_service.dart';
import 'package:CHATS_Vendor/core/services/base_service.dart';
import 'package:CHATS_Vendor/core/services/local_auth_service.dart';
import 'package:CHATS_Vendor/core/services/local_storage_service.dart';
import 'package:CHATS_Vendor/core/services/vendor_service.dart';
import 'package:CHATS_Vendor/modules/onboard/onboard_vm.dart';
import 'package:CHATS_Vendor/modules/onboard/screens/login_screen.dart';
import 'package:CHATS_Vendor/modules/onboard/screens/on_board.dart';
import 'package:CHATS_Vendor/modules/onboard/screens/reset_password_view.dart';
import 'package:flutter_modular/flutter_modular.dart';

class OnboardModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        Bind.instance(SharedPref()),
        Bind.singleton((i) => BaseService()),
        Bind.singleton((i) => AuthenticationService()),
        Bind.instance((i) => VendorService()),
        Bind.singleton((i) => LocalAuthService()),
        Bind.singleton((i) => OnboardVM()),
      ];

  @override
  // TODO: implement forgot password and new password screens here
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (_, args) => OnboardingScreen()),
        ChildRoute('/login', child: (_, args) => LoginScreen()),
        ChildRoute('/reset_password', child: (_, args) => ResetPasswordView()),
      ];
}
