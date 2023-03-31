import 'package:CHATS_Vendor/Utils/colors.dart';
import 'package:CHATS_Vendor/core/services/vendor_service.dart';
import 'package:CHATS_Vendor/theme_changer.dart';
import 'package:CHATS_Vendor/ui/shared/TEXT.dart';
import 'package:CHATS_Vendor/ui/widgets/error_widget_handler.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    if (kDebugMode)
      print({String.fromEnvironment("BUILD_ENV"), "{{{{BUILD_ENV}}}}"});
    return Scaffold(
      backgroundColor:
          ThemeBuilder.of(context)?.getCurrentTheme() == Brightness.light
              ? Color.fromRGBO(250, 250, 250, 1)
              : primaryColorDarkMode,
      appBar: AppBar(
        elevation: 0,
        backgroundColor:
            ThemeBuilder.of(context)?.getCurrentTheme() == Brightness.light
                ? Colors.white
                : primaryColorDarkMode,
        leading: IconButton(
          onPressed: () {
            Modular.to.navigate('/onboard/login');
          },
          icon: Icon(Icons.power_settings_new, color: Colors.red),
          tooltip: 'Logout',
        ),
        // toolbarHeight: 1,
      ),
      body: FutureBuilder(
        future: Modular.get<VendorService>().gettingVendorDetails(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              color: ThemeBuilder.of(context)?.getCurrentTheme() ==
                      Brightness.light
                  ? Colors.white
                  : primaryColorDarkMode,
              child: Center(
                child: CircularProgressIndicator.adaptive(),
              ),
            );
          }

          if (snapshot.hasError) {
            return ErrorWidgetHandler(
              onTap: () {
                setState(() {});
              },
            );
          }
          return Container(
            width: double.infinity,
            height: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            color:
                ThemeBuilder.of(context)?.getCurrentTheme() == Brightness.light
                    ? Color.fromRGBO(250, 250, 250, 1)
                    : primaryColorDarkMode,
            child: RefreshIndicator(
              onRefresh: () async {
                await Modular.get<VendorService>().gettingVendorDetails();
              },
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    buildCard(
                      color: Color.fromRGBO(98, 52, 195, 0.3),
                      image: "icons/home/scan.png",
                      imageBgColor: Color.fromRGBO(155, 117, 237, 1),
                      subTitle: "Complete a payment for service or product",
                      title: "Accept Payment",
                      context: context,
                      route: '/payment/',
                    ),
                    buildCard(
                      color: Color.fromRGBO(247, 233, 111, 0.3),
                      image: "icons/home/volume.png",
                      imageBgColor: Color.fromRGBO(247, 233, 111, 1),
                      subTitle: "See a list of campaigns your’re in",
                      title: "My Campaigns",
                      context: context,
                      route: '/home/campaigns/',
                    ),
                    buildCard(
                      color: Color.fromRGBO(0, 191, 111, 0.3),
                      image: "icons/home/wallet.png",
                      imageBgColor: Color.fromRGBO(53, 199, 138, 1),
                      subTitle: "See your total balance and withdraw money.",
                      title: "Wallet",
                      context: context,
                      route: '/wallet/',
                    ),
                    buildCard(
                      color: Color.fromRGBO(0, 140, 255, 0.3),
                      image: "icons/home/coin.png",
                      imageBgColor: Color.fromRGBO(83, 166, 235, 1),
                      subTitle:
                          "See a full list of all your transactions so far.",
                      title: "Transactions",
                      context: context,
                      route: '/home/transactions',
                    ),
                    buildCard(
                      color: Color.fromRGBO(240, 84, 72, 0.3),
                      image: "icons/home/frame.png",
                      imageBgColor: Color.fromRGBO(247, 121, 110, 1),
                      subTitle: "Edit your profile settings ",
                      title: "Profile",
                      context: context,
                      route: '/profile/',
                    ),
                    SizedBox(height: 24.h),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildCard({
    required Color color,
    required String image,
    Color? imageBgColor,
    required String title,
    required String subTitle,
    required BuildContext context,
    required String route,
  }) {
    return GestureDetector(
      onTap: () {
        Modular.to.pushNamed(route);
      },
      child: Container(
        width: double.infinity,
        // height: 164.h,
        margin: EdgeInsets.only(
          top: 16.h,
        ),
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 17.h),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 50,
              width: 50,
              alignment: Alignment.center,
              child: Image.asset(
                "assets/$image",
                width: 24.w,
                height: 24.h,
                fit: BoxFit.contain,
              ),
              decoration: BoxDecoration(
                color: imageBgColor,
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(height: 12.h),
            TEXT(
              text: title,
              color: ThemeBuilder.of(context)?.getCurrentTheme() ==
                      Brightness.light
                  ? Colors.black
                  : Colors.white,
              fontFamily: "Gilroy-medium",
              edgeInset: EdgeInsets.zero,
              fontSize: 20.sp,
              softWrap: false,
              maxLines: 1,
              textOverflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 5.h),
            Wrap(
              children: [
                TEXT(
                  text: subTitle,
                  color: ThemeBuilder.of(context)?.getCurrentTheme() ==
                          Brightness.light
                      ? Colors.black
                      : Colors.white,
                  fontFamily: "Gilroy-regular",
                  softWrap: true,
                  maxLines: 2,
                  textOverflow: TextOverflow.visible,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
