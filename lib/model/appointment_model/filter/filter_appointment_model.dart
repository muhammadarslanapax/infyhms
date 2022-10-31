import 'package:json_annotation/json_annotation.dart';

part 'filter_appointment_model.g.dart';

@JsonSerializable(explicitToJson: true)
class FilterAppointmentModel {
  bool? success;
  List<FilterAppointmentData>? data;
  String? message;

  FilterAppointmentModel({
    this.success,
    this.data,
    this.message,
  });

  factory FilterAppointmentModel.fromJson(Map<String, dynamic> json) => _$FilterAppointmentModelFromJson(json);

  Map<String, dynamic> toJson() => _$FilterAppointmentModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class FilterAppointmentData {
  int? id;
  String? doctor_name;
  String? appointment_date;
  String? appointment_time;
  String? doctor_department;
  String? doctor_image_url;

  FilterAppointmentData({
    this.id,
    this.doctor_name,
    this.appointment_date,
    this.appointment_time,
    this.doctor_department,
    this.doctor_image_url,
  });
  factory FilterAppointmentData.fromJson(Map<String, dynamic> json) => _$FilterAppointmentDataFromJson(json);

  Map<String, dynamic> toJson() => _$FilterAppointmentDataToJson(this);
}
