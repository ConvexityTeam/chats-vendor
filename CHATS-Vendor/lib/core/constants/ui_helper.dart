import 'package:flutter/material.dart';

class UIHelper {
  static const EdgeInsets sidePadding = EdgeInsets.all(5);
  static const BorderRadiusGeometry borderRadius = BorderRadius.all(
    Radius.circular(5),
  );

  Widget circledBox(
      {@required double height,
      @required double width,
      @required Widget child,
      @required Color color}) {
    return Container(
      height: height,
      width: width,
      child: child,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
    );
  }
}
