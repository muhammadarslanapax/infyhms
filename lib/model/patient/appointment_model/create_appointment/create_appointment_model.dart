import 'package:json_annotation/json_annotation.dart';

part 'create_appointment_model.g.dart';

@JsonSerializable(explicitToJson: true)
class CreateAppointmentModel {
  bool? success;
  String? message;

  CreateAppointmentModel({
    this.success,
    this.message,
  });

  factory CreateAppointmentModel.fromJson(Map<String, dynamic> json) => _$CreateAppointmentModelFromJson(json);

  Map<String, dynamic> toJson() => _$CreateAppointmentModelToJson(this);
}
