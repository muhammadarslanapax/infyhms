import 'package:json_annotation/json_annotation.dart';

part 'get_doctor_model.g.dart';

@JsonSerializable(explicitToJson: true)
class GetDoctorModel {
  bool? success;
  List<GetDoctorData>? data;
  String? message;

  GetDoctorModel({
    this.success,
    this.data,
    this.message,
  });

  factory GetDoctorModel.fromJson(Map<String, dynamic> json) => _$GetDoctorModelFromJson(json);

  Map<String, dynamic> toJson() => _$GetDoctorModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class GetDoctorData {
  int? id;
  String? title;

  GetDoctorData({
    this.id,
    this.title,
  });

  factory GetDoctorData.fromJson(Map<String, dynamic> json) => _$GetDoctorDataFromJson(json);

  Map<String, dynamic> toJson() => _$GetDoctorDataToJson(this);
}
