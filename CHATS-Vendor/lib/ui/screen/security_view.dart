import 'package:flutter/material.dart';

class SecurityView extends StatefulWidget {
  @override
  _SecurityViewState createState() => _SecurityViewState();
}

class _SecurityViewState extends State<SecurityView> {
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
            "Security",
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
                  height: 50,
                  margin: const EdgeInsets.all(10),
                  width: MediaQuery.of(context).size.width * 0.90,
                  child: Row(
                    children: [
                      SizedBox(width: 10),
                      Text(
                        "Change Password",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: "Gilroy-medium",
                        ),
                      ),
                      Spacer(),
                      SizedBox(width: 10),
                    ],
                  ),
                  decoration: BoxDecoration(
                      border: Border.all(),
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(5),
                      )),
                ),
                Container(
                  height: 50,
                  margin: const EdgeInsets.all(10),
                  width: MediaQuery.of(context).size.width * 0.90,
                  child: Row(
                    children: [
                      SizedBox(width: 10),
                      Text(
                        "Enable Finger Print",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: "Gilroy-medium",
                        ),
                      ),
                      Spacer(),
                      Switch(
                        activeColor: Color(0xff31D0AA),
                        value: _value,
                        onChanged: (bool k) {
                          setState(() {
                            _value = k;
                          });
                        },
                      ),
                      SizedBox(width: 10),
                    ],
                  ),
                  decoration: BoxDecoration(
                      border: Border.all(),
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(5),
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
