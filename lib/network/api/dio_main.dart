import 'package:dio/dio.dart';
import 'package:sw_app_gtel/common/core/exceptions/request_exception.dart';
import 'package:sw_app_gtel/network/api/api_url.dart';
import 'package:sw_app_gtel/network/api/dio_interceptor.dart';

class DioMain {
  Dio dio = Dio();
  String baseUrl = APIUrl.API_URL_DEV;
  DioMain() {
    dio.interceptors.add(DioInterceptor());
  }

  Future<dynamic> get(
    String endpoint, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    void Function(int, int)? onReceiveProgress,
  }) async {
    try {
      Response response;

      response = await dio.get(baseUrl + endpoint,
          data: data, queryParameters: queryParameters);
      return _handleResponse(response);
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> post(
    String endponit, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    void Function(int, int)? onSendProgress,
    void Function(int, int)? onReceiveProgress,
  }) async {
    try {
      Response response;
      response = await dio.post(baseUrl + endponit,
          data: data, queryParameters: queryParameters);
      return _handleResponse(response);
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> put(String endpoint,
      {Object? data,
      Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      void Function(int, int)? onSendProgress,
      void Function(int, int)? onReceiveProgress}) async {
    try {
      Response response;
      response = await dio.put(baseUrl + endpoint,
          data: data, queryParameters: queryParameters);
      return _handleResponse(response);
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> patch(String endpoint,
      {Object? data,
      Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      void Function(int, int)? onSendProgress,
      void Function(int, int)? onReceiveProgress}) async {
    try {
      Response response;
      response = await dio.patch(baseUrl + endpoint,
          data: data, queryParameters: queryParameters);
      return _handleResponse(response);
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> delete(
    String endpoint, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      Response response;
      response = await dio.delete(baseUrl + endpoint,
          data: data, queryParameters: queryParameters);
      return _handleResponse(response);
    } catch (e) {
      print(e);
    }
  }

  dynamic _handleResponse(Response response) {
    int code = response.statusCode ?? 0;

    if (code >= 200 && code <= 300) {
      if (code == 204) {
        return {};
      }

      return response.data;
    }

    if (code == 406) {
      return response.data;
    }

    switch (code) {
      case 400:
        print(
          'Error --------------------${response.statusCode}',
        );
        throw BadRequestException(response.data.toString());
      case 401:
      case 403:
        print(
          'Error --------------------${response.statusCode}',
        );
        throw UnauthorizedException(response.data.toString());
      case 500:
      case 406:
      default:
        print(response.data);
        print(
          'Error --------------------${response.statusCode}',
        );
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : $code');
    }
  }
}
