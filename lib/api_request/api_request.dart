import 'package:dio/dio.dart';
import 'package:infyhms_flutter/model/appointment_model.dart';
import 'package:infyhms_flutter/model/login_model.dart';
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
