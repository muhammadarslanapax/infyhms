// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetProfileModel _$GetProfileModelFromJson(Map<String, dynamic> json) =>
    GetProfileModel(
      success: json['success'] as bool?,
      data: json['data'] == null
          ? null
          : GetProfileData.fromJson(json['data'] as Map<String, dynamic>),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$GetProfileModelToJson(GetProfileModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data?.toJson(),
      'message': instance.message,
    };

GetProfileData _$GetProfileDataFromJson(Map<String, dynamic> json) =>
    GetProfileData(
      id: json['id'] as int?,
      first_name: json['first_name'] as String?,
      email: json['email'] as String?,
      last_name: json['last_name'] as String?,
      phone_number: json['phone_number'] as String?,
      image_url: json['image_url'] as String?,
    );

Map<String, dynamic> _$GetProfileDataToJson(GetProfileData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'first_name': instance.first_name,
      'email': instance.email,
      'last_name': instance.last_name,
      'phone_number': instance.phone_number,
      'image_url': instance.image_url,
    };
