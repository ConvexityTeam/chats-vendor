import 'package:CHATS_Vendor/Utils/colors.dart';
import 'package:CHATS_Vendor/core/services/vendor_service.dart';
import 'package:CHATS_Vendor/theme_changer.dart';
import 'package:CHATS_Vendor/ui/shared/BTN.dart';
import 'package:CHATS_Vendor/ui/shared/TEXT.dart';
import 'package:CHATS_Vendor/ui/shared/TF.dart';
import 'package:CHATS_Vendor/ui/shared/ui_helper.dart';
import 'package:bottom_drawer/bottom_drawer.dart';
// import 'package:CHATS_Vendor/ui/widgets/bottom_drawer.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snack/snack.dart';

class WalletView extends StatefulWidget {
  @override
  _WalletViewState createState() => _WalletViewState();
}

class _WalletViewState extends State<WalletView> {
  late double visibleHeight;
  Map? withdrawBank = {};
  final formKey = GlobalKey<FormState>();
  late TextEditingController withdrawAmountController;

  void toggleVisibilty(setState) {
    setState(() {
      visibleHeight =
          visibleHeight == 0 ? -(MediaQuery.of(context).size.height * .45) : 0;
    });
  }

  @override
  void initState() {
    super.initState();
    String? balance =
        Modular.get<VendorService>().vendorDetails!.wallets!.isEmpty ||
                Modular.get<VendorService>().vendorDetails?.wallets == null
            ? '0.00'
            : Modular.get<VendorService>()
                .vendorDetails
                ?.wallets![0]
                .balance
                ?.toStringAsFixed(2);
    withdrawAmountController = TextEditingController(text: balance);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    visibleHeight = -(MediaQuery.of(context).size.height * .45);
  }

