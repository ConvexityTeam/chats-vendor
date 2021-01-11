import 'package:CHATS_Vendor/ui/view_model/splash_screenVM.dart';
import 'package:CHATS_Vendor/ui/view_model/sign_upVM.dart';
import 'package:get_it/get_it.dart';
import 'core/provider_model/base_provider_model.dart';
import 'core/services/local_storage_service.dart';

GetIt locator = GetIt.instance;

void setUpLocator() {
  locator.registerLazySingleton(() => BaseProviderModel());
  locator.registerFactory(() => SharedPref());
  locator.registerLazySingleton(() => SplashScreenViewModel());
  locator.registerLazySingleton(() => SignUpVM());
}
