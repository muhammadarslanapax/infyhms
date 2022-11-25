// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'doctor_schedule_model.g.dart';

@JsonSerializable()
class DoctorScheduleModel {
  bool? success;
  DoctorScheduleData? data;
  String? message;

  DoctorScheduleModel({
    this.success,
    this.data,
    this.message,
  });

  factory DoctorScheduleModel.fromJson(Map<String, dynamic> json) => _$DoctorScheduleModelFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorScheduleModelToJson(this);
}


@JsonSerializable()
class DoctorScheduleData {
  int? id;
  String? per_patient_time;
  List<ScheduleData>? schedule;

  DoctorScheduleData({
    this.id,
    this.per_patient_time,
    this.schedule,
  });
  factory DoctorScheduleData.fromJson(Map<String, dynamic> json) => _$DoctorScheduleDataFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorScheduleDataToJson(this);
}

@JsonSerializable()
class ScheduleData {
  String? available_on;
  String? available_from;
  String? available_to;

  ScheduleData({
    this.available_on,
    this.available_from,
    this.available_to,
  });

  factory ScheduleData.fromJson(Map<String, dynamic> json) => _$ScheduleDataFromJson(json);

  Map<String, dynamic> toJson() => _$ScheduleDataToJson(this);
}
