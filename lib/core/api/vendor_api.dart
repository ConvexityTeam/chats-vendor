import 'dart:io';

import 'package:CHATS_Vendor/core/models/account_model.dart';
import 'package:CHATS_Vendor/core/models/vendor_details_model.dart';
import 'package:CHATS_Vendor/core/services/base_service.dart';
import 'package:CHATS_Vendor/core/services/vendor_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:http_parser/http_parser.dart';

class VendorAPI {
  getVendorDetails() async {
    String _userURL = _baseURL + 'vendors/${Modular.get<VendorService>().id}';
    try {
      final response = await Dio().get("$_userURL",
          options: Options(headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${Modular.get<VendorService>().token}',
          }));

      if (kDebugMode) print({"SENDING REQUEST TO API.... FOR Vendor details"});
      return response.data['data'];
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        print(e.response!.data);
        print(e.response!.headers);
        print(e.response!.requestOptions);
        print(e.response!.statusMessage);
        return e.response!.data;
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.requestOptions);
        print(e.message);
        return {"error": true, "message": "An error occured"};
        // throw e;
      }
    }
  }

  updateVendorProfile(VendorDetails vendorDetails) async {
    String _updateURL = _baseURL + 'users/profile';
    try {
      final response = await Dio().put(
        "$_updateURL",
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${Modular.get<VendorService>().token}',
        }),
        // data: {"userId": locator<VendorService>().id},
        data: vendorDetails.toJson(),
      );

      if (kDebugMode)
        print({"SENDING REQUEST TO API.... FOR Vendor profile update"});
      return response.data;
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        print(e.response!.data);
        print(e.response!.headers);
        print(e.response!.requestOptions);
        print(e.response!.statusMessage);
        return e.response!.data;
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.requestOptions);
        print(e.message);
        return {"error": true, "message": "An error occurred"};
        // throw e;
      }
    }
  }

  // Vendor profile pic update
  updateVendorProfilePic(File vendorProfilePic) async {
    String _updateURL = _baseURL + '/vendors/profile/upload';
    var imageByte = vendorProfilePic.readAsBytesSync();
    var formData = FormData.fromMap({
      "profile_pic": MultipartFile.fromBytes(
        imageByte,
        filename:
            '${Modular.get<VendorService>().vendorDetails!.firstName! + Modular.get<VendorService>().vendorDetails!.lastName!}.jpg',
        contentType: new MediaType("image", "jpeg"),
      ),
    });

    try {
      final response = await Dio().post(
        "$_updateURL",
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${Modular.get<VendorService>().token}',
        }),
        // data: {"userId": locator<VendorService>().id},
        data: formData,
      );

      if (kDebugMode)
        print({"SENDING REQUEST TO API.... FOR Vendor profile PIC update"});
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

  addBankAccount(AccountsModel account) async {
    String _addBankURL = _baseURL + 'users/accounts';
    try {
      final response = await Dio().post(
        "$_addBankURL",
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${Modular.get<VendorService>().token}',
        }),
        // data: {"userId": locator<VendorService>().id},
        data: account.toJson(),
      );

      if (kDebugMode)
        print({"SENDING REQUEST TO API.... FOR Adding vendor bank"});
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

  listBankAccounts() async {
    String _listBanks = _baseURL + 'users/accounts';
    try {
      final response = await Dio().get(
        "$_listBanks",
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${Modular.get<VendorService>().token}',
        }),
      );

      if (kDebugMode)
        print({"SENDING REQUEST TO API.... FOR Listing vendor banks"});
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
          "message": e.response!.statusMessage,
          "status": "error"
        };
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.requestOptions);
        print(e.message);
        return {
          "error": true,
          "message": "An error occurred",
          "status": "error"
        };
        // throw e;
      }
    }
  }

  getVendorSummary() async {
    String _vendorSummaryURL =
        _baseURL + 'vendors/summary/${Modular.get<VendorService>().id}';
    try {
      final response = await Dio().get(
        "$_vendorSummaryURL",
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${Modular.get<VendorService>().token}',
        }),
      );

      if (kDebugMode) print({"SENDING REQUEST TO API.... FOR vendor summary"});
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

  liquidateFunds(String? amount, Map? bankDetails) async {
    String _liquidateURL = _baseURL +
        'users/account/$amount/withdraw/${bankDetails?["account_number"]}';

    try {
      final response = await Dio().post(
        "$_liquidateURL",
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${Modular.get<VendorService>().token}',
        }),
      );

      if (kDebugMode)
        print({
          "SENDING REQUEST .... TO LIQUIDATE VENDOR WALLET",
        });
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
          "status": "error",
          "message": e.response!.statusMessage,
          "error": true
        };
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.requestOptions);
        print(e.message);
        return {"message": e.message, "status": "error", "error": true};
      }
    }
  }

  Future allTransactions(String? period) async {
    String? _transactionsURL = _baseURL +
        'vendors/chart/${period != null ? period : ''}'; //might need to edit
    try {
      final response = await Dio().get('$_transactionsURL',
          // queryParameters: {
          //   "period": period,
          // },
          options: Options(headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${Modular.get<VendorService>().token}',
          }));

      if (kDebugMode)
        print(
            {"SENDING REQUEST TO API.... FOR ALL TRANSACTIONS", response.data});
      return response.data;
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        print(e.response!.data);
        print(e.response!.headers);
        // print(e.response.request);
        return {"status": "failed", "message": e.message, "error": true};
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        // print(e.request);
        print(e.message);
        return {"status": "failed", "message": e.message, "error": true};
      }
    }
  }

  getBankList() async {
    String _getBankListURL = _baseURL + 'utils/banks';

    try {
      final response = await Dio().get(
        "$_getBankListURL",
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${Modular.get<VendorService>().token}',
          },
        ),
      );

      if (kDebugMode) print({"GET BANK LIST FOR VENDOR", response.data});
      return response.data;
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        print(e.response!.data);
        print(e.response!.headers);
        print(e.response!.requestOptions);
        print(e.response!.statusMessage);
        return {"message": e.message, "Status": "failed", "error": true};
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.requestOptions);
        print(e.message);
        return {"message": e.message, "status": "failed", "error": true};
      }
    }
  }

  // Self checkout  endpoints
  verifySMSToken(String token) async {
    String _verifySMSTokenURL = _baseURL + 'vendors/verify/sms-token/$token';

    try {
      final response = await Dio().post(
        "$_verifySMSTokenURL",
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${Modular.get<VendorService>().token}',
          },
        ),
      );

      if (kDebugMode)
        print(
            {"VERIFY SMS TOKEN AND RETURN BENEFICIARY DETAILS", response.data});
      return response.data;
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        print(e.response!.data);
        print(e.response!.headers);
        print(e.response!.requestOptions);
        print(e.response!.statusMessage);
        return {"message": e.message, "Status": "failed", "error": true};
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.requestOptions);
        print(e.message);
        return {"message": e.message, "status": "failed", "error": true};
      }
    }
  }

  confirmPayment(String reference, String pin, int beneficiaryId) async {
    String _verifyTokenURL =
        _baseURL + 'orders/token/confirm-payment/$reference';

    try {
      final response = await Dio().post("$_verifyTokenURL",
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
              'Authorization': 'Bearer ${Modular.get<VendorService>().token}',
            },
          ),
          data: {
            "pin": pin,
            "beneficiaryId": beneficiaryId.toString(),
          });

      if (kDebugMode)
        print({"CONFIRM PAYMENT AND CHANGE ORDER STATUS", response.data});
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
          "message": e.response?.data['message'],
          "Status": "failed",
          "error": true
        };
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.requestOptions);
        print(e.message);
        return {"message": e.message, "status": "failed", "error": true};
      }
    }
  }

  // Vendor Profile endpoint calls
  changePassword(String oldPassword, String newPassword) async {
    String _changePasswordURL = _baseURL + 'users/password';

    try {
      final response = await Dio().put("$_changePasswordURL",
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
              'Authorization': 'Bearer ${Modular.get<VendorService>().token}',
            },
          ),
          data: {
            "old_password": oldPassword,
            "new_password": newPassword,
          });

      if (kDebugMode) print({"CHANGE PASSWORD ENDPOINT CALL", response.data});
      return response.data;
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        print(e.response!.data);
        print(e.response!.headers);
        print(e.response!.requestOptions);
        print(e.response!.statusMessage);
        return e.response!.data;
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.requestOptions);
        print(e.message);
        return {"message": e.message, "status": "failed", "error": true};
      }
    }
  }

  changePin(String oldPin, String newPin) async {
    String _changePinURL = _baseURL + 'users/pin';

    try {
      final response = await Dio().put("$_changePinURL",
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
              'Authorization': 'Bearer ${Modular.get<VendorService>().token}',
            },
          ),
          data: {
            "old_pin": oldPin,
            "new_pin": newPin,
          });

      if (kDebugMode) print({"CHANGE PIN ENDPOINT CALL", response.data});
      return response.data;
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        print(e.response!.data);
        print(e.response!.headers);
        print(e.response!.requestOptions);
        print(e.response!.statusMessage);
        return e.response!.data;
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.requestOptions);
        print(e.message);
        return {"message": e.message, "status": "failed", "error": true};
      }
    }
  }

  setPin(String pin) async {
    String _setPinURL = _baseURL + 'users/pin';

    try {
      final response = await Dio().post("$_setPinURL",
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
              'Authorization': 'Bearer ${Modular.get<VendorService>().token}',
            },
          ),
          data: {"pin": pin});

      if (kDebugMode) print({"SET PIN ENDPOINT CALL", response.data});
      return response.data;
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        print(e.response!.data);
        print(e.response!.headers);
        print(e.response!.requestOptions);
        print(e.response!.statusMessage);
        return e.response!.data;
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.requestOptions);
        print(e.message);
        return {"message": e.message, "status": "failed", "error": true};
      }
    }
  }

  resetUserPasswordReq(String? email, String? phone) async {
    // String _resetPasswordURL = BaseService.rootApi + '/users/reset-password';
    String _resetPasswordURL = _baseURL + '/auth/password/reset';

    try {
      final response = await Dio().post(
        "$_resetPasswordURL",
        data: {"email": email, "phone": phone},
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );

      if (kDebugMode) print({"RESETTING USERS PASSWORD", response.data});
      return response.data;
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        print(e.response!.data);
        print(e.response!.headers);
        print(e.response!.requestOptions);
        print(e.response!.statusMessage);
        return e.response!.data;
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.requestOptions);
        print(e.message);
        return {"message", e.message};
      }
    }
  }

  resetUserPasswordSetnew(String? ref, String? otp, String? newPassword,
      String? confirmNewPass) async {
    // String _resetPasswordURL = BaseService.rootApi + '/users/reset-password';
    String _resetPasswordURL = _baseURL + '/auth/password/reset';

    try {
      final response = await Dio().put(
        "$_resetPasswordURL",
        data: {
          "ref": ref,
          "otp": otp,
          "password": newPassword,
          "confirm_password": confirmNewPass,
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );

      if (kDebugMode) print({"RESETTING USERS PASSWORD", response.data});
      return response.data;
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        print(e.response!.data);
        print(e.response!.headers);
        print(e.response!.requestOptions);
        print(e.response!.statusMessage);
        return e.response!.data;
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.requestOptions);
        print(e.message);
        return {"message", e.message};
      }
    }
  }

  String _baseURL = BaseService.rootApi;
}
