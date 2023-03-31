import 'package:CHATS_Vendor/Utils/colors.dart';
import 'package:CHATS_Vendor/core/services/vendor_service.dart';
import 'package:CHATS_Vendor/theme_changer.dart';
import 'package:CHATS_Vendor/ui/shared/BTN.dart';
import 'package:CHATS_Vendor/ui/shared/TEXT.dart';
import 'package:CHATS_Vendor/ui/shared/TF.dart';
import 'package:CHATS_Vendor/ui/shared/ui_helper.dart';
import 'package:CHATS_Vendor/ui/widgets/custom_dialog.dart';
import 'package:CHATS_Vendor/ui/widgets/error_widget_handler.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PaymentConfirmView extends StatefulWidget {
  const PaymentConfirmView({Key? key, this.beneficiaryData}) : super(key: key);
  final Map? beneficiaryData;

  @override
  _PaymentConfirmViewState createState() => _PaymentConfirmViewState();
}

class _PaymentConfirmViewState extends State<PaymentConfirmView> {
  late TextEditingController _beneficiaryController;
  late TextEditingController _campaignController;
  late TextEditingController _balanceController;
  late TextEditingController _pinController;

  @override
  void initState() {
    super.initState();
    _beneficiaryController = TextEditingController(
        text: widget.beneficiaryData?['Beneficiary']['name']);
    _campaignController =
        TextEditingController(text: widget.beneficiaryData?['CampaignTitle']);
    _balanceController = TextEditingController(
        text: widget.beneficiaryData?['balance'].toString());
    _pinController = TextEditingController(text: '');
  }

  @override
  Widget build(BuildContext context) {
    // double width = MediaQuery.of(context).size.width;
    // var orientation = MediaQuery.of(context).orientation;
    print({widget.beneficiaryData});
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
            text: 'Confirm Payment',
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
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TF(
                      controller: _beneficiaryController,
                      enabled: false,
                      label: TEXT(
                        text: 'Beneficiary',
                        color: ThemeBuilder.of(context)?.getCurrentTheme() ==
                                Brightness.light
                            ? Colors.black
                            : Colors.white,
                        // fontWeight: FontWeight.bold,
                        fontFamily: 'Gilroy-medium',
                      ),
                    ),
                    TF(
                      controller: _campaignController,
                      enabled: false,
                      label: TEXT(
                        text: 'Campaign',
                        color: ThemeBuilder.of(context)?.getCurrentTheme() ==
                                Brightness.light
                            ? Colors.black
                            : Colors.white,
                        // fontWeight: FontWeight.bold,
                        fontFamily: 'Gilroy-medium',
                      ),
                    ),
                    TF(
                      controller: _balanceController,
                      enabled: false,
                      label: TEXT(
                        text: 'Balance',
                        color: ThemeBuilder.of(context)?.getCurrentTheme() ==
                                Brightness.light
                            ? Colors.black
                            : Colors.white,
                        // fontWeight: FontWeight.bold,
                        fontFamily: 'Gilroy-medium',
                      ),
                    ),
                    TF(
                      isPassword: true,
                      controller: _pinController,
                      label: TEXT(
                        text: 'Enter PIN',
                        color: ThemeBuilder.of(context)?.getCurrentTheme() ==
                                Brightness.light
                            ? Colors.black
                            : Colors.white,
                        // fontWeight: FontWeight.bold,
                        fontFamily: 'Gilroy-medium',
                      ),
                    ),
                    // SizedBox(height: 20),
                    BTN(
                      margin: EdgeInsets.zero,
                      onTap: () async {
                        // Call service to check token and get returned data
                        print({
                          "Called the service for SMS token",
                          _beneficiaryController.text,
                          _campaignController.text,
                          _pinController.text,
                          _balanceController.text
                        });

                        var resp = await Modular.get<VendorService>()
                            .confirmPayment(
                                widget.beneficiaryData?["reference"],
                                _pinController.text,
                                widget.beneficiaryData?["Beneficiary"]["id"]);

                        await finishTransaction(resp ?? {});
                        // Navigator.pushNamed(context, Routes.paymentQRCode,
                        //     arguments: '${snapshot.data?["reference"]}');
                      },
                      loadColor: Colors.white,
                      child: Center(
                        child: TEXT(
                          color: Colors.white,
                          text: "Confirm Payment",
                          fontSize: 18.sp,
                          fontFamily: 'Gilroy-bold',
                          edgeInset: EdgeInsets.zero,
                        ),
                      ),
                      // style: ButtonStyle(),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  finishTransaction(Map result) async {
    if (kDebugMode) print({"TRANSACTION RESULT", result});
    final dialogResult = await DialogUtils.showAppResultDialog(context,
        result: result, onRetryTapped: () => Modular.to.pop(false));
    if (kDebugMode) print({"TRANSACTION RESULT", dialogResult});
    if (dialogResult) {
      Modular.to.navigate('/home/');
    } else {
      if (kDebugMode) print({'RETRY', dialogResult});
    }
  }
}
