// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoice_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InvoiceDetailsModel _$InvoiceDetailsModelFromJson(Map<String, dynamic> json) =>
    InvoiceDetailsModel(
      success: json['success'] as bool?,
      data: json['data'] == null
          ? null
          : InvoiceDetailsData.fromJson(json['data'] as Map<String, dynamic>),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$InvoiceDetailsModelToJson(
        InvoiceDetailsModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data,
      'message': instance.message,
    };

InvoiceDetailsData _$InvoiceDetailsDataFromJson(Map<String, dynamic> json) =>
    InvoiceDetailsData(
      id: json['id'] as int?,
      invoice_id: json['invoice_id'] as String?,
      invoice_date: json['invoice_date'] as String?,
      patient_name: json['patient_name'] as String?,
      issued_by: json['issued_by'] as String?,
      hospital_address: json['hospital_address'] as String?,
      invoice_items: (json['invoice_items'] as List<dynamic>?)
          ?.map((e) => InvoiceItemList.fromJson(e as Map<String, dynamic>))
          .toList(),
      address: json['address'] as String?,
      city: json['city'] as String?,
      zip: json['zip'] as String?,
      currencySymbol: json['currencySymbol'] as String?,
      invoice_download: json['invoice_download'] as String?,
    );

Map<String, dynamic> _$InvoiceDetailsDataToJson(InvoiceDetailsData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'invoice_id': instance.invoice_id,
      'invoice_date': instance.invoice_date,
      'patient_name': instance.patient_name,
      'issued_by': instance.issued_by,
      'hospital_address': instance.hospital_address,
      'invoice_items': instance.invoice_items,
      'address': instance.address,
      'city': instance.city,
      'zip': instance.zip,
      'currencySymbol': instance.currencySymbol,
      'invoice_download': instance.invoice_download,
    };

InvoiceItemList _$InvoiceItemListFromJson(Map<String, dynamic> json) =>
    InvoiceItemList(
      id: json['id'] as int?,
      account_name: json['account_name'] as String?,
      description: json['description'] as String?,
      quantity: json['quantity'] as int?,
      price: json['price'] as int?,
      total: json['total'] as int?,
    );

Map<String, dynamic> _$InvoiceItemListToJson(InvoiceItemList instance) =>
    <String, dynamic>{
      'id': instance.id,
      'account_name': instance.account_name,
      'description': instance.description,
      'quantity': instance.quantity,
      'price': instance.price,
      'total': instance.total,
    };
