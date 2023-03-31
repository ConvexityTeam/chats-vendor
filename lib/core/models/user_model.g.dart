// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) {
  return UserModel()
    ..referal_id = json['referal_id'] as String
    ..OrganisationId = json['OrganisationId'] as String
    ..first_name = json['first_name'] as String
    ..last_name = json['last_name'] as String
    ..email = json['email'] as String
    ..phone = json['phone'] as String
    ..password = json['password'] as String
    ..status = json['status'] as int
    ..bvn = json['bvn'] as String
    ..location = json['location'] as String
    ..long = json['long'] as String
    ..lat = json['lat'] as String
    ..profile_pic = json['profile_pic'] as String
    ..nfc = json['nfc'] as String
    ..pin = json['pin'] as String
    ..blockchain_address = json['blockchain_address'] as String
    ..address = json['address'] as String
    ..last_login = json['last_login'] as String
    ..marital_status = json['marital_status'] as String
    ..gender = json['gender'] as String;
}

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'referal_id': instance.referal_id,
      'OrganisationId': instance.OrganisationId,
      'first_name': instance.first_name,
      'last_name': instance.last_name,
      'email': instance.email,
      'phone': instance.phone,
      'password': instance.password,
      'status': instance.status,
      'bvn': instance.bvn,
      'location': instance.location,
      'long': instance.long,
      'lat': instance.lat,
      'profile_pic': instance.profile_pic,
      'nfc': instance.nfc,
      'pin': instance.pin,
      'blockchain_address': instance.blockchain_address,
      'address': instance.address,
      'last_login': instance.last_login,
      'marital_status': instance.marital_status,
      'gender': instance.gender,
    };
