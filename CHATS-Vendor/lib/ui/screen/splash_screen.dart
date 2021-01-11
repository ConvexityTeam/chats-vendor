import 'dart:ui';

import 'package:CHATS_Vendor/ui/view_model/base_view_model.dart';
import 'package:CHATS_Vendor/ui/view_model/splash_screenVM.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
