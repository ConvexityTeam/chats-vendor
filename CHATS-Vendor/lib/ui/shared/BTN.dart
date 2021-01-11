import 'package:CHATS_Vendor/ui/shared/ui_helper.dart';
import 'package:flutter/material.dart';

class BTN extends StatelessWidget {

  BTN({
    this.bgColor,
    @required this.children,
    @required this.onTap,
    this.mainAxisAlignment,
    this.margin,
    this.padding,
    this.borderRadius
  });

  final Color bgColor;
  final List<Widget> children;
  final MainAxisAlignment mainAxisAlignment;
  final EdgeInsets margin;
  final EdgeInsets padding;
  final double borderRadius;
  final Function onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: children,
          mainAxisAlignment: mainAxisAlignment??MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
        ),
      ),
      padding: padding??EdgeInsets.all(14),
        margin: margin??EdgeInsets.all(14),
        decoration: BoxDecoration(
          boxShadow: [
            // BoxShadow(color: CustomColors.subColor.withGreen(150), spreadRadius: 0.2, blurRadius: 5.0, offset: Offset(1, 1)),
            // BoxShadow(color: CustomColors.subColor.withGreen(150), spreadRadius: .2, blurRadius: 5.0, offset: Offset(1, 1)),
          ],
        color: bgColor??Constants.purple,
        borderRadius: BorderRadius.circular(borderRadius??8.0)
      )
      
    );
  }
}