// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prescriptions_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PrescriptionsModel _$PrescriptionsModelFromJson(Map<String, dynamic> json) =>
    PrescriptionsModel(
      success: json['success'] as bool?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => PrescriptionsData.fromJson(e as Map<String, dynamic>))
          .toList(),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$PrescriptionsModelToJson(PrescriptionsModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data?.map((e) => e.toJson()).toList(),
      'message': instance.message,
    };

PrescriptionsData _$PrescriptionsDataFromJson(Map<String, dynamic> json) =>
    PrescriptionsData(
      id: json['id'] as int?,
      doctor_id: json['doctor_id'] as int?,
      doctor_name: json['doctor_name'] as String?,
      doctor_image: json['doctor_image'] as String?,
      created_date: json['created_date'] as String?,
      created_time: json['created_time'] as String?,
      food_allergies: json['food_allergies'] as String?,
      tendency_bleed: json['tendency_bleed'] as String?,
      heart_disease: json['heart_disease'] as String?,
      high_blood_pressure: json['high_blood_pressure'] as String?,
      diabetic: json['diabetic'] as String?,
      surgery: json['surgery'] as String?,
      accident: json['accident'] as String?,
      others: json['others'] as String?,
      medical_history: json['medical_history'] as String?,
      current_medication: json['current_medication'] as String?,
      female_pregnancy: json['female_pregnancy'] as String?,
      breast_feeding: json['breast_feeding'] as String?,
      health_insurance: json['health_insurance'] as String?,
      low_income: json['low_income'] as String?,
      reference: json['reference'] as String?,
    );

Map<String, dynamic> _$PrescriptionsDataToJson(PrescriptionsData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'doctor_id': instance.doctor_id,
      'doctor_name': instance.doctor_name,
      'doctor_image': instance.doctor_image,
      'created_date': instance.created_date,
      'created_time': instance.created_time,
      'food_allergies': instance.food_allergies,
      'tendency_bleed': instance.tendency_bleed,
      'heart_disease': instance.heart_disease,
      'high_blood_pressure': instance.high_blood_pressure,
      'diabetic': instance.diabetic,
      'surgery': instance.surgery,
      'accident': instance.accident,
      'others': instance.others,
      'medical_history': instance.medical_history,
      'current_medication': instance.current_medication,
      'female_pregnancy': instance.female_pregnancy,
      'breast_feeding': instance.breast_feeding,
      'health_insurance': instance.health_insurance,
      'low_income': instance.low_income,
      'reference': instance.reference,
    };
