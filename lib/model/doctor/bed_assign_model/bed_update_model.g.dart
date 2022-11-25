// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bed_update_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BedUpdatedDetailsModel _$BedUpdatedDetailsModelFromJson(
        Map<String, dynamic> json) =>
    BedUpdatedDetailsModel(
      success: json['success'] as bool?,
      data: json['data'] == null
          ? null
          : BedUpdatedData.fromJson(json['data'] as Map<String, dynamic>),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$BedUpdatedDetailsModelToJson(
        BedUpdatedDetailsModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data,
      'message': instance.message,
    };

BedUpdatedData _$BedUpdatedDataFromJson(Map<String, dynamic> json) =>
    BedUpdatedData(
      bed_id: json['bed_id'] as String?,
      patient_id: json['patient_id'] as String?,
      case_id: json['case_id'] as String?,
      assign_date: json['assign_date'] as String?,
      discharge_date: json['discharge_date'] as String?,
    );

Map<String, dynamic> _$BedUpdatedDataToJson(BedUpdatedData instance) =>
    <String, dynamic>{
      'bed_id': instance.bed_id,
      'patient_id': instance.patient_id,
      'case_id': instance.case_id,
      'assign_date': instance.assign_date,
      'discharge_date': instance.discharge_date,
    };
