import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sw_app_gtel/common/pref/sp_util.dart';
import 'package:sw_app_gtel/network/api/api_url.dart';

class DioInterceptor extends Interceptor {
  Dio dio = Dio();
  String baseUrl = APIUrl.API_URL_DEV;
  String accessToken = SpUtil.getString("token");
  String refreshToken = SpUtil.getString("refreshToken");
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    if (!options.path.contains("https")) {
      options.baseUrl = baseUrl;
    }
    options.connectTimeout = const Duration(seconds: 30);
    options.receiveTimeout = const Duration(seconds: 30);
    options.headers['Authorization'] = 'Bearer $accessToken';
    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // Map<String, dynamic> data = response.data;
    // if (data['data'] != null) {
    //   if (data['data'] == "") {
    //     response.data = <String, dynamic>{};
    //   } else {
    //     response.data = data['data'];
    //   }
    // }
    return handler.next(response);
  }

  void onError(DioException error, ErrorInterceptorHandler handler) async {
    if (error.response?.statusCode == 401 ||
        error.response?.statusCode == 403) {
      if (refreshToken.isNotEmpty) {
        try {
          Response response = await dio.post(
            "${baseUrl}auth/refresh-token",
            data: {'refresh_token': refreshToken},
          );
          if (response.statusCode == 200) {
            String newToken = response.data["data"]["token"];
            String newRefreshToken = response.data["data"]["refresh_token"];

            await SpUtil.putString("token", newToken);
            await SpUtil.putString("refreshToken", newRefreshToken);

            accessToken = newToken;
            refreshToken = newRefreshToken;

            error.requestOptions.headers['Authorization'] = "Bearer $newToken";

            final opts = Options(
              method: error.requestOptions.method,
              headers: error.requestOptions.headers,
            );

            final cloneReq = await dio.request(
              error.requestOptions.path,
              options: opts,
              data: error.requestOptions.data,
              queryParameters: error.requestOptions.queryParameters,
            );

            return handler.resolve(cloneReq);
          } else {
            // _logout();
          }
        } catch (e) {
          // _logout();
        }
      } else {
        // _logout();
      }
    } else {
      return handler.next(error);
    }
  }
}
