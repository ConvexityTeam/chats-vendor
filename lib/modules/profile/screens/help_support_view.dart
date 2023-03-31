// import 'package:CHATS/utils/text.dart';
// import 'package:CHATS/utils/ui_helper.dart';
import 'package:CHATS_Vendor/Utils/colors.dart';
import 'package:CHATS_Vendor/theme_changer.dart';
import 'package:CHATS_Vendor/ui/shared/TEXT.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HelpSupportView extends StatefulWidget {
  const HelpSupportView({Key? key}) : super(key: key);

  @override
  _HelpSupportViewState createState() => _HelpSupportViewState();
}

class _HelpSupportViewState extends State<HelpSupportView> {
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
            text: 'Support',
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
              Modular.to.pop(context);
            },
          ),
        ),
        body: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
          color: ThemeBuilder.of(context)?.getCurrentTheme() == Brightness.light
              ? Colors.white
              : primaryColorDarkMode,
          child: Column(
            children: [
              buildButton(
                icon: Icons.phone_outlined,
                text: 'Call An Agent',
                pressed: () {},
              ),
              SizedBox(height: 16.h),
              buildButton(
                icon: Icons.mail_outline,
                text: 'Send Us An Email',
                pressed: () {},
              ),
              SizedBox(height: 16.h),
              buildButton(
                icon: Icons.chat_bubble_outline_outlined,
                text: 'Live Chat',
                pressed: () {},
              ),
              SizedBox(height: 16.h),
              buildButton(
                icon: Icons.facebook_outlined,
                text: 'Facebook',
                pressed: () {},
              ),
              SizedBox(height: 16.h),
              buildButton(
                icon: Icons.facebook_rounded,
                text: 'LinkedIn',
                pressed: () {},
              ),
              SizedBox(height: 16.h),
              buildButton(
                icon: Icons.facebook_rounded,
                text: 'Twitter',
                pressed: () {},
              ),
              SizedBox(height: 16.h),
            ],
          ),
        ));
  }

  Widget buildButton(
      {required String text, required Function pressed, IconData? icon}) {
    return SizedBox(
      width: double.infinity,
      height: 52.h,
      child: TextButton(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(icon,
                color: ThemeBuilder.of(context)?.getCurrentTheme() ==
                        Brightness.light
                    ? Colors.black
                    : Colors.white),
            SizedBox(width: 10.w),
            TEXT(
              text: '$text',
              fontFamily: 'Gilroy-medium',
              color: ThemeBuilder.of(context)?.getCurrentTheme() ==
                      Brightness.light
                  ? Colors.black
                  : Colors.white,
              edgeInset: EdgeInsets.zero,
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
}
