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
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snack/snack.dart';

class SetPINView extends StatefulWidget {
  const SetPINView({Key? key}) : super(key: key);

  @override
  _SetPINViewState createState() => _SetPINViewState();
}

class _SetPINViewState extends State<SetPINView> {
  late TextEditingController _setPINController;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _setPINController = TextEditingController();
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
            text: 'Set PIN',
            fontFamily: 'Gilroy-medium',
            fontSize: 22.sp,
            edgeInset: EdgeInsets.zero,
            textAlign: TextAlign.left,
            color:
                ThemeBuilder.of(context)?.getCurrentTheme() == Brightness.light
                    ? Colors.black
                    : Colors.white),
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              Form(
                key: formKey,
                child: TF(
                  controller: _setPINController,
                  isPassword: hidePassword,
                  keyboardType: TextInputType.number,
                  label: TEXT(
                    text: 'Set PIN',
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
                    if (val!.isEmpty) return "Field can't be empty";
                    if (val.length > 6 || val.length < 6)
                      return "Your pin must be 6 digit numbers";
                  },
                ),
              ),
              BTN(
                height: 52.h,
                margin: EdgeInsets.zero,
                child: TEXT(
                  text: 'Set Transaction PIN',
                  fontFamily: 'Gilroy-bold',
                  edgeInset: EdgeInsets.zero,
                  color: Colors.white,
                  textAlign: TextAlign.center,
                ),
                onTap: () async {
                  print(_setPINController.value.text);
                  formKey.currentState!.save();
                  if (formKey.currentState!.validate()) {
                    String? response = await Modular.get<VendorService>()
                        .setPin(_setPINController.text);
                    final bar = SnackBar(content: Text('$response'));
                    bar.show(context);
                    print(response);
                    Modular.to.pop(context);
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _setPINController.dispose();
    super.dispose();
  }

  bool hidePassword = true;
}
