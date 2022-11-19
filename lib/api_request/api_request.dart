import 'dart:io';

import 'package:dio/dio.dart';
import 'package:infyhms_flutter/model/doctor/doctor_appointment_model/doctor_appointment_model.dart';
import 'package:infyhms_flutter/model/doctor/doctor_model/doctor_detail_model.dart';
import 'package:infyhms_flutter/model/doctor/doctor_model/doctor_model.dart';
import 'package:infyhms_flutter/model/doctor/doctor_prescription_model/doctor_prescription_detail_model.dart';
import 'package:infyhms_flutter/model/doctor/doctor_prescription_model/doctor_prescription_model.dart';
import 'package:infyhms_flutter/model/patient/account_model/edit_profile_model.dart';
import 'package:infyhms_flutter/model/patient/account_model/get_profile_model.dart';
import 'package:infyhms_flutter/model/patient/admission_model/admission_model.dart';
import 'package:infyhms_flutter/model/patient/appointment_model/appointment_model.dart';
import 'package:infyhms_flutter/model/patient/appointment_model/cancel_appointment/cancel_appointment_model.dart';
import 'package:infyhms_flutter/model/patient/appointment_model/create_appointment/create_appointment_model.dart';
import 'package:infyhms_flutter/model/patient/appointment_model/delete_appointment/delete_appointment_model.dart';
import 'package:infyhms_flutter/model/patient/appointment_model/doctor/doctor_department_model.dart';
import 'package:infyhms_flutter/model/patient/appointment_model/doctor/get_doctor_model.dart';
import 'package:infyhms_flutter/model/patient/appointment_model/filter/filter_appointment_model.dart';
import 'package:infyhms_flutter/model/patient/appointment_model/slot_booking/slot_booking_model.dart';
import 'package:infyhms_flutter/model/patient/auth_model/forgot_password_model.dart';
import 'package:infyhms_flutter/model/patient/auth_model/login_model.dart';
import 'package:infyhms_flutter/model/patient/auth_model/logout_model.dart';
import 'package:infyhms_flutter/model/patient/auth_model/reset_password_model.dart';
import 'package:infyhms_flutter/model/patient/auth_model/send_token_model.dart';
import 'package:infyhms_flutter/model/patient/bills_model/bill_detail_model.dart';
import 'package:infyhms_flutter/model/patient/bills_model/bill_model.dart';
import 'package:infyhms_flutter/model/patient/case_model/case_model.dart';
import 'package:infyhms_flutter/model/patient/diagnosis_model/diagnosis_test_details_model.dart';
import 'package:infyhms_flutter/model/patient/diagnosis_model/diagnosis_test_model.dart';
import 'package:infyhms_flutter/model/patient/documents_model/document_delete_model/document_delete.dart';
import 'package:infyhms_flutter/model/patient/documents_model/document_download_model/document_download.dart';
import 'package:infyhms_flutter/model/patient/documents_model/document_store_model/document_store.dart';
import 'package:infyhms_flutter/model/patient/documents_model/document_update_model/document_update.dart';
import 'package:infyhms_flutter/model/patient/documents_model/documents_model/documents.dart';
import 'package:infyhms_flutter/model/patient/documents_model/documents_type_model/documents_type.dart';
import 'package:infyhms_flutter/model/patient/invoice_model/invoice_details_model.dart';
import 'package:infyhms_flutter/model/patient/invoice_model/invoice_model.dart';
import 'package:infyhms_flutter/model/patient/live_consultancy/live_consultation_details_model.dart';
import 'package:infyhms_flutter/model/patient/live_consultancy/live_consultation_filter.dart';
import 'package:infyhms_flutter/model/patient/live_consultancy/live_consultation_model.dart';
import 'package:infyhms_flutter/model/patient/notice_board_model/notice_board.dart';
import 'package:infyhms_flutter/model/patient/prescriptions_model/prescriptions_model.dart';
import 'package:infyhms_flutter/model/patient/vaccinated_model/vaccinated_model.dart';
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
    @Field("patient_id") String patientId,
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
  Future<DocumentUpdateModel> updateDocument(
    @Header('Authorization') String? token,
    @Part(name: "title") String title,
    @Part(name: "document_type_id") String documentTypeId,
    @Part(name: "notes") String notes,
    @Part(name: "file") File? file,
    @Path("id") int documentId,
  );

  @GET("document-delete/{id}")
  Future<DocumentDeleteModel> deleteDocument(
    @Header('Authorization') String? token,
    @Path("id") int documentId,
  );

  @GET("document-download/{id}")
  Future<DocumentDownloadModel> downloadDocument(
    @Header('Authorization') String? token,
    @Path("id") int documentId,
  );

  @GET("notice-board")
  Future<NoticeBoardModel> getNoticeBoard(
    @Header('Authorization') String? token,
  );

  @GET("invoices")
  Future<InvoiceModel> getInvoices(
    @Header('Authorization') String? token,
  );

  @GET("invoice/{id}")
  Future<InvoiceDetailsModel> getInvoiceData(
    @Header('Authorization') String? token,
    @Path("id") int invoiceId,
  );

  @GET("live-consultation")
  Future<LiveConsultationModel> liveConsultations(
    @Header('Authorization') String? token,
  );

  @GET("live-consultation/{id}")
  Future<LiveConsultationDetailsModel> liveConsultationData(
    @Header('Authorization') String? token,
    @Path("id") int consultationId,
  );

  @POST("live-consultation-filter?status={status}")
  Future<LiveConsultationFilter> liveConsultationFilter(
    @Header('Authorization') String? token,
    @Path("status") String status,
  );

  @POST("cancel-appointment")
  Future<CancelAppointmentModel> cancelAppointment(
    @Header('Authorization') String? token,
    @Field("id") int id,
  );

  @POST("delete-appointment")
  Future<DeleteAppointmentModel> deleteAppointment(
    @Header('Authorization') String? token,
    @Field("id") int id,
  );

  @GET("bills")
  Future<BillsModel> getBills(
    @Header('Authorization') String? token,
  );

  @GET("bills/{id}")
  Future<BillDetailModel> getBillsDetails(
    @Header('Authorization') String? token,
    @Path("id") int id,
  );

  @GET("diagnosis")
  Future<DiagnosisTestModel> getDiagnosisTest(
    @Header('Authorization') String? token,
  );

  @GET("diagnosis/{id}")
  Future<DiagnosisTestDetailsModel> getDiagnosisTestDetails(
    @Header('Authorization') String? token,
    @Path("id") int id,
  );

  @GET("patient-cases")
  Future<CaseModel> getCase(
    @Header('Authorization') String? token,
  );

  @GET("patient-admissions")
  Future<AdmissionModel> getAdmission(
    @Header('Authorization') String? token,
  );

  @GET("patient-prescription")
  Future<PrescriptionsModel> getPrescription(
    @Header('Authorization') String? token,
  );

  @GET("vaccinated-patient")
  Future<VaccinatedModel> getVaccinated(
    @Header('Authorization') String? token,
  );

  @MultiPart()
  @POST("update-profile")
  Future<EditProfileModel> editProfile(
    @Header('Authorization') String? token,
    @Part(name: "first_name") String firstName,
    @Part(name: "last_name") String lastName,
    @Part(name: "email") String email,
    @Part(name: "phone") String phone,
    @Part(name: "image") File? profileImage,
  );

  @POST("logout")
  Future<LogoutModel> logout(
    @Header('Authorization') String? token,
  );

  @POST("reset-password")
  Future<ResetPasswordModel> resetPassword(
    @Header('Authorization') String? token,
    @Body() Map<String, dynamic> data,
  );

  @POST("forgot-password")
  Future<ForgotPasswordModel> forgotPassword(
    @Body() Map<String, dynamic> data,
  );

  @POST("password")
  Future<SendTokenModel> sendToken(
    @Field("token") String token,
    @Field("password") String password,
    @Field("password_confirmation") String passwordConfirmation,
    @Field("email") String email,
  );

  @GET("get-profile")
  Future<GetProfileModel> getProfile(
    @Header('Authorization') String? token,
  );

  /// Doctor panel

  @GET("doctors/appointment-filter?status={status}")
  Future<DoctorAppointmentModel> getDoctorAppointments(
    @Header('Authorization') String? token,
    @Path("status") String status,
  );

  @GET("doctors/doctors")
  Future<DoctorsModel> getDoctors(
    @Header('Authorization') String? token,
  );

  @GET("doctors/doctors/{id}")
  Future<DoctorsDetailModel> getDoctorsDetail(
    @Header('Authorization') String? token,
    @Path("id") int id,
  );

  @GET("doctors/prescriptions")
  Future<DoctorPrescriptionModel> getDoctorsPrescription(
    @Header('Authorization') String? token,
  );

  @GET("doctors/prescriptions/{id}")
  Future<DoctorPrescriptionDetailModel> getDoctorsPrescriptionDetail(
    @Header('Authorization') String? token,
    @Path("id") int id,
  );
}
