import 'package:dio/dio.dart';
import 'package:sw_app_gtel/common/pref/sp_util.dart';
import 'package:sw_app_gtel/network/api/api_url.dart';
import 'package:sw_app_gtel/network/api/dio_main.dart';
import 'package:sw_app_gtel/network/responses/driver_me_reponse.dart';
import 'package:sw_app_gtel/network/responses/login_response.dart';

class LoginRepository {
  DioMain dioMain = DioMain();
  Future login(String phone, String password) async {
    try {
      final response = await dioMain
          .post("auth/login", data: {"phone": phone, "password": password});

      if (response["success"] == true) {
        LoginReponse reponse = LoginReponse.fromJson(response["data"]);
        await SpUtil.putObject("member_info", reponse.memberInfo.toJson());
        await SpUtil.putString("token", reponse.token);
        await SpUtil.putString("refreshToken", reponse.refreshToken);
        await getDriverMe(reponse.token);
        return reponse;
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<bool> refreshToken(String refreshToken) async {
    try {
      final response = await dioMain
          .post("auth/refresh-token", data: {"refresh_token": refreshToken});
      if (response["success"] == true) {
        LoginReponse res = LoginReponse.fromJson(response["data"]);
        await SpUtil.putString("token", res.token);
        await SpUtil.putString("refreshToken", res.refreshToken);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future logout() async {
    SpUtil.clear();
  }

  Future getDriverMe(String token) async {
    Dio dio = Dio();
    try {
      final response = await dio.get(
          "${APIUrl.API_URL_DEV}api/v1/tms-service/driver/me",
          options: Options(headers: {'Authorization': token}));
      if (response.data != "") {
        DriverReponse driverInfoResponse =
            DriverReponse.fromJson(response.data["data"]);
        await SpUtil.putInt("driverId", driverInfoResponse.driverId!);
        return response.data;
      } else {
        throw Exception("LOI");
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
