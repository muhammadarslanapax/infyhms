import 'package:json_annotation/json_annotation.dart';

part 'doctor_appointment_model.g.dart';

@JsonSerializable(explicitToJson: true)
class DoctorAppointmentModel {
  bool? success;
  List<DoctorAppointmentData>? data;
  String? message;

  DoctorAppointmentModel({
    this.success,
    this.data,
    this.message,
  });

  factory DoctorAppointmentModel.fromJson(Map<String, dynamic> json) => _$DoctorAppointmentModelFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorAppointmentModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class DoctorAppointmentData {
  int? id;
  String? patient_name;
  String? appointment_date;
  String? appointment_time;
  String? patient_image;

  DoctorAppointmentData({
    this.id,
    this.patient_name,
    this.appointment_date,
    this.appointment_time,
    this.patient_image,
  });

  factory DoctorAppointmentData.fromJson(Map<String, dynamic> json) => _$DoctorAppointmentDataFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorAppointmentDataToJson(this);
}
