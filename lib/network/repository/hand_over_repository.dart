import 'dart:convert';
import 'dart:io';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path/path.dart';
import 'package:dio/dio.dart';

import 'package:sw_app_gtel/network/api/dio_main.dart';
import 'package:sw_app_gtel/network/responses/data_hand_over_reponse.dart';
import 'package:sw_app_gtel/network/responses/image_upload_reponse.dart';
import 'package:sw_app_gtel/network/responses/route_handover_reponse.dart';
import 'package:sw_app_gtel/network/responses/sub_account_reponse.dart';

class HandOverRepository {
  DioMain dioMain = DioMain();
  Future<List<HandOverReponse>> getAllHandOver(
      int page, int size, int driver_id) async {
    try {
      final response = await dioMain.get(
          "api/v1/tms-service/routing/cpn/route?page=$page&size=$size&driver_id=$driver_id");

      if (response["success"] == true) {
        List<HandOverReponse> listRoute =
            response["data"].map<HandOverReponse>((e) {
          return HandOverReponse.fromJson(e);
        }).toList();
        return listRoute;
      } else {
        return [];
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<SubAccountReponse> getSubAccount(
      int page, int size, int serviceId) async {
    try {
      final response = await dioMain
          .get("api/v1/tms-service/member/sub-account", queryParameters: {
        "page": 1,
        "size": 10,
        "filter": jsonEncode([
          {"col": "service_provider_id", "op": "\$eq", "val": serviceId}
        ])
      });
      return SubAccountReponse.fromJson(response);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<RouteHandoverReponse> getinfoHandOver(int routeID) async {
    try {
      final response = await dioMain
          .get("api/v1/tms-service/routing/cpn/route/handover/${routeID}");

      return RouteHandoverReponse.fromJson(response);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<XFile?> compressImage(File file, Directory dir) async {
    final targetPath =
        '${dir.path}/${basenameWithoutExtension(file.path)}_compressed.jpg';

    return await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      targetPath,
      quality: 75, // Giảm xuống nếu cần (<75)
      minWidth: 1280,
      minHeight: 720,
    );
  }

  Future<ImageUploadReponse> uploadImage(
      int routeId, File imageFile, bool deletable, Directory dir) async {
    try {
      final compressedFile = await compressImage(imageFile, dir);
      final fileName = basename(compressedFile!.path);

      final metadata = {
        "rel_id": routeId,
        "rel_type": "route_id",
        "deletable": false,
      };

      FormData formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(
          compressedFile.path,
          filename: fileName,
        ),
        "metadata": jsonEncode(metadata),
      });

      final response =
          await dioMain.post("api/v1/tms-service/image-upload-log/image",
              data: formData,
              options: Options(
                headers: {
                  "Content-Type": "multipart/form-data",
                },
              ));

      return ImageUploadReponse.fromJson(response);
    } catch (e) {
      throw Exception(e);
    }
  }
}
