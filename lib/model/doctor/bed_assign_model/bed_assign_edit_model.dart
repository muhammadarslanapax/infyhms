// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'bed_assign_edit_model.g.dart';

@JsonSerializable(explicitToJson: true)
class EditBedAssignModel {
  bool? success;
  EditBedAssignData? data;
  String? message;

  EditBedAssignModel({
    this.success,
    this.data,
    this.message,
  });

  factory EditBedAssignModel.fromJson(Map<String, dynamic> json) => _$EditBedAssignModelFromJson(json);

  Map<String, dynamic> toJson() => _$EditBedAssignModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class EditBedAssignData {
  int? id;
  String? case_id;
  String? patient_name;
  String? ipd_patient;
  String? bed;
  String? assign_date;
  String? discharge_date;
  String? description;
  int? ipd_patient_department_id;

  EditBedAssignData({
    this.id,
    this.case_id,
    this.patient_name,
    this.ipd_patient,
    this.bed,
    this.assign_date,
    this.discharge_date,
    this.description,
    this.ipd_patient_department_id
  });
  factory EditBedAssignData.fromJson(Map<String, dynamic> json) => _$EditBedAssignDataFromJson(json);

  Map<String, dynamic> toJson() => _$EditBedAssignDataToJson(this);
}
