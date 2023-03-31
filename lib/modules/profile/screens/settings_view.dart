// import 'package:CHATS/domain/locator.dart';
// import 'package:CHATS/screens/auth/login_screen.dart';
// import 'package:CHATS/services/user_service.dart';
// import 'package:CHATS/utils/text.dart';
// import 'package:CHATS/utils/ui_helper.dart';
import 'package:CHATS_Vendor/Utils/colors.dart';
import 'package:CHATS_Vendor/core/services/local_storage_service.dart';
import 'package:CHATS_Vendor/theme_changer.dart';
import 'package:CHATS_Vendor/ui/shared/TEXT.dart';
import 'package:CHATS_Vendor/ui/shared/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  _SettingsViewState createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  late bool isDarkModeEnabled;
  late bool deactiVateAccount;
  final keyStore = Modular.get<SharedPref>();

  @override
  void initState() {
    super.initState();
    isDarkModeEnabled = false;
    deactiVateAccount = false;
    setThemeMode();
  }

  void setThemeMode() async {
    var result = await keyStore.getFromDisk('isDarkModeEnabled');
    print({"Dark Mode key", result});
    setState(() {
      isDarkModeEnabled = result != null ? result : false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor:
            ThemeBuilder.of(context)?.getCurrentTheme() == Brightness.light
                ? Colors.white
                : primaryColorDarkMode,
        title: TEXT(
          text: 'Settings',
          fontFamily: 'Gilroy-medium',
          fontSize: 22.sp,
          edgeInset: EdgeInsets.zero,
          textAlign: TextAlign.left,
          color: ThemeBuilder.of(context)?.getCurrentTheme() == Brightness.light
              ? Colors.black
              : Colors.white,
        ),
        centerTitle: false,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color:
                ThemeBuilder.of(context)?.getCurrentTheme() == Brightness.light
                    ? Colors.black
                    : Colors.white,
          ),
          onPressed: () {
            Modular.to.pop(context);
          },
        ),
      ),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
        color: ThemeBuilder.of(context)!.getCurrentTheme() == Brightness.light
            ? Colors.white
            : primaryColorDarkMode,
        child: Column(
          children: [
            buildButton(
              text: 'Enable Dark Mode',
              pressed: (bool? value) {
                if (value != null) {
                  keyStore.saveToDisk('isDarkModeEnabled', value);
                  ThemeBuilder.of(context)!.changeTheme(value);
                  setState(() {
                    isDarkModeEnabled = value;
                  });
                }
              },
              isFingerPrint: true,
              state: isDarkModeEnabled,
            ),
            SizedBox(height: 20.h),
            // buildButton(
            //   text: 'Deactivate Account',
            //   pressed: (bool? value) async {
            //     if (value != null) {
            //       setState(() {
            //         deactiVateAccount = value;
            //       });

            //       Map? service = await locator<UserService>().deactivateUser();
            //       if (service!['status'] == 'success') {
            //         //* show snackbar and then push to login page

            //         final bar = SnackBar(
            //           content: Text(service['message'] ??
            //               'Deactivated account successfully'),
            //           duration: Duration(seconds: 4),
            //           shape: RoundedRectangleBorder(
            //               borderRadius: BorderRadius.circular(40)),
            //           behavior: SnackBarBehavior.floating,
            //           margin: EdgeInsets.all(10),
            //         );
            //         bar.show(context);
            //         await Future.delayed(Duration(seconds: 3));
            //         print(service);

            //         Navigator.pushAndRemoveUntil(
            //           context,
            //           PageRouteBuilder(
            //             pageBuilder: (BuildContext context, Animation animation,
            //                 Animation secondaryAnimation) {
            //               return LoginScreen();
            //             },
            //             transitionsBuilder:
            //                 (context, animation, secondaryAnimation, child) {
            //               return SlideTransition(
            //                 position: Tween<Offset>(
            //                         begin: Offset(
            //                           1.0,
            //                           0.0,
            //                         ),
            //                         end: Offset.zero)
            //                     .animate(animation),
            //                 child: child,
            //               );
            //             },
            //           ),
            //           (route) => false,
            //         );
            //       } else {
            //         //! Show snackBar with error message

            //         final bar = SnackBar(
            //           content: Text(service['message'] ??
            //               'An error occured while trying to deactivate account, check connectivity and try again!'),
            //           duration: Duration(seconds: 4),
            //           shape: RoundedRectangleBorder(
            //               borderRadius: BorderRadius.circular(40)),
            //           behavior: SnackBarBehavior.floating,
            //           margin: EdgeInsets.all(10),
            //         );
            //         bar.show(context);
            //       }
            //     }
            //   },
            //   isFingerPrint: true,
            //   state: deactiVateAccount,
            //   idleStateColor: Color.fromRGBO(228, 44, 102, 1),
            // ),
          ],
        ),
      ),
    );
  }

  Widget buildButton(
      {required String text,
      required Function pressed,
      bool? isFingerPrint,
      bool? state,
      Color? idleStateColor}) {
    return SizedBox(
      width: double.infinity,
      height: 52.h,
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
            isFingerPrint == null
                ? Icon(Icons.arrow_forward_ios_outlined, color: Colors.black)
                : isFingerPrint
                    ? Switch.adaptive(
                        value: state!,
                        activeColor: Constants.usedGreen,
                        inactiveTrackColor: idleStateColor,
                        onChanged: (value) {
                          pressed(value);
                        },
                      )
                    : Icon(
                        Icons.arrow_forward_ios_outlined,
                        color: Colors.black,
                      ),
          ],
        ),
        style: ButtonStyle(
          side: MaterialStateProperty.all(
            BorderSide(width: 1.4, color: Color.fromRGBO(153, 153, 153, 1)),
          ),
          overlayColor: MaterialStateProperty.all(Colors.grey[200]),
          padding:
              MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 15.w)),
        ),
        onPressed: () => pressed(!state!),
      ),
    );
  }
}
