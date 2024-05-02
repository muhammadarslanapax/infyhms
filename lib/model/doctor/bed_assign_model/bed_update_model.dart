// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'bed_update_model.g.dart';

@JsonSerializable()
class BedUpdatedDetailsModel {
  bool? success;
  // BedUpdatedData? data;
  String? message;

  BedUpdatedDetailsModel({
    this.success,
    // this.data,
    this.message,
  });
  factory BedUpdatedDetailsModel.fromJson(Map<String, dynamic> json) => _$BedUpdatedDetailsModelFromJson(json);

  Map<String, dynamic> toJson() => _$BedUpdatedDetailsModelToJson(this);
}
//
// @JsonSerializable()
// class BedUpdatedData {
//   String? bed_id;
//   String? patient_id;
//   String? case_id;
//   String? assign_date;
//   String? discharge_date;
//
//   BedUpdatedData({
//     this.bed_id,
//     this.patient_id,
//     this.case_id,
//     this.assign_date,
//     this.discharge_date,
//   });
//   factory BedUpdatedData.fromJson(Map<String, dynamic> json) => _$BedUpdatedDataFromJson(json);
//
//   Map<String, dynamic> toJson() => _$BedUpdatedDataToJson(this);
// }
