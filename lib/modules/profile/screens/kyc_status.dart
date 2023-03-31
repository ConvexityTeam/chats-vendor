import 'dart:convert';
import 'dart:io';

// import 'package:CHATS/domain/locator.dart';
// import 'package:CHATS/services/user_service.dart';
// import 'package:CHATS/utils/custom_text_field.dart';
// import 'package:CHATS/utils/text.dart';
// import 'package:CHATS/utils/ui_helper.dart';
// import 'package:CHATS/widgets/custom_btn.dart';
// import 'package:CHATS/widgets/error_widget_handler.dart';
import 'package:CHATS_Vendor/Utils/colors.dart';
import 'package:CHATS_Vendor/core/models/vendor_details_model.dart';
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
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:snack/snack.dart';

class KYCstatus extends StatefulWidget {
  @override
  _KYCstatusState createState() => _KYCstatusState();
}

class _KYCstatusState extends State<KYCstatus> {
  late TextEditingController _docNumberController;
  String _idDocType = '';
  String? _ip;

  @override
  void initState() {
    super.initState();
    _docNumberController = TextEditingController(
      text: Modular.get<VendorService>().vendorDetails?.nin,
    );

    _getDeviceIP();
  }

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    // final smallH = size.height / 36;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor:
            ThemeBuilder.of(context)?.getCurrentTheme() == Brightness.light
                ? Colors.white
                : primaryColorDarkMode,
        title: TEXT(
          text: 'ID Verification',
          fontFamily: 'Gilroy-medium',
          fontSize: 22.sp,
          edgeInset: EdgeInsets.zero,
          textAlign: TextAlign.left,
          color: ThemeBuilder.of(context)?.getCurrentTheme() == Brightness.light
              ? Colors.black
              : Colors.white,
        ),
        centerTitle: false,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color:
                ThemeBuilder.of(context)?.getCurrentTheme() == Brightness.light
                    ? Colors.black
                    : Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: FutureBuilder(
        future:
            Modular.get<VendorService>().vendorDetails?.isNinVerified != null
                ? null
                : Modular.get<VendorService>().gettingVendorDetails(),
        builder: (context, snapshot) {
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

          return Container(
            color:
                ThemeBuilder.of(context)?.getCurrentTheme() == Brightness.light
                    ? Colors.white
                    : primaryColorDarkMode,
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildVerifiedWidget(Modular.get<VendorService>()
                            .vendorDetails
                            ?.isNinVerified ??
                        false),
                  ],
                ),
                SizedBox(height: 32.h),
                StatefulBuilder(builder: (context, setState) {
                  return Container(
                    width: double.infinity,
                    height: 52.h,
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: ThemeBuilder.of(context)?.getCurrentTheme() ==
                                Brightness.light
                            ? Colors.black
                            : Colors.white,
                      ),
                      borderRadius: BorderRadius.circular(5.r),
                    ),
                    child: DropdownButton<String>(
                      value: _idDocType.isEmpty ? null : _idDocType,

                      icon: const Icon(Icons.keyboard_arrow_down_rounded),
                      iconEnabledColor:
                          ThemeBuilder.of(context)?.getCurrentTheme() ==
                                  Brightness.light
                              ? Colors.black
                              : Colors.white,
                      // dropdownColor: Constants.usedGreen,
                      iconSize: 24,
                      elevation: 8,
                      isExpanded: true,
                      hint: TEXT(
                        text: 'Select Identity Document Type',
                        fontFamily: 'Gilroy-medium',
                        color: ThemeBuilder.of(context)?.getCurrentTheme() ==
                                Brightness.light
                            ? Colors.black
                            : Colors.white,
                        edgeInset: EdgeInsets.zero,
                      ),
                      style: TextStyle(
                          color: ThemeBuilder.of(context)?.getCurrentTheme() ==
                                  Brightness.light
                              ? Colors.black
                              : Colors.white),
                      // underline: Container(
                      //   height: 2,
                      //   color: Colors.green,
                      // ),
                      onChanged: (String? newValue) {
                        setState(() {
                          _idDocType = newValue!;
                        });
                      },
                      items: <String>[
                        'National Identity Number',
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: TextStyle(
                              color:
                                  ThemeBuilder.of(context)?.getCurrentTheme() ==
                                          Brightness.light
                                      ? Colors.black
                                      : Colors.white,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  );
                }),
                SizedBox(height: 16.h),
                TF(
                  label: TEXT(
                    text: 'Virtual NIN (vNIN)',
                    color: ThemeBuilder.of(context)?.getCurrentTheme() ==
                            Brightness.light
                        ? Colors.black
                        : Colors.white,
                  ),
                  controller: _docNumberController,
                  hintText: 'Document number',
                ),
                TEXT(
                  text:
                      'Two ways to generate your virtual NIN for KYC\n- USSD: *346*3*customer NIN*696739#\n- NIMC official mobile app',
                  textAlign: TextAlign.left,
                  fontWeight: FontWeight.w800,
                  edgeInset: EdgeInsets.only(left: 10),
                  color: Constants.usedGreen,
                  fontSize: 18,
                ),
                SizedBox(height: 35),
                BTN(
                  height: 52.h,
                  margin: EdgeInsets.zero,
                  child: TEXT(
                    text: 'Verify Profile',
                    color: Colors.white,
                    edgeInset: EdgeInsets.zero,
                    fontFamily: 'Gilroy-bold',
                    textAlign: TextAlign.center,
                  ),
                  onTap: () async {
                    if (_docNumberController.text.isNotEmpty) {
                      var result = await Modular.get<VendorService>()
                          .updateVendorProfile(
                        VendorDetails(
                            firstName: Modular.get<VendorService>()
                                .vendorDetails
                                ?.firstName,
                            lastName: Modular.get<VendorService>()
                                .vendorDetails
                                ?.lastName,
                            nin: _docNumberController.text,
                            ip: _ip),
                      );

                      SnackBar(
                        content: TEXT(
                          text: result?['message'],
                          color: ThemeBuilder.of(context)!.getCurrentTheme() ==
                                  Brightness.light
                              ? Colors.white
                              : Colors.black,
                        ),
                      ).show(context);
                    } else {
                      SnackBar(
                        content: TEXT(
                          text:
                              'You have to enter a valid Identification Number',
                        ),
                      ).show(context);
                    }
                  },
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Widget buildVerifiedWidget(bool isVerified) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 13, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: isVerified
            ? Color.fromRGBO(23, 206, 137, 0.1)
            : Color.fromRGBO(228, 44, 102, 0.1),
      ),
      child: Row(
        children: [
          CircleAvatar(
            child: Icon(
              isVerified ? Icons.check : Icons.close_rounded,
              size: 18,
              color: Colors.white,
            ),
            radius: 12,
            backgroundColor: isVerified
                ? Color.fromRGBO(0, 168, 105, 1)
                : Color.fromRGBO(228, 44, 102, 1),
          ),
          SizedBox(width: 10),
          TEXT(
            text: isVerified ? 'Verified' : 'Unverified',
            fontFamily: 'Gilroy-medium',
            color: isVerified
                ? Color.fromRGBO(0, 168, 105, 1)
                : Color.fromRGBO(228, 44, 102, 1),
            edgeInset: EdgeInsets.zero,
          )
        ],
      ),
    );
  }

