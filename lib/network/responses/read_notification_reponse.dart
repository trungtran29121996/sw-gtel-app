class ReadNotificationReponse {
  bool? success;
  String? message;
  int? errorCode;
  Data? data;

  ReadNotificationReponse({
    this.success,
    this.message,
    this.errorCode,
    this.data,
  });

  factory ReadNotificationReponse.fromJson(Map<String, dynamic> json) =>
      ReadNotificationReponse(
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
  int? id;
  DateTime? readAt;
  int? modifiedAt;
  dynamic redirectUrl;
  dynamic screenName;
  dynamic screenParams;
  dynamic type;

  Data({
    this.id,
    this.readAt,
    this.modifiedAt,
    this.redirectUrl,
    this.screenName,
    this.screenParams,
    this.type,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        readAt:
            json["read_at"] == null ? null : DateTime.parse(json["read_at"]),
        modifiedAt: json["modified_at"],
        redirectUrl: json["redirect_url"],
        screenName: json["screen_name"],
        screenParams: json["screen_params"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "read_at": readAt?.toIso8601String(),
        "modified_at": modifiedAt,
        "redirect_url": redirectUrl,
        "screen_name": screenName,
        "screen_params": screenParams,
        "type": type,
      };
}
