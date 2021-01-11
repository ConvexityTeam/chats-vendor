import 'package:CHATS_Vendor/core/constants/route_paths.dart';
import 'package:flutter/material.dart';

class ProfileView extends StatelessWidget {
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
            "Profile",
            style: TextStyle(
              color: Colors.black,
              fontFamily: "Gilroy-bold",
              fontSize: 24,
            ),
          ),
        ),
        // Body
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20),
              Center(
                child: Column(
                  children: [
                    Container(
                      height: 110,
                      width: 110,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("images/profile_image.png"),
                          fit: BoxFit.cover,
                        ),
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Yasmine Hardy",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 20),
              buildProfileComponent(
                  icon: "icons/profile.png",
                  pressed: () {
                    Navigator.pushNamed(context, Routes.accountSettingsView);
                  },
                  title: "Account Settings"),
              buildProfileComponent(
                  icon: "icons/card.png",
                  pressed: () {
                    Navigator.pushNamed(context, Routes.cardAndPaymentView);
                  },
                  title: "Cards & Payment"),
              buildProfileComponent(
                  icon: "icons/pin.png",
                  pressed: () {
                    Navigator.pushNamed(context, Routes.securityView);
                  },
                  title: "Security"),
              buildProfileComponent(
                  icon: "icons/contact.png",
                  pressed: () {
                    Navigator.pushNamed(context, Routes.supportView);
                  },
                  title: "Help & Support"),
              buildProfileComponent(
                  icon: "icons/logout.png", pressed: () {}, title: "Log Out"),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildProfileComponent(
      {@required String title,
      @required Function pressed,
      @required String icon}) {
    return GestureDetector(
      onTap: pressed,
      child: ListTile(
        leading: Image.asset(icon),
        trailing: Image.asset("icons/arrow_foward.png"),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 15,
            color: Colors.black,
            fontFamily: "Gilroy-Regular",
          ),
        ),
      ),
    );
  }
}