  Future<String?> _getDeviceIP() async {
    String? hostAddress;
    try {
      //*Setup and get IP
      await Permission.location.request();
      // final info = NetworkInfo();
      // hostAddress = await info.getWifiIP();
      if (hostAddress == null) {
        var ipList =
            await NetworkInterface.list(type: InternetAddressType.IPv4);
        hostAddress = ipList.first.addresses.first.address;
        print({hostAddress, "***IP ADDRESS***"});
        setState(() {
          _ip = hostAddress;
        });
      }

      return hostAddress;
    } catch (err) {
      print({err, "an error occurred"});
    }
  }

  bool pictureUploaded = false;
  bool idUploaded = false;
  Widget buildIdentityVerification(double height) {
    // instantiate image picker
    final _picker = ImagePicker();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TEXT(
          text: 'Identity Verification',
          fontFamily: 'Gilroy-bold',
          fontSize: height,
          edgeInset: EdgeInsets.only(bottom: height * 2, top: height),
        ),
        // Text(model.signUpErrorMessage, style: TextStyle(color: Colors.red)),
        GestureDetector(
            child: _buildCard(
                Image.asset("assets/upload_icon.png"),
                'Upload Picture',
                'Upload a clear picture showing your face. Avoid group picture',
                height,
                pictureUploaded),
            onTap: () async {
              PickedFile? file =
                  await _picker.getImage(source: ImageSource.gallery);
              if (file != null) {
                setState(() {
                  pictureUploaded = true;
                });
                String base64Image = base64Encode(await file.readAsBytes());
                // model.profilePicture = base64Image;
              } else {
                // User canceled the picker
              }
            }),
        GestureDetector(
            child: _buildCard(
                Image.asset("assets/upload_icon.png"),
                'Upload Valid ID',
                'National ID, Drivers’ License, Intl. Passport',
                height,
                idUploaded),
            onTap: () async {
              var file = await _picker.getImage(source: ImageSource.gallery);
              if (file != null) {
                setState(() {
                  // idUploaded = true;
                });
                String base64Image = base64Encode(await file.readAsBytes());
                // model.validId = base64Image;
              } else {
                // User canceled the picker
              }
            }),

        GestureDetector(
            child: _buildCard(
                Icon(
                  FontAwesomeIcons.microscope,
                  color: Constants.kpurple2,
                ),
                'Verify NIN/BVN',
                ' ',
                height,
                false),
            onTap: () async {
              // FilePickerResult result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['jpg', 'png']);

              Navigator.pushNamed(context, 'bvnVerification');
            }),
        BTN(
          margin: EdgeInsets.only(top: height * 2, bottom: 10),
          bgColor: Constants.usedGreen,
          children: [
            Expanded(
                child: TEXT(
              text: 'Verify',
              color: Colors.white,
              fontWeight: FontWeight.bold,
              textAlign: TextAlign.center,
              edgeInset: EdgeInsets.all(0.0),
            )),
            // SizedBox(
            //   height: 18,
            //   width: 18,
            //   child: CircularProgressIndicator(
            //       strokeWidth: 2,
            //       valueColor:
            //           AlwaysStoppedAnimation<Color>(
            //               !model.savingUser
            //                   ? Constants.purple
            //                   : Colors.black)))
          ],
          onTap: () {
            // model.register(userModel, context);
          },
        )
      ],
    );
  }

  Container _buildCard(
      Widget icon, String title, String body, double height, bool uploaded) {
    return Container(
      padding: EdgeInsets.only(top: 18, bottom: 18),
      child: ListTile(
        isThreeLine: true,
        // leading: Icon(icon, color: Constants.purple, size: height * 2),
        leading: icon,
        title: TEXT(
          text: title,
          fontFamily: 'Gilroy-Medium',
          fontSize: 16,
        ),
        trailing: uploaded
            ? Container(
                child: Icon(Icons.check, color: Colors.white),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(style: BorderStyle.none),
                    color: Constants.purple),
              )
            : Text(''),
        subtitle: TEXT(
            text: body, fontSize: 12, color: Color.fromRGBO(85, 85, 85, 1)),
      ),
      margin: EdgeInsets.only(bottom: height),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          border: Border(
              bottom: BorderSide.none,
              top: BorderSide.none,
              left: BorderSide.none,
              right: BorderSide.none),
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(174, 174, 192, 1),
              // spreadRadius: 0.4,
              blurRadius: 10,
            )
          ]),
    );
  }
}

