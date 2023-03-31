import 'dart:io';

import 'package:CHATS_Vendor/core/api/vendor_api.dart';
import 'package:CHATS_Vendor/core/models/account_model.dart';
import 'package:CHATS_Vendor/core/models/bank_list.dart';
import 'package:CHATS_Vendor/core/models/transactions_history.dart';
import 'package:CHATS_Vendor/core/models/vendor_details_model.dart';
import 'package:CHATS_Vendor/core/services/store_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_modular/flutter_modular.dart';

class VendorService extends ChangeNotifier {
  bool _isUploadingProfilePic = false;
  bool get isUploading => _isUploadingProfilePic;
  String? token;
  String? id;
  String? pin;
  VendorDetails? _vendorDetails;
  List<AccountsModel>? _accounts;
  TransactionsHistory? _history;
  List<BankList>? _banks;

  List<AccountsModel>? get accounts {
    return _accounts;
  }

  VendorDetails? get vendorDetails {
    return _vendorDetails;
  }

  TransactionsHistory? get history {
    return _history;
  }

  List<BankList>? get banks {
    return _banks;
  }

  Future<void> gettingVendorDetails() async {
    Map<String, dynamic> detailResponse = await VendorAPI().getVendorDetails();
    _vendorDetails = VendorDetails.fromJson(detailResponse);
    await Modular.get<StoreService>().getAllVendorOrders();
    if (kDebugMode) print({"Vendor details reponse", detailResponse});
  }

  Future<Map?> updateVendorProfile(VendorDetails updateData) async {
    var response = await VendorAPI().updateVendorProfile(updateData);

    if (kDebugMode) print({"Updating vendor profile", response});

    return response;
  }

  Future<String?> updateVendorProfilePic(File pic) async {
    _isUploadingProfilePic = true;
    notifyListeners();
    var response = await VendorAPI().updateVendorProfilePic(pic);
    if (kDebugMode)
      print({"Updating vendor profile pic", response, response.keys});
    _isUploadingProfilePic = false;
    notifyListeners();

    return response['message'];
  }

  Future<String?> addBankAccount(AccountsModel newAccount) async {
    var response = await VendorAPI().addBankAccount(newAccount);
    if (kDebugMode) print({"Add bank account details", response});
    return response['message'];
  }

  Future listBankAccounts() async {
    var response = await VendorAPI().listBankAccounts();
    if (kDebugMode) print({"List bank accounts of vendor", response});

    if (response['status'] == 'success') {
      _accounts = response['data']
          .map<AccountsModel>((item) => AccountsModel.fromJson(item))
          .toList();
    }
    this.getBankList();
  }

  Future<String> liquidateUserWallet(String? amount, Map? bankDetails) async {
    var response = await VendorAPI().liquidateFunds(amount!, bankDetails);
    if (kDebugMode) print({"Liquidating vendor balance", response});
    return response['message'];
  }

  Future<void> retrieveTransactions(period) async {
    var response = await VendorAPI().allTransactions(period);
    if (kDebugMode)
      print({"Retrieving the transaction history of the user", response});

    if (response['status'] != "failed") {
      _history = TransactionsHistory.fromJson(response['data']);
    }
  }

  Future<void> getBankList() async {
    var response = await VendorAPI().getBankList();
    if (response['status'] == 'success') {
      _banks = response['data'].isEmpty
          ? []
          : response['data']
              .map<BankList>((item) => BankList.fromJson(item))
              .toList();
    }
  }

  Future<Map?> verifySMSToken(String token) async {
    var response = await VendorAPI().verifySMSToken(token);

    if (response['status'] == 'success') {
      return response['data'] as Map;
    }

    return null;
  }

  Future<Map?> confirmPayment(
    String reference,
    String pin,
    int beneficiaryId,
  ) async {
    var response =
        await VendorAPI().confirmPayment(reference, pin, beneficiaryId);

    return response;
  }

  // Profile management services
  Future<String?> changePassword(String oldPassword, String newPassword) async {
    var response = await VendorAPI().changePassword(oldPassword, newPassword);

    if (kDebugMode) print({"Error", response['data'], response['message']});

    return response['message'];
  }

  Future<String?> setPin(String pin) async {
    var response = await VendorAPI().setPin(pin);

    if (kDebugMode) print({"Error", response['data'], response['message']});

    return response['message'];
  }

  Future<String?> changePin(String oldPin, String newPin) async {
    var response = await VendorAPI().changePin(oldPin, newPin);

    if (kDebugMode) print({"Error", response['data'], response['message']});

    return response['message'];
  }

  Future<Map?> resetUserPasswordReq(String? email, String? phone) async {
    var response = await VendorAPI().resetUserPasswordReq(email, phone);
    if (kDebugMode) print('sent req to reset users password... $response');
    return response;
  }

  Future<Map?> resetUserPasswordSetnew(
      String? ref, String? otp, String? newPass, String? confirmNewPass) async {
    var response = await VendorAPI()
        .resetUserPasswordSetnew(ref, otp, newPass, confirmNewPass);
    if (kDebugMode) print('Resetting users password... $response');
    return response;
  }
}
