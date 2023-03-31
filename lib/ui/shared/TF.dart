import 'package:CHATS_Vendor/Utils/colors.dart';
import 'package:CHATS_Vendor/theme_changer.dart';
import 'package:CHATS_Vendor/ui/shared/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'TEXT.dart';

class TF extends StatelessWidget {
  TF(
      {required this.controller,
      required this.label,
      this.hintText,
      this.helpText,
      this.prefixIcon,
      this.suffixIcon,
      this.isPassword,
      this.enabled,
      this.readOnly,
      this.borderColor,
      this.keyboardType,
      this.focusColor,
      this.validateFn,
      this.maxLength,
      this.padding,
      this.margin,
      this.onSaved,
      this.inputBorder});

  final TextEditingController controller;
  final String? hintText;
  final String? helpText;
  final Icon? prefixIcon;
  final Widget? suffixIcon;
  final bool? isPassword;
  final bool? enabled;
  final bool? readOnly;
  final Color? borderColor;
  final TextInputType? keyboardType;
  final Color? focusColor;
  final String? Function(String? text)? validateFn;
  final int? maxLength;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final Function(String? value)? onSaved;
  final InputBorder? inputBorder;
  final TEXT label;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Container(
      // padding: padding??EdgeInsets.only(left:8.0),
      margin: margin ?? EdgeInsets.only(bottom: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          label,
          SizedBox(height: 8.h),
          TextFormField(
            controller: controller,
            readOnly: readOnly ?? false,
            obscureText: isPassword ?? false,
            style: TextStyle(
              fontSize: (screenSize.height / 48).sp,
              color: ThemeBuilder.of(context)?.getCurrentTheme() ==
                      Brightness.light
                  ? Colors.black
                  : Colors.white,
            ),
            keyboardType: keyboardType ?? TextInputType.text,
            validator: validateFn,
            onSaved: onSaved,
            cursorColor: Constants.purple,
            enabled: enabled ?? true,
            // maxLength: maxLength??,
            decoration: InputDecoration(
              enabled: true,
              hintText: hintText,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 8.0.w, vertical: 14.h),
              hintStyle: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.normal,
                color: ThemeBuilder.of(context)?.getCurrentTheme() ==
                        Brightness.light
                    ? Colors.black
                    : Colors.white,
              ),
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon,
              focusColor: focusColor ?? Colors.blue,
              border: inputBorder ??
                  OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.r),
                    borderSide: BorderSide(
                      width: .5.w,
                      color: Constants.borderColor,
                    ),
                  ),
              focusedBorder: inputBorder ??
                  OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.r),
                    borderSide: BorderSide(width: 1.w, color: Constants.purple),
                  ),
              fillColor: ThemeBuilder.of(context)?.getCurrentTheme() ==
                      Brightness.light
                  ? Colors.white
                  : primaryColorDarkMode,
              filled: true,
            ),
          ),
        ],
      ),
      // decoration: BoxDecoration(
      //   color: Colors.white,
      //   shape: BoxShape.rectangle,
      //   borderRadius: BorderRadius.circular(8.0),
      //   // border: Border.all(color: borderColor??CustomColors.subColor.withGreen(150),width: 1.0)
      // ),
    );
  }
}
