import 'package:CHATS_Vendor/Utils/colors.dart';
import 'package:CHATS_Vendor/core/constants/route_paths.dart';
import 'package:CHATS_Vendor/core/constants/ui_helper.dart';
import 'package:flutter/material.dart';

class AcceptPaymentsView extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    // double width = MediaQuery.of(context).size.width;
    // var orientation = MediaQuery.of(context).orientation;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Image.asset("icons/arrow_back.png"),
          ),
          title: Text(
            "Accept Payments",
            style: TextStyle(
              color: Colors.black,
              fontFamily: "Gilroy-bold",
              fontSize: 24,
            ),
          ),
        ),
        body: Column(
          children: [
            Row(
              children: [
                Container(
                  height: 246,
                  width: 150,
                  margin: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: UIHelper.borderRadius,
                    color: backgroundColor,
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      Container(
                        height: 45,
                        width: 45,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: Center(
                          child: Image.asset(
                            "icons/barcode.png",
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Scan\nNFC Card",
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.black,
                          fontFamily: "Gilroy-medium",
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Scan a customer\n  NFC Card",
                        style: TextStyle(
                          fontSize: 13,
                          // fontFamily: "Gilroy-medium",
                          color: Color(0xff4F4F4F),
                        ),
                      ),
                      Expanded(
                        child: SizedBox(),
                      )
                    ],
                  ),
                ),
                SizedBox(width: 30),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, Routes.scanCodeView);
                  },
                  child: Container(
                    margin: EdgeInsets.all(20),
                    height: 246,
                    width: 150,
                    decoration: BoxDecoration(
                      color: backgroundColor,
                      borderRadius: UIHelper.borderRadius,
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 20),
                        Container(
                          height: 45,
                          width: 45,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: Center(
                              child: Image.asset("icons/qr code.png",
                                  fit: BoxFit.cover)),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Scan\nQR Code",
                          style: TextStyle(
                            fontSize: 17,
                            color: Colors.black,
                            fontFamily: "Gilroy-medium",
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Complete a\npayment with an\nalready created\n   QR code.",
                          style: TextStyle(
                            fontSize: 13,
                            color: Color(0xff4F4F4F),
                            // fontFamily: "Gilroy-medium",
                          ),
                        ),
                        Expanded(
                          child: SizedBox(),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
