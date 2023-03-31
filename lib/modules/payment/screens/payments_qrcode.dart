import 'package:CHATS_Vendor/Utils/colors.dart';
import 'package:CHATS_Vendor/theme_changer.dart';
import 'package:CHATS_Vendor/ui/shared/BTN.dart';
import 'package:CHATS_Vendor/ui/shared/TEXT.dart';
import 'package:CHATS_Vendor/ui/shared/ui_helper.dart';
import 'package:CHATS_Vendor/ui/widgets/error_widget_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_flutter/qr_flutter.dart';

class PaymentQRCodeView extends StatefulWidget {
  const PaymentQRCodeView({Key? key, this.qrData}) : super(key: key);

  final String? qrData;
  @override
  _PaymentQRCodeViewState createState() => _PaymentQRCodeViewState();
}

class _PaymentQRCodeViewState extends State<PaymentQRCodeView> {
  // ScanResult? _result;
  @override
  Widget build(BuildContext context) {
    // double width = MediaQuery.of(context).size.width;
    // var orientation = MediaQuery.of(context).orientation;
    // BeneficiaryUser? user = locator<UserService>().data;

    print({"QR COde String", widget.qrData});
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
            text: 'Payments - QR Code',
            fontFamily: 'Gilroy-medium',
            fontSize: 22.sp,
            color:
                ThemeBuilder.of(context)?.getCurrentTheme() == Brightness.light
                    ? Colors.black
                    : Colors.white,
          ),
          leading: GestureDetector(
            onTap: () {
              Modular.to.pop(context);
            },
            child: Icon(Icons.arrow_back_ios,
                color: ThemeBuilder.of(context)?.getCurrentTheme() ==
                        Brightness.light
                    ? Colors.black
                    : Colors.white),
          ),
        ),
        body: FutureBuilder(
          // future: locator<UserService>().getPaymentDetails(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container(
                  color: ThemeBuilder.of(context)?.getCurrentTheme() ==
                          Brightness.light
                      ? Colors.white
                      : primaryColorDarkMode,
                  child: Center(child: CircularProgressIndicator()));
            }

            if (snapshot.hasError) {
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
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 40.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        style: BorderStyle.solid,
                        color: Color.fromRGBO(23, 206, 137, 1),
                      ),
                      color: Color.fromRGBO(250, 250, 250, 1),
                    ),
                    child: QrImage(
                      data: widget.qrData!,
                      version: QrVersions.auto,
                      // size: 320,
                      gapless: false,
                      errorStateBuilder: (cxt, err) {
                        return Container(
                          child: Center(
                            child: TEXT(
                              text: "Could not generate the QR Code",
                              textAlign: TextAlign.center,
                              color:
                                  ThemeBuilder.of(context)?.getCurrentTheme() ==
                                          Brightness.light
                                      ? Colors.black
                                      : Colors.white,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 20.h),
                  TEXT(
                    text:
                        'QR code should be scanned from a beneficiary app, in other to carry out payment.',
                    textAlign: TextAlign.center,
                    fontFamily: 'Gilroy-medium',
                    fontSize: 21.sp,
                    color: ThemeBuilder.of(context)?.getCurrentTheme() ==
                            Brightness.light
                        ? Colors.black
                        : Colors.white,
                  ),
                  SizedBox(height: 50.h),
                  BTN(
                    margin: EdgeInsets.zero,
                    onTap: () async {
                      print('Save Qr image and transaction');
                      // await Modular.get<StoreService>().refresh();
                      Modular.to.navigate('/home/');
                    },
                    child: TEXT(
                      color: Colors.white,
                      text: "Done",
                      fontSize: 18,
                      fontFamily: 'Gilroy-bold',
                      edgeInset: EdgeInsets.zero,
                      textAlign: TextAlign.center,
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
}
