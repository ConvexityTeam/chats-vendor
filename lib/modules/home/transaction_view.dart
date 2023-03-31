import 'package:CHATS_Vendor/Utils/colors.dart';
import 'package:CHATS_Vendor/core/services/vendor_service.dart';
import 'package:CHATS_Vendor/theme_changer.dart';
import 'package:CHATS_Vendor/ui/shared/TEXT.dart';
import 'package:CHATS_Vendor/ui/widgets/error_widget_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TransactionView extends StatefulWidget {
  @override
  State<TransactionView> createState() => _TransactionViewState();
}

class _TransactionViewState extends State<TransactionView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor:
            ThemeBuilder.of(context)?.getCurrentTheme() == Brightness.light
                ? Colors.white
                : primaryColorDarkMode,
        centerTitle: false,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Image.asset(
            "icons/arrow_back.png",
            color:
                ThemeBuilder.of(context)?.getCurrentTheme() == Brightness.light
                    ? Colors.black
                    : Colors.white,
          ),
        ),
        title: TEXT(
          text: "Transactions",
          color: ThemeBuilder.of(context)?.getCurrentTheme() == Brightness.light
              ? Colors.black
              : Colors.white,
          fontFamily: "Gilroy-medium",
          fontSize: 22.sp,
        ),
      ),
      body: FutureBuilder(
        future: Modular.get<VendorService>().retrieveTransactions('yearly'),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }

          if (snapshot.hasError) {
            return ErrorWidgetHandler(onTap: () {
              setState(() {});
            });
          }

          if (Modular.get<VendorService>().history == null ||
              Modular.get<VendorService>().history?.transactions?.count == 0) {
            return Center(
              child: TEXT(
                text: 'You have no transactions at this time',
                color: ThemeBuilder.of(context)!.getCurrentTheme() ==
                        Brightness.light
                    ? Colors.black
                    : Colors.white,
              ),
            );
          }
          return Container(
            height: double.infinity,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
            color:
                ThemeBuilder.of(context)!.getCurrentTheme() == Brightness.light
                    ? Color.fromRGBO(250, 250, 250, 1)
                    : primaryColorDarkMode,
            child: Column(
              children: [
                SizedBox(height: 25.h),
                Expanded(
                  child: ListView.separated(
                    reverse: false,
                    itemBuilder: (context, int index) => buildTransactionCard(
                        Modular.get<VendorService>()
                            .history!
                            .transactions!
                            .rows
                            ?.reversed
                            .toList()[index]),
                    separatorBuilder: (context, int index) => Divider(
                      height: 20.h,
                      thickness: 1,
                    ),
                    itemCount: Modular.get<VendorService>()
                        .history!
                        .transactions!
                        .rows!
                        .length,
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Widget buildTransactionCard(Map? item) {
    return ListTile(
      leading: Container(
        height: 56.w,
        width: 56.w,
        decoration: BoxDecoration(
          color: Color.fromRGBO(240, 240, 240, 0.4),
          borderRadius: BorderRadius.all(
            Radius.circular(5.r),
          ),
        ),
        child: Center(
          child: TEXT(
            text: (item?['narration'] as String)[0],
            color:
                ThemeBuilder.of(context)!.getCurrentTheme() == Brightness.light
                    ? Colors.black
                    : Colors.white,
            fontSize: 18.sp,
            fontFamily: "Gilroy-medium",
          ),
        ),
      ),
      trailing: TEXT(
        text: "${item?['amount']}",
        color: ThemeBuilder.of(context)!.getCurrentTheme() == Brightness.light
            ? Color(0xff333333)
            : Colors.white,
      ),
      subtitle: TEXT(
        text:
            "${DateTime.parse(item?['createdAt']).toString().substring(0, 11)}",
        fontSize: 11.sp,
        color: ThemeBuilder.of(context)!.getCurrentTheme() == Brightness.light
            ? Color(0xff333333)
            : Colors.white,
      ),
      title: TEXT(
        text: "${item?['narration']}",
        color: ThemeBuilder.of(context)!.getCurrentTheme() == Brightness.light
            ? Color(0xff333333)
            : Colors.white,
      ),
    );
  }
}
