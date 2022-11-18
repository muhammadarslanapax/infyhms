// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_doctor_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetDoctorModel _$GetDoctorModelFromJson(Map<String, dynamic> json) =>
    GetDoctorModel(
      success: json['success'] as bool?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => GetDoctorData.fromJson(e as Map<String, dynamic>))
          .toList(),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$GetDoctorModelToJson(GetDoctorModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data?.map((e) => e.toJson()).toList(),
      'message': instance.message,
    };

GetDoctorData _$GetDoctorDataFromJson(Map<String, dynamic> json) =>
    GetDoctorData(
      id: json['id'] as int?,
      title: json['title'] as String?,
    );

Map<String, dynamic> _$GetDoctorDataToJson(GetDoctorData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
    };
