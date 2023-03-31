import 'package:CHATS_Vendor/Utils/colors.dart';
import 'package:CHATS_Vendor/core/models/order_model.dart';
import 'package:CHATS_Vendor/core/services/store_service.dart';
import 'package:CHATS_Vendor/theme_changer.dart';
import 'package:CHATS_Vendor/ui/shared/BTN.dart';
import 'package:CHATS_Vendor/ui/shared/TEXT.dart';
import 'package:CHATS_Vendor/ui/shared/ui_helper.dart';
import 'package:CHATS_Vendor/ui/view_model/base_view_model.dart';
import 'package:CHATS_Vendor/ui/view_model/payment_view_VM.dart';
import 'package:CHATS_Vendor/ui/widgets/bottom_drawer.dart';
import 'package:CHATS_Vendor/ui/widgets/error_widget_handler.dart';
import 'package:CHATS_Vendor/ui/widgets/tag.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jiffy/jiffy.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:snack/snack.dart';

class AcceptPaymentsView extends StatefulWidget {
  @override
  _AcceptPaymentsViewState createState() => _AcceptPaymentsViewState();
}

class _AcceptPaymentsViewState extends State<AcceptPaymentsView> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  OrderModel? bottomDrawerContent;

  @override
  Widget build(BuildContext context) {
    // double width = MediaQuery.of(context).size.width;
    // var orientation = MediaQuery.of(context).orientation;
    return BaseViewModel<PaymentVM>(
      providerReady: (provider) => provider.initHeight(context),
      builder: (context, provider, child) {
        return Scaffold(
          backgroundColor:
              ThemeBuilder.of(context)?.getCurrentTheme() == Brightness.light
                  ? Color.fromRGBO(250, 250, 250, 1)
                  : primaryColorDarkMode,
          appBar: AppBar(
            elevation: 0,
            backgroundColor:
                ThemeBuilder.of(context)?.getCurrentTheme() == Brightness.light
                    ? Colors.white
                    : primaryColorDarkMode,
            centerTitle: false,
            leading: GestureDetector(
              onTap: () {
                Modular.to.pushNamed('/home/');
              },
              child: Image.asset("icons/arrow_back.png",
                  color: ThemeBuilder.of(context)?.getCurrentTheme() ==
                          Brightness.light
                      ? Colors.black
                      : Colors.white),
            ),
            title: Text(
              "Payments - Products",
              textAlign: TextAlign.left,
              style: TextStyle(
                color: ThemeBuilder.of(context)?.getCurrentTheme() ==
                        Brightness.light
                    ? Colors.black
                    : Colors.white,
                fontFamily: "Gilroy-medium",
                fontSize: 22.sp,
              ),
            ),
          ),
          body: Stack(children: [
            Padding(
              padding: EdgeInsets.all(24.w),
              child: Column(
                children: [
                  SizedBox(height: 10.h),
                  BTN(
                    height: 52.h,
                    margin: EdgeInsets.zero,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                      SizedBox(width: 20.w),
                      TEXT(
                        text: 'Create new payment',
                        color: Colors.white,
                        fontFamily: 'Gilroy-medium',
                      )
                    ],
                    onTap: () async {
                      // Navigator.pushNamed(context, Routes.paymentSummary);
                      if (Modular.get<StoreService>().campaigns == null ||
                          Modular.get<StoreService>().orders == null) {
                        var snackBar = SnackBar(
                          content: TEXT(
                            text:
                                'Error in getting campaign data, or you may not have been added to a campaign yet',
                            color: Colors.white,
                            fontFamily: 'Gilroy-medium',
                          ),
                        );
                        snackBar.show(context);
                        return;
                      }
                      // var campaignID = await pickCampaign(context);

                      // print({"Campaign ID", campaignID});

                      // if (campaignID == null) return;

                      // Navigate to the my campaign list view
                      Modular.to.pushNamed('/home/campaigns');
                    },
                  ),
                  SizedBox(height: 25.h),
                  SizedBox(
                    width: double.infinity,
                    child: TEXT(
                      text: 'Pending Payments',
                      fontFamily: 'Gilroy-medium',
                      textAlign: TextAlign.left,
                      fontSize: 23.sp,
                      color: ThemeBuilder.of(context)?.getCurrentTheme() ==
                              Brightness.light
                          ? Colors.black
                          : Colors.white,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  FutureBuilder(
                    // future: Modular.get<StoreService>().getAllVendorOrders(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Container(
                            child: Center(
                                child: CircularProgressIndicator.adaptive()));
                      }

                      if (snapshot.hasError) {
                        return ErrorWidgetHandler(onTap: () {
                          setState(() {});
                        });
                      }

                      if (snapshot.data is String) {
                        return Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TEXT(
                                text: '${snapshot.data.toString()}',
                                color: ThemeBuilder.of(context)
                                            ?.getCurrentTheme() ==
                                        Brightness.light
                                    ? Colors.black
                                    : Colors.white,
                              ),
                              BTN(
                                children: [TEXT(text: 'Refresh')],
                                onTap: () {
                                  setState(() {});
                                },
                              ),
                            ],
                          ),
                        );
                      }

                      return Expanded(
                        child: RefreshIndicator(
                          onRefresh: () async {
                            await Modular.get<StoreService>()
                                .getAllVendorOrders();
                          },
                          child: StatefulBuilder(builder: (context, setState) {
                            return ListView(
                              children: Modular.get<StoreService>().orders !=
                                          null ||
                                      Modular.get<StoreService>()
                                          .orders!
                                          .isNotEmpty
                                  ? Modular.get<StoreService>()
                                      .orders!
                                      .where((i) => i.status != 'confirmed')
                                      .map((e) => paymentsCard(
                                            status: '${e.status}',
                                            amount:
                                                '${e.cart?[0].totalAmount.toString()}',
                                            dateGenerated:
                                                '${Jiffy(e.createdAt!).format('do MMM')}',
                                            qrReference: '${e.reference}',
                                            onTap: () {
                                              setState(() {
                                                bottomDrawerContent = e;
                                              });
                                              provider
                                                  .toggleVisibility(context);
                                            },
                                          ))
                                      .toList()
                                  : [
                                      Container(
                                        child: TEXT(
                                          text:
                                              'No pending orders at this time',
                                          color: ThemeBuilder.of(context)
                                                      ?.getCurrentTheme() ==
                                                  Brightness.light
                                              ? Colors.black
                                              : Colors.white,
                                        ),
                                      ),
                                    ],
                            );
                          }),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            BottomDrawer(
              height: provider.visibleHeight,
              child: drawerChild(provider, context, bottomDrawerContent),
            ),
          ]),
        );
      },
    );
  }

  pickCampaign(BuildContext context) {
    print({"Campaign Length", Modular.get<StoreService>().campaigns?.length});
    var uniqueCampaignList =
        Modular.get<StoreService>().campaigns?.toSet().toList();
    print({"Campaign Unique Length", uniqueCampaignList?.length});
    return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          elevation: 3,
          child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * .35,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: Modular.get<StoreService>().campaigns?.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            ListTile(
                              title: TEXT(
                                text:
                                    '${Modular.get<StoreService>().campaigns![index].campaign?.title}',
                                fontFamily: 'Gilroy-medium',
                              ),
                              subtitle: TEXT(
                                  text:
                                      'Campaign ID: ${Modular.get<StoreService>().campaigns![index].campaignId}'),
                              trailing: Icon(
                                Icons.check_circle_rounded,
                                color: Modular.get<StoreService>()
                                        .campaigns![index]
                                        .approved!
                                    ? Colors.green
                                    : Colors.red,
                              ),
                              horizontalTitleGap: 10,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: BorderSide()),
                              onTap: () {
                                Navigator.pop(
                                    context,
                                    Modular.get<StoreService>()
                                        .campaigns![index]
                                        .campaignId);
                              },
                            ),
                            Divider(
                              color: Colors.grey.shade800.withOpacity(.5),
                              height: 10,
                              thickness: 2,
                            ),
                          ],
                        );
                      },
                    ),
                  )
                ],
              )),
        );
      },
    );
  }

  Widget drawerChild(
      PaymentVM provider, BuildContext context, OrderModel? content) {
    CarouselController carouselController = CarouselController();
    double width = MediaQuery.of(context).size.width;

    return CarouselSlider.builder(
      carouselController: carouselController,
      options: CarouselOptions(
        height: double.infinity,
        initialPage: 0,
        aspectRatio: 16 / 9,
        enlargeCenterPage: true,
        viewportFraction: 0.9,
        autoPlay: false,
        scrollDirection: Axis.horizontal,
      ),
      itemCount: 2,
      itemBuilder: (context, index, pageViewIndex) {
        return index <= 0
            ? Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TEXT(
                        text: 'Payment details',
                        color: ThemeBuilder.of(context)?.getCurrentTheme() ==
                                Brightness.light
                            ? Color.fromRGBO(37, 57, 111, 1)
                            : Colors.white,
                        fontSize: 22,
                        fontFamily: 'Gilroy-bold',
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          TEXT(
                            text: 'Slide',
                            fontFamily: 'Gilroy-medium',
                            color:
                                ThemeBuilder.of(context)?.getCurrentTheme() ==
                                        Brightness.light
                                    ? Color.fromRGBO(37, 57, 111, 1)
                                    : Colors.white,
                          ),
                          SizedBox(width: 10),
                          Icon(
                            Icons.arrow_right_alt_rounded,
                            color:
                                ThemeBuilder.of(context)?.getCurrentTheme() ==
                                        Brightness.light
                                    ? Color.fromRGBO(37, 57, 111, 1)
                                    : Colors.white,
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 4,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    TEXT(
                                      text: 'QR Reference',
                                      color: ThemeBuilder.of(context)
                                                  ?.getCurrentTheme() ==
                                              Brightness.light
                                          ? Color.fromRGBO(37, 57, 111, 1)
                                          : Colors.white,
                                      // fontSize: 22,
                                      fontFamily: 'Gilroy-regular',
                                    ),
                                    SizedBox(height: 10),
                                    TEXT(
                                      text:
                                          '${content?.reference ?? 'QR-21290'}',
                                      color: ThemeBuilder.of(context)
                                                  ?.getCurrentTheme() ==
                                              Brightness.light
                                          ? Color.fromRGBO(37, 57, 111, 1)
                                          : Colors.white,
                                      fontSize: 20,
                                      fontFamily: 'Gilroy-medium',
                                      softWrap: false,
                                      maxLines: 2,
                                      textOverflow: TextOverflow.visible,
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TEXT(
                                      text: 'Amount',
                                      color: ThemeBuilder.of(context)
                                                  ?.getCurrentTheme() ==
                                              Brightness.light
                                          ? Color.fromRGBO(37, 57, 111, 1)
                                          : Colors.white,
                                      // fontSize: 22,
                                      fontFamily: 'Gilroy-regular',
                                    ),
                                    SizedBox(height: 10),
                                    TEXT(
                                      text:
                                          'NGN ${content?.cart?[0].totalAmount?.toStringAsFixed(2) ?? '0.00'}',
                                      color: ThemeBuilder.of(context)
                                                  ?.getCurrentTheme() ==
                                              Brightness.light
                                          ? Color.fromRGBO(37, 57, 111, 1)
                                          : Colors.white,
                                      fontSize: 20,
                                      fontFamily: 'Gilroy-medium',
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 3,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TEXT(
                                      text: 'Generated on',
                                      color: ThemeBuilder.of(context)
                                                  ?.getCurrentTheme() ==
                                              Brightness.light
                                          ? Color.fromRGBO(37, 57, 111, 1)
                                          : Colors.white,
                                      // fontSize: 22,
                                      fontFamily: 'Gilroy-regular',
                                    ),
                                    SizedBox(height: 10),
                                    TEXT(
                                      text: content?.createdAt != null
                                          ? '${Jiffy(content!.createdAt!).format('do MMM, yyy. h:mm')}'
                                          : '',
                                      color: ThemeBuilder.of(context)
                                                  ?.getCurrentTheme() ==
                                              Brightness.light
                                          ? Color.fromRGBO(37, 57, 111, 1)
                                          : Colors.white,
                                      fontSize: 20,
                                      fontFamily: 'Gilroy-medium',
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 4,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TEXT(
                                      text: 'Transaction ID',
                                      color: ThemeBuilder.of(context)
                                                  ?.getCurrentTheme() ==
                                              Brightness.light
                                          ? Color.fromRGBO(37, 57, 111, 1)
                                          : Colors.white,
                                      // fontSize: 22,
                                      fontFamily: 'Gilroy-regular',
                                    ),
                                    SizedBox(height: 10),
                                    TEXT(
                                      text: content?.id.toString() ??
                                          'CHATS0123456',
                                      color: ThemeBuilder.of(context)
                                                  ?.getCurrentTheme() ==
                                              Brightness.light
                                          ? Color.fromRGBO(37, 57, 111, 1)
                                          : Colors.white,
                                      fontSize: 20,
                                      fontFamily: 'Gilroy-medium',
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TEXT(
                                      text: 'Status',
                                      // fontSize: 22,
                                      color: ThemeBuilder.of(context)
                                                  ?.getCurrentTheme() ==
                                              Brightness.light
                                          ? Color.fromRGBO(37, 57, 111, 1)
                                          : Colors.white,
                                      fontFamily: 'Gilroy-regular',
                                    ),
                                    SizedBox(height: 10),
                                    tag(content?.status ?? 'pending'),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  BTN(
                    margin: EdgeInsets.zero,
                    borderColor: Constants.usedGreen,
                    bgColor: Colors.transparent,
                    height: 42,
                    child: TEXT(
                      text: 'Close',
                      fontSize: 21,
                      fontFamily: 'Gilroy-medium',
                      color: Constants.usedGreen,
                      textAlign: TextAlign.center,
                    ),
                    onTap: () {
                      provider.toggleVisibility(context);
                    },
                  ),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TEXT(
                        text: 'Payment QR Code',
                        color: ThemeBuilder.of(context)?.getCurrentTheme() ==
                                Brightness.light
                            ? Color.fromRGBO(37, 57, 111, 1)
                            : Colors.white,
                        fontSize: 22,
                        fontFamily: 'Gilroy-bold',
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          TEXT(
                            text: 'Slide',
                            fontFamily: 'Gilroy-medium',
                            color:
                                ThemeBuilder.of(context)?.getCurrentTheme() ==
                                        Brightness.light
                                    ? Color.fromRGBO(37, 57, 111, 1)
                                    : Colors.white,
                          ),
                          SizedBox(width: 10),
                          Icon(
                            Icons.arrow_right_alt_rounded,
                            color:
                                ThemeBuilder.of(context)?.getCurrentTheme() ==
                                        Brightness.light
                                    ? Color.fromRGBO(37, 57, 111, 1)
                                    : Colors.white,
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Expanded(
                    child: QrImage(
                      data: content?.reference ?? 'QR-21290',
                      version: QrVersions.auto,
                      // size: 320,
                      gapless: false,
                      errorStateBuilder: (cxt, err) {
                        return Container(
                          child: Center(
                            child: Text(
                              "Could not generate the QR Code",
                              style: TextStyle(
                                  color: ThemeBuilder.of(context)
                                              ?.getCurrentTheme() ==
                                          Brightness.light
                                      ? Colors.black
                                      : Colors.white),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
      },
    );
  }

  Widget paymentsCard({
    String? status,
    String? amount,
    String? dateGenerated,
    String? qrReference,
    Function()? onTap,
  }) {
    return GestureDetector(
      onTap: () => onTap!(),
      child: Card(
        elevation: 0,
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TEXT(
                      text: '${qrReference ?? 'QR-21290'}',
                      color: Color.fromRGBO(37, 57, 111, 1),
                      fontSize: 22,
                      fontFamily: 'Gilroy-medium',
                      softWrap: true,
                      maxLines: 2,
                      textOverflow: TextOverflow.ellipsis,
                    ),
                  ),
                  tag(status ?? 'pending')
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TEXT(
                    text: 'Amount',
                    color: Color.fromRGBO(37, 57, 111, 1),
                  ),
                  TEXT(
                    text: 'Generated on',
                    color: Color.fromRGBO(37, 57, 111, 1),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TEXT(
                    text: 'NGN ${amount ?? 15500}',
                    fontFamily: 'Gilroy-medium',
                    color: Color.fromRGBO(37, 57, 111, 1),
                    fontSize: 20,
                  ),
                  TEXT(
                    text: '${dateGenerated ?? '03 Dec, 2020. 12:45 pm'}',
                    fontFamily: 'Gilroy-medium',
                    color: Color.fromRGBO(37, 57, 111, 1),
                    fontSize: 20,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
