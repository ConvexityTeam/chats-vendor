import 'package:CHATS_Vendor/core/services/local_storage_service.dart';
import 'package:CHATS_Vendor/core/services/vendor_service.dart';
import 'package:CHATS_Vendor/modules/wallet/wallet_view.dart';
import 'package:flutter_modular/flutter_modular.dart';

class WalletModule extends Module {
  @override
  // TODO: implement binds
  List<Bind<Object>> get binds => [
        Bind.instance(SharedPref()),
        Bind.instance((i) => VendorService()),
      ];

  @override
  // TODO: implement routes
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (_, args) => WalletView()),
      ];
}
