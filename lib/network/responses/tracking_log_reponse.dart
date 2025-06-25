class TrackingLogReponse {
  bool? success;
  String? message;
  int? errorCode;
  List<Datum>? data;

  TrackingLogReponse({
    this.success,
    this.message,
    this.errorCode,
    this.data,
  });

  factory TrackingLogReponse.fromJson(Map<String, dynamic> json) =>
      TrackingLogReponse(
        success: json["success"],
        message: json["message"],
        errorCode: json["error_code"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "error_code": errorCode,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  DateTime? createdAt;
  DateTime? modifiedAt;
  int? memberCreated;
  int? memberUpdated;
  dynamic deletedAt;
  String? requestLogId;
  String? requestId;
  String? routeId;
  String? serviceProviderId;
  int? status;
  String? fullAddress;
  String? addressLabel;
  int? wardId;
  String? description;
  String? note;
  List<dynamic>? evidenceImages;
  String? driverId;
  String? clientId;
  String? requestProviderId;
  int? type;

  Datum({
    this.createdAt,
    this.modifiedAt,
    this.memberCreated,
    this.memberUpdated,
    this.deletedAt,
    this.requestLogId,
    this.requestId,
    this.routeId,
    this.serviceProviderId,
    this.status,
    this.fullAddress,
    this.addressLabel,
    this.wardId,
    this.description,
    this.note,
    this.evidenceImages,
    this.driverId,
    this.clientId,
    this.requestProviderId,
    this.type,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        modifiedAt: json["modified_at"] == null
            ? null
            : DateTime.parse(json["modified_at"]),
        memberCreated: json["member_created"],
        memberUpdated: json["member_updated"],
        deletedAt: json["deleted_at"],
        requestLogId: json["request_log_id"],
        requestId: json["request_id"],
        routeId: json["route_id"],
        serviceProviderId: json["service_provider_id"],
        status: json["status"],
        fullAddress: json["full_address"],
        addressLabel: json["address_label"],
        wardId: json["ward_id"],
        description: json["description"],
        note: json["note"],
        evidenceImages: json["evidence_images"] == null
            ? []
            : List<dynamic>.from(json["evidence_images"]!.map((x) => x)),
        driverId: json["driver_id"],
        clientId: json["client_id"],
        requestProviderId: json["request_provider_id"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "created_at": createdAt?.toIso8601String(),
        "modified_at": modifiedAt?.toIso8601String(),
        "member_created": memberCreated,
        "member_updated": memberUpdated,
        "deleted_at": deletedAt,
        "request_log_id": requestLogId,
        "request_id": requestId,
        "route_id": routeId,
        "service_provider_id": serviceProviderId,
        "status": status,
        "full_address": fullAddress,
        "address_label": addressLabel,
        "ward_id": wardId,
        "description": description,
        "note": note,
        "evidence_images": evidenceImages == null
            ? []
            : List<dynamic>.from(evidenceImages!.map((x) => x)),
        "driver_id": driverId,
        "client_id": clientId,
        "request_provider_id": requestProviderId,
        "type": type,
      };
}
