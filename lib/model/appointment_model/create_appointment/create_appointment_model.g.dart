// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_appointment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateAppointmentModel _$CreateAppointmentModelFromJson(
        Map<String, dynamic> json) =>
    CreateAppointmentModel(
      success: json['success'] as bool?,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$CreateAppointmentModelToJson(
        CreateAppointmentModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
    };
