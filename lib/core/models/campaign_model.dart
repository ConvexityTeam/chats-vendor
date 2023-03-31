class CampaignModel {
  int? id;
  int? vendorId;
  int? campaignId;
  bool? approved;
  String? createdAt;
  String? updatedAt;
  Campaign? campaign;

  CampaignModel(
      {this.id,
      this.vendorId,
      this.campaignId,
      this.approved,
      this.createdAt,
      this.updatedAt,
      this.campaign});

  CampaignModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vendorId = json['VendorId'];
    campaignId = json['CampaignId'];
    approved = json['approved'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    campaign = json['Campaign'] != null
        ? new Campaign.fromJson(json['Campaign'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['VendorId'] = this.vendorId;
    data['CampaignId'] = this.campaignId;
    data['approved'] = this.approved;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.campaign != null) {
      data['Campaign'] = this.campaign?.toJson();
    }
    return data;
  }
}

class Campaign {
  int? id;
  int? organisationId;
  String? title;
  String? type;
  String? spending;
  String? description;
  String? status;
  bool? isFunded;
  String? fundedWith;
  double? budget;
  double? amountDisbursed;
  String? location;
  String? startDate;
  String? pausedDate;
  String? endDate;
  String? createdAt;
  String? updatedAt;

  Campaign(
      {this.id,
      this.organisationId,
      this.title,
      this.type,
      this.spending,
      this.description,
      this.status,
      this.isFunded,
      this.fundedWith,
      this.budget,
      this.amountDisbursed,
      this.location,
      this.startDate,
      this.pausedDate,
      this.endDate,
      this.createdAt,
      this.updatedAt});

  Campaign.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    organisationId = json['OrganisationId'];
    title = json['title'];
    type = json['type'];
    spending = json['spending'];
    description = json['description'];
    status = json['status'];
    isFunded = json['is_funded'];
    fundedWith = json['funded_with'];
    budget = json['budget'].toDouble();
    amountDisbursed = json['amount_disbursed'].toDouble();
    location = json['location'];
    startDate = json['start_date'];
    pausedDate = json['paused_date'];
    endDate = json['end_date'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['OrganisationId'] = this.organisationId;
    data['title'] = this.title;
    data['type'] = this.type;
    data['spending'] = this.spending;
    data['description'] = this.description;
    data['status'] = this.status;
    data['is_funded'] = this.isFunded;
    data['funded_with'] = this.fundedWith;
    data['budget'] = this.budget;
    data['amount_disbursed'] = this.amountDisbursed;
    data['location'] = this.location;
    data['start_date'] = this.startDate;
    data['paused_date'] = this.pausedDate;
    data['end_date'] = this.endDate;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
