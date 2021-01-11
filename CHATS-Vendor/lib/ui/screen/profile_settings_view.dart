import 'package:CHATS_Vendor/ui/widgets/custom_button.dart';
import 'package:CHATS_Vendor/ui/widgets/text_field.dart';
import 'package:flutter/material.dart';

class ProfileSettings extends StatelessWidget {
  final TextEditingController name = TextEditingController();
  final TextEditingController lastName = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController phone = TextEditingController();
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
            "Profile Settings",
            style: TextStyle(
              color: Colors.black,
              fontFamily: "Gilroy-bold",
              fontSize: 24,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.all(10),
            child: Column(
              children: [
                SizedBox(height: 20),
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage("images/profile_image.png"),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  "Upload new image",
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: "Gilroy-Regular",
                    color: Color(0xff492954),
                  ),
                ),
                SizedBox(height: 20),
                CustomTextField(
                  title: "First Name",
                  controller: name,
                ),
                CustomTextField(
                  title: "Last Name",
                  controller: lastName,
                ),
                CustomTextField(
                  title: "Phone Number",
                  controller: phone,
                ),
                CustomTextField(
                  title: "Email",
                  controller: email,
                ),
                SizedBox(height: 20),
                CustomButton(
                  function: () {},
                  title: "Save",
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
