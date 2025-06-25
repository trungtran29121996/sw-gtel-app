import 'dart:io';

import 'package:sw_app_gtel/common/core/base/event/base_event.dart';

class HandOverEvent extends BaseEvent {}

class GetAllHandOver extends HandOverEvent {
  int page;
  int size;
  int driver_id;
  GetAllHandOver(
      {required this.page, required this.size, required this.driver_id});
}

class GetSubAccount extends HandOverEvent {
  int page;
  int size;
  int service_provider_id;
  GetSubAccount(
      {required this.page,
      required this.size,
      required this.service_provider_id});
}

class UploadImage extends HandOverEvent {
  int routeId;
  File imageFile;
  UploadImage({required this.routeId, required this.imageFile});
}
