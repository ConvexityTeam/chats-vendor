class ProductModel {
  int? id;
  String? type;
  String? tag;
  double? cost;
  int? marketId;
  int? campaignId;
  String? createdAt;
  String? updatedAt;
  int? qty = 1;

  ProductModel({
    this.id,
    this.type,
    this.tag,
    this.cost,
    this.marketId,
    this.campaignId,
    this.createdAt,
    this.updatedAt,
    this.qty,
  });

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    tag = json['tag'];
    cost = json['cost'] != null ? json['cost'].toDouble() : json['cost'];
    marketId = json['MarketId'];
    campaignId = json['CampaignId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['tag'] = this.tag;
    data['cost'] = this.cost;
    data['MarketId'] = this.marketId;
    data['CampaignId'] = this.campaignId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
