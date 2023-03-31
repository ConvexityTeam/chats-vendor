import 'package:CHATS_Vendor/Utils/colors.dart';
import 'package:CHATS_Vendor/core/constants/ui_helper.dart';
import 'package:CHATS_Vendor/ui/shared/ui_helper.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Function()? function;
  final String? title;
  const CustomButton({Key? key, this.function, this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      margin: UIHelper.sidePadding,
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: UIHelper.borderRadius,
      ),
      child: TextButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Constants.usedGreen)),
        onPressed: function,
        child: Text(
          title!,
          style: TextStyle(
            fontFamily: "Gilroy-bold",
            fontSize: 18,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
// ff8080
