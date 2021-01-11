import 'package:CHATS_Vendor/Utils/colors.dart';
import 'package:flutter/material.dart';

class WalletView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
            "Wallet",
            style: TextStyle(
              color: Colors.black,
              fontFamily: "Gilroy-bold",
              fontSize: 24,
            ),
          ),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 195,
                  width: MediaQuery.of(context).size.width * 0.87,
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: backgroundColor,
                      borderRadius: BorderRadius.all(
                        Radius.circular(5),
                      )),
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "${12500}.00",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 36,
                          fontFamily: "Gilroy-medium",
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Current balance",
                        style: TextStyle(
                          color: Color(0xff555555),
                          fontSize: 14,
                          fontFamily: "Gilroy-medium",
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 20),
                buildCard(context)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildCard(context) {
    return Card(
      child: Container(
        height: 60,
        margin: const EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width * 0.87,
        child: Row(
          children: [
            SizedBox(width: 10),
            Text(
              "Withdraw",
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontFamily: "Gilroy-medium",
              ),
            ),
            Spacer(),
            GestureDetector(
              onTap: () {},
              child: Icon(
                Icons.arrow_forward_ios,
                size: 9,
              ),
            ),
            SizedBox(width: 10),
          ],
        ),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(5),
            )),
      ),
    );
  }
}
