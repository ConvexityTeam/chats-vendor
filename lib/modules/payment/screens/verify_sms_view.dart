import 'package:CHATS_Vendor/Utils/colors.dart';
import 'package:CHATS_Vendor/core/services/vendor_service.dart';
import 'package:CHATS_Vendor/theme_changer.dart';
import 'package:CHATS_Vendor/ui/shared/BTN.dart';
import 'package:CHATS_Vendor/ui/shared/TEXT.dart';
import 'package:CHATS_Vendor/ui/shared/TF.dart';
import 'package:CHATS_Vendor/ui/shared/ui_helper.dart';
import 'package:CHATS_Vendor/ui/widgets/error_widget_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VerifySMSView extends StatefulWidget {
  const VerifySMSView({Key? key, this.qrData}) : super(key: key);
  final String? qrData;

  @override
  _VerifySMSViewState createState() => _VerifySMSViewState();
}

class _VerifySMSViewState extends State<VerifySMSView> {
  @override
  Widget build(BuildContext context) {
    // double width = MediaQuery.of(context).size.width;
    // var orientation = MediaQuery.of(context).orientation;
    return WillPopScope(
      onWillPop: () => onBackPressed(context),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          elevation: 0,
          backgroundColor:
              ThemeBuilder.of(context)?.getCurrentTheme() == Brightness.light
                  ? Colors.white
                  : primaryColorDarkMode,
          title: TEXT(
            text: 'Verify SMS Token',
            fontFamily: 'Gilroy-medium',
            fontSize: 22.sp,
            edgeInset: EdgeInsets.only(top: 3),
            color:
                ThemeBuilder.of(context)?.getCurrentTheme() == Brightness.light
                    ? Colors.black
                    : Colors.white,
          ),
          leading: GestureDetector(
            onTap: () {
              Modular.to.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: ThemeBuilder.of(context)?.getCurrentTheme() ==
                      Brightness.light
                  ? Colors.black
                  : Colors.white,
            ),
          ),
        ),
        body: FutureBuilder(
          future: null,
          // locator<StoreService>()
          //     .createOrder(widget.cartData?[0], widget.cartData?[1]),
          initialData: <String, dynamic>{},
          builder: (context, AsyncSnapshot<dynamic> snapshot) {
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
              return ErrorWidgetHandler(onTap: () {
                setState(() {});
              });
            }

            if (snapshot.data is String) {
              return ErrorWidgetHandler(onTap: () {
                setState(() {});
              });
            }

            return Container(
              color: ThemeBuilder.of(context)?.getCurrentTheme() ==
                      Brightness.light
                  ? Colors.white
                  : primaryColorDarkMode,
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
              child: Column(
                children: [
                  TF(
                    controller: _smsTokenTFController,
                    label: TEXT(
                      text: 'Enter SMS token',
                      color: ThemeBuilder.of(context)?.getCurrentTheme() ==
                              Brightness.light
                          ? Colors.black
                          : Colors.white,
                      // fontWeight: FontWeight.bold,
                      fontFamily: 'Gilroy-medium',
                      fontSize: 21.sp,
                    ),
                  ),
                  // SizedBox(height: 20),
                  BTN(
                    margin: EdgeInsets.zero,
                    onTap: () async {
                      // Call service to check token and get returned data
                      print({
                        "Called the service for SMS token",
                        _smsTokenTFController.text
                      });

                      Map? resp = await Modular.get<VendorService>()
                          .verifySMSToken(_smsTokenTFController.text);

                      Modular.to.pushNamed(
                        '/payment/confirm',
                        arguments: {
                          "CampaignId": resp?["CampaignId"],
                          "CampaignTitle": resp?["Campaign_title"],
                          "Beneficiary": {
                            "id": resp?["Beneficiary"]["id"],
                            "name":
                                "${resp?['Beneficiary']['first_name'] ?? ''} ${resp?['Beneficiary']['last_name'] ?? ''}"
                          },
                          "balance": resp?["Approve_to_spend"].toString(),
                          "reference": widget.qrData,
                        },
                      );
                    },
                    loadColor: Colors.white,
                    child: Center(
                      child: TEXT(
                        color: Colors.white,
                        text: "Verify token",
                        fontSize: 18.sp,
                        fontFamily: 'Gilroy-bold',
                        edgeInset: EdgeInsets.zero,
                      ),
                    ),
                    // style: ButtonStyle(),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  TextEditingController _smsTokenTFController = TextEditingController(text: '');
}
