import 'package:json_annotation/json_annotation.dart';

part 'appointment_model.g.dart';

@JsonSerializable(explicitToJson: true)
class AppointmentModel {
  bool? success;
  List<AppointmentData>? data;
  String? message;

  AppointmentModel({
    this.success,
    this.data,
    this.message,
  });

  factory AppointmentModel.fromJson(Map<String, dynamic> json) => _$AppointmentModelFromJson(json);

  Map<String, dynamic> toJson() => _$AppointmentModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class AppointmentData {
  int? id;
  String? doctor_name;
  String? appointment_date;
  String? appointment_time;
  String? doctor_department;
  String? doctor_image_url;

  AppointmentData({
    this.id,
    this.doctor_name,
    this.appointment_date,
    this.appointment_time,
    this.doctor_department,
    this.doctor_image_url,
  });
  factory AppointmentData.fromJson(Map<String, dynamic> json) => _$AppointmentDataFromJson(json);

  Map<String, dynamic> toJson() => _$AppointmentDataToJson(this);
}
