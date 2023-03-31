// import 'package:CHATS/domain/locator.dart';
// import 'package:CHATS/services/user_service.dart';
// import 'package:CHATS/utils/custom_text_field.dart';
// import 'package:CHATS/utils/text.dart';
// import 'package:CHATS/utils/ui_helper.dart';
// import 'package:CHATS/widgets/custom_btn.dart';
import 'package:CHATS_Vendor/Utils/colors.dart';
import 'package:CHATS_Vendor/core/services/vendor_service.dart';
import 'package:CHATS_Vendor/theme_changer.dart';
import 'package:CHATS_Vendor/ui/shared/BTN.dart';
import 'package:CHATS_Vendor/ui/shared/TEXT.dart';
import 'package:CHATS_Vendor/ui/shared/TF.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snack/snack.dart';
// import 'package:snack/snack.dart';

class ChangePasswordView extends StatefulWidget {
  const ChangePasswordView({Key? key}) : super(key: key);

  @override
  _ChangePasswordViewState createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<ChangePasswordView> {
  late TextEditingController _oldPassController;
  late TextEditingController _newPassController;
  late TextEditingController _confirmPassController;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _oldPassController = TextEditingController();
    _newPassController = TextEditingController();
    _confirmPassController = TextEditingController();
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
          text: 'Change Password',
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
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TF(
                  controller: _oldPassController,
                  isPassword: hidePassword,
                  label: TEXT(
                    text: 'Old Password',
                    edgeInset: EdgeInsets.zero,
                    color: ThemeBuilder.of(context)?.getCurrentTheme() ==
                            Brightness.light
                        ? Colors.black
                        : Colors.white,
                  ),
                  suffixIcon: GestureDetector(
                    child: Image.asset(
                      hidePassword
                          ? 'assets/icons/hide.png'
                          : 'assets/icons/show.png',
                      color: ThemeBuilder.of(context)?.getCurrentTheme() ==
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
                  validateFn: (val) {
                    if (val!.isEmpty) return "This field cannot be empty";
                  },
                ),
                TF(
                  controller: _newPassController,
                  isPassword: hidePassword,
                  label: TEXT(
                    text: 'New Password',
                    edgeInset: EdgeInsets.zero,
                    color: ThemeBuilder.of(context)?.getCurrentTheme() ==
                            Brightness.light
                        ? Colors.black
                        : Colors.white,
                  ),
                  suffixIcon: GestureDetector(
                    child: Image.asset(
                      hidePassword
                          ? 'assets/icons/hide.png'
                          : 'assets/icons/show.png',
                      color: ThemeBuilder.of(context)?.getCurrentTheme() ==
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
                  validateFn: (val) {
                    if (val!.isEmpty) return "This field cannot be empty";
                  },
                ),
                TF(
                  controller: _confirmPassController,
                  isPassword: hidePassword,
                  label: TEXT(
                    text: 'Comfirm Password',
                    edgeInset: EdgeInsets.zero,
                    color: ThemeBuilder.of(context)?.getCurrentTheme() ==
                            Brightness.light
                        ? Colors.black
                        : Colors.white,
                  ),
                  suffixIcon: GestureDetector(
                    child: Image.asset(
                      hidePassword
                          ? 'assets/icons/hide.png'
                          : 'assets/icons/show.png',
                      color: ThemeBuilder.of(context)?.getCurrentTheme() ==
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
                  validateFn: (val) {
                    if (val!.isEmpty) return "This field cannot be empty";
                  },
                ),
                BTN(
                  height: 52.h,
                  margin: EdgeInsets.zero,
                  child: TEXT(
                    text: 'Change Password',
                    fontFamily: 'Gilroy-bold',
                    edgeInset: EdgeInsets.zero,
                    color: Colors.white,
                    textAlign: TextAlign.center,
                  ),
                  onTap: () async {
                    print({
                      _oldPassController.value.text,
                      _newPassController.value.text,
                      _confirmPassController,
                    });

                    formKey.currentState!.save();
                    if (formKey.currentState!.validate()) {
                      if (_confirmPassController.value.text !=
                          _newPassController.value.text) {
                        // print(locator<UserService>().userDetails!.pin);
                        final bar = SnackBar(
                            content:
                                Text('Your confirm password does not match'));
                        if (kDebugMode) print('confirm password match error');
                        return bar.show(context);
                      }
                      String? service = await Modular.get<VendorService>()
                          .changePassword(_oldPassController.value.text,
                              _newPassController.value.text);

                      SnackBar(content: Text(service ?? '')).show(context);
                      // bar.show(context);
                      if (kDebugMode) print(service);
                      Modular.to.pop(context);
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _oldPassController.dispose();
    _newPassController.dispose();
    _confirmPassController.dispose();
    super.dispose();
  }

  bool hidePassword = true;
}
