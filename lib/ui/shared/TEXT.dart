import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TEXT extends StatelessWidget {
  TEXT(
      {required this.text,
      this.color,
      this.fontSize,
      this.fontWeight,
      this.textAlign,
      this.textDecorationStyle,
      this.fontStyle,
      this.edgeInset,
      this.fontFamily,
      this.softWrap,
      this.maxLines,
      this.textOverflow});

  final String text;
  final double? fontSize;
  final Color? color;
  final FontWeight? fontWeight;

  final TextAlign? textAlign;
  final TextDecorationStyle? textDecorationStyle;
  final FontStyle? fontStyle;
  final EdgeInsets? edgeInset;
  final String? fontFamily;
  bool? softWrap = false;
  int? maxLines = 1;
  TextOverflow? textOverflow = TextOverflow.ellipsis;
  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return Padding(
      padding: edgeInset ?? EdgeInsets.zero,
      child: Text(
        text,
        style: TextStyle(
            color: color ?? Colors.black,
            decorationStyle: textDecorationStyle ?? TextDecorationStyle.solid,
            fontSize: fontSize ?? 16.sp,
            fontWeight: fontWeight ?? FontWeight.w400,
            fontFamily: fontFamily ?? 'Gilroy-Regular'
            // fontStyle: fontStyle??FontStyle.norma,
            // fontFamily: 'proxima-light'

            ),
        softWrap: softWrap,
        maxLines: maxLines,
        overflow: textOverflow,
        textAlign: textAlign ?? TextAlign.left,
      ),
    );
  }
}
