import 'package:CHATS_Vendor/core/provider_model/base_provider_model.dart';
import 'package:flutter/material.dart';

class PaymentVM extends BaseProviderModel {
  late double visibleHeight;

  initHeight(BuildContext context) {
    visibleHeight = -(MediaQuery.of(context).size.height * .45);
  }

  void toggleVisibility(BuildContext context) {
    visibleHeight =
        visibleHeight == 0 ? -(MediaQuery.of(context).size.height * .45) : 0;
    notifyListeners();
  }
}
