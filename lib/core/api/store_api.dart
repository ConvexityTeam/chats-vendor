import 'package:CHATS_Vendor/core/services/base_service.dart';
import 'package:CHATS_Vendor/core/services/store_service.dart';
import 'package:CHATS_Vendor/core/services/vendor_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_modular/flutter_modular.dart';

class StoreAPI {
  getVendorStore() async {
    String _vendorStoreURL =
        _baseURL + '/vendors/store/${Modular.get<VendorService>().id}';
    try {
      final response = await Dio().get(
        "$_vendorStoreURL",
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${Modular.get<VendorService>().token}',
        }),
      );

      if (kDebugMode) print({"SENDING REQUEST TO API.... FOR vendor store"});
      String id = response.data['data']['id'];
      Modular.get<StoreService>().storeId = id;
      return response.data['data'];
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        print(e.response!.data);
        print(e.response!.headers);
        print(e.response!.requestOptions);
        print(e.response!.statusMessage);
        return {"error": true, "message": e.response!.statusMessage};
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.requestOptions);
        print(e.message);
        return {"error": true, "message": "An error occured"};
        // throw e;
      }
    }
  }

  getProductsByStore() async {
    String _productsURL = _baseURL +
        'vendors/store/products/${Modular.get<StoreService>().storeId}';
    try {
      final response = await Dio().get(
        "$_productsURL",
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${Modular.get<VendorService>().token}',
        }),
      );

      if (kDebugMode)
        print({"SENDING REQUEST TO API.... FOR vendor store products"});
      return response.data['data'];
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        print(e.response!.data);
        print(e.response!.headers);
        print(e.response!.requestOptions);
        print(e.response!.statusMessage);
        return {"error": true, "message": e.response!.statusMessage};
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.requestOptions);
        print(e.message);
        return {"error": true, "message": "An error occured"};
        // throw e;
      }
    }
  }

  getProducts() async {
    String _productsURL = _baseURL + 'vendors/products';
    try {
      final response = await Dio().get(
        "$_productsURL",
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${Modular.get<VendorService>().token}',
        }),
      );

      if (kDebugMode) print({"SENDING REQUEST TO API.... FOR vendor products"});
      return response.data;
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        print(e.response!.data);
        print(e.response!.headers);
        print(e.response!.requestOptions);
        print(e.response!.statusMessage);
        return {"error": true, "message": e.response!.statusMessage};
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.requestOptions);
        print(e.message);
        return {"error": true, "message": "An error occured"};
        // throw e;
      }
    }
  }

  getProductDetails(String? productId) async {
    String _productDetailsURL = _baseURL + 'vendors/products/single/$productId';
    try {
      final response = await Dio().get(
        "$_productDetailsURL",
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${Modular.get<VendorService>().token}',
        }),
      );

      if (kDebugMode) print({"SENDING REQUEST TO API.... FOR product details"});
      return response.data['data'];
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        print(e.response!.data);
        print(e.response!.headers);
        print(e.response!.requestOptions);
        print(e.response!.statusMessage);
        return {"error": true, "message": e.response!.statusMessage};
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.requestOptions);
        print(e.message);
        return {"error": true, "message": "An error occured"};
        // throw e;
      }
    }
  }

  createOrder(List<Map<String, dynamic>> cart, int campaignId) async {
    String _createOrderURL = _baseURL + 'vendors/orders';
    try {
      final response = await Dio().post(
        "$_createOrderURL",
        data: {
          "campaign_id": campaignId,
          "products": cart,
        },
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${Modular.get<VendorService>().token}',
        }),
      );

      if (kDebugMode) print({"SENDING REQUEST TO API.... FOR ORDER creattion"});
      return response.data;
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        print(e.response!.data);
        print(e.response!.headers);
        print(e.response!.requestOptions);
        print(e.response!.statusMessage);
        return {
          "error": true,
          "status": "failed",
          "message": e.response!.statusMessage
        };
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.requestOptions);
        print(e.message);
        return {
          "error": true,
          "status": "failed",
          "message": "An error occurred"
        };
        // throw e;
      }
    }
  }

  findSingleOrder(String? orderId) async {
    String _findOrderURL = _baseURL + 'vendors/orders/$orderId';
    try {
      final response = await Dio().get(
        "$_findOrderURL",
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${Modular.get<VendorService>().token}',
        }),
      );

      if (kDebugMode)
        print({"SENDING REQUEST TO API.... FOR finding and order"});
      return response.data['data'];
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        print(e.response!.data);
        print(e.response!.headers);
        print(e.response!.requestOptions);
        print(e.response!.statusMessage);
        return {"error": true, "message": e.response!.statusMessage};
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.requestOptions);
        print(e.message);
        return {"error": true, "message": "An error occured"};
        // throw e;
      }
    }
  }

  getAllOrders() async {
    String _findOrderURL = _baseURL + 'vendors/orders';
    print({Modular.get<VendorService>().token, "Vendor token"});
    try {
      final response = await Dio().get(
        "$_findOrderURL",
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${Modular.get<VendorService>().token}',
        }),
      );

      if (kDebugMode)
        print({
          "SENDING REQUEST TO API.... FOR finding all vendor orders",
          response.data
        });
      return response.data['data'];
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        print(e.response!.data);
        print(e.response!.headers);
        print(e.response!.requestOptions);
        print(e.response!.statusMessage);
        return {"error": true, "message": e.response!.statusMessage};
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.requestOptions);
        print(e.message);
        return {"error": true, "message": "An error occured"};
        // throw e;
      }
    }
  }

  getVendorCampaigns() async {
    String _vendorCampaigns = _baseURL + 'vendors/campaigns';
    try {
      final response = await Dio().get(
        "$_vendorCampaigns",
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${Modular.get<VendorService>().token}',
        }),
      );

      if (kDebugMode)
        print({
          "SENDING REQUEST TO API.... FOR finding all vendor orders",
          response.data
        });
      return response.data['data'];
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        print(e.response!.data);
        print(e.response!.headers);
        print(e.response!.requestOptions);
        print(e.response!.statusMessage);
        return {"error": true, "message": e.response!.statusMessage};
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.requestOptions);
        print(e.message);
        return {"error": true, "message": "An error occured"};
      }
    }
  }

  String _baseURL = BaseService.rootApi;
}
