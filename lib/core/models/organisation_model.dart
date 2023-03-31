class OrganisationModel {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? address;
  String? state;
  String? country;
  String? logoLink;
  String? websiteUrl;
  String? registrationId;
  String? yearOfInception;
  bool? profileCompleted;
  bool? isVerified;
  String? createdAt;
  String? updatedAt;
  OrganisationMembers? organisationMembers;

  OrganisationModel(
      {this.id,
      this.name,
      this.email,
      this.phone,
      this.address,
      this.state,
      this.country,
      this.logoLink,
      this.websiteUrl,
      this.registrationId,
      this.yearOfInception,
      this.profileCompleted,
      this.isVerified,
      this.createdAt,
      this.updatedAt,
      this.organisationMembers});

  OrganisationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    address = json['address'];
    state = json['state'];
    country = json['country'];
    logoLink = json['logo_link'];
    websiteUrl = json['website_url'];
    registrationId = json['registration_id'];
    yearOfInception = json['year_of_inception'];
    profileCompleted = json['profile_completed'];
    isVerified = json['is_verified'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    organisationMembers = json['OrganisationMembers'] != null
        ? new OrganisationMembers.fromJson(json['OrganisationMembers'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['address'] = this.address;
    data['state'] = this.state;
    data['country'] = this.country;
    data['logo_link'] = this.logoLink;
    data['website_url'] = this.websiteUrl;
    data['registration_id'] = this.registrationId;
    data['year_of_inception'] = this.yearOfInception;
    data['profile_completed'] = this.profileCompleted;
    data['is_verified'] = this.isVerified;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.organisationMembers != null) {
      data['OrganisationMembers'] = this.organisationMembers?.toJson();
    }
    return data;
  }
}

class OrganisationMembers {
  int? userId;
  int? organisationId;
  String? role;
  String? createdAt;
  String? updatedAt;

  OrganisationMembers(
      {this.userId,
      this.organisationId,
      this.role,
      this.createdAt,
      this.updatedAt});

  OrganisationMembers.fromJson(Map<String, dynamic> json) {
    userId = json['UserId'];
    organisationId = json['OrganisationId'];
    role = json['role'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['UserId'] = this.userId;
    data['OrganisationId'] = this.organisationId;
    data['role'] = this.role;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
