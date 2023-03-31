import 'package:CHATS_Vendor/Utils/colors.dart';
import 'package:CHATS_Vendor/core/models/campaign_model.dart';
import 'package:CHATS_Vendor/core/services/store_service.dart';
import 'package:CHATS_Vendor/theme_changer.dart';
import 'package:CHATS_Vendor/ui/shared/TEXT.dart';
import 'package:CHATS_Vendor/ui/widgets/error_widget_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CampaignsVew extends StatefulWidget {
  final String? type;

  CampaignsVew({this.type});
  @override
  State<CampaignsVew> createState() => _CampaignsVewState();
}

class _CampaignsVewState extends State<CampaignsVew> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          text:
              "My ${(widget.type != null && widget.type!.isNotEmpty) ? widget.type != 'item' ? 'Cash' : 'Item' : ''} Campaigns",
          color: ThemeBuilder.of(context)?.getCurrentTheme() == Brightness.light
              ? Colors.black
              : Colors.white,
          fontFamily: "Gilroy-medium",
          fontSize: 22.sp,
        ),
      ),
      body: FutureBuilder(
        future: (widget.type == null || widget.type!.isEmpty)
            ? null
            : Modular.get<StoreService>().getVendorCampaigns(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }

          if (snapshot.hasError) {
            return ErrorWidgetHandler(onTap: () {
              setState(() {});
            });
          }

          if (Modular.get<StoreService>().campaigns == null ||
              Modular.get<StoreService>().campaigns?.length == 0) {
            return Center(
              child: TEXT(
                text: 'You are not a part of any campaigns at the moment!',
                color: ThemeBuilder.of(context)!.getCurrentTheme() ==
                        Brightness.light
                    ? Colors.black
                    : Colors.white,
              ),
            );
          }

          if (widget.type == null || widget.type!.isEmpty) {
            return Container(
              height: double.infinity,
              width: MediaQuery.of(context).size.width,
              color: ThemeBuilder.of(context)!.getCurrentTheme() ==
                      Brightness.light
                  ? Color.fromRGBO(250, 250, 250, 1)
                  : primaryColorDarkMode,
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 35.h),
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () =>
                              Modular.to.pushNamed('/home/campaigns/cash'),
                          child: Container(
                            width: double.infinity,
                            // height: 56,
                            decoration: BoxDecoration(
                              color:
                                  ThemeBuilder.of(context)!.getCurrentTheme() ==
                                          Brightness.light
                                      ? Colors.white
                                      : Color.fromRGBO(128, 128, 128, 1),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.r),
                              ),
                            ),
                            padding: EdgeInsets.symmetric(
                                vertical: 20.h, horizontal: 25.w),
                            margin: EdgeInsets.only(bottom: 12.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TEXT(
                                  text: 'Cash campaigns',
                                  fontFamily: 'Gilroy-Bold',
                                  fontSize: 16.sp,
                                ),
                                SizedBox(height: 12.h),
                                TEXT(
                                  text:
                                      'Campaigns involving monetary items e.g. Cash',
                                  fontFamily: 'Gilroy-Light',
                                  fontSize: 14.sp,
                                ),
                                SizedBox(height: 18.h),
                                TEXT(
                                  text:
                                      'Total campaigns: ${Modular.get<StoreService>().campaigns!.where((c) => c.campaign?.status != 'ended').where((c) => c.campaign?.type != 'item').length}',
                                  fontFamily: 'Gilroy-Light',
                                  fontSize: 14.sp,
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () =>
                              Modular.to.pushNamed('/home/campaigns/item'),
                          child: Container(
                            width: double.infinity,
                            // height: 56,
                            decoration: BoxDecoration(
                              color:
                                  ThemeBuilder.of(context)!.getCurrentTheme() ==
                                          Brightness.light
                                      ? Colors.white
                                      : Color.fromRGBO(128, 128, 128, 1),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.r),
                              ),
                            ),
                            padding: EdgeInsets.symmetric(
                                vertical: 20.h, horizontal: 25.w),
                            margin: EdgeInsets.only(bottom: 12.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TEXT(
                                  text: 'Item campaigns',
                                  fontFamily: 'Gilroy-Bold',
                                  fontSize: 16.sp,
                                ),
                                SizedBox(height: 12.h),
                                TEXT(
                                  text:
                                      'Campaigns involving non-monetary items e.g. Vaccine',
                                  fontFamily: 'Gilroy-Light',
                                  fontSize: 14.sp,
                                ),
                                SizedBox(height: 18.h),
                                TEXT(
                                  text:
                                      'Total campaigns: ${Modular.get<StoreService>().campaigns!.where((c) => c.campaign?.status != 'ended').where((c) => c.campaign?.type == 'item').length}',
                                  fontFamily: 'Gilroy-Light',
                                  fontSize: 14.sp,
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            );
          }

          return Container(
            height: double.infinity,
            width: MediaQuery.of(context).size.width,
            color:
                ThemeBuilder.of(context)!.getCurrentTheme() == Brightness.light
                    ? Color.fromRGBO(250, 250, 250, 1)
                    : primaryColorDarkMode,
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 25.h),
                  Column(
                    children: Modular.get<StoreService>()
                        .campaigns!
                        .where((c) => c.campaign?.status != 'ended')
                        .where(widget.type!.isNotEmpty && widget.type == 'item'
                            ? (c) => c.campaign?.type == 'item'
                            : (c) => c.campaign?.type != 'item')
                        .map(
                          (campaign) =>
                              buildCampaignsCard(campaign, type: widget.type),
                        )
                        .toList(),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildCampaignsCard(CampaignModel? item, {String? type}) {
    return GestureDetector(
      onTap: () => Modular.to
          .pushNamed('/payment/create?campaignId=${item?.campaignId}'),
      child: Container(
        width: double.infinity,
        // height: 56,
        decoration: BoxDecoration(
          color: ThemeBuilder.of(context)!.getCurrentTheme() == Brightness.light
              ? Colors.white
              : Color.fromRGBO(128, 128, 128, 1),
          borderRadius: BorderRadius.all(
            Radius.circular(10.r),
          ),
        ),
        padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 25.w),
        margin: EdgeInsets.only(bottom: 12.h),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TEXT(
                    text: item!.campaign!.title!,
                    color: ThemeBuilder.of(context)!.getCurrentTheme() ==
                            Brightness.light
                        ? Colors.black
                        : Colors.white,
                    fontSize: 16.sp,
                    fontFamily: "Gilroy-Bold",
                  ),
                )
              ],
            ),
            SizedBox(height: 10.h),
            productsList(item.campaignId),
          ],
        ),
      ),
    );
  }

  Widget productsList(int? campaignId) {
    List<Map?> products = Modular.get<StoreService>()
        .products!
        .map((product) {
          if (product.campaignId == campaignId) {
            return {"tag": product.tag, "cost": product.cost};
          }
        })
        .where((element) => element?["tag"] != null && element?["cost"] != null)
        .toList();

    return Column(
      children: products
          .map((item) => Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: TEXT(
                          text: 'Product/Service Tag',
                          color: ThemeBuilder.of(context)!.getCurrentTheme() ==
                                  Brightness.light
                              ? Colors.black
                              : Colors.white,
                          fontSize: 12.sp,
                          fontFamily: 'Gilroy-Light',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: TEXT(
                          text: item?["tag"] ?? '',
                          color: ThemeBuilder.of(context)!.getCurrentTheme() ==
                                  Brightness.light
                              ? Colors.black
                              : Colors.white,
                          fontFamily: "Gilroy-Light",
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 7.h),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: TEXT(
                          text: 'Cost',
                          color: ThemeBuilder.of(context)!.getCurrentTheme() ==
                                  Brightness.light
                              ? Colors.black
                              : Colors.white,
                          fontSize: 12.sp,
                          fontFamily: 'Gilroy-Light',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: TEXT(
                          text: item?["cost"]?.toStringAsFixed(2) ?? '',
                          color: ThemeBuilder.of(context)!.getCurrentTheme() ==
                                  Brightness.light
                              ? Colors.black
                              : Colors.white,
                          fontFamily: "Gilroy-Light",
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  products.length <= 1 ||
                          products.indexOf(item) == (products.length - 1)
                      ? SizedBox.shrink()
                      : Divider(height: 8.h, thickness: 2),
                ],
              ))
          .toList(),
    );
  }
}
