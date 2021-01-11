import 'package:CHATS_Vendor/core/constants/route_paths.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class ScanQRView extends StatefulWidget {
  @override
  _ScanQRViewState createState() => _ScanQRViewState();
}

class _ScanQRViewState extends State<ScanQRView> {
  String _result;
  @override
  Widget build(BuildContext context) {
    // double width = MediaQuery.of(context).size.width;
    // var orientation = MediaQuery.of(context).orientation;
    return SafeArea(
        child: Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: RaisedButton(
              onPressed: () {
                scanCode(context);
              },
              child: Text(
                "Scan QR code for transaction",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontFamily: "Gilroy-Regular"),
              ),
            ),
          )
        ],
      ),
    ));
  }

  scanCode(context) async {
    String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
      "#000000",
      "Scan",
      false,
      ScanMode.QR,
    );
    if (barcodeScanRes != null) {
      setState(() => _result = barcodeScanRes);
      print("HOLLA! SUCCESSFUL");
      Navigator.pushNamed(context, Routes.homeView);
    } else {
      await showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text("Scan Error"),
          content: Text("Sorry, no code was provided to scan"),
          actions: [
            FlatButton(
              child: Text("OK"),
              onPressed: () => Navigator.of(context).pop(),
            )
          ],
        ),
      );
    }
  }
}
