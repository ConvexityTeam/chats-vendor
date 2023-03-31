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

class ChangePINView extends StatefulWidget {
  const ChangePINView({Key? key}) : super(key: key);

  @override
  _ChangePINViewState createState() => _ChangePINViewState();
}

class _ChangePINViewState extends State<ChangePINView> {
  late TextEditingController _oldPINController;
  late TextEditingController _newPINController;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _oldPINController = TextEditingController();
    _newPINController = TextEditingController();
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
          text: 'Change PIN',
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
                  controller: _oldPINController,
                  isPassword: hidePassword,
                  keyboardType: TextInputType.number,
                  label: TEXT(
                    text: 'Old PIN',
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
                    if (val.length < 6 || val.length > 6)
                      return "Your PIN must be 6 digits";
                  },
                ),
                TF(
                  controller: _newPINController,
                  isPassword: hidePassword,
                  keyboardType: TextInputType.number,
                  label: TEXT(
                    text: 'New PIN',
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
                    if (val.length < 6 || val.length > 6)
                      return "Your PIN must be 6 digits";
                  },
                ),
                BTN(
                  height: 52.h,
                  margin: EdgeInsets.zero,
                  child: TEXT(
                    text: 'Change PIN',
                    fontFamily: 'Gilroy-bold',
                    edgeInset: EdgeInsets.zero,
                    color: Colors.white,
                    textAlign: TextAlign.center,
                  ),
                  onTap: () async {
                    print({
                      _oldPINController.value.text,
                      _newPINController.value.text
                    });
                    formKey.currentState?.save();
                    //* check if the old pin matches the already added pin

                    if (formKey.currentState!.validate()) {
                      String? service = await Modular.get<VendorService>()
                          .changePin(
                              _oldPINController.text, _newPINController.text);
                      final bar = SnackBar(content: Text('$service'));
                      bar.show(context);

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
    _oldPINController.dispose();
    _newPINController.dispose();
    super.dispose();
  }

  bool hidePassword = true;
}
