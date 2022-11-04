import 'package:dio/dio.dart';
import 'package:infyhms_flutter/model/appointment_model/appointment_model.dart';
import 'package:infyhms_flutter/model/appointment_model/create_appointment/create_appointment_model.dart';
import 'package:infyhms_flutter/model/appointment_model/filter/filter_appointment_model.dart';
import 'package:infyhms_flutter/model/appointment_model/new_appointment/doctor_department_model.dart';
import 'package:infyhms_flutter/model/appointment_model/new_appointment/get_doctor_model.dart';
import 'package:infyhms_flutter/model/appointment_model/slot_booking/slot_booking_model.dart';
import 'package:infyhms_flutter/model/auth_model/login_model.dart';
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
