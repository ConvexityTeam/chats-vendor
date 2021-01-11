import 'package:CHATS_Vendor/ui/shared/ui_helper.dart';
import 'package:flutter/material.dart';

import 'TEXT.dart';

class TF extends StatelessWidget{
  TF({
    @required this.controller,
    @required this.label,
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
    this.inputBorder
  });

  final TextEditingController controller;
  final String hintText;
  final String helpText;
  final Icon prefixIcon;
  final Widget suffixIcon;
  final bool isPassword;
  final bool enabled;
  final bool readOnly;
  final Color borderColor;
  final TextInputType keyboardType;
  final Color focusColor;
  final Function(String text) validateFn;
  final int maxLength;
  final EdgeInsets margin;
  final EdgeInsets padding;
  final Function(String value) onSaved;
  final InputBorder inputBorder;
  final TEXT label;

  @override 
  Widget build(BuildContext context){
    Size screenSize = MediaQuery.of(context).size;
    return Container(
      // padding: padding??EdgeInsets.only(left:8.0),
      margin: margin??EdgeInsets.only(bottom: screenSize.height/34),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          label,
          TextFormField(
            controller: controller,
            readOnly: readOnly??false,
            obscureText: isPassword??false,
            style: TextStyle( fontSize: screenSize.height/48),
            keyboardType: keyboardType??TextInputType.text,
            validator: validateFn,
            onSaved: onSaved,
            cursorColor: Constants.purple,
            enabled: enabled??true,
            // maxLength: maxLength??,
            decoration: InputDecoration(
              enabled: true,
              hintText: hintText,
              contentPadding: EdgeInsets.only(left:8.0),
              hintStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon,
              focusColor: focusColor??Colors.blue,
              border: inputBorder??OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide(width: .5, color: Constants.borderColor)),
              focusedBorder: inputBorder??OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide(width: 1, color: Constants.purple)),
              fillColor: Colors.white,
              filled: true
              
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