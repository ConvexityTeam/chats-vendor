class BankList {
  String? name;
  String? country;
  String? currency;
  String? code;

  BankList({this.name, this.country, this.currency, this.code});

  BankList.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    country = json['country'];
    currency = json['currency'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['country'] = this.country;
    data['currency'] = this.currency;
    data['code'] = this.code;
    return data;
  }
}
