// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'live_consultation_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LiveConsultationModel _$LiveConsultationModelFromJson(
        Map<String, dynamic> json) =>
    LiveConsultationModel(
      success: json['success'] as bool?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => LiveConsultationData.fromJson(e as Map<String, dynamic>))
          .toList(),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$LiveConsultationModelToJson(
        LiveConsultationModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data,
      'message': instance.message,
    };

LiveConsultationData _$LiveConsultationDataFromJson(
        Map<String, dynamic> json) =>
    LiveConsultationData(
      id: json['id'] as int?,
      consultation_title: json['consultation_title'] as String?,
      consultation_date: json['consultation_date'] as String?,
      consultation_time: json['consultation_time'] as String?,
      status: json['status'] as String?,
      doctor_image: json['doctor_image'] as String?,
    );

Map<String, dynamic> _$LiveConsultationDataToJson(
        LiveConsultationData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'consultation_title': instance.consultation_title,
      'consultation_date': instance.consultation_date,
      'consultation_time': instance.consultation_time,
      'status': instance.status,
      'doctor_image': instance.doctor_image,
    };
