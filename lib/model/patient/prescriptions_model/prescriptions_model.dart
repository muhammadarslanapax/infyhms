import 'package:json_annotation/json_annotation.dart';

part 'prescriptions_model.g.dart';

@JsonSerializable(explicitToJson: true)
class PrescriptionsModel {
  bool? success;
  List<PrescriptionsData>? data;
  String? message;

  PrescriptionsModel({
    this.success,
    this.data,
    this.message,
  });

  factory PrescriptionsModel.fromJson(Map<String, dynamic> json) => _$PrescriptionsModelFromJson(json);

  Map<String, dynamic> toJson() => _$PrescriptionsModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class PrescriptionsData {
  int? id;
  int? doctor_id;
  String? doctor_name;
  String? doctor_image;
  String? created_date;
  String? created_time;
  String? food_allergies;
  String? tendency_bleed;
  String? heart_disease;
  String? high_blood_pressure;
  String? diabetic;
  String? surgery;
  String? accident;
  String? others;
  String? medical_history;
  String? current_medication;
  String? female_pregnancy;
  String? breast_feeding;
  String? health_insurance;
  String? low_income;
  String? reference;

  PrescriptionsData({
    this.id,
    this.doctor_id,
    this.doctor_name,
    this.doctor_image,
    this.created_date,
    this.created_time,
    this.food_allergies,
    this.tendency_bleed,
    this.heart_disease,
    this.high_blood_pressure,
    this.diabetic,
    this.surgery,
    this.accident,
    this.others,
    this.medical_history,
    this.current_medication,
    this.female_pregnancy,
    this.breast_feeding,
    this.health_insurance,
    this.low_income,
    this.reference,
  });
  factory PrescriptionsData.fromJson(Map<String, dynamic> json) => _$PrescriptionsDataFromJson(json);

  Map<String, dynamic> toJson() => _$PrescriptionsDataToJson(this);
}
