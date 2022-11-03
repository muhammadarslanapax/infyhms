import 'package:json_annotation/json_annotation.dart';

part 'doctor_department_model.g.dart';

@JsonSerializable(explicitToJson: true)
class DoctorDepartmentModel {
  bool? success;
  List<DoctorDepartmentData>? data;
  String? message;

  DoctorDepartmentModel({
    this.success,
    this.data,
    this.message,
  });

  factory DoctorDepartmentModel.fromJson(Map<String, dynamic> json) => _$DoctorDepartmentModelFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorDepartmentModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class DoctorDepartmentData {
  int? id;
  String? title;

  DoctorDepartmentData({
    this.id,
    this.title,
  });

  factory DoctorDepartmentData.fromJson(Map<String, dynamic> json) => _$DoctorDepartmentDataFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorDepartmentDataToJson(this);
}
