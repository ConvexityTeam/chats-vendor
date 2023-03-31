import 'package:CHATS_Vendor/ui/shared/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BTN extends StatefulWidget {
  BTN({
    Key? key,
    this.bgColor,
    this.loadColor,
    this.children,
    this.child,
    required this.onTap,
    this.mainAxisAlignment,
    this.margin,
    this.padding,
    this.borderRadius,
    this.borderColor,
    this.useOverlay = false,
    this.height,
    this.disabled = false,
  }) : super(key: key);

  final Color? bgColor;
  final Color? loadColor;
  final List<Widget>? children;
  final Widget? child;
  final MainAxisAlignment? mainAxisAlignment;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final double? borderRadius;
  final Color? borderColor;
  final bool? useOverlay;
  final double? height;
  final bool? disabled;
  final Function() onTap;

  @override
  State<BTN> createState() => _BTNState();
}

class _BTNState extends State<BTN> {
  bool loading = false;

  startLoading() => setState(() {
        loading = true;
      });
  stopLoading() => setState(() {
        loading = false;
      });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: widget.padding ?? EdgeInsets.symmetric(horizontal: 10.w),
      margin: widget.margin ?? EdgeInsets.zero,
      height: widget.height ?? 52.h,
      decoration: BoxDecoration(
        boxShadow: [
          // BoxShadow(color: CustomColors.subColor.withGreen(150), spreadRadius: 0.2, blurRadius: 5.0, offset: Offset(1, 1)),
          // BoxShadow(color: CustomColors.subColor.withGreen(150), spreadRadius: .2, blurRadius: 5.0, offset: Offset(1, 1)),
        ],
        color: (widget.disabled! || loading)
            ? Constants.hintColor
            : widget.bgColor ?? Constants.usedGreen,
        borderRadius: BorderRadius.circular(widget.borderRadius ?? 8.0.r),
        border: widget.borderColor != null
            ? Border.all(color: widget.borderColor!)
            : null,
      ),
      child: InkWell(
        overlayColor: widget.useOverlay != null && widget.useOverlay!
            ? MaterialStateProperty.all(Colors.grey)
            : MaterialStateProperty.all(Colors.transparent),
        onTap: () async {
          if (widget.disabled! || loading) return;
          if (widget.children != null) {
            await widget.onTap();
            return;
          }
          this.startLoading();
          await widget.onTap();
          this.stopLoading();
        },
        child: Row(
          // children: widget.children!,
          children: widget.child != null
              ? [
                  Expanded(child: widget.child!),
                  SizedBox(
                    height: loading ? 18 : 0,
                    width: loading ? 18 : 0,
                    child: loading
                        ? CircularProgressIndicator(
                            strokeWidth: 2,
                            color: widget.loadColor ?? Colors.white,
                          )
                        : SizedBox.shrink(),
                  )
                ]
              : widget.children!,
          mainAxisAlignment:
              widget.mainAxisAlignment ?? MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
        ),
      ),
    );
  }
}

// class BTN extends StatelessWidget {
//   BTN({
//     this.bgColor,
//     this.height,
//     required this.children,
//     required this.onTap,
//     this.mainAxisAlignment,
//     this.margin,
//     this.padding,
//     this.borderRadius,
//     this.borderColor,
//   });

//   final Color? bgColor;
//   final double? height;
//   final List<Widget> children;
//   final MainAxisAlignment? mainAxisAlignment;
//   final EdgeInsets? margin;
//   final EdgeInsets? padding;
//   final double? borderRadius;
//   final Color? borderColor;
//   final Function()? onTap;
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: height,
//       child: InkWell(
//         onTap: onTap,
//         child: Row(
//           children: children,
//           mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.spaceEvenly,
//           crossAxisAlignment: CrossAxisAlignment.center,
//         ),
//       ),
//       padding: padding ?? EdgeInsets.all(14),
//       margin: margin ?? EdgeInsets.all(14),
//       decoration: BoxDecoration(
//         boxShadow: [
//           // BoxShadow(color: CustomColors.subColor.withGreen(150), spreadRadius: 0.2, blurRadius: 5.0, offset: Offset(1, 1)),
//           // BoxShadow(color: CustomColors.subColor.withGreen(150), spreadRadius: .2, blurRadius: 5.0, offset: Offset(1, 1)),
//         ],
//         color: bgColor ?? Constants.usedGreen,
//         borderRadius: BorderRadius.circular(borderRadius ?? 8.0),
//         border: Border.all(color: borderColor ?? Colors.transparent),
//       ),
//     );
//   }
// }
