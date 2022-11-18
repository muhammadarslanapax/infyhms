import 'package:json_annotation/json_annotation.dart';

part 'live_consultation_details_model.g.dart';

@JsonSerializable()
class LiveConsultationDetailsModel {
  bool? success;
  LiveConsultationDetailsData? data;
  String? message;

  LiveConsultationDetailsModel({
    this.success,
    this.data,
    this.message,
  });

  factory LiveConsultationDetailsModel.fromJson(Map<String, dynamic> json) => _$LiveConsultationDetailsModelFromJson(json);

  Map<String, dynamic> toJson() => _$LiveConsultationDetailsModelToJson(this);
}

@JsonSerializable()
class LiveConsultationDetailsData {
  int? id;
  String? consultation_title;
  String? consultation_date;
  String? consultation_time;
  String? status;
  String? duration;
  String? doctor_name;
  String? meeting_id;
  String? password;
  String? host_video;
  String? type;
  String? type_number;
  String? join_url;

  LiveConsultationDetailsData({
    this.id,
    this.consultation_title,
    this.consultation_date,
    this.consultation_time,
    this.status,
    this.duration,
    this.doctor_name,
    this.meeting_id,
    this.password,
    this.host_video,
    this.type,
    this.type_number,
    this.join_url,
  });

  factory LiveConsultationDetailsData.fromJson(Map<String, dynamic> json) => _$LiveConsultationDetailsDataFromJson(json);

  Map<String, dynamic> toJson() => _$LiveConsultationDetailsDataToJson(this);
}
