class ImageUploadReponse {
  bool? success;
  String? message;
  int? errorCode;
  Data? data;

  ImageUploadReponse({
    this.success,
    this.message,
    this.errorCode,
    this.data,
  });

  factory ImageUploadReponse.fromJson(Map<String, dynamic> json) =>
      ImageUploadReponse(
        success: json["success"],
        message: json["message"],
        errorCode: json["error_code"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "error_code": errorCode,
        "data": data?.toJson(),
      };
}

class Data {
  String? memberCreated;
  String? clientId;
  String? imageUrl;
  bool? deletable;
  String? relId;
  String? relType;
  DateTime? createdAt;
  DateTime? modifiedAt;
  String? memberUpdated;
  dynamic deletedAt;
  String? id;
  List<dynamic>? categories;

  Data({
    this.memberCreated,
    this.clientId,
    this.imageUrl,
    this.deletable,
    this.relId,
    this.relType,
    this.createdAt,
    this.modifiedAt,
    this.memberUpdated,
    this.deletedAt,
    this.id,
    this.categories,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        memberCreated: json["member_created"],
        clientId: json["client_id"],
        imageUrl: json["image_url"],
        deletable: json["deletable"],
        relId: json["rel_id"],
        relType: json["rel_type"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        modifiedAt: json["modified_at"] == null
            ? null
            : DateTime.parse(json["modified_at"]),
        memberUpdated: json["member_updated"],
        deletedAt: json["deleted_at"],
        id: json["id"],
        categories: json["categories"] == null
            ? []
            : List<dynamic>.from(json["categories"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "member_created": memberCreated,
        "client_id": clientId,
        "image_url": imageUrl,
        "deletable": deletable,
        "rel_id": relId,
        "rel_type": relType,
        "created_at": createdAt?.toIso8601String(),
        "modified_at": modifiedAt?.toIso8601String(),
        "member_updated": memberUpdated,
        "deleted_at": deletedAt,
        "id": id,
        "categories": categories == null
            ? []
            : List<dynamic>.from(categories!.map((x) => x)),
      };
}
