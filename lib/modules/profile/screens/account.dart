// import 'package:CHATS/utils/custom_text_field.dart';
// import 'package:CHATS/utils/text.dart';
// import 'package:CHATS/utils/ui_helper.dart';
// import 'package:CHATS/widgets/custom_btn.dart';
import 'package:CHATS_Vendor/Utils/colors.dart';
import 'package:CHATS_Vendor/core/models/account_model.dart';
import 'package:CHATS_Vendor/core/models/bank_list.dart';
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
import 'package:snack/snack.dart';

class Account extends StatefulWidget {
  const Account({Key? key}) : super(key: key);

  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  late PageController _pageController;
  late TextEditingController _accNumberController;
  late TextEditingController _bankNameController;

  int pageIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: pageIndex);
    _accNumberController = TextEditingController(text: '');
    _bankNameController = TextEditingController(text: '058');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor:
            ThemeBuilder.of(context)!.getCurrentTheme() == Brightness.light
                ? Colors.white
                : primaryColorDarkMode,
        title: TEXT(
          text: 'Account',
          fontFamily: 'Gilroy-medium',
          fontSize: 22.sp,
          edgeInset: EdgeInsets.zero,
          textAlign: TextAlign.left,
          color: ThemeBuilder.of(context)!.getCurrentTheme() == Brightness.light
              ? Colors.black
              : Colors.white,
        ),
        centerTitle: false,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color:
                ThemeBuilder.of(context)!.getCurrentTheme() == Brightness.light
                    ? Colors.black
                    : Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: FutureBuilder(
        future: Modular.get<VendorService>().listBankAccounts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }

          if (snapshot.hasError) {
            return ErrorWidgetHandler(
              onTap: () {
                setState(() {});
              },
            );
          }

          return PageView(
            controller: _pageController,
            physics: NeverScrollableScrollPhysics(),
            children: [
              Modular.get<VendorService>().accounts!.isEmpty
                  ? noAccountScreen(context)
                  : buildBankCards(
                      Modular.get<VendorService>().accounts, context),
              buildNewBankCard(context),
            ],
          );
        },
      ),
    );
  }

  Widget noAccountScreen(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height,
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 90.w,
            backgroundColor: Color.fromRGBO(47, 185, 249, .09),
            child: Icon(
              Icons.house_siding_rounded,
              color: Color.fromRGBO(23, 206, 137, 1),
              size: 65.w,
            ),
          ),
          SizedBox(height: 32.h),
          TEXT(
            text:
                'No banks added. Add a new bank to withdraw to your local bank account',
            fontFamily: 'Gilroy-regular',
            textAlign: TextAlign.center,
            color:
                ThemeBuilder.of(context)!.getCurrentTheme() == Brightness.light
                    ? Colors.black
                    : Colors.white,
          ),
          SizedBox(height: 32.h),
          BTN(
            height: 52.h,
            margin: EdgeInsets.zero,
            children: [
              TEXT(
                text: 'Add A New Bank',
                color: Colors.white,
                edgeInset: EdgeInsets.zero,
                fontFamily: 'Gilroy-bold',
              )
            ],
            onTap: () {
              // setState(() {
              //   pageIndex = 1;
              _pageController.animateToPage(
                1,
                duration: Duration(milliseconds: 400),
                curve: Curves.ease,
              );
              // });
            },
          )
        ],
      ),
    );
  }

  Widget buildBankCards(List<AccountsModel>? cards, context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: double.infinity,
            height: 130.h,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: buildCard(cards, context),
            ),
          ),
          SizedBox(height: 40.h),
          BTN(
            height: 52.h,
            margin: EdgeInsets.zero,
            children: [
              TEXT(
                text: 'Add A New Bank',
                color: Colors.white,
                edgeInset: EdgeInsets.zero,
                fontFamily: 'Gilroy-bold',
              )
            ],
            onTap: () {
              // setState(() {
              //   pageIndex = 1;
              _pageController.animateToPage(
                1,
                duration: Duration(milliseconds: 400),
                curve: Curves.ease,
              );
              // });
            },
          ),
        ],
      ),
    );
  }

  List<Container> buildCard(List<AccountsModel>? cards, context) {
    return cards!
        .map((item) => Container(
              width: (MediaQuery.of(context).size.width * .7),
              padding: EdgeInsets.all(20.w),
              margin: EdgeInsets.only(right: 20.w),
              decoration: BoxDecoration(
                color: Color.fromRGBO(122, 128, 155, .1),
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(
                  color: Color.fromRGBO(100, 106, 134, 1),
                  width: 1.5,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TEXT(
                    text: '${item.accountName}',
                    fontFamily: 'Gilroy-bold',
                    color: Color.fromRGBO(100, 106, 134, 1),
                  ),
                  SizedBox(height: 8),
                  TEXT(
                    text: '${item.bankName}',
                    color: Color.fromRGBO(124, 141, 181, 1),
                  ),
                  SizedBox(height: 12),
                  TEXT(
                    text: '${item.accountNumber}',
                    fontSize: 21,
                    color: Color.fromRGBO(124, 141, 181, 1),
                  ),
                ],
              ),
            ))
        .toList();
  }

  Widget buildNewBankCard(context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TF(
            controller: _accNumberController,
            label: TEXT(
              text: 'Account Number',
              color: ThemeBuilder.of(context)!.getCurrentTheme() ==
                      Brightness.light
                  ? Colors.black
                  : Colors.white,
            ),
            hintText: 'Enter account number',
          ),
          BankListDropDown(
            onChange: (newValue) {
              _bankNameController.text = newValue!;
            },
          ),

          // CustomTextField(
          //   controller: _bankNameController,
          //   label: CustomText(
          //     text: 'Bank Name',
          //     color: ThemeBuilder.of(context)!.getCurrentTheme() ==
          //             Brightness.light
          //         ? Colors.black
          //         : Colors.white,
          //   ),
          //   hintText: 'Enter bank name',
          // ),
          SizedBox(height: 16.h),
          BTN(
            height: 52.h,
            margin: EdgeInsets.zero,
            child: TEXT(
              text: 'Add Bank',
              color: Colors.white,
              edgeInset: EdgeInsets.zero,
              fontFamily: 'Gilroy-bold',
              textAlign: TextAlign.center,
            ),
            onTap: () async {
              if (_accNumberController.text.isNotEmpty &&
                  _bankNameController.text.isNotEmpty) {
                String? result = await Modular.get<VendorService>()
                    .addBankAccount(AccountsModel(
                  accountNumber: _accNumberController.text,
                  bankCode: _bankNameController.text,
                ));
                var snackBar = SnackBar(content: Text(result ?? ''));
                snackBar.show(context);
                _accNumberController.clear();
                _bankNameController.clear();

                setState(() {});
              }
            },
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
    _accNumberController.dispose();
    _bankNameController.dispose();
  }
}

