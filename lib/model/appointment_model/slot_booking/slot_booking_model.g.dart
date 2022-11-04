// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'slot_booking_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SlotBookingModel _$SlotBookingModelFromJson(Map<String, dynamic> json) =>
    SlotBookingModel(
      success: json['success'] as bool?,
      data: json['data'] == null
          ? null
          : SlotBookingData.fromJson(json['data'] as Map<String, dynamic>),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$SlotBookingModelToJson(SlotBookingModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data?.toJson(),
      'message': instance.message,
    };

SlotBookingData _$SlotBookingDataFromJson(Map<String, dynamic> json) =>
    SlotBookingData(
      bookingSlotArr: (json['bookingSlotArr'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$SlotBookingDataToJson(SlotBookingData instance) =>
    <String, dynamic>{
      'bookingSlotArr': instance.bookingSlotArr,
    };
