import 'package:CHATS_Vendor/ui/shared/BTN.dart';
import 'package:CHATS_Vendor/ui/shared/TEXT.dart';
import 'package:CHATS_Vendor/ui/shared/TF.dart';
import 'package:CHATS_Vendor/ui/shared/ui_helper.dart';
import 'package:CHATS_Vendor/ui/view_model/base_view_model.dart';
import 'package:CHATS_Vendor/ui/view_model/sign_upVM.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final myKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final smallH = size.height / 36;
    final smallW = size.height / 46;
    return BaseViewModel<SignUpVM>(
        providerReady: (provider) {},
        builder: (context, provider, child) => Scaffold(
                body: Stack(
                    // alignment: Alignment.bottomCenter,
                    children: [
                  Image.asset(
                    'assets/guyandgirl.png',
                    width: 600,
                    fit: BoxFit.cover,
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: size.height / 2,
                      child: SingleChildScrollView(
                        child: Form(
                          key: myKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Center(
                                  child: TEXT(
                                edgeInset: EdgeInsets.all(0),
                                text: provider.errorMessage,
                                color: Colors.red,
                                fontSize: 12,
                              )),
                              TF(
                                controller: emailController,
                                label: TEXT(
                                  text: 'Email / Phone Number',
                                  fontFamily: 'Gilroy-Medium',
                                ),
                                validateFn: (val) {
                                  if (val.isEmpty) return 'Cannot be empty';
                                },
                              ),
                              TF(
                                controller: passController,
                                isPassword: hidePassword,
                                label: TEXT(
                                  text: 'Password',
                                  fontFamily: 'Gilroy-Medium',
                                ),
                                suffixIcon: GestureDetector(
                                  child: Image.asset(
                                    hidePassword
                                        ? 'assets/icons/hide.png'
                                        : 'assets/icons/show.png',
                                  ),
                                  onTap: () {
                                    Navigator.pushNamed(context, 'onboard');
                                    setState(() {
                                      hidePassword = !hidePassword;
                                    });
                                  },
                                ),
                                validateFn: (val) {
                                  if (val.isEmpty) return 'Cannot be empty';
                                },
                              ),
                              GestureDetector(
                                  child: TEXT(
                                text: 'Forgot Password?',
                                color: Colors.black,
                              )),
                              BTN(
                                  children: [
                                    Expanded(
                                        child: TEXT(
                                            text: 'Log in',
                                            color: Colors.black,
                                            textAlign: TextAlign.center,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                            edgeInset: EdgeInsets.all(0.0))),
                                    SizedBox(
                                        height: 18,
                                        width: 18,
                                        child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                                    !provider.isBusy
                                                        ? Constants.purple
                                                        : Colors.black)))
                                  ],
                                  onTap: () {
                                    if (myKey.currentState.validate()) {
                                      provider.login(emailController.text,
                                          passController.text, context);
                                    }
                                  },
                                  mainAxisAlignment: provider.isBusy
                                      ? MainAxisAlignment.end
                                      : MainAxisAlignment.center),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TEXT(text: "Don't have an account? "),
                                  GestureDetector(
                                    child: TEXT(
                                      text: 'Sign up',
                                      color: Constants.purple,
                                    ),
                                    onTap: () {
                                      Navigator.pushReplacementNamed(
                                          context, 'signUp');
                                    },
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      padding: EdgeInsets.only(
                          top: smallH * 2, right: smallW, left: smallW),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          )),
                    ),
                  ),
                ])));
  }

  bool hidePassword = true;

  TextEditingController emailController = new TextEditingController(text: '');

  TextEditingController passController = new TextEditingController(text: '');
}
