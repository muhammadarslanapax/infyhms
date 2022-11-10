import 'dart:io';

import 'package:dio/dio.dart';
import 'package:infyhms_flutter/model/account_model/edit_profile_model.dart';
import 'package:infyhms_flutter/model/admission_model/admission_model.dart';
import 'package:infyhms_flutter/model/appointment_model/appointment_model.dart';
import 'package:infyhms_flutter/model/appointment_model/cancel_appointment/cancel_appoitment_model.dart';
import 'package:infyhms_flutter/model/appointment_model/create_appointment/create_appointment_model.dart';
import 'package:infyhms_flutter/model/appointment_model/delete_appointement/delete_appointment_model.dart';
import 'package:infyhms_flutter/model/appointment_model/doctor/doctor_department_model.dart';
import 'package:infyhms_flutter/model/appointment_model/doctor/get_doctor_model.dart';
import 'package:infyhms_flutter/model/appointment_model/filter/filter_appointment_model.dart';
import 'package:infyhms_flutter/model/appointment_model/slot_booking/slot_booking_model.dart';
import 'package:infyhms_flutter/model/auth_model/login_model.dart';
import 'package:infyhms_flutter/model/auth_model/logout_model.dart';
import 'package:infyhms_flutter/model/auth_model/reset_password_model.dart';
import 'package:infyhms_flutter/model/bills_model/bill_detail_model.dart';
import 'package:infyhms_flutter/model/bills_model/bill_model.dart';
import 'package:infyhms_flutter/model/case_model/case_model.dart';
import 'package:infyhms_flutter/model/diagnosis_model/diagnosis_test_details_model.dart';
import 'package:infyhms_flutter/model/diagnosis_model/diagnosis_test_model.dart';
import 'package:infyhms_flutter/model/prescriptions_model/prescriptions_model.dart';
import 'package:infyhms_flutter/model/vaccinated_model/vaccinated_model.dart';
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
}
//
// validateStatus: (statusCod
// if (statusCode == null) {
// return false;
// }
// if (statusCode == 422) {
// return true;
// } else {
// return statusCode >= 200 && statusCode < 300;
// }
// },
