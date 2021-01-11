import 'package:CHATS_Vendor/core/constants/route_paths.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, Routes.acceptPaymentsView);
                },
                child: buildCard(
                  color: Color(0xff6234C3).withOpacity(0.40),
                  fontFamily: "Gilroy-medium",
                  image: "icons/qr code.png",
                  subTitle:
                      "Complete a payment with an already created QR code",
                  title: "Accept Payment",
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, Routes.walletView);
                },
                child: buildCard(
                  color: Color(0xff00BF6F).withOpacity(0.40),
                  fontFamily: "Gilroy-medium",
                  image: "icons/wallet.png",
                  subTitle: "See your total balance and withdraw money.",
                  title: "Wallet",
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, Routes.transactionView);
                },
                child: buildCard(
                  color: Color(0xff008CFF).withOpacity(0.40),
                  fontFamily: "Gilroy-medium",
                  image: "icons/transactions.png",
                  subTitle: "See a full list of all your transactions so far.",
                  title: "Transactions",
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, Routes.profileView);
                },
                child: buildCard(
                    color: Color(0xffF05448).withOpacity(0.40),
                    fontFamily: "Gilroy-medium",
                    image: "icons/profile.png",
                    subTitle: "Edit your profile settings ",
                    title: "Profile"),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCard(
      {@required Color color,
      @required String image,
      @required String title,
      @required String subTitle,
      @required String fontFamily}) {
    return Container(
      height: 200,
      margin: const EdgeInsets.only(
        top: 3,
        bottom: 3,
      ),
      decoration: BoxDecoration(
        color: color,
      ),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 15),
          ListTile(
            leading: Container(
              height: 50,
              width: 50,
              alignment: Alignment.center,
              child: Image.asset(image),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
            ),
          ),
          ListTile(
            title: Text(
              title,
              style: TextStyle(
                  color: Colors.black, fontFamily: fontFamily, fontSize: 18),
            ),
          ),
          ListTile(
            title: Text(
              subTitle,
              style: TextStyle(
                  color: Color(0xff4f4f4f),
                  fontFamily: "Gilroy-Regular",
                  fontSize: 16),
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
