import 'package:CHATS_Vendor/Utils/colors.dart';
import 'package:CHATS_Vendor/core/services/vendor_service.dart';
import 'package:CHATS_Vendor/theme_changer.dart';
import 'package:CHATS_Vendor/ui/shared/TEXT.dart';
import 'package:CHATS_Vendor/ui/shared/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileView extends StatefulWidget {
  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // ignore: missing_return
      onWillPop: () => onBackPressed(context),
      child: Scaffold(
        backgroundColor:
            ThemeBuilder.of(context)?.getCurrentTheme() == Brightness.light
                ? Color.fromRGBO(250, 250, 250, 1)
                : primaryColorDarkMode,
        key: scaffoldKey,
        appBar: AppBar(
          elevation: 0,
          centerTitle: false,
          backgroundColor:
              ThemeBuilder.of(context)?.getCurrentTheme() == Brightness.light
                  ? Colors.white
                  : primaryColorDarkMode,
          leading: GestureDetector(
            onTap: () {
              // scaffoldKey.currentState!.openDrawer();
              Navigator.pop(context);
            },
            // child: Image.asset("assets/Group.png"),
            child: Icon(
              Icons.arrow_back_ios_new,
              color: ThemeBuilder.of(context)?.getCurrentTheme() ==
                      Brightness.light
                  ? Colors.black
                  : Colors.white,
            ),
          ),
          title: TEXT(
            text: 'Profile',
            fontFamily: 'Gilroy-medium',
            fontSize: 22.sp,
            // textAlign: TextAlign.left,
            color:
                ThemeBuilder.of(context)?.getCurrentTheme() == Brightness.light
                    ? Colors.black
                    : Colors.white,
          ),
        ),
        // drawer: AppDrawer(),
        // Body
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          color: ThemeBuilder.of(context)?.getCurrentTheme() == Brightness.light
              ? Colors.white
              : primaryColorDarkMode,
          child: RefreshIndicator(
            onRefresh: () async {
              await Modular.get<VendorService>().gettingVendorDetails();
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 20.h),
                  Center(
                    child: Column(
                      children: [
                        Container(
                          height: 110,
                          width: 110,
                          decoration: BoxDecoration(
                            // image: DecorationImage(
                            //   image: NetworkImage(
                            //       // TODO: Replace with actual default URL of the logo
                            //       locator<UserService>().data?.profilePic ??
                            //           'https://www.gravatar.com/avatar/205e460b479e2e5b48aec07710c08d50'),
                            //   fit: BoxFit.cover,
                            // ),
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        // Text(
                        //   "${locator<UserService>().data!.firstName} ${locator<UserService>().data!.lastName}",
                        //   style: TextStyle(
                        //     fontSize: 16,
                        //     color: Colors.black,
                        //   ),
                        // )
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h),
                  buildProfileComponent(
                    context,
                    title: "Personal Information",
                    pressed: () {
                      // Navigator.pushNamed(context, Routes.personalInfo);
                      Modular.to.pushNamed('/profile/personal_info');
                    },
                  ),
                  // SizedBox(height: 20.h),
                  Divider(height: 48.h),
                  buildProfileComponent(
                    context,
                    title: "Account",
                    pressed: () {
                      // Navigator.pushNamed(context, Routes.account);
                      Modular.to.pushNamed('/profile/account');
                    },
                  ),
                  Divider(height: 48.h),
                  buildProfileComponent(
                    context,
                    title: "KYC Status",
                    pressed: () {
                      // Navigator.pushNamed(context, Routes.kycStatus);
                      Modular.to.pushNamed('/profile/kyc');
                    },
                  ),
                  Divider(height: 48.h),
                  buildProfileComponent(
                    context,
                    title: "Security",
                    pressed: () {
                      // Navigator.pushNamed(context, Routes.security);
                      Modular.to.pushNamed('/profile/security');
                    },
                  ),
                  Divider(height: 48.h),
                  buildProfileComponent(
                    context,
                    title: "Settings",
                    pressed: () {
                      // Navigator.pushNamed(context, Routes.mySettings);
                      Modular.to.pushNamed('/profile/settings');
                    },
                  ),
                  Divider(height: 48.h),
                  buildProfileComponent(
                    context,
                    title: "Help & Support",
                    pressed: () {
                      // Navigator.pushNamed(context, Routes.helpSupport);
                      Modular.to.pushNamed('/profile/support');
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildProfileComponent(
    context, {
    required String? title,
    required Function? pressed,
  }) {
    return InkWell(
      onTap: () => pressed!(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title!,
            style: TextStyle(
              fontSize: 15.sp,
              color: ThemeBuilder.of(context)?.getCurrentTheme() ==
                      Brightness.light
                  ? Colors.black
                  : Colors.white,
              fontFamily: "Gilroy-Regular",
            ),
          ),
          title == "KYC Status"
              ? Row(
                  children: [
                    buildVerifiedWidget(Modular.get<VendorService>()
                        .vendorDetails!
                        .isNinVerified!),
                    SizedBox(width: 10.w),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: ThemeBuilder.of(context)?.getCurrentTheme() ==
                              Brightness.light
                          ? Colors.black
                          : Colors.white,
                    ),
                  ],
                )
              : Icon(
                  Icons.arrow_forward_ios,
                  color: ThemeBuilder.of(context)?.getCurrentTheme() ==
                          Brightness.light
                      ? Colors.black
                      : Colors.white,
                )
        ],
      ),
    );
  }

  Widget buildVerifiedWidget(bool isVerified) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 13, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: isVerified
            ? Color.fromRGBO(23, 206, 137, 0.1)
            : Color.fromRGBO(228, 44, 102, 0.1),
      ),
      child: Row(
        children: [
          CircleAvatar(
            child: Icon(
              isVerified ? Icons.check : Icons.close_rounded,
              size: 18,
              color: Colors.white,
            ),
            radius: 12,
            backgroundColor: isVerified
                ? Color.fromRGBO(0, 168, 105, 1)
                : Color.fromRGBO(228, 44, 102, 1),
          ),
          SizedBox(width: 10),
          TEXT(
            text: isVerified ? 'Verified' : 'Unverified',
            fontFamily: 'Gilroy-medium',
            color: isVerified
                ? Color.fromRGBO(0, 168, 105, 1)
                : Color.fromRGBO(228, 44, 102, 1),
            edgeInset: EdgeInsets.zero,
          )
        ],
      ),
    );
  }
}
