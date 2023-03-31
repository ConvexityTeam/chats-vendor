import 'package:CHATS_Vendor/Utils/colors.dart';
import 'package:CHATS_Vendor/Utils/validators.dart';
import 'package:CHATS_Vendor/modules/onboard/onboard_vm.dart';
import 'package:CHATS_Vendor/theme_changer.dart';
import 'package:CHATS_Vendor/ui/shared/BTN.dart';
import 'package:CHATS_Vendor/ui/shared/TEXT.dart';
import 'package:CHATS_Vendor/ui/shared/TF.dart';
import 'package:CHATS_Vendor/ui/shared/ui_helper.dart';
import 'package:CHATS_Vendor/ui/view_model/base_view_model.dart';
import 'package:CHATS_Vendor/ui/widgets/policy_dialog.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snack/snack.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final myKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final smallH = size.height / 36;
    final smallW = size.height / 46;
    return BaseViewModel<OnboardVM>(
      providerReady: (provider) {},
      builder: (context, provider, child) => Scaffold(
        body: Stack(
          // alignment: Alignment.bottomCenter,
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              color: Color.fromRGBO(23, 206, 137, 1),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                child: Column(
                  children: [
                    SizedBox(height: 50.h),
                    Image.asset(
                      'assets/logo_white.png',
                      width: 234.37.w,
                      height: 72.h,
                      fit: BoxFit.contain,
                    ),
                    SizedBox(height: 34.h),
                    Image.asset(
                      'assets/images/login/pana.png',
                      width: 300.w,
                      height: 261.18.h,
                      fit: BoxFit.contain,
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 378.h,
                child: Form(
                  key: myKey,
                  child: SingleChildScrollView(
                    physics: ClampingScrollPhysics(
                        parent: NeverScrollableScrollPhysics()),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Center(
                          child: TEXT(
                            text: provider.errorMessage ?? '',
                            edgeInset: EdgeInsets.all(0),
                            color: Colors.red,
                            fontSize: 12.sp,
                          ),
                        ),
                        TF(
                          controller: vendorIdController,
                          label: TEXT(
                            text: 'Vendor ID',
                            fontFamily: 'Gilroy-Medium',
                            color:
                                ThemeBuilder.of(context)?.getCurrentTheme() ==
                                        Brightness.light
                                    ? Colors.black
                                    : Colors.white,
                          ),
                          validateFn: (val) {
                            if (val!.isEmpty) return 'Cannot be empty';
                          },
                        ),
                        TF(
                          controller: passController,
                          isPassword: hidePassword,
                          label: TEXT(
                            text: 'Password',
                            fontFamily: 'Gilroy-Medium',
                            color:
                                ThemeBuilder.of(context)?.getCurrentTheme() ==
                                        Brightness.light
                                    ? Colors.black
                                    : Colors.white,
                          ),
                          suffixIcon: GestureDetector(
                            child: Image.asset(
                              hidePassword
                                  ? 'assets/icons/show.png'
                                  : 'assets/icons/hide.png',
                              color:
                                  ThemeBuilder.of(context)?.getCurrentTheme() ==
                                          Brightness.light
                                      ? Colors.black
                                      : Colors.white,
                            ),
                            onTap: () {
                              // Navigator.pushNamed(context, 'onboard');
                              setState(() {
                                hidePassword = !hidePassword;
                              });
                            },
                          ),
                          validateFn: (val) => Validators.validatePassword(val),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: BTN(
                                margin: EdgeInsets.zero,
                                height: 52.h,
                                child: TEXT(
                                  text:
                                      'Log in to ${const String.fromEnvironment('BUILD_ENV').toUpperCase()}',
                                  color: Colors.white,
                                  textAlign: TextAlign.center,
                                  fontFamily: 'Gilroy-bold',
                                  fontSize: 18.sp,
                                  edgeInset: EdgeInsets.zero,
                                ),
                                onTap: () async {
                                  myKey.currentState!.save();
                                  if (myKey.currentState!.validate()) {
                                    await provider.login(
                                      vendorIdController.text.trim(),
                                      passController.text,
                                      context,
                                    );
                                  } else {
                                    return SnackBar(
                                      content:
                                          Text('All fields must be validated'),
                                    ).show(context);
                                  }
                                },
                                mainAxisAlignment: provider.isBusy
                                    ? MainAxisAlignment.end
                                    : MainAxisAlignment.center,
                              ),
                            ),
                            SizedBox(width: 10.w),
                            BTN(
                              height: 52.h,
                              padding: EdgeInsets.only(left: 15.w, right: 15.w),
                              borderColor: Constants.usedGreen,
                              bgColor: Colors.grey.withOpacity(.3),
                              children: [
                                Icon(Icons.fingerprint_outlined,
                                    color: Constants.usedGreen)
                              ],
                              onTap: () async {
                                bool? isAuthenticated =
                                    await provider.shouldAuthenticate(context);
                                if (isAuthenticated != null &&
                                    !isAuthenticated) {
                                  final snackBar = SnackBar(
                                    content: Text(
                                        'Authentication error occured or you need to setup authentication after login'),
                                    behavior: SnackBarBehavior.floating,
                                    margin: EdgeInsets.all(20),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.r)),
                                  );
                                  snackBar.show(context);
                                }
                              },
                            )
                          ],
                        ),
                        SizedBox(height: 20.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // TEXT(text: "Don't have an account? "),
                            GestureDetector(
                              child: TEXT(
                                text: 'Forgot Password?',
                                // color: Constants.purple,
                                color: ThemeBuilder.of(context)
                                            ?.getCurrentTheme() ==
                                        Brightness.light
                                    ? Colors.black
                                    : Colors.white,
                              ),
                              onTap: () {
                                // Go to forgot password screen
                                // Navigator.pushReplacementNamed(
                                //     context, 'signUp');
                                Modular.to.pushNamed('/onboard/reset_password');
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: 8.h),
                        Center(
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              text: "By logging in, you are agreeing to our\n",
                              style: TextStyle(
                                color: ThemeBuilder.of(context)
                                            ?.getCurrentTheme() ==
                                        Brightness.light
                                    ? Colors.black
                                    : Colors.white,
                              ),
                              children: [
                                TextSpan(
                                    text: "Terms & Conditions ",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: ThemeBuilder.of(context)
                                                  ?.getCurrentTheme() ==
                                              Brightness.light
                                          ? Colors.black
                                          : Colors.white,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        // OPen dialog with terms and conditions
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return PolicyDialog(
                                                  mdFileName: 'toc.md');
                                            });
                                      }),
                                TextSpan(
                                    text: 'and ',
                                    style: TextStyle(
                                      color: ThemeBuilder.of(context)
                                                  ?.getCurrentTheme() ==
                                              Brightness.light
                                          ? Colors.black
                                          : Colors.white,
                                    )),
                                TextSpan(
                                    text: "Privacy Policy!",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        // Open dialog with privacy policy
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return PolicyDialog(
                                                  mdFileName:
                                                      'privacy_policy.md');
                                            });
                                      })
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                padding: EdgeInsets.only(top: 32.h, right: 24.w, left: 24.w),
                decoration: BoxDecoration(
                  color: ThemeBuilder.of(context)?.getCurrentTheme() ==
                          Brightness.light
                      ? Colors.white
                      : primaryColorDarkMode,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.r),
                    topRight: Radius.circular(30.r),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool hidePassword = true;

  TextEditingController vendorIdController =
      new TextEditingController(text: '');

  TextEditingController passController = new TextEditingController(text: '');
}
