import 'package:CHATS_Vendor/ui/shared/BTN.dart';
import 'package:CHATS_Vendor/ui/shared/TEXT.dart';
import 'package:CHATS_Vendor/ui/shared/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DialogUtils {
  static dynamic showAppResultDialog(
    BuildContext context, {
    required Map result,
    Function? onOkayTapped,
    Function? onRetryTapped,
  }) {
    Widget successState(String message, dynamic onOk) => Container(
          width: double.infinity,
          height: 350.h,
          padding: EdgeInsets.all(20.h),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.r)),
          child: Column(
            children: [
              Icon(
                Icons.check_circle_rounded,
                color: Constants.usedGreen,
                size: 70.0,
              ),
              SizedBox(height: 32.h),
              TEXT(
                text: 'Operation successful',
                fontSize: 23.sp,
                fontFamily: 'Gilroy-Bold',
              ),
              SizedBox(height: 16.h),
              TEXT(
                text: message,
                fontSize: 16.sp,
                fontFamily: 'Gilroy-Medium',
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 12.h),
              BTN(
                onTap: onOk,
                bgColor: Colors.transparent,
                borderColor: Constants.usedGreen,
                child: TEXT(
                  text: 'Ok, got it',
                  color: Constants.usedGreen,
                  fontFamily: 'Gilroy-Bold',
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        );
    Widget failedState(String message, dynamic onRetry) => Container(
          width: double.infinity,
          height: 350.h,
          padding: EdgeInsets.all(20.h),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.r)),
          child: Column(
            children: [
              Icon(
                Icons.cancel_rounded,
                color: Colors.redAccent.shade400,
                size: 70.0,
              ),
              SizedBox(height: 32.h),
              TEXT(
                text: 'Operation failed',
                fontSize: 23.sp,
                fontFamily: 'Gilroy-Bold',
              ),
              SizedBox(height: 16.h),
              TEXT(
                text: message,
                fontSize: 16.sp,
                fontFamily: 'Gilroy-Medium',
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 12.h),
              BTN(
                onTap: onRetry,
                bgColor: Colors.redAccent.shade400,
                borderColor: Colors.transparent,
                child: TEXT(
                  text: 'Ok, retry',
                  color: Colors.white,
                  fontFamily: 'Gilroy-Bold',
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        );

    return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          insetPadding: EdgeInsets.all(20.h),
          alignment: Alignment.center,
          backgroundColor: Colors.white,
          shadowColor: Colors.black.withAlpha(5),
          child: result['status'] == 'success'
              ? successState(
                  result['message'],
                  onOkayTapped ?? () => Modular.to.pop(true),
                )
              : failedState(
                  result['message'],
                  onRetryTapped ?? () => Modular.to.pop(false),
                ),
        );
      },
    );
  }
}
