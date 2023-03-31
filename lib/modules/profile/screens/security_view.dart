// import 'package:CHATS/domain/locator.dart';
// import 'package:CHATS/router.dart';
// import 'package:CHATS/screens/Home/view_models/base_view_model.dart';
// import 'package:CHATS/screens/Home/view_models/local_auth_vm.dart';
// import 'package:CHATS/services/local_storage_service.dart';
// import 'package:CHATS/services/user_service.dart';
// import 'package:CHATS/utils/text.dart';
// import 'package:CHATS/utils/ui_helper.dart';
import 'package:CHATS_Vendor/Utils/colors.dart';
import 'package:CHATS_Vendor/core/services/vendor_service.dart';
import 'package:CHATS_Vendor/theme_changer.dart';
import 'package:CHATS_Vendor/ui/shared/TEXT.dart';
import 'package:CHATS_Vendor/ui/shared/ui_helper.dart';
import 'package:CHATS_Vendor/ui/view_model/base_view_model.dart';
import 'package:CHATS_Vendor/ui/view_model/local_auth_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snack/snack.dart';

class SecurityView extends StatefulWidget {
  const SecurityView({Key? key}) : super(key: key);

  @override
  _SecurityViewState createState() => _SecurityViewState();
}

class _SecurityViewState extends State<SecurityView> {
  // bool? enableFP;
  // final keyStore = locator<SharedPref>();

  // @override
  // void initState() {
  //   super.initState();
  //   getFingerprintSettings();
  // }

  // getFingerprintSettings() async {
  //   bool? val = await keyStore.getFromDisk('isFingerprintEnabled');
  //   setState(() {
  //     if (val != null) {
  //       enableFP = val;
  //     } else {
  //       enableFP = false;
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    // print({enableFP, "The finger print saved boolean"});
    return BaseViewModel<LocalAuthVM>(
      providerReady: (provider) => provider.setUp(),
      builder: (context, provider, child) => Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor:
              ThemeBuilder.of(context)?.getCurrentTheme() == Brightness.light
                  ? Colors.white
                  : primaryColorDarkMode,
          title: TEXT(
            text: 'Security',
            fontFamily: 'Gilroy-medium',
            fontSize: 22.sp,
            edgeInset: EdgeInsets.zero,
            textAlign: TextAlign.left,
            color:
                ThemeBuilder.of(context)?.getCurrentTheme() == Brightness.light
                    ? Colors.black
                    : Colors.white,
          ),
          centerTitle: false,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: ThemeBuilder.of(context)?.getCurrentTheme() ==
                      Brightness.light
                  ? Colors.black
                  : Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
          color: ThemeBuilder.of(context)?.getCurrentTheme() == Brightness.light
              ? Colors.white
              : primaryColorDarkMode,
          child: Column(
            children: [
              buildButton(
                text: 'Change Password',
                pressed: () {
                  // Navigator.pushNamed(context, Routes.changePassword);
                  Modular.to.pushNamed('/profile/security/change_password');
                },
              ),
              SizedBox(height: 16.h),
              buildButton(
                text: 'Create / Change Pin',
                pressed: () {
                  // check if the user has pin already
                  if (Modular.get<VendorService>().vendorDetails!.pin == null) {
                    // Navigator.pushNamed(context, Routes.setPIN);
                    Modular.to.pushNamed('/profile/security/set_pin');
                  } else {
                    // if not then set pin
                    // Navigator.pushNamed(context, Routes.changePIN);
                    Modular.to.pushNamed('/profile/security/change_pin');
                  }
                },
              ),
              SizedBox(height: 16.h),
              buildSwitchButton(
                context,
                text: 'Enable Fingerprint',
                pressed: (bool? value) async {
                  bool? service = await provider.toggle(value!, context);
                  if (service!) {
                    final snackBar = SnackBar(
                      content: Text('Authenticated Successfuly!'),
                      behavior: SnackBarBehavior.floating,
                      margin: EdgeInsets.all(20),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                    );
                    snackBar.show(context);
                  } else {
                    final snackBar = SnackBar(
                      content: Text('Authentication Disabled!'),
                      behavior: SnackBarBehavior.floating,
                      margin: EdgeInsets.all(20),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                    );
                    snackBar.show(context);
                  }
                },
                provider: provider,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildButton({
    required String text,
    required Function pressed,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: TextButton(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TEXT(
              text: '$text',
              fontFamily: 'Gilroy-medium',
              color: ThemeBuilder.of(context)?.getCurrentTheme() ==
                      Brightness.light
                  ? Colors.black
                  : Colors.white,
              edgeInset: EdgeInsets.zero,
            ),
            Icon(
              Icons.arrow_forward_ios_outlined,
              color: ThemeBuilder.of(context)?.getCurrentTheme() ==
                      Brightness.light
                  ? Colors.black
                  : Colors.white,
            ),
          ],
        ),
        style: ButtonStyle(
          side: MaterialStateProperty.all(
            BorderSide(width: 1.4, color: Color.fromRGBO(153, 153, 153, 1)),
          ),
          overlayColor: MaterialStateProperty.all(Colors.grey[200]),
          padding:
              MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 15)),
        ),
        onPressed: () => pressed(),
      ),
    );
  }

  Widget buildSwitchButton(BuildContext context,
      {required String text,
      required Function pressed,
      LocalAuthVM? provider}) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: TextButton(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TEXT(
              text: '$text',
              fontFamily: 'Gilroy-medium',
              color: ThemeBuilder.of(context)?.getCurrentTheme() ==
                      Brightness.light
                  ? Colors.black
                  : Colors.white,
              edgeInset: EdgeInsets.zero,
            ),
            Switch.adaptive(
              value: provider?.isEnabled ?? false,
              activeColor: Constants.usedGreen,
              onChanged: (value) {
                pressed(value);
              },
            )
          ],
        ),
        style: ButtonStyle(
          side: MaterialStateProperty.all(
            BorderSide(width: 1.4, color: Color.fromRGBO(153, 153, 153, 1)),
          ),
          overlayColor: MaterialStateProperty.all(Colors.grey[200]),
          padding:
              MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 15)),
        ),
        onPressed: () {
          final snackBar = SnackBar(
            content: Text('Tap on the switch directly'),
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.all(20),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          );
          snackBar.show(context);
        },
      ),
    );
  }
}
