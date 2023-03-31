import 'dart:convert';

import 'package:CHATS_Vendor/core/models/user_model.dart';
import 'package:CHATS_Vendor/core/provider_model/base_provider_model.dart';
import 'package:CHATS_Vendor/core/services/authentication_service.dart';
import 'package:CHATS_Vendor/core/services/local_auth_service.dart';
import 'package:CHATS_Vendor/core/services/local_storage_service.dart';
import 'package:CHATS_Vendor/core/services/vendor_service.dart';
import 'package:CHATS_Vendor/ui/shared/TEXT.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snack/snack.dart';

class OnboardVM extends BaseProviderModel {
  List<String> imageList = [
    'assets/onboard1.jpeg',
    'assets/onboard2.jpeg',
    'assets/onboard3.jpeg'
  ];
  // List<String> scrollText = ['a', 'b', 'c'];

  final keyStore = Modular.get<SharedPref>();

  Future<bool?> shouldAuthenticate(BuildContext context) async {
    isFPEnabled = await keyStore.getFromDisk(isFPEnabledKey);
    if (isFPEnabled != null && isFPEnabled!) {
      var snackBar = SnackBar(
        content: Text(
          'Touch ID is required to continue using the app. Scan fingerprint to unlock',
        ),
      );
      snackBar.show(context);
      bool? service = await Modular.get<LocalAuthService>().authenticate();
      if (service) {
        // setup data push to home screen
        Modular.get<VendorService>().token =
            await keyStore.getFromDisk('localUserToken') ?? '';
        Modular.get<VendorService>().id =
            await keyStore.getFromDisk('localUserID') ?? '';
        Modular.get<VendorService>().pin =
            await keyStore.getFromDisk('userPinSet') ?? '';
        Modular.to.navigate('/home/');
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  login(String vendorId, String password, BuildContext context) async {
    if (isBusy) return;
    errorMessage = '';
    isBusy = true;
    notifyListeners();
    await _authenticationService.login(vendorId, password).then((value) {
      // Sends user to homepage if credentials are correct
      errorMessage = '';
      if (value['code'] == 200) {
        Modular.to.navigate('/home/');
      } else {
        errorMessage = value['message'];
        print(value['code']);
      }
    }).catchError((e) {
      print(e);
    });
    isBusy = false;
    notifyListeners();
  }

  register(UserModel model, BuildContext context) async {
    // model.profile_pic = profilePicture;
    print(jsonEncode(model.toJson()));
    savingUser = true;
    signUpErrorMessage = '';
    notifyListeners();
    await _authenticationService.register(model)?.then((value) {
      if (value['code'] == 201) {
        Navigator.pushReplacementNamed(context, '/');
      } else {
        signUpErrorMessage = value['message'];
      }
    }).catchError((e) {
      print(e);
      print("ss");
    });
    savingUser = false;
    notifyListeners();
  }

  bool isBusy = false;
  bool savingUser = false;
  String? errorMessage = '';
  String signUpErrorMessage = '';
  final isFPEnabledKey = 'isFingerprintEnabled';
  bool? isFPEnabled = false;

  AuthenticationService _authenticationService =
      Modular.get<AuthenticationService>();

  String? profilePicture;

  String? validId;

  List<Widget> scrollText = [
    Container(
      child: Column(
        children: [
          Container(
            height: 20.h,
            child: TEXT(
              text: 'Simple And Easy',
              fontSize: 22.sp,
              fontFamily: 'Gilroy-bold',
            ),
          ),
          SizedBox(
            height: 3.h,
          ),
          Container(
            height: 20.h,
            child: TEXT(
              text: 'Easy and Straightforward onboarding\n process',
              fontSize: 16.sp,
              fontFamily: 'Gilroy-regular',
            ),
          )
        ],
      ),
    ),
    Container(
      child: Column(
        children: [
          Container(
            height: 20.h,
            child: TEXT(
              text: 'Safe  And Secure',
              fontSize: 22.sp,
              fontFamily: 'Gilroy-bold',
            ),
          ),
          SizedBox(
            height: 3.h,
          ),
          Container(
            height: 50.h,
            child: TEXT(
              text:
                  'Convexity is safe  and secured to set up \n \t encrypted security using blockchain',
              fontSize: 16.sp,
              fontFamily: 'Gilroy-regular',
            ),
          )
        ],
      ),
    ),
    Container(
      child: Column(
        children: [
          TEXT(
            text: 'Pay Money Instantly',
            fontSize: 22.sp,
            fontFamily: 'Gilroy-bold',
          ),
          SizedBox(
            height: 3.h,
          ),
          Container(
            height: 50.h,
            child: TEXT(
              text:
                  'Transfer instantly between vendors and \n \t\t\t                   beneficiaries',
              fontSize: 16.sp,
              fontFamily: 'Gilroy-regular',
            ),
          )
        ],
      ),
    ),
  ];
}
