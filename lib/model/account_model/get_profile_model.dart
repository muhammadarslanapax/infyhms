import 'package:json_annotation/json_annotation.dart';

part 'get_profile_model.g.dart';

@JsonSerializable(explicitToJson: true)
class GetProfileModel {
  bool? success;
  GetProfileData? data;
  String? message;

  GetProfileModel({
    this.success,
    this.data,
    this.message,
  });

  factory GetProfileModel.fromJson(Map<String, dynamic> json) => _$GetProfileModelFromJson(json);

  Map<String, dynamic> toJson() => _$GetProfileModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class GetProfileData {
  int? id;
  String? first_name;
  String? email;
  String? last_name;
  String? phone_number;
  String? image_url;

  GetProfileData({
    this.id,
    this.first_name,
    this.email,
    this.last_name,
    this.phone_number,
    this.image_url,
  });

  factory GetProfileData.fromJson(Map<String, dynamic> json) => _$GetProfileDataFromJson(json);

  Map<String, dynamic> toJson() => _$GetProfileDataToJson(this);
}
