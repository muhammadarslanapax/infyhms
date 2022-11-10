import 'package:json_annotation/json_annotation.dart';

part 'live_consultation_model.g.dart';

@JsonSerializable()
class LiveConsultationModel {
  bool? success;
  List<LiveConsultationData>? data;
  String? message;

  LiveConsultationModel({
    this.success,
    this.data,
    this.message,
  });
  factory LiveConsultationModel.fromJson(Map<String, dynamic> json) => _$LiveConsultationModelFromJson(json);

  Map<String, dynamic> toJson() => _$LiveConsultationModelToJson(this);
}

@JsonSerializable()
class LiveConsultationData {
  int? id;
  String? consultation_title;
  String? consultation_date;
  String? consultation_time;
  String? status;
  String? doctor_image;

  LiveConsultationData({
    this.id,
    this.consultation_title,
    this.consultation_date,
    this.consultation_time,
    this.status,
    this.doctor_image,
  });

  factory LiveConsultationData.fromJson(Map<String, dynamic> json) => _$LiveConsultationDataFromJson(json);

  Map<String, dynamic> toJson() => _$LiveConsultationDataToJson(this);
}
