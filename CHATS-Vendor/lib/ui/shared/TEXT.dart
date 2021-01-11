import 'package:flutter/material.dart';

class TEXT extends StatelessWidget {

  TEXT({
    @required this.text,
    this.color,
    this.fontSize,
    this.fontWeight,
    this.textAlign,
    this.textDecorationStyle,
    this.fontStyle,
    this.edgeInset,
    this.fontFamily
  });

  final String text;
  final double fontSize;
  final Color color;
  final FontWeight fontWeight;

  final TextAlign textAlign;
  final TextDecorationStyle textDecorationStyle;
  final FontStyle fontStyle;
  final EdgeInsets edgeInset;
  final String fontFamily;
  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return Padding( 
      padding: edgeInset??EdgeInsets.only(bottom: 8.0),
      child: Text(text, style: TextStyle(
        color: color??Colors.black,
        decorationStyle: textDecorationStyle??TextDecorationStyle.solid,
        fontSize: fontSize??16,
        fontWeight: fontWeight??FontWeight.w400,
        fontFamily: fontFamily??'Gilroy-Regular'
        // fontStyle: fontStyle??FontStyle.norma,
        // fontFamily: 'proxima-light'
        
      ),
      softWrap: true,
      maxLines: 5,
      overflow: TextOverflow.clip,
      textAlign: textAlign??TextAlign.left,
      ),
    );
  }
}