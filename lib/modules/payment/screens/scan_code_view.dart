// import 'package:CHATS/router.dart';
// import 'package:CHATS/screens/Home/views/drawer_view.dart';
// import 'package:CHATS/theme_changer.dart';
// import 'package:CHATS/utils/colors.dart';
// import 'package:CHATS/utils/text.dart';
// import 'package:CHATS/utils/ui_helper.dart';
import 'package:CHATS_Vendor/Utils/colors.dart';
import 'package:CHATS_Vendor/core/constants/route_paths.dart';
import 'package:CHATS_Vendor/core/constants/ui_helper.dart';
import 'package:CHATS_Vendor/theme_changer.dart';
import 'package:CHATS_Vendor/ui/shared/TEXT.dart';
import 'package:CHATS_Vendor/ui/shared/ui_helper.dart';
import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:nfc_manager/nfc_manager.dart';
import 'package:snack/snack.dart';

// import '../../../utils/colors.dart';

class ScanQRView extends StatefulWidget {
  @override
  _ScanQRViewState createState() => _ScanQRViewState();
}

class _ScanQRViewState extends State<ScanQRView> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  ScanResult? _result;

  @override
  Widget build(BuildContext context) {
    // double width = MediaQuery.of(context).size.width;
    // var orientation = MediaQuery.of(context).orientation;
    return WillPopScope(
      // ignore: missing_return
      onWillPop: () => onBackPressed(context),
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          centerTitle: false,
          elevation: 0,
          backgroundColor:
              ThemeBuilder.of(context)!.getCurrentTheme() == Brightness.light
                  ? Colors.white
                  : primaryColorDarkMode,
          leading: GestureDetector(
            onTap: () {
              scaffoldKey.currentState!.openDrawer();
            },
            child: Image.asset(
              "assets/Group.png",
              color: ThemeBuilder.of(context)!.getCurrentTheme() ==
                      Brightness.light
                  ? Colors.black
                  : Colors.white,
            ),
          ),
          title: TEXT(
            text: 'Scan QR Code',
            fontFamily: 'Gilroy-medium',
            fontSize: 22,
            edgeInset: EdgeInsets.only(top: 3),
            color:
                ThemeBuilder.of(context)!.getCurrentTheme() == Brightness.light
                    ? Colors.black
                    : Colors.white,
          ),
        ),
        // drawer: AppDrawer(),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          margin: UIHelper.sidePadding,
          color: ThemeBuilder.of(context)!.getCurrentTheme() == Brightness.light
              ? Colors.white
              : primaryColorDarkMode,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              InkWell(
                onTap: () async {
                  // Navigator.pushNamed(context, scanCode);
                  await _scan();
                  print({
                    _result!.format,
                    _result!.formatNote,
                    _result!.rawContent,
                    _result!.type,
                  });

                  if (_result!.rawContent is String) {
                    Navigator.pushNamed(context, Routes.paymentConfirmation,
                        arguments: _result!.rawContent);
                  } else {
                    var snackBar = SnackBar(
                      content: TEXT(
                        text: 'There was an issue getting the QR code result',
                        color: ThemeBuilder.of(context)!.getCurrentTheme() ==
                                Brightness.light
                            ? Colors.black
                            : Colors.white,
                      ),
                    );
                    snackBar.show(context);
                    return;
                  }
                },
                child: Container(
                  margin: EdgeInsets.all(20),
                  padding: EdgeInsets.all(20),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(245, 246, 248, 1),
                    borderRadius: UIHelper.borderRadius,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // SizedBox(height: 20),
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: Center(
                          child: Image.asset(
                            "assets/scan_code.png",
                            width: 18,
                            height: 18,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      TEXT(
                        text: "Scan QR Code",
                        fontSize: 22,
                        color: Colors.black,
                        fontFamily: "Gilroy-medium",
                      ),
                      SizedBox(height: 10),
                      TEXT(
                        text:
                            "Complete a payment with an already\n created QR code.",
                        textAlign: TextAlign.center,
                        // fontSize: 18,
                        color: Color(0xff4F4F4F),
                        fontFamily: 'Gilroy-regular',
                      ),
                    ],
                  ),
                ),
              ),
              // InkWell(
              //   onTap: () async {
              //     // Start NFC reader
              //     // Check availability
              //     bool isAvailable = await NfcManager.instance.isAvailable();
              //     if (isAvailable) {
              //       print({"NFC is available"});
              //     }

              //     // Start Session
              //     NfcManager.instance.startSession(
              //       onDiscovered: (NfcTag tag) async {
              //         // Do something with an NfcTag instance.
              //         print({"Tag read", tag});
              //         Ndef? ndef = Ndef.from(tag);

              //         if (ndef == null) {
              //           print('Tag is not compatible with NDEF');
              //           return;
              //         }

              //         // Do something with an Ndef instance
              //         print({"Ndef", ndef});
              //       },
              //     );

              //     // Stop Session
              //     NfcManager.instance.stopSession();
              //   },
              //   child: Container(
              //     child: Text('READ NFC CARD'),
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
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
