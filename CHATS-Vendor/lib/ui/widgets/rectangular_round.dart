import 'package:flutter/material.dart';

class RoundRectangularButton extends StatelessWidget {
  final Widget text;
  final radius;
  final color;
  final Function onPressed;
  RoundRectangularButton(
      {@required this.radius,
      @required this.color,
      @required this.onPressed,
      @required this.text});
  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
      ),
      onPressed: onPressed,
      child: text,
      fillColor: color,
      constraints: BoxConstraints.tightFor(
        width: MediaQuery.of(context).size.width / 1.1,
        height: MediaQuery.of(context).size.height / 15,
      ),
    );
  }
}