class BankListDropDown extends StatefulWidget {
  const BankListDropDown({Key? key, this.onChange}) : super(key: key);

  final Function(String?)? onChange;

  @override
  State<BankListDropDown> createState() => _BankListDropDownState();
}

class _BankListDropDownState extends State<BankListDropDown> {
  String? _bankVal = '058';

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Align(
        alignment: Alignment.centerLeft,
        child: TEXT(
          text: 'Bank Name',
          textAlign: TextAlign.left,
          color: ThemeBuilder.of(context)!.getCurrentTheme() == Brightness.light
              ? Colors.black
              : Colors.white,
        ),
      ),
      SizedBox(height: 8.h),
      Container(
        alignment: Alignment.center,
        width: double.infinity,
        height: 52.h,
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        decoration: BoxDecoration(
          border: Border.all(
            color:
                ThemeBuilder.of(context)?.getCurrentTheme() == Brightness.light
                    ? Colors.black
                    : Colors.white,
          ),
          borderRadius: BorderRadius.circular(5.r),
        ),
        child: DropdownButton<String>(
          value: _bankVal,
          icon: const Icon(Icons.arrow_downward),
          iconEnabledColor: Constants.usedGreen,
          iconSize: 24,
          elevation: 8,
          underline: SizedBox.shrink(),
          isExpanded: true,
          hint: TEXT(
            text: 'Pick bank',
            fontFamily: 'Gilroy-medium',
            color: Constants.usedGreen,
            edgeInset: EdgeInsets.zero,
          ),
          style: const TextStyle(color: Constants.usedGreen),
          // underline: Container(
          //   height: 2,
          //   color: Colors.green,
          // ),
          onChanged: (String? newValue) {
            print({newValue, "New bank Value"});
            setState(() {
              _bankVal = newValue!;
            });
            widget.onChange!(newValue);
          },
          items: Modular.get<VendorService>()
              .banks
              ?.map<DropdownMenuItem<String>>((BankList value) {
            return DropdownMenuItem<String>(
              value: value.code,
              child: TEXT(
                text: value.name!,
                color: ThemeBuilder.of(context)?.getCurrentTheme() ==
                        Brightness.light
                    ? Colors.black
                    : Colors.white,
              ),
            );
          }).toList(),
        ),
      ),
    ]);
  }
}


// Container(
//                   width: 130,
//                   height: 130,
//                   margin: EdgeInsets.only(right: 20),
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(10),
//                       border: Border.all(color: Constants.usedGreen)),
//                   child: InkWell(
//                     onTap: () {},
//                     highlightColor: Colors.transparent,
//                     splashColor: Constants.usedGreen.withOpacity(.4),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Icon(
//                           Icons.add_circle_rounded,
//                           color: Constants.usedGreen,
//                           size: 32,
//                         ),
//                         SizedBox(height: 10),
//                         TEXT(
//                           text: 'Add New',
//                           fontFamily: 'Gilroy-medium',
//                           color: Constants.usedGreen,
//                           edgeInset: EdgeInsets.zero,
//                         )
//                       ],
//                     ),
//                   ),
//                 ),