import 'package:sw_app_gtel/network/api/dio_main.dart';
import 'package:sw_app_gtel/network/responses/scanbarcode_reponse.dart';

class ScanListBarcodeRepository {
  DioMain dioMain = DioMain();

  Future<ScanListBarcodeReponse> scanListBarCode(List<String> listBarCode,
      int route_id, bool is_drop, List<String> image_urls) async {
    try {
      final response = await dioMain.patch(
          "api/v1/tms-service/routing/cpn/route/driver/route/${route_id}",
          data: {
            "list_request_id": listBarCode,
            "is_drop": is_drop,
            "image_urls": image_urls,
            "note": "",
          });
      return ScanListBarcodeReponse.fromJson(response);
    } catch (e) {
      throw Exception('Error fetching data: $e');
    }
  }
}
