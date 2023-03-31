class AccountsModel {
  int? id;
  int? userId;
  String? accountNumber;
  String? accountName;
  String? bankCode;
  String? bankName;
  String? recipientCode;
  String? type;
  String? createdAt;
  String? updatedAt;
  AccountHolder? accountHolder;

  AccountsModel(
      {this.id,
      this.userId,
      this.accountNumber,
      this.accountName,
      this.bankCode,
      this.bankName,
      this.recipientCode,
      this.type,
      this.createdAt,
      this.updatedAt,
      this.accountHolder});

  AccountsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['UserId'];
    accountNumber = json['account_number'];
    accountName = json['account_name'];
    bankCode = json['bank_code'];
    bankName = json['bank_name'];
    recipientCode = json['recipient_code'];
    type = json['type'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    accountHolder = json['AccountHolder'] != null
        ? new AccountHolder.fromJson(json['AccountHolder'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['account_number'] = this.accountNumber;
    data['bank_code'] = this.bankCode;
    return data;
  }
}

class AccountHolder {
  String? firstName;
  String? lastName;
  String? phone;
  String? dob;

  AccountHolder({this.firstName, this.lastName, this.phone, this.dob});

  AccountHolder.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    phone = json['phone'];
    dob = json['dob'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['phone'] = this.phone;
    data['dob'] = this.dob;
    return data;
  }
}
