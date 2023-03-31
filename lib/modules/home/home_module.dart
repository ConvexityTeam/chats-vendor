import 'package:CHATS_Vendor/core/services/local_storage_service.dart';
import 'package:CHATS_Vendor/core/services/store_service.dart';
import 'package:CHATS_Vendor/core/services/vendor_service.dart';
import 'package:CHATS_Vendor/modules/home/campaigns_view.dart';
import 'package:CHATS_Vendor/modules/home/home_screen.dart';
import 'package:CHATS_Vendor/modules/home/transaction_view.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomeModule extends Module {
  @override
  // TODO: implement binds
  List<Bind<Object>> get binds => [
        Bind.instance(SharedPref()),
        Bind.instance((i) => VendorService()),
        Bind.instance((i) => StoreService()),
      ];

  @override
  // TODO: implement routes
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (_, args) => HomeView()),
        ChildRoute(
          '/campaigns/:type',
          child: (_, args) => CampaignsVew(type: args.params['type']),
        ),
        ChildRoute('/transactions', child: (_, args) => TransactionView()),
      ];
}
