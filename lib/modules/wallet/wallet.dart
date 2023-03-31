class WalletModel {
  String? uuid;
  String? address;
  String? bantuAddress;
  int? campaignId;
  int? organisationId;
  String? walletType;
  int? userId;
  double? balance;
  double? cryptoBalance;
  double? fiatBalance;
  String? localCurrency;
  String? createdAt;
  String? updatedAt;

  WalletModel(
      {this.uuid,
      this.address,
      this.bantuAddress,
      this.campaignId,
      this.organisationId,
      this.walletType,
      this.userId,
      this.balance,
      this.cryptoBalance,
      this.fiatBalance,
      this.localCurrency,
      this.createdAt,
      this.updatedAt});

  WalletModel.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    address = json['address'];
    bantuAddress = json['bantuAddress'];
    campaignId = json['CampaignId'];
    organisationId = json['OrganisationId'];
    walletType = json['wallet_type'];
    userId = json['UserId'];
    balance = json['balance'].toDouble();
    cryptoBalance = json['crypto_balance'].toDouble();
    fiatBalance = json['fiat_balance'].toDouble();
    localCurrency = json['local_currency'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uuid'] = this.uuid;
    data['address'] = this.address;
    data['bantuAddress'] = this.bantuAddress;
    data['CampaignId'] = this.campaignId;
    data['OrganisationId'] = this.organisationId;
    data['wallet_type'] = this.walletType;
    data['UserId'] = this.userId;
    data['balance'] = this.balance;
    data['crypto_balance'] = this.cryptoBalance;
    data['fiat_balance'] = this.fiatBalance;
    data['local_currency'] = this.localCurrency;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
