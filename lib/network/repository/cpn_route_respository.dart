import 'package:sw_app_gtel/network/api/dio_main.dart';
import 'package:sw_app_gtel/network/responses/data_cpn_route.dart';
import 'package:sw_app_gtel/network/responses/data_cpn_route_byid.dart';
import 'package:sw_app_gtel/network/responses/routing_cpn_start.dart';

class CPNRouteRepository {
  DioMain dioMain = DioMain();
  Future<List<DataCnpRouteReponse>> getAllRoute(
      int page, int size, int driver_id) async {
    try {
      final response = await dioMain.get(
          "api/v1/tms-service/routing/cpn/route?page=$page&size=$size&service_provider_id=$driver_id");

      if (response["success"] == true) {
        List<DataCnpRouteReponse> listRoute =
            response["data"].map<DataCnpRouteReponse>((e) {
          return DataCnpRouteReponse.fromJson(e);
        }).toList();
        return listRoute;
      } else {
        return [];
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<DataCnpRouteByIdReponse?> getRouteById(int routeId) async {
    try {
      final response =
          await dioMain.get("api/v1/tms-service/routing/cpn/route/$routeId");
      if (response["success"] == true) {
        return DataCnpRouteByIdReponse.fromJson(response["data"]);
      } else {
        return null;
      }
    } catch (e) {
      throw Exception('Error fetching data: $e');
    }
  }

  Future<UpdatRouteCPNReponse?> getRoutingCPNStart(int routeId) async {
    try {
      final response = await dioMain
          .patch("api/v1/tms-service/routing/cpn/route/${routeId}/start");

      if (response["success"] == true) {
        return UpdatRouteCPNReponse.fromJson(response["data"]);
      } else {
        return null;
      }
    } catch (e) {
      throw Exception('Error fetching data: $e');
    }
  }

  Future<UpdatRouteCPNReponse?> getRoutingCPNcomplete(int routeId) async {
    try {
      final response = await dioMain
          .patch("api/v1/tms-service/routing/cpn/route/${routeId}/complete");
      if (response["success"] == true) {
        return UpdatRouteCPNReponse.fromJson(response["data"]);
      } else {
        return null;
      }
    } catch (e) {
      throw Exception('Error fetching data: $e');
    }
  }

  Future<bool> updateStatusSeq(
      int seqID, int status, int driverId, String note) async {
    try {
      final response = await dioMain.patch(
          "api/v1/tms-service/routing/cpn/route/driver/${driverId}/sequence/${seqID}",
          data: {"status": status, "evidence_images": [], "note": note});
      if (response["success"] == true) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw Exception('Error fetching data: $e');
    }
  }
}
