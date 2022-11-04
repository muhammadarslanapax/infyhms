import 'dart:io';

import 'package:dio/dio.dart';
import 'package:infyhms_flutter/model/appointment_model/appointment_model.dart';
import 'package:infyhms_flutter/model/appointment_model/create_appointment/create_appointment_model.dart';
import 'package:infyhms_flutter/model/appointment_model/filter/filter_appointment_model.dart';
import 'package:infyhms_flutter/model/appointment_model/new_appointment/doctor_department_model.dart';
import 'package:infyhms_flutter/model/appointment_model/new_appointment/get_doctor_model.dart';
import 'package:infyhms_flutter/model/appointment_model/slot_booking/slot_booking_model.dart';
import 'package:infyhms_flutter/model/auth_model/login_model.dart';
import 'package:infyhms_flutter/model/documents/document_delete_model/document_delete.dart';
import 'package:infyhms_flutter/model/documents/document_download_model/document_download.dart';
import 'package:infyhms_flutter/model/documents/document_store_model/document_store.dart';
import 'package:infyhms_flutter/model/documents/documents_model/documents.dart';
import 'package:infyhms_flutter/model/documents/documents_type_model/documents_type.dart';
import 'package:infyhms_flutter/utils/string_utils.dart';
import 'package:retrofit/retrofit.dart';

part 'api_request.g.dart';

@RestApi(baseUrl: "https://hms-staging.infyom.com/api/")
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @POST(StringUtils.loginPatient)
  Future<LoginModel> loginPatient(@Body() Map<String, dynamic> data);

  @GET(StringUtils.appointments)
  Future<AppointmentModel> getAppointments(
    @Header('Authorization') String? token,
  );

  @POST("appointment-filter?status={filter}")
  Future<FilterAppointmentModel> getPastAppointments(
    @Header('Authorization') String? token,
    @Path("filter") String filter,
  );

  @GET("doctor-department")
  Future<DoctorDepartmentModel> getDoctorDepartment(
    @Header('Authorization') String? token,
  );

  @POST("doctor/{id}")
  Future<GetDoctorModel> getDoctor(
    @Header('Authorization') String? token,
    @Path("id") int id,
  );

  @POST("slot-booking")
  Future<SlotBookingModel> getBookingSlotDate(
    @Header('Authorization') String? token,
    @Field("editSelectedDate") String editSelectedDate,
    @Field("doctor_id") String doctorId,
  );

  @POST("appointment-create")
  Future<CreateAppointmentModel> createAppointment(
    @Header('Authorization') String? token,
    @Field("department_id") String departmentId,
    @Field("doctor_id") String doctorId,
    @Field("opd_date") String selectedDate,
    @Field("time") String selectedTime,
  );

  @GET("documents")
  Future<DocumentsModel> getDocuments(
    @Header('Authorization') String? token,
  );

  @GET("document-type")
  Future<DocumentsTypeModel> getDocumentsType(
    @Header('Authorization') String? token,
  );

  @MultiPart()
  @POST("document-store")
  Future<DocumentStoreModel> storeDocument(
    @Header('Authorization') String? token,
    @Part(name: "title") String title,
    @Part(name: "document_type_id") String documentTypeId,
    @Part(name: "notes") String notes,
    @Part(name: "file") File file,
  );

  @MultiPart()
  @POST("document-update/{id}")
  Future<DocumentStoreModel> updateDocument(
    @Header('Authorization') String? token,
    @Part(name: "title") String title,
    @Part(name: "document_type_id") String documentTypeId,
    @Part(name: "notes") String notes,
    @Part(name: "file") File file,
    @Path("id") int documentId,
  );

  @GET("document-delete/{id}")
  Future<DocumentDeleteModel> deleteDocument(
    @Path("id") int documentId,
  );

  @GET("document-download/{id}")
  Future<DocumentDownloadModel> downloadDocument(
    @Path("id") int documentId,
  );
}

// validateStatus: (statusCode) {
// if (statusCode == null) {
// return false;
// }
// if (statusCode == 422) {
// return true;
// } else {
// return statusCode >= 200 && statusCode < 300;
// }
// },
