import 'package:json_annotation/json_annotation.dart';

part 'edit_profile_model.g.dart';

@JsonSerializable(explicitToJson: true)
class EditProfileModel {
  bool? success;
  EditProfileData? data;
  String? message;

  EditProfileModel({
    this.success,
    this.data,
    this.message,
  });

  factory EditProfileModel.fromJson(Map<String, dynamic> json) => _$EditProfileModelFromJson(json);

  Map<String, dynamic> toJson() => _$EditProfileModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class EditProfileData {
  String? first_name;
  String? last_name;
  String? email;
  String? phone;
  String? profile_image;

  EditProfileData({
    this.first_name,
    this.last_name,
    this.email,
    this.phone,
    this.profile_image,
  });

  factory EditProfileData.fromJson(Map<String, dynamic> json) => _$EditProfileDataFromJson(json);

  Map<String, dynamic> toJson() => _$EditProfileDataToJson(this);
}
