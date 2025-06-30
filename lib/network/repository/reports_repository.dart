import 'package:sw_app_gtel/network/api/dio_main.dart';
import 'package:sw_app_gtel/network/responses/dashboard_list_reponse.dart';
import 'package:sw_app_gtel/network/responses/dashboard_summary_reponse.dart';

class ReportsRepository {
  DioMain dioMain = DioMain();

  Future<DashboardSummaryReponse> getReports(int from_date, int to_date) async {
    try {
      final response = await dioMain.get(
          "api/v1/tms-service/courier/dashboard/summary",
          queryParameters: {
            "from_date": from_date,
            "to_date": to_date,
          });
      return DashboardSummaryReponse.fromJson(response);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<DashboardListReponse> getDashboardList(
      int from_date, int to_date) async {
    try {
      final response = await dioMain.get(
          "api/v1/tms-service/courier/dashboard/request-list",
          queryParameters: {
            "from_date": from_date,
            "to_date": to_date,
          });
      return DashboardListReponse.fromJson(response);
    } catch (e) {
      throw Exception(e);
    }
  }
}
