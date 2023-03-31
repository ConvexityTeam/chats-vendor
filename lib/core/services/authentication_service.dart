import 'dart:convert';

import 'package:CHATS_Vendor/core/models/user_model.dart';
import 'package:CHATS_Vendor/core/services/base_service.dart';
import 'package:CHATS_Vendor/core/services/local_storage_service.dart';
import 'package:CHATS_Vendor/core/services/vendor_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:http/http.dart' as http;

class AuthenticationService extends BaseService {
  String authUrl = BaseService.rootApi + 'vendors/auth';
  Future<Map<String, dynamic>>? register(UserModel userObj) async {
    try {
      final response = await http.post(Uri.parse("${authUrl}/register"),
          body: jsonEncode(userObj.toJson()), headers: header);

      print(jsonDecode(response.body));
      return jsonDecode(response.body);
    } catch (e) {
      print(e);
      return {"message": e.toString()};
    }
  }

  Future<Map<String, dynamic>> login(String vendorId, String password) async {
    String _loginURL = authUrl + '/login';
    try {
      final keyStore = Modular.get<SharedPref>();
      final response = await Dio().post(
        "$_loginURL",
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        }),
        data: {"vendor_id": vendorId, "password": password},
      );

      if (kDebugMode)
        print({"SENDING REQUEST TO API.... FOR Vendor login", response.data});
      String token = response.data['data']['token'];
      String id = response.data['data']['user']['id'].toString();
      String pin = response.data['data']['user']['pin'];

      Modular.get<VendorService>().token = token;
      keyStore.saveToDisk('localUserToken', token);
      Modular.get<VendorService>().id = id;
      keyStore.saveToDisk('localUserID', id);
      Modular.get<VendorService>().pin = pin;
      keyStore.saveToDisk('userPinSet', pin);
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
        return {"error": true, "message": e.message};
        // throw e;
      }
    }
  }
}
