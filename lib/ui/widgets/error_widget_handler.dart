import 'package:CHATS_Vendor/theme_changer.dart';
import 'package:CHATS_Vendor/ui/shared/BTN.dart';
import 'package:CHATS_Vendor/ui/shared/TEXT.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ErrorWidgetHandler extends StatelessWidget {
  const ErrorWidgetHandler({Key? key, this.onTap}) : super(key: key);

  final Function? onTap;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(20.0.w),
            child: TEXT(
                textAlign: TextAlign.center,
                color: ThemeBuilder.of(context)?.getCurrentTheme() ==
                        Brightness.light
                    ? Colors.black
                    : Colors.white,
                text:
                    'An error occured while loading, check your network then hit refresh'),
          ),
          BTN(
            height: 52.h,
            margin: EdgeInsets.all(20.w),
            children: [
              TEXT(
                text: 'Refresh',
                color: Colors.white,
                fontFamily: 'Gilroy-medium',
              )
            ],
            onTap: () => onTap!(),
          ),
        ],
      ),
    );
  }
}
