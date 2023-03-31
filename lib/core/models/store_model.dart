class StoreModel {
  int? id;
  int? userId;
  String? storeName;
  String? address;
  String? location;
  String? createdAt;
  String? updatedAt;

  StoreModel({
    this.id,
    this.userId,
    this.storeName,
    this.address,
    this.location,
    this.createdAt,
    this.updatedAt,
  });

  StoreModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['UserId'];
    storeName = json['store_name'];
    address = json['address'];
    location = json['location'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['UserId'] = this.userId;
    data['store_name'] = this.storeName;
    data['address'] = this.address;
    data['location'] = this.location;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
