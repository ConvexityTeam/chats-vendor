import 'package:CHATS_Vendor/core/api/store_api.dart';
import 'package:CHATS_Vendor/core/models/campaign_model.dart';
import 'package:CHATS_Vendor/core/models/order_model.dart';
import 'package:CHATS_Vendor/core/models/product_model.dart';
import 'package:CHATS_Vendor/core/models/store_model.dart';
import 'package:flutter/foundation.dart';

class StoreService extends ChangeNotifier {
  String? storeId;
  StoreModel? _store;
  dynamic _productDetails;
  List<ProductModel>? _products;
  List<OrderModel>? _orders;
  List<CampaignModel>? _campaigns;

  StoreModel? get store {
    return _store;
  }

  List<ProductModel>? get products {
    return _products;
  }

  dynamic get productDetails {
    return _productDetails;
  }

  List<OrderModel>? get orders {
    return _orders;
  }

  List<CampaignModel>? get campaigns {
    return _campaigns;
  }

  Future refresh() async {
    _orders = null;
    _campaigns = null;
  }

  Future<void> getStoreDetails() async {
    Map<String, dynamic> responseDetails = await StoreAPI().getVendorStore();
    _store = StoreModel.fromJson(responseDetails);
    if (kDebugMode) print({"Store details reponse", responseDetails});
  }

  Future<String?> getProducts() async {
    var response = await StoreAPI().getProducts();
    if (kDebugMode) print({"Get Products response", response});

    if (response['status'] != 'success') {
      return response['message'];
    }

    _products = response['data']
        .map<ProductModel>((item) => ProductModel.fromJson(item))
        .toList();
  }

  Future<void> getProductDetails(String productId) async {
    _productDetails = await StoreAPI().getProductDetails(productId);
    if (kDebugMode) print({"Product details response", _productDetails});
  }

  Future<String?> getAllVendorOrders() async {
    var orderResponse = await StoreAPI().getAllOrders();
    if (kDebugMode) print({"Vendor orders response", orderResponse});

    _orders = orderResponse
        .map<OrderModel>((item) => OrderModel.fromJson(item))
        .toList();

    await this.getVendorCampaigns();
    var result = await this.getProducts();
    return result;
  }

  Future createOrder(List<Map<String, dynamic>> cart, int campaignId) async {
    var response = await StoreAPI().createOrder(cart, campaignId);

    if (response['status'] != 'success') {
      return response['message'];
    }

    return response['data'];
  }

  Future getVendorCampaigns() async {
    var response = await StoreAPI().getVendorCampaigns();
    if (kDebugMode) print({'<<<<CAMPAIGNS>>>>', response[0]});

    _campaigns = (response as List)
        .map<CampaignModel>((item) => CampaignModel.fromJson(item))
        .toList();
    await this.getProducts();
  }
}
