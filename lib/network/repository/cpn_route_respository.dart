import 'dart:convert';

import 'package:sw_app_gtel/network/api/dio_main.dart';
import 'package:sw_app_gtel/network/request/create_cpnlot_request.dart';
import 'package:sw_app_gtel/network/responses/data_cpn_route_reponse.dart';
import 'package:sw_app_gtel/network/responses/data_cpn_route_byid_reponse.dart';
import 'package:sw_app_gtel/network/responses/request_cpn_reponse.dart';
import 'package:sw_app_gtel/network/responses/routing_cpn_start_reponse.dart';
import 'package:sw_app_gtel/network/responses/tracking_log_reponse.dart';
import 'package:sw_app_gtel/network/responses/update_status_seq_reponse.dart';

class CPNRouteRepository {
  DioMain dioMain = DioMain();
  Future<List<DataCnpRouteReponse>> getAllRoute(
      int page, int size, int driver_id, List<int> lstType) async {
    try {
      final response = await dioMain
          .get("api/v1/tms-service/routing/cpn/route", queryParameters: {
        "page": page,
        "size": size,
        "service_provider_id": driver_id,
        "filter": jsonEncode([
          {"col": "request_type", "op": "\$in", "val": lstType}
        ])
      });

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

  Future<DataUpdatRouteCPNReponse?> getRoutingCPNStart(int routeId) async {
    try {
      final response = await dioMain
          .patch("api/v1/tms-service/routing/cpn/route/${routeId}/start");
      return DataUpdatRouteCPNReponse.fromJson(response);
    } catch (e) {
      print("${e.toString()}");
    }
    return null;
  }

  Future<UpdateStatusSeqReponse> updateStatusSeq(int seqID, int status,
      int driverId, String note, List<String> evidenceImages) async {
    try {
      final response = await dioMain.patch(
          "api/v1/tms-service/routing/cpn/route/driver/${driverId}/sequence/${seqID}",
          data: {
            "status": status,
            "evidence_images": evidenceImages,
            "note": note
          });
      return UpdateStatusSeqReponse.fromJson(response);
    } catch (e) {
      throw Exception('Error fetching data: $e');
    }
  }

  Future<UpdatRouteCPNReponse?> getRoutingCPNcomplete(int routeId,
      String handover_note, String assignee_id, List<String> lstimage) async {
    try {
      Map<String, dynamic> params = {
        "handover_note": handover_note,
        "assignee_id": assignee_id,
        "handover_images": lstimage
      };

      final response = await dioMain.patch(
          "api/v1/tms-service/routing/cpn/route/${routeId}/complete",
          data: {params});

      if (response["success"] == true) {
        return UpdatRouteCPNReponse.fromJson(response["data"]);
      } else {
        return null;
      }
    } catch (e) {
      throw Exception('Error fetching data: $e');
    }
  }

  Future<TrackingLogReponse?> trackingLog(int request_id) async {
    try {
      final response = await dioMain
          .get("api/v1/tms-service/request-tracking-log/request/1000000597");
      return TrackingLogReponse.fromJson(response);
    } catch (e) {
      print("${e.toString()}");
    }
    return null;
  }

  Future<bool> createCPNLot(
      int requestId, CreateCpnLotRequest createCpnLotRequest) async {
    try {
      final response = await dioMain
          .patch("api/v1/tms-service/request/cpn/lot/${requestId}", data: {
        "rlength": createCpnLotRequest.rlength,
        "rwidth": createCpnLotRequest.rwidth,
        "rheight": createCpnLotRequest.rheight,
        "rweight": createCpnLotRequest.rweight,
        "note": createCpnLotRequest.note,
        "request_package_items": createCpnLotRequest.requestPackageItems,
        "url_pictures": createCpnLotRequest.urlPictures
      });
      if (response["success"] == true) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw Exception('Error fetching data: $e');
    }
  }

  Future<RequsetCPN?> getRequsetCPN(int requestID) async {
    try {
      final response =
          await dioMain.get("api/v1/tms-service/request/cpn/lot/${requestID}");
      if (response["success"] == true) {
        return RequsetCPN.fromJson(response["data"]);
      } else {
        return null;
      }
    } catch (e) {
      throw Exception('Error fetching data: $e');
    }
  }
}
