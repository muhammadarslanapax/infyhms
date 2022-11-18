import 'package:json_annotation/json_annotation.dart';

part 'slot_booking_model.g.dart';

@JsonSerializable(explicitToJson: true)
class SlotBookingModel {
  bool? success;
  SlotBookingData? data;
  String? message;

  SlotBookingModel({
    this.success,
    this.data,
    this.message,
  });

  factory SlotBookingModel.fromJson(Map<String, dynamic> json) => _$SlotBookingModelFromJson(json);

  Map<String, dynamic> toJson() => _$SlotBookingModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SlotBookingData {
  List<String>? bookingSlotArr;

  SlotBookingData({
    this.bookingSlotArr,
  });
  factory SlotBookingData.fromJson(Map<String, dynamic> json) => _$SlotBookingDataFromJson(json);

  Map<String, dynamic> toJson() => _$SlotBookingDataToJson(this);
}
