import 'package:CHATS_Vendor/Utils/colors.dart';
import 'package:CHATS_Vendor/theme_changer.dart';
import 'package:CHATS_Vendor/ui/shared/TEXT.dart';
import 'package:CHATS_Vendor/ui/shared/ui_helper.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomTextField extends StatelessWidget {
  CustomTextField({
    required this.controller,
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
    this.maxLines,
    this.padding,
    this.margin,
    this.onSaved,
    this.inputBorder,
    this.onTap,
  });

  final TextEditingController? controller;
  final String? hintText;
  final String? helpText;
  final Icon? prefixIcon;
  final Widget? suffixIcon;
  bool? isPassword = false;
  final bool? enabled;
  final bool? readOnly;
  final Color? borderColor;
  final TextInputType? keyboardType;
  final Color? focusColor;
  final String? Function(String? text)? validateFn;
  int? maxLines = 1;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final void Function(String? value)? onSaved;
  final InputBorder? inputBorder;
  final TEXT? label;
  void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Container(
      // padding: padding??EdgeInsets.only(left:8.0),
      margin: margin ?? EdgeInsets.only(bottom: screenSize.height / 34),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          label!,
          SizedBox(height: 10),
          TextFormField(
            onTap: onTap,
            // maxLines: maxLines ?? null,
            controller: controller,
            readOnly: readOnly ?? false,
            obscureText: isPassword ?? false,
            style: TextStyle(
                fontSize: screenSize.height / 48,
                color: ThemeBuilder.of(context)?.getCurrentTheme() ==
                        Brightness.light
                    ? Colors.black
                    : Colors.white),
            keyboardType: keyboardType ?? TextInputType.text,
            validator: validateFn,
            onSaved: onSaved,
            cursorColor: Constants.purple,
            enabled: enabled ?? true,
            // maxLength: maxLength??,
            decoration: InputDecoration(
                enabled: true,
                hintText: hintText,
                contentPadding: EdgeInsets.only(left: 8.0),
                hintStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: ThemeBuilder.of(context)?.getCurrentTheme() ==
                            Brightness.light
                        ? Colors.black
                        : Colors.white),
                prefixIcon: prefixIcon,
                suffixIcon: suffixIcon,
                focusColor: focusColor ?? Colors.blue,
                border: inputBorder ??
                    OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(
                          width: .5,
                          color: ThemeBuilder.of(context)?.getCurrentTheme() ==
                                  Brightness.light
                              ? Constants.borderColor
                              : Colors.white,
                        )),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: ThemeBuilder.of(context)?.getCurrentTheme() ==
                            Brightness.light
                        ? borderColor ?? Colors.black
                        : Colors.white,
                  ),
                ),
                focusedBorder: inputBorder ??
                    OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide:
                            BorderSide(width: 1, color: Constants.purple)),
                fillColor: ThemeBuilder.of(context)?.getCurrentTheme() ==
                        Brightness.light
                    ? Colors.white
                    : primaryColorDarkMode,
                filled: true),
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
