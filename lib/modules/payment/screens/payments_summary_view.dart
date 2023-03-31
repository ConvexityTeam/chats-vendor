import 'dart:convert';

import 'package:CHATS_Vendor/Utils/colors.dart';
// import 'package:CHATS_Vendor/core/services/store_service.dart';
// import 'package:CHATS_Vendor/locator.dart';
import 'package:CHATS_Vendor/theme_changer.dart';
import 'package:CHATS_Vendor/ui/shared/BTN.dart';
import 'package:CHATS_Vendor/ui/shared/TEXT.dart';
import 'package:CHATS_Vendor/ui/shared/ui_helper.dart';
import 'package:CHATS_Vendor/ui/widgets/bottom_drawer.dart';
import 'package:CHATS_Vendor/ui/widgets/error_widget_handler.dart';
import 'package:CHATS_Vendor/ui/widgets/tag.dart';
import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jiffy/jiffy.dart';
// import 'package:nfc_manager/nfc_manager.dart';
import 'package:snack/snack.dart';

class PaymentSummaryView extends StatefulWidget {
  const PaymentSummaryView({
    Key? key,
    this.order,
  }) : super(key: key);

  final Map<String, dynamic>? order;

  @override
  _PaymentSummaryViewState createState() => _PaymentSummaryViewState();
}

class _PaymentSummaryViewState extends State<PaymentSummaryView> {
  late double visibleHeight;
  bool _scanDone = false;
  ScanResult? _result;
  String? _selectedAction = 'qr_code_gen';

