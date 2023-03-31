import 'package:CHATS_Vendor/Utils/colors.dart';
import 'package:CHATS_Vendor/core/services/store_service.dart';
import 'package:CHATS_Vendor/theme_changer.dart';
import 'package:CHATS_Vendor/ui/shared/BTN.dart';
import 'package:CHATS_Vendor/ui/shared/TEXT.dart';
import 'package:CHATS_Vendor/ui/shared/ui_helper.dart';
import 'package:CHATS_Vendor/ui/view_model/base_view_model.dart';
import 'package:CHATS_Vendor/ui/view_model/create_order_VM.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snack/snack.dart';

class PaymentCreateView extends StatefulWidget {
  const PaymentCreateView({Key? key, this.campaignId}) : super(key: key);

  final int? campaignId;
  @override
  _PaymentCreateViewState createState() => _PaymentCreateViewState();
}

class _PaymentCreateViewState extends State<PaymentCreateView> {
  // ScanResult? _result;

  // late TextEditingController _productTagController;

  @override
  void initState() {
    super.initState();
    // _productTagController = TextEditingController(text: '');
  }

  @override
  Widget build(BuildContext context) {
    // double width = MediaQuery.of(context).size.width;
    // var orientation = MediaQuery.of(context).orientation;
    // BeneficiaryUser? user = locator<UserService>().data;
    return BaseViewModel<CreateOrderVM>(
      providerReady: (provider) {},
      builder: (context, provider, child) {
        // List<String>? initialTags = provider.selectedProducts != null
        //     ? provider.selectedProducts
        //         ?.map<String>((item) => item.tag.toString())
        //         .toList()
        //     : null;

        return WillPopScope(
          onWillPop: () => onBackPressed(context),
          child: Scaffold(
            backgroundColor:
                ThemeBuilder.of(context)?.getCurrentTheme() == Brightness.light
                    ? Color.fromRGBO(250, 250, 250, 1)
                    : primaryColorDarkMode,
            appBar: AppBar(
              centerTitle: false,
              elevation: 0,
              backgroundColor: ThemeBuilder.of(context)?.getCurrentTheme() ==
                      Brightness.light
                  ? Colors.white
                  : primaryColorDarkMode,
              title: TEXT(
                text: 'Payments - Add Products',
                fontFamily: 'Gilroy-medium',
                fontSize: 22.sp,
                edgeInset: EdgeInsets.only(top: 3),
                color: ThemeBuilder.of(context)?.getCurrentTheme() ==
                        Brightness.light
                    ? Colors.black
                    : Colors.white,
              ),
              leading: GestureDetector(
                onTap: () {
                  provider.emptyCartItems();
                  Modular.to.pop(context);
                },
                child: Icon(
                  Icons.arrow_back_ios,
                  color: ThemeBuilder.of(context)?.getCurrentTheme() ==
                          Brightness.light
                      ? Colors.black
                      : Colors.white,
                ),
              ),
            ),
            body: Container(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TEXT(
                    text: 'Add Products',
                    fontFamily: 'Gilroy-medium',
                    textAlign: TextAlign.left,
                    fontSize: 23.sp,
                    color: ThemeBuilder.of(context)?.getCurrentTheme() ==
                            Brightness.light
                        ? Colors.black
                        : Colors.white,
                  ),
                  SizedBox(height: 10.h),
                  TEXT(
                    text:
                        'Add products to generate QR code for beneficiary to pay.',
                    fontFamily: 'Gilroy-regular',
                    color: ThemeBuilder.of(context)?.getCurrentTheme() ==
                            Brightness.light
                        ? Colors.black
                        : Colors.white,
                  ),
                  SizedBox(height: 20.h),
                  Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(15.0.w),
                      child: Column(
                        children: [
                          Wrap(
                            spacing: 15,
                            runSpacing: 10,
                            runAlignment: WrapAlignment.start,
                            children: Modular.get<StoreService>().products !=
                                    null
                                ? Modular.get<StoreService>()
                                    .products!
                                    .map<Widget>((element) {
                                    if (element.campaignId !=
                                        widget.campaignId) {
                                      return SizedBox.shrink();
                                    }

                                    if (kDebugMode)
                                      print({"<<<<PRODUCT>>>>", element.cost});

                                    return productTag(
                                      element.type!,
                                      element.tag!,
                                      () async {
                                        await provider.selectProduct(element);
                                        print({
                                          "Adding product to the cart",
                                          provider.cartItems,
                                          element,
                                        });

                                        setState(() {});
                                      },
                                    );
                                  }).toList()
                                : [],
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TEXT(
                        text: 'Products',
                        fontFamily: 'Gilroy-medium',
                        fontSize: 17.sp,
                        color: ThemeBuilder.of(context)?.getCurrentTheme() ==
                                Brightness.light
                            ? Colors.black
                            : Colors.white,
                      ),
                      TEXT(
                        text: 'Qty',
                        fontFamily: 'Gilroy-medium',
                        fontSize: 17.sp,
                        color: ThemeBuilder.of(context)?.getCurrentTheme() ==
                                Brightness.light
                            ? Colors.black
                            : Colors.white,
                      ),
                      TEXT(
                        text: 'Amount',
                        fontFamily: 'Gilroy-medium',
                        fontSize: 17.sp,
                        color: ThemeBuilder.of(context)?.getCurrentTheme() ==
                                Brightness.light
                            ? Colors.black
                            : Colors.white,
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 120.0.h),
                        child: Column(
                          children: [
                            Column(
                              children: provider.cartItems != null
                                  ? provider.cartItems!
                                  : [],
                            ),
                            Divider(height: 10.h, thickness: 3),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TEXT(
                                  text: 'Sub Total:',
                                  fontFamily: 'Gilroy-medium',
                                  fontSize: 18.sp,
                                  color: ThemeBuilder.of(context)
                                              ?.getCurrentTheme() ==
                                          Brightness.light
                                      ? Colors.blueGrey.shade600
                                      : Colors.white,
                                  textAlign: TextAlign.left,
                                ),
                                TEXT(
                                  text:
                                      'NGN ${provider.finalCartItems.isNotEmpty ? provider.finalCartItems.fold<double>(0, (previousValue, element) => previousValue + (element.cost == null ? 1.0 : element.cost! * element.qty!.toDouble())).toStringAsFixed(2) : '0.00'}',
                                  fontFamily: 'Gilroy-bold',
                                  fontSize: 18.sp,
                                  color: ThemeBuilder.of(context)
                                              ?.getCurrentTheme() ==
                                          Brightness.light
                                      ? Colors.blueGrey.shade600
                                      : Colors.white,
                                  textAlign: TextAlign.left,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            bottomSheet: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 30.h, horizontal: 20.w),
              color: ThemeBuilder.of(context)?.getCurrentTheme() ==
                      Brightness.light
                  ? Colors.white
                  : primaryColorDarkMode,
              child: BTN(
                disabled: provider.finalCartItems.isEmpty,
                margin: EdgeInsets.zero,
                onTap: () async {
                  // TODO: call the create order service and pass the cartItems array
                  if (provider.finalCartItems.isEmpty) {
                    var snackBar = SnackBar(
                        content: TEXT(
                      text:
                          'There are no items in your cart, try adding some products',
                      fontFamily: 'Gilroy-medium',
                      color: Colors.white,
                    ));
                    return snackBar.show(context);
                  }

                  List<Map<String, dynamic>> cartList = provider.finalCartItems
                      .map((e) => {
                            "quantity": e.qty,
                            "product_id": e.id,
                          })
                      .toList();

                  print(cartList);

                  final order = await Modular.get<StoreService>()
                      .createOrder(cartList, widget.campaignId!);

                  if (order is String) {
                    SnackBar(
                        content: TEXT(
                      text: order,
                      fontFamily: 'Gilroy-medium',
                      color: Colors.white,
                    )).show(context);
                    return;
                  }
                  // provider.emptyCartItems();

                  // print({
                  //   "Final cart qty",
                  //   provider.finalCartItems.fold(
                  //       0,
                  //       (int previousValue, element) =>
                  //           (previousValue + element.qty!)),
                  //   "Manual total churning",
                  //   provider.finalCartItems
                  // });
                  Modular.to.pushNamed(
                    '/payment/summary',
                    arguments: order,
                  );
                },
                child: TEXT(
                  color: Colors.white,
                  text: "Confirm",
                  fontSize: 18.sp,
                  fontFamily: 'Gilroy-bold',
                  edgeInset: EdgeInsets.zero,
                  textAlign: TextAlign.center,
                ),
                // style: ButtonStyle(),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget productTag(String type, String name, Function() tapHandler) {
    return GestureDetector(
      onTap: () => tapHandler(),
      child: Badge(
        label: TEXT(
          text: 'S',
          color: Colors.white,
        ),
        child: Container(
          child: TEXT(
            text: name,
            color: Colors.white,
            fontFamily: 'Gilroy-bold',
          ),
          padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
          decoration: BoxDecoration(
            color: Color.fromRGBO(23, 206, 137, 1),
            borderRadius: BorderRadius.circular(30.r),
          ),
        ),
        isLabelVisible: type == "product" ? false : true,
      ),
    );
  }
}