/*







          onTap: () => showDialog(
              context: context,
              builder: (BuildContext context) {
                return Dialog(
                  child: Container(
                    height: 200,
                    padding: EdgeInsets.all(12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Select Picture'),
                        FlatButton(
                          onPressed: () async {
                            var file = await ImagePicker.pickImage(
                                source: ImageSource.camera);

                            if (file != null) {
                              setState(() {
                                pictureUploaded = true;
                              });
                              String base64Image =
                                  base64Encode(file.readAsBytesSync());
                              model.profilePicture = base64Image;
                            } else {
                              // User canceled the picker
                            }

                            Navigator.pop(context);
                          },
                          child: Text('Choose from camera',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        FlatButton(
                          onPressed: () async {
                            var file = await ImagePicker.pickImage(
                                source: ImageSource.gallery);

                            if (file != null) {
                              setState(() {
                                pictureUploaded = true;
                              });
                              String base64Image =
                                  base64Encode(file.readAsBytesSync());
                              model.profilePicture = base64Image;
                            } else {
                              // User canceled the picker
                            }

                            Navigator.pop(context);
                          },
                          child: Text('Choose from gallery',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        Container(
                          child: FlatButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('CANCEL',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                          alignment: Alignment.bottomRight,
                        )
                      ],
                    ),
                  ),
                );
              }),
        ),
        GestureDetector(
          child: _buildCard(
              Icons.upload_outlined,
              'Upload Valid ID',
              'National ID, Drivers’ License, Intl. Passport',
              height,
              idUploaded),
          onTap: () => showDialog(
              context: context,
              builder: (BuildContext context) {
                return Dialog(
                  child: Container(
                    height: 200,
                    padding: EdgeInsets.all(12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Select Picture'),
                        FlatButton(
                          onPressed: () async {
                            var file = await ImagePicker.pickImage(
                                source: ImageSource.camera);

                            if (file != null) {
                              setState(() {
                                idUploaded = true;
                              });
                              String base64Image =
                                  base64Encode(file.readAsBytesSync());
                              model.profilePicture = base64Image;
                            } else {
                              // User canceled the picker
                            }

                            Navigator.pop(context);
                          },
                          child: Text('Choose from camera',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        FlatButton(
                          onPressed: () async {
                            var file = await ImagePicker.pickImage(
                                source: ImageSource.gallery);

                            if (Icons.filter_2_sharp != null) {
                              setState(() {
                                idUploaded = true;
                              });
                              String base64Image =
                                  base64Encode(file.readAsBytesSync());
                              model.profilePicture = base64Image;
                            } else {
                              // User canceled the picker
                            }

                            Navigator.pop(context);
                          },
                          child: Text('Choose from gallery',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        Container(
                          child: FlatButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('CANCEL',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                          alignment: Alignment.bottomRight,
                        )
                      ],
                    ),
                  ),
                );
              }),
        ),
        GestureDetector(
            child: _buildCard(
                Icons.upload_outlined, 'Verify NIN/BVN', ' ', height, false),
            onTap: () async {
              Navigator.pushNamed(context, 'bvnVerification');
              // FilePickerResult result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['jpg', 'png']);
            })







 */
