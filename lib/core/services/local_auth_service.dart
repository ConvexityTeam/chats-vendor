// import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:local_auth/local_auth.dart';
// import 'package:flutter_local_auth_invisible/flutter_local_auth_invisible.dart';

class LocalAuthService {
  // final _auth = LocalAuthentication();
  Future<bool> authenticate() async {
    // check if biometric is available
    final isAvailable = await hasBiometrics();
    if (!isAvailable) return false;

    try {
      // return await _auth.authenticate(
      //   localizedReason: 'Scan fingerprint or face to authenticate',
      //   options: const AuthenticationOptions(
      //       biometricOnly: true, useErrorDialogs: true),
      // );
      return true;
    } on PlatformException catch (e) {
      print({"Auth Error", e.message});
      return false;
    }
  }

  Future<bool> hasBiometrics() async {
    try {
      // return await _auth.canCheckBiometrics;
      return true;
    } on PlatformException catch (e) {
      print(e.message);
      return false;
    }
  }

  // Future<List<BiometricType>> getBiometrics() async {
  //   try {
  //     return await _auth.getAvailableBiometrics();
  //   } on PlatformException catch (e) {
  //     print(e.message);
  //     return <BiometricType>[];
  //   }
  // }
}
