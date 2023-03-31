import 'package:CHATS_Vendor/modules/onboard/onboard_vm.dart';
import 'package:CHATS_Vendor/ui/shared/BTN.dart';
import 'package:CHATS_Vendor/ui/shared/TEXT.dart';
import 'package:CHATS_Vendor/ui/view_model/base_view_model.dart';
import 'package:CHATS_Vendor/ui/widgets/custom_carousel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BaseViewModel<OnboardVM>(
      providerReady: (provider) => null,
      builder: (context, provider, child) => Scaffold(
        body: Container(
          padding: MediaQuery.of(context).viewPadding,
          height: size.height,
          child: Column(
            children: [
              Center(
                child: Container(
                  margin: EdgeInsets.only(top: size.height / 50),
                  padding: EdgeInsets.all(size.height / 50),
                  child: Image.asset(
                    'assets/logo.png',
                    width: 156.24.w,
                    height: 48.h,
                    // scale: 5,
                  ),
                ),
              ),
              SizedBox(height: 40.h),
              Expanded(
                child: SliderImages(
                  imageList: provider.imageList,
                  scrollText: provider.scrollText,
                ),
              ),
              // SizedBox(height: 20),
              // RoundRectangularButton(
              //     radius: 10.0,
              //     color: AppConstants.purple,
              //     onPressed: () =>
              //         Navigator.pushNamed(context, 'signUp'),
              //     text: Text(
              //       'Sign Up',
              //       style: TextStyle(
              //           color: Colors.black,
              //           fontSize: 16,
              //           fontFamily: 'Gilroy-Regular'),
              //     )),
              SizedBox(height: 10.h),
              BTN(
                margin: EdgeInsets.symmetric(horizontal: 24.w),
                height: 52,
                onTap: () =>
                    // Navigator.pushNamed(context, 'login'),
                    Modular.to.navigate('/onboard/login'),
                child: TEXT(
                  text: 'Log In',
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontFamily: 'Gilroy-medium',
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}
