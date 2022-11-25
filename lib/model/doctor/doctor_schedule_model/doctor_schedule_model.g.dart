// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doctor_schedule_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DoctorScheduleModel _$DoctorScheduleModelFromJson(Map<String, dynamic> json) =>
    DoctorScheduleModel(
      success: json['success'] as bool?,
      data: json['data'] == null
          ? null
          : DoctorScheduleData.fromJson(json['data'] as Map<String, dynamic>),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$DoctorScheduleModelToJson(
        DoctorScheduleModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data,
      'message': instance.message,
    };

DoctorScheduleData _$DoctorScheduleDataFromJson(Map<String, dynamic> json) =>
    DoctorScheduleData(
      id: json['id'] as int?,
      per_patient_time: json['per_patient_time'] as String?,
      schedule: (json['schedule'] as List<dynamic>?)
          ?.map((e) => ScheduleData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DoctorScheduleDataToJson(DoctorScheduleData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'per_patient_time': instance.per_patient_time,
      'schedule': instance.schedule,
    };

ScheduleData _$ScheduleDataFromJson(Map<String, dynamic> json) => ScheduleData(
      available_on: json['available_on'] as String?,
      available_from: json['available_from'] as String?,
      available_to: json['available_to'] as String?,
    );

Map<String, dynamic> _$ScheduleDataToJson(ScheduleData instance) =>
    <String, dynamic>{
      'available_on': instance.available_on,
      'available_from': instance.available_from,
      'available_to': instance.available_to,
    };
