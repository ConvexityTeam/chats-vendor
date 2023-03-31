// import 'dart:convert';
import 'dart:convert';
import 'dart:io';

import 'package:CHATS_Vendor/Utils/colors.dart';
import 'package:CHATS_Vendor/core/services/vendor_service.dart';
import 'package:CHATS_Vendor/theme_changer.dart';
import 'package:CHATS_Vendor/ui/shared/TEXT.dart';
import 'package:CHATS_Vendor/ui/shared/TF.dart';
import 'package:CHATS_Vendor/ui/shared/ui_helper.dart';
import 'package:CHATS_Vendor/ui/widgets/error_widget_handler.dart';
// import 'package:CHATS/widgets/custom_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:snack/snack.dart';

class PersonalInfo extends StatefulWidget {
  @override
  _PersonalInfoState createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfo> {
  late TextEditingController _nameEditingController;
  late TextEditingController _emailEditingController;
  late TextEditingController _phoneEditingController;
  late TextEditingController _dobEditingController;
  late TextEditingController _countryEditingController;
  late TextEditingController _ninEditingController;
  final formKey = GlobalKey<FormState>();
  File? userImage;

  @override
  void initState() {
    super.initState();

    _nameEditingController = TextEditingController(text: '');
    _emailEditingController = TextEditingController(text: '');
    _phoneEditingController = TextEditingController(text: '');
    _dobEditingController = TextEditingController(text: '');
    _countryEditingController = TextEditingController(text: '');
    _ninEditingController = TextEditingController(text: '');
  }

  @override
  void dispose() {
    _nameEditingController.dispose();
    _emailEditingController.dispose();
    _phoneEditingController.dispose();
    _dobEditingController.dispose();
    _countryEditingController.dispose();
    _ninEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor:
            ThemeBuilder.of(context)?.getCurrentTheme() == Brightness.light
                ? Colors.white
                : primaryColorDarkMode,
        centerTitle: false,
        elevation: 0,
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
        title: TEXT(
          text: 'Personal Information',
          fontFamily: 'Gilroy-medium',
          fontSize: 22.sp,
          edgeInset: EdgeInsets.zero,
          textAlign: TextAlign.left,
          color: ThemeBuilder.of(context)?.getCurrentTheme() == Brightness.light
              ? Colors.black
              : Colors.white,
        ),
      ),
      body: FutureBuilder(
          // future: locator<VendorService>().gettingVendorDetails(),
          builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            color:
                ThemeBuilder.of(context)?.getCurrentTheme() == Brightness.light
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

        return RefreshIndicator(
          onRefresh: () async {
            await Modular.get<VendorService>().gettingVendorDetails();
          },
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
            child: Column(
              children: [
                Container(
                  height: 110,
                  width: 110,
                  decoration: BoxDecoration(
                    image: new DecorationImage(
                      image: getDPImage(Modular.get<VendorService>()
                          .vendorDetails
                          ?.profilePic),
                      fit: BoxFit.cover,
                    ),
                    color: Constants.usedGreen,
                    shape: BoxShape.circle,
                  ),
                  child: Stack(
                    alignment: AlignmentDirectional.bottomEnd,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          //* Launch image picker store image and call update service
                          print({"Shit happened in this function"});
                          PickedFile? file = await ImagePicker()
                              .getImage(source: ImageSource.camera);
                          if (file != null) {
                            // String base64Image =
                            //     base64Encode(await file.readAsBytes());

                            String? message = await Modular.get<VendorService>()
                                .updateVendorProfilePic(File(file.path));
                            print({"Update profile image service", file});
                            var snackBar = SnackBar(
                              content: Text(message ??
                                  'Something went wrong updating profile pice'),
                              margin: EdgeInsets.all(10),
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.r),
                              ),
                            );
                            snackBar.show(context);
                          } else {
                            // User canceled the picker
                            var snackBar = SnackBar(
                              content: Text('The picker was cancelled'),
                              margin: EdgeInsets.all(10),
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.r)),
                            );
                            snackBar.show(context);
                          }
                        },
                        child: Container(
                          width: 40,
                          height: 40,
                          padding: EdgeInsets.all(7),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color.fromRGBO(124, 141, 181, 1),
                            border:
                                Border.all(width: 4.2.w, color: Colors.white),
                          ),
                          child: SizedBox.expand(
                            child: FittedBox(
                              fit: BoxFit.fill,
                              child: Modular.get<VendorService>().isUploading
                                  ? CircularProgressIndicator.adaptive()
                                  : Icon(
                                      Icons.camera_alt_rounded,
                                      color: Colors.white,
                                    ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 20),
                TEXT(
                  text:
                      '${Modular.get<VendorService>().vendorDetails?.firstName} ${Modular.get<VendorService>().vendorDetails?.lastName}',
                  edgeInset: EdgeInsets.zero,
                  fontFamily: 'Gilroy-regular',
                  fontSize: 28,
                  color: ThemeBuilder.of(context)?.getCurrentTheme() ==
                          Brightness.light
                      ? Color.fromRGBO(34, 34, 34, 1)
                      : Colors.white,
                ),
                SizedBox(height: 10),
                TEXT(
                  text:
                      'ID: ${Modular.get<VendorService>().vendorDetails?.vendorId}',
                  edgeInset: EdgeInsets.zero,
                  fontFamily: 'Gilroy-regular',
                  fontSize: 20,
                  color: ThemeBuilder.of(context)?.getCurrentTheme() ==
                          Brightness.light
                      ? Color.fromRGBO(100, 106, 134, 1)
                      : Colors.white,
                ),
                buildInfoCard(Modular.get<VendorService>().vendorDetails),
                // SizedBox(height: 10),
                // BTN(
                //   height: 52,
                //   child: TEXT(
                //     text: 'Update Profile',
                //     fontSize: 19,
                //     fontFamily: 'Gilroy-medium',
                //     color: Colors.white,
                //     textAlign: TextAlign.center,
                //     edgeInset: EdgeInsets.zero,
                //   ),
                //   // SizedBox(
                //   //   height: 18,
                //   //   width: 18,
                //   //   child:
                //   //       ? CircularProgressIndicator(
                //   //           strokeWidth: 2,
                //   //           color: Colors.white,
                //   //         )
                //   //       : Placeholder(color: Colors.transparent),
                //   // ),
                //   onTap: () async {
                //     formKey.currentState!.save();
                //     if (formKey.currentState!.validate()) {
                //       // TODO: call the service and pass the values
                //       VendorDetails details = VendorDetails(
                //         id: Modular.get<VendorService>().vendorDetails?.id,
                //         firstName:
                //             _nameEditingController.value.text.split(" ")[0],
                //         lastName:
                //             _nameEditingController.value.text.split(" ")[1],
                //         phone: _phoneEditingController.value.text,
                //         email: _emailEditingController.value.text,
                //         dob: _dobEditingController.value.text,
                //         location: _countryEditingController.value.text,
                //         nin: _ninEditingController.value.text,
                //         address: "not_set",
                //         maritalStatus: "single",
                //       );
                //       var updateResp = await Modular.get<VendorService>()
                //           .updateVendorProfile(details);
                //       var snackBar =
                //           SnackBar(content: Text(updateResp?['message']));
                //       return snackBar.show(context);
                //     }
                //   },
                // ),
                // SizedBox(height: 50),
                // buildIdentityVerification(smallH),
              ],
            ),
          ),
        );
      }),
    );
  }

  Container _buildCard(
      IconData icon, String title, String body, double height, bool uploaded) {
    return Container(
      padding: EdgeInsets.only(top: 18, bottom: 18),
      child: ListTile(
        isThreeLine: true,
        leading: Icon(icon, color: Constants.purple, size: height * 2),
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
          text: body,
          fontSize: 12,
          color: Color.fromRGBO(85, 85, 85, 1),
        ),
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
            spreadRadius: 0.4,
            blurRadius: 20,
          )
        ],
      ),
    );
  }

  ImageProvider<Object> getDPImage(image) {
    late dynamic myDP;
    if (image == null) {
      myDP = AssetImage("assets/Ellipse 4.png");
    } else {
      myDP = NetworkImage(image);
    }

    return myDP;
  }

  Widget buildInfoCard(data) {
    _nameEditingController.text = '${data.firstName} ${data.lastName}';
    _emailEditingController.text = '${data.email}';
    _phoneEditingController.text = '${data.phone}';
    _dobEditingController.text = data.dob != null
        ? '${DateTime.parse(data.dob).toString().substring(0, 11)}'
        : '';
    _countryEditingController.text = '${jsonDecode(data.location)["country"]}';
    _ninEditingController.text = data.nin != null ? '${data.nin}' : 'No data';
    return Container(
      width: double.infinity,
      child: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TF(
              enabled: false,
              controller: _nameEditingController,
              borderColor: Colors.transparent,
              label: TEXT(
                text: 'Full Name',
                edgeInset: EdgeInsets.only(left: 10),
                color: ThemeBuilder.of(context)?.getCurrentTheme() ==
                        Brightness.light
                    ? Colors.black
                    : Colors.white,
              ),
              validateFn: (value) {
                if (value!.isEmpty) {
                  return 'The field cannot be empty';
                }
              },
            ),
            TF(
              enabled: false,
              controller: _emailEditingController,
              borderColor: Colors.transparent,
              label: TEXT(
                text: 'Email Adress',
                edgeInset: EdgeInsets.only(left: 10),
                color: ThemeBuilder.of(context)?.getCurrentTheme() ==
                        Brightness.light
                    ? Colors.black
                    : Colors.white,
              ),
              validateFn: (value) {
                if (value!.isEmpty) {
                  return 'The field cannot be empty';
                }
              },
            ),
            TF(
              enabled: false,
              controller: _phoneEditingController,
              borderColor: Colors.transparent,
              label: TEXT(
                text: 'Phone Number',
                edgeInset: EdgeInsets.only(left: 10),
                color: ThemeBuilder.of(context)?.getCurrentTheme() ==
                        Brightness.light
                    ? Colors.black
                    : Colors.white,
              ),
              validateFn: (value) {
                if (value!.isEmpty) {
                  return 'The field cannot be empty';
                }
              },
            ),
            // TF(
            //   controller: _dobEditingController,
            //   borderColor: Colors.transparent,
            //   label: TEXT(
            //     text: 'Date of Birth',
            //     edgeInset: EdgeInsets.only(left: 10),
            //   ),
            //   onTap: () {
            //     DatePicker.showDatePicker(
            //       context,
            //       showTitleActions: true,
            //       minTime: DateTime(1940, 3, 5),
            //       maxTime: DateTime.now(),
            //       onChanged: (date) {},
            //       onConfirm: (date) {
            //         print('change $date');

            //         DateFormat dateFormat = DateFormat('MMMM-d-yyyy');
            //         var formattedDate = dateFormat.format(date);
            //         _dobEditingController.text = formattedDate;
            //       },
            //       onCancel: () {},
            //       currentTime: DateTime.now(),
            //       locale: LocaleType.en,
            //     );
            //   },
            // ),
            TF(
              enabled: false,
              controller: _countryEditingController,
              borderColor: Colors.transparent,
              label: TEXT(
                text: 'Country',
                edgeInset: EdgeInsets.only(left: 10),
                color: ThemeBuilder.of(context)?.getCurrentTheme() ==
                        Brightness.light
                    ? Colors.black
                    : Colors.white,
              ),
              validateFn: (value) {
                if (value!.isEmpty) {
                  return 'The field cannot be empty';
                }
              },
            ),
            TF(
              enabled: false,
              controller: _ninEditingController,
              borderColor: Colors.transparent,
              label: TEXT(
                text: 'NIN',
                edgeInset: EdgeInsets.only(left: 10),
                color: ThemeBuilder.of(context)?.getCurrentTheme() ==
                        Brightness.light
                    ? Colors.black
                    : Colors.white,
              ),
              validateFn: (value) {
                if (value!.isEmpty) {
                  return 'The field cannot be empty';
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
