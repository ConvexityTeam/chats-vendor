import 'package:CHATS_Vendor/core/services/local_storage_service.dart';
import 'package:CHATS_Vendor/modules/splash/splash_screen.dart';
import 'package:CHATS_Vendor/modules/splash/splash_screenVM.dart';
import 'package:CHATS_Vendor/ui/view_model/base_view_model.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SplashModule extends Module {
  @override
  // TODO: implement binds
  List<Bind<Object>> get binds => [
        Bind.factory((i) => SharedPref()),
        Bind.instance(BaseViewModel()),
        Bind.singleton((i) => SplashScreenViewModel()),
      ];

  @override
  // TODO: implement routes
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (_, args) => SplashScreen()),
      ];
}
