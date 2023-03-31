import 'package:CHATS_Vendor/Utils/colors.dart';
import 'package:CHATS_Vendor/theme_changer.dart';
import 'package:CHATS_Vendor/ui/shared/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottomDrawer extends StatelessWidget {
  const BottomDrawer({
    Key? key,
    this.toggleVisible,
    this.child,
    required this.height,
  }) : super(key: key);

  final Function()? toggleVisible;
  final Widget? child;
  final double height;

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: Duration(milliseconds: 260),
      curve: Curves.easeIn,
      bottom: height,
      right: 0,
      left: 0,
      height: MediaQuery.of(context).size.height * .45,
      child: Container(
        clipBehavior: Clip.hardEdge,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 30.h, horizontal: 20.h),
          child: child,
        ),
        decoration: BoxDecoration(
          color: ThemeBuilder.of(context)?.getCurrentTheme() == Brightness.light
              ? Colors.white
              : primaryColorDarkMode,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
          border: Border.all(color: Constants.usedGreen),
        ),
      ),
    );
  }
}
