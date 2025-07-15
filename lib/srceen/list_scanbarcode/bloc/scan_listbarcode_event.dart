import 'package:sw_app_gtel/common/core/base/event/base_event.dart';

class ScanListBarCodeEvent extends BaseEvent {}

class GetListBarCodeEvent extends ScanListBarCodeEvent {
  List<String> listBarCode;
  int route_id;
  bool is_drop;
  List<String> image_urls;
  GetListBarCodeEvent(
      {required this.listBarCode,
      required this.route_id,
      required this.is_drop,
      required this.image_urls});
}