  @override
  Widget build(BuildContext context) {
    String? balance =
        Modular.get<VendorService>().vendorDetails!.wallets!.isEmpty ||
                Modular.get<VendorService>().vendorDetails?.wallets == null
            ? '0.00'
            : Modular.get<VendorService>()
                .vendorDetails
                ?.wallets![0]
                .balance
                ?.toStringAsFixed(2);
    // withdrawAmountController.text = balance == null ? '0.00' : balance;
    String? currency = Modular.get<VendorService>()
                .vendorDetails!
                .wallets!
                .isEmpty ||
            Modular.get<VendorService>().vendorDetails?.wallets == null
        ? 'NGN'
        : Modular.get<VendorService>().vendorDetails?.wallets![0].localCurrency;
    return Scaffold(
      backgroundColor: Color.fromRGBO(250, 250, 250, 1),
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
          text: "Wallet",
          color: ThemeBuilder.of(context)?.getCurrentTheme() == Brightness.light
              ? Colors.black
              : Colors.white,
          fontFamily: "Gilroy-medium",
          fontSize: 22.sp,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color: ThemeBuilder.of(context)?.getCurrentTheme() ==
                        Brightness.light
                    ? Colors.white
                    : primaryColorDarkMode,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        height: 240.h,
                        width: MediaQuery.of(context).size.width * 0.90,
                        margin: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Constants.usedGreen.withOpacity(0.1),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.r),
                            )),
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "$currency $balance",
                              style: TextStyle(
                                color: Constants.usedGreen,
                                fontSize: 36.sp,
                                fontFamily: "Gilroy-medium",
                              ),
                            ),
                            SizedBox(height: 10.h),
                            Text(
                              "Current balance",
                              style: TextStyle(
                                color: Constants.usedGreen,
                                fontFamily: "Gilroy-bold",
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 20.h),
                      buildCard(context)
                    ],
                  ),
                ),
              ),
              BottomDrawer(
                controller: _bottomDrawerController,
                body: Container(
                  width: MediaQuery.of(context).size.width,
                  height: (MediaQuery.of(context).size.height * .55),
                  padding: EdgeInsets.only(top: 20.h, bottom: 20.h),
                  decoration: BoxDecoration(
                    color: ThemeBuilder.of(context)?.getCurrentTheme() ==
                            Brightness.light
                        ? Colors.white
                        : primaryColorDarkMode,
                    border: Border.all(color: Constants.usedGreen),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(40),
                      topLeft: Radius.circular(40),
                    ),
                  ),
                  child: drawerChild(balance, context, currency),
                ),
                drawerHeight: (MediaQuery.of(context).size.height * .55),
                headerHeight: 0,
                header: Container(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  BottomDrawerController _bottomDrawerController = BottomDrawerController();

  Widget drawerChild(String? balance, BuildContext context, String? currency) {
    return CarouselSlider(
      carouselController: _carouselController,
      options: CarouselOptions(
        height: double.infinity,
        initialPage: 0,
        aspectRatio: 16 / 9,
        enlargeCenterPage: true,
        viewportFraction: 0.9,
        autoPlay: false,
        scrollDirection: Axis.horizontal,
        scrollPhysics: NeverScrollableScrollPhysics(),
      ),
      items: [
        Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 7,
                    child: TEXT(
                      text: 'Withdrawal Confirmation',
                      color: ThemeBuilder.of(context)?.getCurrentTheme() ==
                              Brightness.light
                          ? Color.fromRGBO(37, 57, 111, 1)
                          : Colors.white,
                      fontSize: 22.sp,
                      fontFamily: 'Gilroy-bold',
                    ),
                  ),
                  Expanded(
                    child: IconButton(
                      onPressed: () {
                        _bottomDrawerController.close();
                        withdrawAmountController.text = balance!;
                      },
                      icon: Icon(
                        Icons.close_rounded,
                        color: ThemeBuilder.of(context)?.getCurrentTheme() ==
                                Brightness.light
                            ? Color.fromRGBO(37, 57, 111, 1)
                            : Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 17.h),
              TF(
                controller: withdrawAmountController,
                label: TEXT(
                  text: 'Amount to withdraw',
                  color: ThemeBuilder.of(context)?.getCurrentTheme() ==
                          Brightness.light
                      ? Color.fromARGB(255, 32, 32, 33)
                      : Colors.white,
                ),
                hintText: 'Enter amount to withdraw',
              ),
              SizedBox(height: 10.h),
              Modular.get<VendorService>().vendorDetails!.bankAccounts != null
                  ? Row(
                      children: [
                        Expanded(
                          child: TEXT(
                            text:
                                'You are about to withdraw, please select account to withdraw to.',
                            fontWeight: FontWeight.w400,
                            fontSize: 19.sp,
                            fontFamily: 'Gilroy-medium',
                            textAlign: TextAlign.center,
                            color:
                                ThemeBuilder.of(context)?.getCurrentTheme() ==
                                        Brightness.light
                                    ? Color.fromRGBO(37, 57, 111, 1)
                                    : Colors.white,
                            softWrap: true,
                            maxLines: 3,
                          ),
                        ),
                      ],
                    )
                  : SizedBox.shrink(),

              // ListTile goes here
              SizedBox(height: 15.h),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: Modular.get<VendorService>()
                                .vendorDetails!
                                .bankAccounts !=
                            null
                        ? Modular.get<VendorService>()
                            .vendorDetails!
                            .bankAccounts!
                            .map<Widget>(
                              (account) => Container(
                                padding: EdgeInsets.only(bottom: 5.h),
                                margin: EdgeInsets.only(bottom: 14.h),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: ThemeBuilder.of(context)
                                                  ?.getCurrentTheme() ==
                                              Brightness.light
                                          ? Color.fromRGBO(153, 153, 153, 1)
                                          : Colors.white,
                                    ),
                                    borderRadius: BorderRadius.circular(10.r)),
                                child: ListTile(
                                  dense: false,
                                  leading: CircleAvatar(
                                    radius: 45,
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Image.asset(
                                        "assets/bank.png",
                                        scale: .65,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    backgroundColor:
                                        Color.fromRGBO(245, 246, 248, 1),
                                  ),
                                  title: TEXT(
                                    text: account.bankName!,
                                    color: ThemeBuilder.of(context)
                                                ?.getCurrentTheme() ==
                                            Brightness.light
                                        ? Color.fromRGBO(37, 57, 111, 1)
                                        : Colors.white,
                                  ),
                                  subtitle: TEXT(
                                    text: account.accountNumber!,
                                    color: ThemeBuilder.of(context)
                                                ?.getCurrentTheme() ==
                                            Brightness.light
                                        ? Color.fromRGBO(37, 57, 111, 1)
                                        : Colors.white,
                                  ),
                                  onTap: () {
                                    if (withdrawAmountController
                                            .text.isNotEmpty &&
                                        double.parse(withdrawAmountController
                                                .text) <=
                                            double.parse(balance!)) {
                                      // Set selected bank to the state
                                      setState(() {
                                        withdrawBank = {
                                          'account_name': account.bankName,
                                          'account_number':
                                              account.accountNumber,
                                          'bank_code': account.bankCode
                                        };
                                      });
                                      // Move to next carousel and confirm withdraw request
                                      _carouselController.nextPage(
                                        duration: Duration(milliseconds: 400),
                                        curve: Curves.easeIn,
                                      );
                                    } else {
                                      SnackBar(
                                        content: TEXT(
                                          text:
                                              'Amount to withdraw must be less than or equal to balance',
                                          color: ThemeBuilder.of(context)
                                                      ?.getCurrentTheme() ==
                                                  Brightness.light
                                              ? Color.fromARGB(255, 17, 17, 17)
                                              : Colors.white,
                                        ),
                                      ).show(context);
                                    }
                                  },
                                ),
                              ),
                            )
                            .toList()
                        : [
                            TEXT(
                              text: 'You have not added any bank account',
                              fontWeight: FontWeight.w400,
                              fontSize: 21.sp,
                              fontFamily: 'Gilroy-medium',
                              textAlign: TextAlign.center,
                              color:
                                  ThemeBuilder.of(context)?.getCurrentTheme() ==
                                          Brightness.light
                                      ? Color.fromRGBO(37, 57, 111, 1)
                                      : Colors.white,
                            ),
                          ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Column(
          children: [
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 7,
                  child: TEXT(
                    text: 'Withdrawal Confirmation',
                    color: ThemeBuilder.of(context)?.getCurrentTheme() ==
                            Brightness.light
                        ? Color.fromRGBO(37, 57, 111, 1)
                        : Colors.white,
                    fontSize: 22.sp,
                    fontFamily: 'Gilroy-bold',
                    softWrap: true,
                    maxLines: 1,
                    textOverflow: TextOverflow.ellipsis,
                  ),
                ),
                Expanded(
                  child: IconButton(
                    onPressed: () {
                      _bottomDrawerController.close(); //Close bottom drawer
                      _carouselController.jumpToPage(0);
                      withdrawAmountController.text = balance!;
                    },
                    icon: Icon(
                      Icons.close_rounded,
                      color: ThemeBuilder.of(context)?.getCurrentTheme() ==
                              Brightness.light
                          ? Color.fromRGBO(37, 57, 111, 1)
                          : Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30.h),
            // Transaction confirmation goes here

            // ListTile goes here
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TEXT(
                      text:
                          'Confirm your withdrawal of ${currency} ${withdrawAmountController.text} to ${withdrawBank?['account_name']} with account number ${withdrawBank?['account_number']}',
                      fontWeight: FontWeight.w400,
                      fontSize: 21.sp,
                      fontFamily: 'Gilroy-medium',
                      textAlign: TextAlign.center,
                      color: ThemeBuilder.of(context)?.getCurrentTheme() ==
                              Brightness.light
                          ? Color.fromRGBO(37, 57, 111, 1)
                          : Colors.white,
                    ),
                  ],
                ),
              ),
            ),

            BTN(
              height: 52.h,
              onTap: () async {
                // On tap call the resolve service and send the bank details to the service

                // setState(() {
                //   withdrawLoading = true;
                // });

                var message =
                    await Modular.get<VendorService>().liquidateUserWallet(
                  withdrawAmountController.text,
                  withdrawBank,
                );

                new SnackBar(content: Text(message)).show(context);
                // setState(() {
                //   withdrawLoading = false;
                // });
                _bottomDrawerController.close();
                _carouselController.jumpToPage(0);
                setState(() {
                  withdrawBank = {};
                });
                print({withdrawBank, "The selected bank"});
              },
              bgColor: Constants.usedGreen,
              loadColor: Colors.white,
              child: TEXT(
                text: 'Confirm',
                fontFamily: 'Gilroy-bold',
                fontWeight: FontWeight.w500,
                textAlign: TextAlign.center,
                color: Colors.white,
              ),
              // mainAxisAlignment: withdrawLoading!
              //     ? MainAxisAlignment.end
              //     : MainAxisAlignment.center,
            )
          ],
        ),
      ],
    );
  }

  Widget buildCard(context) {
    return GestureDetector(
      onTap: () {
        _bottomDrawerController.open();
      },
      child: Container(
        height: 70.h,
        margin: const EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width * 0.90,
        child: Row(
          children: [
            SizedBox(width: 20.w),
            TEXT(
              text: "Withdraw",
              color: ThemeBuilder.of(context)?.getCurrentTheme() ==
                      Brightness.light
                  ? Colors.black
                  : Colors.white,
              fontFamily: "Gilroy-medium",
            ),
            Spacer(),
            Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: ThemeBuilder.of(context)?.getCurrentTheme() ==
                      Brightness.light
                  ? Colors.black
                  : Colors.white,
            ),
            SizedBox(width: 15.w),
          ],
        ),
        decoration: BoxDecoration(
          color: ThemeBuilder.of(context)?.getCurrentTheme() == Brightness.light
              ? Colors.white
              : primaryColorDarkMode,
          borderRadius: BorderRadius.all(
            Radius.circular(5.r),
          ),
          border: Border.all(
            color: Colors.grey.withOpacity(.5),
          ),
        ),
      ),
    );
  }

  CarouselController _carouselController = new CarouselController();
}
