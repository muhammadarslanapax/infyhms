// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_request.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _ApiClient implements ApiClient {
  _ApiClient(
    this._dio, {
    this.baseUrl,
  }) {
    baseUrl ??= 'https://hms-staging.infyom.com/api/';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<LoginModel> loginPatient(data) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(data);
    final _result = await _dio.fetch<Map<String, dynamic>>(_setStreamType<LoginModel>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      validateStatus: (statusCode) {
        if (statusCode == null) {
          return false;
        }
        if (statusCode == 422) {
          return true;
        } else {
          return statusCode >= 200 && statusCode < 300;
        }
      },
    )
        .compose(
          _dio.options,
          'login',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = LoginModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<AppointmentModel> getAppointments(token) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{r'Authorization': token};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(_setStreamType<AppointmentModel>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
      validateStatus: (statusCode) {
        if (statusCode == null) {
          return false;
        }
        if (statusCode == 401) {
          return true;
        } else {
          return statusCode >= 200 && statusCode < 300;
        }
      },
    )
        .compose(
          _dio.options,
          'appointments',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = AppointmentModel.fromJson(_result.data!);
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic && !(requestOptions.responseType == ResponseType.bytes || requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
