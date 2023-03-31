class OrderModel {
  int? id;
  String? reference;
  int? vendorId;
  String? status;
  String? createdAt;
  String? updatedAt;
  Vendor? vendor;
  List<Cart>? cart;

  OrderModel(
      {this.id,
      this.reference,
      this.vendorId,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.vendor,
      this.cart});

  OrderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    reference = json['reference'];
    vendorId = json['VendorId'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    vendor =
        json['Vendor'] != null ? new Vendor.fromJson(json['Vendor']) : null;
    if (json['Cart'] != null) {
      cart = <Cart>[];
      json['Cart'].forEach((v) {
        cart?.add(new Cart.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['reference'] = this.reference;
    data['VendorId'] = this.vendorId;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.vendor != null) {
      data['Vendor'] = this.vendor?.toJson();
    }
    if (this.cart != null) {
      data['Cart'] = this.cart?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Vendor {
  int? id;
  String? email;
  String? phone;
  String? firstName;
  String? lastName;
  String? gender;
  String? maritalStatus;
  String? profilePic;
  String? dob;
  Store? store;

  Vendor(
      {this.id,
      this.email,
      this.phone,
      this.firstName,
      this.lastName,
      this.gender,
      this.maritalStatus,
      this.profilePic,
      this.dob,
      this.store});

  Vendor.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    phone = json['phone'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    gender = json['gender'];
    maritalStatus = json['marital_status'];
    profilePic = json['profile_pic'];
    dob = json['dob'];
    store = json['Store'] != null ? new Store.fromJson(json['Store']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['gender'] = this.gender;
    data['marital_status'] = this.maritalStatus;
    data['profile_pic'] = this.profilePic;
    data['dob'] = this.dob;
    if (this.store != null) {
      data['Store'] = this.store?.toJson();
    }
    return data;
  }
}

class Store {
  int? id;
  int? userId;
  String? storeName;
  String? address;
  String? location;
  String? createdAt;
  String? updatedAt;

  Store(
      {this.id,
      this.userId,
      this.storeName,
      this.address,
      this.location,
      this.createdAt,
      this.updatedAt});

  Store.fromJson(Map<String, dynamic> json) {
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

class Cart {
  int? orderId;
  int? productId;
  int? quantity;
  double? unitPrice;
  double? totalAmount;
  String? createdAt;
  String? updatedAt;
  Product? product;

  Cart(
      {this.orderId,
      this.productId,
      this.quantity,
      this.unitPrice,
      this.totalAmount,
      this.createdAt,
      this.updatedAt,
      this.product});

  Cart.fromJson(Map<String, dynamic> json) {
    orderId = json['OrderId'];
    productId = json['ProductId'];
    quantity = json['quantity'];
    unitPrice = json['unit_price'].toDouble();
    totalAmount = json['total_amount'].toDouble();
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    product =
        json['Product'] != null ? new Product.fromJson(json['Product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['OrderId'] = this.orderId;
    data['ProductId'] = this.productId;
    data['quantity'] = this.quantity;
    data['unit_price'] = this.unitPrice;
    data['total_amount'] = this.totalAmount;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.product != null) {
      data['Product'] = this.product?.toJson();
    }
    return data;
  }
}

class Product {
  int? id;
  String? type;
  String? tag;
  double? cost;
  int? marketId;
  int? campaignId;
  String? createdAt;
  String? updatedAt;

  Product(
      {this.id,
      this.type,
      this.tag,
      this.cost,
      this.marketId,
      this.campaignId,
      this.createdAt,
      this.updatedAt});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    tag = json['tag'];
    cost = json['cost'].toDouble();
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
