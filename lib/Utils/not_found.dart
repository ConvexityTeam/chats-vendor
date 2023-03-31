import 'package:CHATS_Vendor/ui/shared/TEXT.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotFoundWidget extends StatelessWidget {
  const NotFoundWidget({Key? key, this.path});
  final String? path;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: Center(
          child: TEXT(
            text: 'Page does not exist yet\nroute: $path',
            fontSize: 26.sp,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
