import 'package:CHATS_Vendor/Utils/not_found.dart';
import 'package:CHATS_Vendor/core/services/local_storage_service.dart';
import 'package:CHATS_Vendor/core/services/store_service.dart';
import 'package:CHATS_Vendor/core/services/vendor_service.dart';
import 'package:CHATS_Vendor/modules/home/home_module.dart';
import 'package:CHATS_Vendor/modules/onboard/onboard_module.dart';
import 'package:CHATS_Vendor/modules/payment/payment_module.dart';
import 'package:CHATS_Vendor/modules/profile/profile_module.dart';
import 'package:CHATS_Vendor/modules/splash/splash_module.dart';
import 'package:CHATS_Vendor/modules/wallet/wallet_module.dart';
import 'package:CHATS_Vendor/ui/view_model/base_view_model.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  // TODO: implement binds
  List<Bind<Object>> get binds => [
        Bind.singleton((i) => BaseViewModel()),
        Bind.factory((i) => SharedPref()),
        Bind.singleton((i) => VendorService()),
        Bind.singleton((i) => StoreService()),
      ];

  @override
  // TODO: implement routes
  List<ModularRoute> get routes => [
        ModuleRoute(Modular.initialRoute, module: SplashModule()),
        ModuleRoute('/onboard', module: OnboardModule()),
        ModuleRoute('/home', module: HomeModule()),
        ModuleRoute('/payment', module: PaymentModule()),
        ModuleRoute('/wallet', module: WalletModule()),
        ModuleRoute('/profile', module: ProfileModule()),

        //* Handle non-existent routes
        WildcardRoute(child: (_, args) => NotFoundWidget()),
      ];
}
