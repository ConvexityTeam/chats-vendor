import 'package:CHATS_Vendor/core/constants/ui_helper.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomTextField extends StatelessWidget {
  CustomTextField({this.controller, this.title});

  TextEditingController controller = TextEditingController();
  final String title;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontFamily: "Gilroy-Regular",
            fontSize: 16,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 10),
        Container(
          height: 50,
          width: MediaQuery.of(context).size.width * 0.90,
          margin: UIHelper.sidePadding,
          decoration: BoxDecoration(
            borderRadius: UIHelper.borderRadius,
          ),
          child: TextFormField(
            controller: controller,
            decoration: InputDecoration(
              border: OutlineInputBorder(borderRadius: UIHelper.borderRadius),
            ),
          ),
        ),
      ],
    );
  }
}
