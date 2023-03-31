import 'package:CHATS_Vendor/core/services/base_service.dart';
import 'package:CHATS_Vendor/modules/splash/splash_screenVM.dart';
import 'package:CHATS_Vendor/ui/view_model/base_view_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (kDebugMode)
      print({
        "{{BUILD_ENV}}",
        const String.fromEnvironment('BUILD_ENV'),
        "{{BASE_URL}}",
        const String.fromEnvironment('BASE_URL'),
        BaseService.rootApi,
        "ROOT API",
      });
    return BaseViewModel<SplashScreenViewModel>(
      providerReady: (provider) {
        provider.startUp(context);
      },
      builder: (context, provider, _) => Scaffold(
        backgroundColor: Colors.black,
        body: Container(
          height: MediaQuery.of(context).size.height,
          child: Center(
            child: Image.asset(
              'assets/chatGif.gif',
              // height: MediaQuery.of(context).size.height,
              // width: MediaQuery.of(context).size.height,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
