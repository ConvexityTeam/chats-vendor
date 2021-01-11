import 'package:CHATS_Vendor/Utils/colors.dart';
import 'package:flutter/material.dart';

class TransactionView extends StatelessWidget {
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
            "Transactions",
            style: TextStyle(
              color: Colors.black,
              fontFamily: "Gilroy-bold",
              fontSize: 24,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: List.generate(6, (index) => buildTransactionCard()),
          ),
        ),
      ),
    );
  }

  Widget buildTransactionCard() {
    int price = 240;
    return ListTile(
      leading: Container(
        height: 56,
        width: 56,
        decoration: BoxDecoration(
          color: Color.fromRGBO(240, 240, 240, 0.4),
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
        ),
        child: Center(
          child: Text(
            "C",
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontFamily: "Gilroy-medium",
            ),
          ),
        ),
      ),
      trailing: Text(
        "\$15000.75",
        style:
            TextStyle(fontFamily: "Gilroy-Regular", fontSize: 16, color: kRed),
      ),
      subtitle: Text(
        "20, Dec 2018",
        style: TextStyle(
          fontSize: 11,
          color: Color(0xff555555),
        ),
      ),
      title: Text(
        "Adewale",
        style: TextStyle(
            fontFamily: "Gilroy-Regular",
            fontSize: 16,
            color: Color(0xff555555)),
      ),
    );
  }
}
