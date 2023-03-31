import 'package:CHATS_Vendor/core/models/account_model.dart';
import 'package:CHATS_Vendor/core/models/organisation_model.dart';
import 'package:CHATS_Vendor/core/models/store_model.dart';
import 'package:CHATS_Vendor/modules/wallet/wallet.dart';

class VendorDetails {
  int? id;
  String? referalId;
  int? roleId;
  String? firstName;
  String? lastName;
  String? email;
  String? password;
  String? phone;
  String? bvn;
  String? nin;
  String? maritalStatus;
  String? gender;
  String? status;
  String? location;
  String? pin;
  String? address;
  String? vendorId;
  bool? isEmailVerified;
  bool? isPhoneVerified;
  bool? isBvnVerified;
  bool? isNinVerified;
  bool? isSelfSignup;
  bool? isPublic;
  bool? isTfaEnabled;
  String? tfaSecret;
  String? lastLogin;
  String? profilePic;
  String? nfc;
  String? dob;
  String? ip;
  String? createdAt;
  String? updatedAt;
  List<WalletModel>? wallets;
  StoreModel? store;
  List<OrganisationModel>? organisations;
  List<AccountsModel>? bankAccounts;

  VendorDetails({
    this.id,
    this.referalId,
    this.roleId,
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.phone,
    this.bvn,
    this.nin,
    this.maritalStatus,
    this.gender,
    this.status,
    this.location,
    this.pin,
    this.address,
    this.vendorId,
    this.isEmailVerified,
    this.isPhoneVerified,
    this.isBvnVerified,
    this.isNinVerified,
    this.isSelfSignup,
    this.isPublic,
    this.isTfaEnabled,
    this.tfaSecret,
    this.lastLogin,
    this.profilePic,
    this.nfc,
    this.dob,
    this.ip,
    this.createdAt,
    this.updatedAt,
    this.wallets,
    this.store,
    this.organisations,
    this.bankAccounts,
  });

  VendorDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    referalId = json['referal_id'];
    roleId = json['RoleId'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    password = json['password'];
    phone = json['phone'];
    bvn = json['bvn'];
    nin = json['nin'];
    maritalStatus = json['marital_status'];
    gender = json['gender'];
    status = json['status'];
    location = json['location'];
    pin = json['pin'];
    address = json['address'];
    vendorId = json['vendor_id'];
    isEmailVerified = json['is_email_verified'];
    isPhoneVerified = json['is_phone_verified'];
    isBvnVerified = json['is_bvn_verified'];
    isNinVerified = json['is_nin_verified'];
    isSelfSignup = json['is_self_signup'];
    isPublic = json['is_public'];
    isTfaEnabled = json['is_tfa_enabled'];
    tfaSecret = json['tfa_secret'];
    lastLogin = json['last_login'];
    profilePic = json['profile_pic'];
    nfc = json['nfc'];
    dob = json['dob'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    store = json['Store'] != null ? StoreModel.fromJson(json['Store']) : null;
    wallets = json['Wallets'] != null
        ? json['Wallets']
            .map<WalletModel>((wallet) => WalletModel.fromJson(wallet))
            .toList()
        : [];
    organisations = json['Organisations'] != null
        ? json['Organisations']
            .map<OrganisationModel>((org) => OrganisationModel.fromJson(org))
            .toList()
        : [];
    bankAccounts = json['BankAccounts'] != null
        ? json['BankAccounts']
            .map<AccountsModel>((account) => AccountsModel.fromJson(account))
            .toList()
        : [];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    if (this.nin != null && this.nin?.length != 0) data['nin'] = this.nin;
    if (this.gender != null) data['phone'] = this.phone;
    if (this.gender != null) data['gender'] = this.gender;
    if (this.ip != null) data['ip'] = this.ip;
    if (this.dob != null && this.dob?.length != 0) data['dob'] = this.dob;

    print({"Formatted data", data});
    return data;
  }
}