  // void toggleVisibility(Function setState) {
  //   setState(() {
  //     visibleHeight =
  //         visibleHeight == 0 ? -(MediaQuery.of(context).size.height * .45) : 0;
  //   });
  // }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    visibleHeight = -(MediaQuery.of(context).size.height * .45);
  }

  @override
  Widget build(BuildContext context) {
    // double width = MediaQuery.of(context).size.width;
    // var orientation = MediaQuery.of(context).orientation;
    // BeneficiaryUser? user = locator<UserService>().data;

    print({"Summary", widget.order});
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
            text: 'Payments Summary',
            fontFamily: 'Gilroy-medium',
            fontSize: 22.sp,
            edgeInset: EdgeInsets.zero,
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
          initialData: widget.order,
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

            return StatefulBuilder(builder: (context, setState) {
              return Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    color: ThemeBuilder.of(context)?.getCurrentTheme() ==
                            Brightness.light
                        ? Colors.white
                        : primaryColorDarkMode,
                    padding:
                        EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 30),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                style: BorderStyle.solid,
                                color: Color.fromRGBO(124, 141, 181, 1),
                              ),
                              color: Color.fromRGBO(245, 246, 248, 1),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          TEXT(
                                            text: 'AMOUNT TO BE PAID',
                                            fontSize: 12,
                                            fontFamily: 'Gilroy-regular',
                                            textAlign: TextAlign.left,
                                            color: Color.fromRGBO(
                                                124, 141, 181, 1),
                                          ),
                                          TEXT(
                                            text:
                                                'NGN ${snapshot.data?["Cart"]?.fold(0, (prevValue, elem) => (prevValue + elem['total_amount'])).toStringAsFixed(2) ?? '0.00'}',
                                            fontSize: 18,
                                            fontFamily: 'Gilroy-medium',
                                            textAlign: TextAlign.left,
                                            color:
                                                Color.fromRGBO(37, 57, 111, 1),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          TEXT(
                                            text: 'TRANSACTION ID',
                                            fontSize: 12,
                                            fontFamily: 'Gilroy-regular',
                                            textAlign: TextAlign.left,
                                            color: Color.fromRGBO(
                                                124, 141, 181, 1),
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: TEXT(
                                                  text:
                                                      '${snapshot.data?["reference"] ?? 'CHATSQR'}',
                                                  fontSize: 18,
                                                  fontFamily: 'Gilroy-medium',
                                                  textAlign: TextAlign.left,
                                                  color: Color.fromRGBO(
                                                      37, 57, 111, 1),
                                                  softWrap: true,
                                                  textOverflow:
                                                      TextOverflow.visible,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 24),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TEXT(
                                          text: 'GENERATED ON',
                                          fontSize: 12,
                                          fontFamily: 'Gilroy-regular',
                                          textAlign: TextAlign.left,
                                          color:
                                              Color.fromRGBO(124, 141, 181, 1),
                                        ),
                                        TEXT(
                                          text:
                                              '${Jiffy(snapshot.data?["createdAt"]).format('do MMM, yyy. h:mm a')}',
                                          fontSize: 18,
                                          fontFamily: 'Gilroy-medium',
                                          textAlign: TextAlign.left,
                                          color: Color.fromRGBO(37, 57, 111, 1),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(height: 24),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          TEXT(
                                            text: 'STATUS',
                                            fontSize: 12,
                                            fontFamily: 'Gilroy-regular',
                                            textAlign: TextAlign.left,
                                            color: Color.fromRGBO(
                                                124, 141, 181, 1),
                                          ),
                                          tag(snapshot.data?["status"] ??
                                              'pending')
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          TEXT(
                                            text: '',
                                            fontSize: 12,
                                            fontFamily: 'Gilroy-regular',
                                            textAlign: TextAlign.left,
                                            color: Color.fromRGBO(
                                                124, 141, 181, 1),
                                          ),
                                          TEXT(
                                            text: '',
                                            fontSize: 18,
                                            fontFamily: 'Gilroy-medium',
                                            textAlign: TextAlign.left,
                                            color:
                                                Color.fromRGBO(37, 57, 111, 1),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 30),
                          Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                      color: Colors.blueGrey.withOpacity(.7)),
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                                padding: EdgeInsets.symmetric(
                                    vertical: 8.h, horizontal: 12.w),
                                margin: EdgeInsets.only(bottom: 10.h),
                                child: Row(
                                  children: [
                                    Container(
                                      height: 30,
                                      width: 30,
                                      alignment: Alignment.center,
                                      child: SizedBox.expand(
                                        child: FittedBox(
                                          fit: BoxFit.fill,
                                          child: Image.asset(
                                            "assets/icons/gen_qr_code.png",
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10.w),
                                    Expanded(
                                      child: TEXT(
                                        text: "Generate QR Code",
                                        color: Color.fromRGBO(37, 57, 111, 1),
                                        fontSize: 18.sp,
                                        fontFamily: 'Gilroy-bold',
                                        softWrap: false,
                                        maxLines: 1,
                                        textOverflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Radio(
                                      value: 'qr_code_gen',
                                      groupValue: _selectedAction,
                                      activeColor: Constants.usedGreen,
                                      fillColor:
                                          _selectedAction == 'qr_code_gen'
                                              ? MaterialStateProperty.all(
                                                  Constants.usedGreen)
                                              : MaterialStateProperty.all(
                                                  Colors.blueGrey),
                                      onChanged: (String? value) {
                                        if (kDebugMode)
                                          print({value, "Option value"});
                                        setState(() {
                                          _selectedAction = value!;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                      color: Colors.blueGrey.withOpacity(.7)),
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                                padding: EdgeInsets.symmetric(
                                    vertical: 8.h, horizontal: 12.w),
                                margin: EdgeInsets.only(bottom: 10.h),
                                child: Row(
                                  children: [
                                    Container(
                                      height: 30,
                                      width: 30,
                                      alignment: Alignment.center,
                                      child: SizedBox.expand(
                                        child: FittedBox(
                                          fit: BoxFit.fill,
                                          child: Image.asset(
                                            "assets/icons/scan_qr_code.png",
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10.w),
                                    Expanded(
                                      child: TEXT(
                                        text: "Scan QR Code",
                                        color: Color.fromRGBO(37, 57, 111, 1),
                                        fontSize: 18.sp,
                                        fontFamily: 'Gilroy-bold',
                                        softWrap: false,
                                        maxLines: 1,
                                        textOverflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Radio(
                                      value: 'qr_code_scan',
                                      groupValue: _selectedAction,
                                      activeColor: Constants.usedGreen,
                                      fillColor:
                                          _selectedAction == 'qr_code_scan'
                                              ? MaterialStateProperty.all(
                                                  Constants.usedGreen)
                                              : MaterialStateProperty.all(
                                                  Colors.blueGrey),
                                      onChanged: (String? value) {
                                        if (kDebugMode)
                                          print({value, "Option value"});
                                        setState(() {
                                          _selectedAction = value!;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                      color: Colors.blueGrey.withOpacity(.7)),
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                                padding: EdgeInsets.symmetric(
                                    vertical: 8.h, horizontal: 12.w),
                                margin: EdgeInsets.only(bottom: 10.h),
                                child: Row(
                                  children: [
                                    Container(
                                      height: 30,
                                      width: 30,
                                      alignment: Alignment.center,
                                      child: SizedBox.expand(
                                        child: FittedBox(
                                          fit: BoxFit.fill,
                                          child: Image.asset(
                                            "assets/icons/sms_token.png",
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10.w),
                                    Expanded(
                                      child: TEXT(
                                        text: "Verify SMS Token",
                                        color: Color.fromRGBO(37, 57, 111, 1),
                                        fontSize: 18,
                                        fontFamily: 'Gilroy-bold',
                                        softWrap: false,
                                        maxLines: 1,
                                        textOverflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Radio(
                                      value: 'sms_token',
                                      groupValue: _selectedAction,
                                      activeColor: Constants.usedGreen,
                                      fillColor: _selectedAction == 'sms_token'
                                          ? MaterialStateProperty.all(
                                              Constants.usedGreen)
                                          : MaterialStateProperty.all(
                                              Colors.blueGrey),
                                      onChanged: (String? value) {
                                        if (kDebugMode)
                                          print({value, "Option value"});
                                        setState(() {
                                          _selectedAction = value!;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                      color: Colors.blueGrey.withOpacity(.7)),
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                                padding: EdgeInsets.symmetric(
                                    vertical: 8.h, horizontal: 12.w),
                                margin: EdgeInsets.only(bottom: 10.h),
                                child: Row(
                                  children: [
                                    Container(
                                      height: 30,
                                      width: 30,
                                      alignment: Alignment.center,
                                      child: SizedBox.expand(
                                        child: FittedBox(
                                          fit: BoxFit.fill,
                                          child: Image.asset(
                                            "assets/icons/nfc_card.png",
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10.w),
                                    Expanded(
                                      child: TEXT(
                                        text: "Tap NFC Card",
                                        color: Color.fromRGBO(37, 57, 111, 1),
                                        fontSize: 18,
                                        fontFamily: 'Gilroy-bold',
                                        softWrap: false,
                                        maxLines: 1,
                                        textOverflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Radio(
                                      value: 'nfc_card',
                                      groupValue: _selectedAction,
                                      activeColor: Constants.usedGreen,
                                      fillColor: _selectedAction == 'nfc_card'
                                          ? MaterialStateProperty.all(
                                              Constants.usedGreen)
                                          : MaterialStateProperty.all(
                                              Colors.blueGrey),
                                      onChanged: (String? value) {
                                        if (kDebugMode)
                                          print({value, "Option value"});
                                        setState(() {
                                          _selectedAction = value!;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20.h),
                          BTN(
                              margin: EdgeInsets.zero,
                              onTap: () async {
                                // Check the action selected and continue based on action
                                switch (_selectedAction) {
                                  case 'qr_code_gen':
                                    Modular.to.pushNamed('/payment/gen_qrcode',
                                        arguments:
                                            '${snapshot.data?["reference"]}');
                                    break;
                                  case 'qr_code_scan':
                                    await _scan();
                                    Map scanData = {
                                      "CampaignId": 0,
                                      "CampaignTitle": "",
                                      "Beneficiary": {},
                                      "balance": 0,
                                      "reference": ""
                                    };

                                    print({
                                      _result!.format,
                                      _result!.formatNote,
                                      _result!.rawContent,
                                      _result!.type,
                                    });

                                    // if (kDebugMode) {
                                    //   scanData = {
                                    //     "CampaignId": "uniqueCampaignId",
                                    //     "CampaignTitle": "Campaign TItle",
                                    //     "Beneficiary": {
                                    //       "id": "uniqueId",
                                    //       "name": "Test User"
                                    //     },
                                    //     "balance": "2000",
                                    //     "reference": snapshot.data?["reference"],
                                    //   };
                                    // } else {
                                    var decodedQRData =
                                        jsonDecode(_result!.rawContent);
                                    print(
                                        {"DECODED OBJECT", decodedQRData.keys});
                                    scanData["CampaignId"] =
                                        decodedQRData["Campaign"]["id"];
                                    scanData["CampaignTitle"] =
                                        decodedQRData["Campaign"]["title"];
                                    scanData["Beneficiary"]["id"] =
                                        decodedQRData["Beneficiary"]["id"];
                                    scanData["Beneficiary"]["name"] =
                                        decodedQRData["Beneficiary"]["name"];
                                    scanData["balance"] =
                                        decodedQRData["amount"];
                                    scanData["reference"] =
                                        snapshot.data?["reference"];
                                    // }

                                    if (_result!.type.name != 'Cancelled') {
                                      //for test
                                      Modular.to.pushNamed(
                                        '/payment/confirm',
                                        arguments: scanData,
                                      );
                                    } else {
                                      var snackBar = SnackBar(
                                        content: Text(
                                          _result!.type.name == 'Cancelled'
                                              ? 'The scan has been cancelled'
                                              : 'There was an issue getting the QR code result',
                                          // color:
                                          //     ThemeBuilder.of(context)!.getCurrentTheme() ==
                                          //             Brightness.light
                                          //         ? Colors.white
                                          //         : Colors.black,
                                        ),
                                      );
                                      snackBar.show(context);
                                      return;
                                    }
                                    break;

                                  case 'sms_token':
                                    Modular.to.pushNamed(
                                      '/payment/sms_token',
                                      arguments:
                                          '${snapshot.data?["reference"]}',
                                    );
                                    break;

                                  case 'nfc_card':
                                    // TODO: Add nfc card functionality here

                                    setState(() {
                                      visibleHeight = visibleHeight == 0
                                          ? -(MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              .45)
                                          : 0;
                                    });
                                    bool isScanned = await _nfcStartSession();
                                    setState(() {
                                      _scanDone = isScanned;
                                    });
                                    break;
                                  default:
                                }
                              },
                              children: [
                                TEXT(
                                  color: Colors.white,
                                  text: "Continue",
                                  fontSize: 18.sp,
                                  fontFamily: 'Gilroy-bold',
                                  edgeInset: EdgeInsets.zero,
                                  textAlign: TextAlign.center,
                                ),
                              ]
                              // style: ButtonStyle(),
                              ),
                        ],
                      ),
                    ),
                  ),
                  BottomDrawer(
                    height: visibleHeight,
                    child: _scanDone
                        ? Column(
                            children: [
                              Image.asset(
                                'assets/icons/nfc_read_session_done.png',
                                width: 140.w,
                                height: 140.h,
                              ),
                              Spacer(),
                              BTN(
                                onTap: () {
                                  // _nfcStopSession();
                                  setState(() {
                                    _scanDone = false;
                                    visibleHeight = visibleHeight == 0
                                        ? -(MediaQuery.of(context).size.height *
                                            .45)
                                        : 0;
                                  });
                                },
                                child: TEXT(
                                  text: 'Done',
                                  fontFamily: 'Gilroy-bold',
                                  textAlign: TextAlign.center,
                                ),
                                bgColor: Constants.usedGreen,
                              )
                            ],
                          )
                        : Column(
                            children: [
                              TEXT(
                                text: 'Ready to Scan',
                                fontSize: 20.sp,
                                fontFamily: 'Gilroy-bold',
                              ),
                              SizedBox(height: 20.h),
                              Image.asset(
                                'assets/icons/nfc_read_session.png',
                                width: 140.w,
                                height: 140.h,
                              ),
                              SizedBox(height: 20.h),
                              TEXT(
                                text:
                                    'Hold and tap on your NFC card here to scan',
                                fontFamily: 'Gilroy-medium',
                              ),
                              Spacer(),
                              BTN(
                                onTap: () {
                                  // _nfcStopSession();
                                  setState(() {
                                    _scanDone = false;
                                    visibleHeight = visibleHeight == 0
                                        ? -(MediaQuery.of(context).size.height *
                                            .45)
                                        : 0;
                                  });
                                },
                                child: TEXT(
                                  text: 'Cancel',
                                  fontFamily: 'Gilroy-bold',
                                  textAlign: TextAlign.center,
                                ),
                                bgColor: Colors.transparent,
                                borderColor: Colors.blueGrey[200],
                              )
                            ],
                          ),
                  ),
                ],
              );
            });
          },
        ),
      ),
    );
  }

  Future<bool> _nfcStartSession() async {
    // bool isNFCAvailable = await NfcManager.instance.isAvailable();

    // if (isNFCAvailable) {
    //   NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
    //     // Do something with the tag
    //     print({'NFC Tag', tag, tag.data});
    //   });
    // } else {
    //   SnackBar(
    //           content:
    //               Text('NFC Functionality is not available on this device'))
    //       .show(context);
    // }

    return false;
  }

  _nfcStopSession() async {
    // NfcManager.instance.stopSession();
  }

  Future<void> _scan() async {
    try {
      final result = await BarcodeScanner.scan(
        options: ScanOptions(
          strings: {
            'cancel': 'Cancel Scan',
            'flash_on': 'Flash On',
            'flash_off': 'Flash Off',
          },
          // restrictFormat: selectedFormats,
          useCamera: -1,
          autoEnableFlash: false,
          // android: AndroidOptions(
          //   aspectTolerance: _aspectTolerance,
          //   useAutoFocus: _useAutoFocus,
          // ),
        ),
      );
      // return result;
      setState(() => _result = result);
    } on PlatformException catch (e) {
      setState(() {
        _result = ScanResult(
          type: ResultType.Error,
          format: BarcodeFormat.unknown,
          rawContent: e.code == BarcodeScanner.cameraAccessDenied
              ? 'The user did not grant the camera permission!'
              : 'Unknown error: $e',
        );
      });
    }
  }
}
