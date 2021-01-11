import 'package:CHATS_Vendor/core/constants/route_paths.dart';
import 'package:CHATS_Vendor/core/constants/ui_helper.dart';
import 'package:flutter/material.dart';

class AccountSettingsView extends StatefulWidget {
  @override
  _AccountSettingsViewState createState() => _AccountSettingsViewState();
}

class _AccountSettingsViewState extends State<AccountSettingsView> {
  bool _value = false;
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
          "Account Settings",
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
        margin: const EdgeInsets.all(10),
        child: Column(
          children: [
            SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, Routes.profileSettingsView);
              },
              child: buildCard(
                  image: "icons/profile.png",
                  title: "Profile Settings",
                  context: context
                  // trailing: Container(),
                  ),
            ),
            Container(
              height: 50,
              margin: const EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width * 0.90,
              child: ListTile(
                leading: Image.asset("icons/notifications.png"),
                title: Text(
                  "Notifications",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: "Gilroy-Regular"),
                ),
                trailing: Switch(
                  activeColor: Color(0xff31D0AA),
                  value: _value,
                  onChanged: (bool k) {
                    setState(() {
                      _value = k;
                    });
                  },
                ),
              ),
              decoration: BoxDecoration(
                  border: Border.all(),
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  )),
            ),
            buildCard(image: "icons/pin.png", title: "BVN", context: context)
          ],
        ),
      ),
    ));
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
