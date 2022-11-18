// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'live_consultation_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LiveConsultationDetailsModel _$LiveConsultationDetailsModelFromJson(
        Map<String, dynamic> json) =>
    LiveConsultationDetailsModel(
      success: json['success'] as bool?,
      data: json['data'] == null
          ? null
          : LiveConsultationDetailsData.fromJson(
              json['data'] as Map<String, dynamic>),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$LiveConsultationDetailsModelToJson(
        LiveConsultationDetailsModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data,
      'message': instance.message,
    };

LiveConsultationDetailsData _$LiveConsultationDetailsDataFromJson(
        Map<String, dynamic> json) =>
    LiveConsultationDetailsData(
      id: json['id'] as int?,
      consultation_title: json['consultation_title'] as String?,
      consultation_date: json['consultation_date'] as String?,
      consultation_time: json['consultation_time'] as String?,
      status: json['status'] as String?,
      duration: json['duration'] as String?,
      doctor_name: json['doctor_name'] as String?,
      meeting_id: json['meeting_id'] as String?,
      password: json['password'] as String?,
      host_video: json['host_video'] as String?,
      type: json['type'] as String?,
      type_number: json['type_number'] as String?,
      join_url: json['join_url'] as String?,
    );

Map<String, dynamic> _$LiveConsultationDetailsDataToJson(
        LiveConsultationDetailsData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'consultation_title': instance.consultation_title,
      'consultation_date': instance.consultation_date,
      'consultation_time': instance.consultation_time,
      'status': instance.status,
      'duration': instance.duration,
      'doctor_name': instance.doctor_name,
      'meeting_id': instance.meeting_id,
      'password': instance.password,
      'host_video': instance.host_video,
      'type': instance.type,
      'type_number': instance.type_number,
      'join_url': instance.join_url,
    };
