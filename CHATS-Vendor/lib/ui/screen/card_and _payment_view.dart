import 'package:CHATS_Vendor/ui/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class CardAndPaymentsView extends StatelessWidget {
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
            "Cards & Payments",
            style: TextStyle(
              color: Colors.black,
              fontFamily: "Gilroy-bold",
              fontSize: 24,
            ),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 150,
              width: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("icons/card.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: Text(
                "No cards added. Add a new card\nto withdraw to your local bank\naccount",
                style: TextStyle(
                  color: Color(0xff333333),
                  fontSize: 16,
                  fontFamily: "Gilroy-Regular",
                ),
              ),
            ),
            SizedBox(height: 50),
            CustomButton(
              function: () {},
              title: "Add A New Card",
            )
          ],
        ),
      ),
    );
  }
}
