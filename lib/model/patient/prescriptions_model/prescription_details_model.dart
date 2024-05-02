import 'package:json_annotation/json_annotation.dart';

part 'prescription_details_model.g.dart';

@JsonSerializable(explicitToJson: true)
class PrescriptionDetailModel {
  bool? success;
  PrescriptionDetailData? data;
  String? message;

  PrescriptionDetailModel({
    this.success,
    this.data,
    this.message,
  });

  factory PrescriptionDetailModel.fromJson(Map<String, dynamic> json) => _$PrescriptionDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$PrescriptionDetailModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class PrescriptionDetailData {
  String? doctor_name;
  String? specialist;
  String? problem;
  String? test;
  String? advice;
  List<Medicine>? medicine;
  String? download_prescription;

  PrescriptionDetailData({
    this.doctor_name,
    this.specialist,
    this.problem,
    this.test,
    this.advice,
    this.medicine,
    this.download_prescription,
  });

  factory PrescriptionDetailData.fromJson(Map<String, dynamic> json) => _$PrescriptionDetailDataFromJson(json);

  Map<String, dynamic> toJson() => _$PrescriptionDetailDataToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Medicine {
  String? name;
  String? dosage;
  String? days;
  String? time;

  Medicine({
    this.name,
    this.dosage,
    this.days,
    this.time
  });
  factory Medicine.fromJson(Map<String, dynamic> json) => _$MedicineFromJson(json);

  Map<String, dynamic> toJson() => _$MedicineToJson(this);
}
