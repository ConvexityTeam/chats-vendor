import 'package:CHATS_Vendor/core/constants/ui_helper.dart';
import 'package:flutter/material.dart';

class SupportView extends StatelessWidget {
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
            "Support",
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
          child: Column(
            children: [
              SizedBox(height: 20),
              buildCard(
                  image: "icons/call.png",
                  title: "Call An Agent",
                  context: context),
              buildCard(
                  image: "icons/email.png",
                  title: "Send Us An Email",
                  context: context),
              buildCard(
                  image: "icons/live_chat.png",
                  title: "Live Chat",
                  context: context),
              buildCard(
                  image: "icons/facebook.png",
                  title: "Facebook",
                  context: context),
              buildCard(
                  image: "icons/linkedIn.png",
                  title: "LinkedIn ",
                  context: context),
              buildCard(
                  image: "icons/twitter.png",
                  title: "Twitter ",
                  context: context),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCard(
      {@required String title, @required String image, BuildContext context}) {
    return Container(
      margin: UIHelper.sidePadding,
      height: 50,
      width: MediaQuery.of(context).size.width * 0.90,
      child: ListTile(
        leading: Image.asset(image),
        title: Text(
          title,
          style: TextStyle(
              color: Colors.black, fontSize: 16, fontFamily: "Gilroy-Regular"),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: UIHelper.borderRadius,
        border: Border.all(
          color: Colors.black,
        ),
      ),
    );
  }
}
