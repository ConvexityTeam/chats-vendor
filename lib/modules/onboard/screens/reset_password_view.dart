import 'package:CHATS_Vendor/Utils/colors.dart';
import 'package:CHATS_Vendor/Utils/validators.dart';
import 'package:CHATS_Vendor/core/services/vendor_service.dart';
import 'package:CHATS_Vendor/theme_changer.dart';
import 'package:CHATS_Vendor/ui/shared/BTN.dart';
import 'package:CHATS_Vendor/ui/shared/TEXT.dart';
import 'package:CHATS_Vendor/ui/shared/TF.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snack/snack.dart';

class ResetPasswordView extends StatefulWidget {
  const ResetPasswordView({Key? key}) : super(key: key);

  @override
  _ResetPasswordViewState createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> {
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _otpController;
  late TextEditingController _newPassController;
  late TextEditingController _confirmNewPassController;
  late PageController _pageController;
  late String? ref;
  final formKey = GlobalKey<FormState>();
  final newPassFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
    _otpController = TextEditingController();
    _newPassController = TextEditingController();
    _confirmNewPassController = TextEditingController();
    _pageController = PageController();
    ref = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor:
            ThemeBuilder.of(context)!.getCurrentTheme() == Brightness.light
                ? Colors.white
                : primaryColorDarkMode,
        title: TEXT(
          text: 'Reset Password',
          fontFamily: 'Gilroy-medium',
          fontSize: 22.sp,
          edgeInset: EdgeInsets.zero,
          color: ThemeBuilder.of(context)!.getCurrentTheme() == Brightness.light
              ? Colors.black
              : Colors.white,
        ),
        centerTitle: false,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color:
                ThemeBuilder.of(context)!.getCurrentTheme() == Brightness.light
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
        child: PageView(
            controller: _pageController,
            physics: NeverScrollableScrollPhysics(),
            children: [
              Form(
                key: formKey,
                child: Column(
                  children: [
                    TF(
                      controller: _emailController,
                      hintText: 'Optional if phone is set',
                      label: TEXT(
                        text: 'Enter registered email',
                        edgeInset: EdgeInsets.zero,
                        color: ThemeBuilder.of(context)!.getCurrentTheme() ==
                                Brightness.light
                            ? Colors.black
                            : Colors.white,
                      ),
                      validateFn: (val) => _phoneController.text.isEmpty
                          ? Validators.validateEmail(val?.trim())
                          : null,
                    ),
                    TF(
                      controller: _phoneController,
                      hintText: 'optional if email is set',
                      label: TEXT(
                        text: 'Enter registered phone number',
                        edgeInset: EdgeInsets.zero,
                        color: ThemeBuilder.of(context)!.getCurrentTheme() ==
                                Brightness.light
                            ? Colors.black
                            : Colors.white,
                      ),
                      validateFn: (val) {
                        if (_emailController.text.isEmpty)
                          Validators.validatePhone(val?.trim());

                        return null;
                      },
                    ),
                    SizedBox(
                      height: 52,
                      child: BTN(
                        margin: EdgeInsets.zero,
                        children: [
                          TEXT(
                            text: 'Send Reset Request',
                            fontFamily: 'Gilroy-medium',
                            edgeInset: EdgeInsets.zero,
                            color: Colors.white,
                          )
                        ],
                        onTap: () async {
                          print({
                            _emailController.value.text,
                            _phoneController.value.text,
                          });

                          formKey.currentState!.save();
                          if (formKey.currentState!.validate()) {
                            Map? service = await Modular.get<VendorService>()
                                .resetUserPasswordReq(
                              _emailController.value.text,
                              _phoneController.value.text,
                            );

                            if (service!['status'] == "success") {
                              setState(() {
                                ref = service['data']['ref'];
                              });
                              final bar = SnackBar(
                                content: Text(service['message']),
                                duration: Duration(seconds: 4),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40)),
                                behavior: SnackBarBehavior.floating,
                                margin: EdgeInsets.all(10),
                              );
                              bar.show(context);
                              print(service);
                              // Navigate user to the next page
                              _pageController.nextPage(
                                  duration: Duration(microseconds: 300),
                                  curve: Curves.linear);
                            } else {
                              final bar = SnackBar(
                                content: Text(service['message'] ??
                                    'An error occured with the request please check network connectivity and try again'),
                                duration: Duration(seconds: 4),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40)),
                                behavior: SnackBarBehavior.floating,
                                margin: EdgeInsets.all(10),
                                padding: EdgeInsets.all(10),
                              );
                              bar.show(context);
                            }
                          }
                        },
                      ),
                    )
                  ],
                ),
              ),
              Form(
                key: newPassFormKey,
                child: Column(
                  children: [
                    TF(
                      controller: _otpController,
                      hintText: 'Enter OTP sent to email or phone',
                      label: TEXT(
                        text: 'Enter OTP',
                        edgeInset: EdgeInsets.zero,
                        color: ThemeBuilder.of(context)!.getCurrentTheme() ==
                                Brightness.light
                            ? Colors.black
                            : Colors.white,
                      ),
                      validateFn: (val) {
                        if (val!.isEmpty) return "This field cannot be empty";
                      },
                    ),
                    TF(
                      controller: _newPassController,
                      hintText: 'New password',
                      label: TEXT(
                        text: 'Enter a new password',
                        edgeInset: EdgeInsets.zero,
                        color: ThemeBuilder.of(context)!.getCurrentTheme() ==
                                Brightness.light
                            ? Colors.black
                            : Colors.white,
                      ),
                      validateFn: (val) {
                        if (val!.isEmpty) return "This field cannot be empty";
                      },
                    ),
                    TF(
                      controller: _confirmNewPassController,
                      hintText: 'Re-Enter your new password to confirm',
                      label: TEXT(
                        text: 'Confirm your new password',
                        edgeInset: EdgeInsets.zero,
                        color: ThemeBuilder.of(context)!.getCurrentTheme() ==
                                Brightness.light
                            ? Colors.black
                            : Colors.white,
                      ),
                      validateFn: (val) {
                        if (val!.isEmpty) return "This field cannot be empty";
                      },
                    ),
                    BTN(
                      margin: EdgeInsets.zero,
                      children: [
                        TEXT(
                          text: 'Reset Password',
                          fontFamily: 'Gilroy-medium',
                          edgeInset: EdgeInsets.zero,
                          color: Colors.white,
                        )
                      ],
                      onTap: () async {
                        print({
                          _otpController.value.text,
                          _newPassController.value.text,
                          _confirmNewPassController,
                        });

                        newPassFormKey.currentState!.save();
                        if (newPassFormKey.currentState!.validate()) {
                          Map? service = await Modular.get<VendorService>()
                              .resetUserPasswordSetnew(
                            ref,
                            _otpController.value.text,
                            _newPassController.value.text,
                            _confirmNewPassController.value.text,
                          );

                          if (service!['status'] == "success") {
                            final bar = SnackBar(
                              content: Text(service['message']),
                              duration: Duration(seconds: 4),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(40)),
                              behavior: SnackBarBehavior.floating,
                              margin: EdgeInsets.all(10),
                            );
                            bar.show(context);
                            print(service);
                            // Navigate user to the login page
                            Modular.to.navigate('/onboard/login');
                          } else {
                            final bar = SnackBar(
                              content: Text(service['message'] ??
                                  'An error occured with the request please check network connectivity and try again'),
                              duration: Duration(seconds: 4),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(40)),
                              behavior: SnackBarBehavior.floating,
                              margin: EdgeInsets.all(10),
                              padding: EdgeInsets.all(10),
                            );
                            bar.show(context);
                          }
                        }
                      },
                    )
                  ],
                ),
              ),
            ]),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }
}
