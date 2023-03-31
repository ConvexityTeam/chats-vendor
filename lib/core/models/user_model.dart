import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel{

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  UserModel();

  String referal_id= "";
  String OrganisationId= "2";
  String first_name= "";
  String last_name= "";
  String email= "";
  String phone= "";
  String password= "";
  int status= 0;
  String bvn= "";
  String location= "";
  String long= "";
  String lat= "";
  String profile_pic= "";
  String nfc= "";
  String pin= "";
  String blockchain_address= "";
  String address= "";
  String last_login= "";
  String marital_status= "";
  String gender= "";

}