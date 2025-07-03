class NotificationReponse {
  bool? success;
  String? message;
  int? errorCode;
  List<Datum>? data;

  NotificationReponse({
    this.success,
    this.message,
    this.errorCode,
    this.data,
  });

  factory NotificationReponse.fromJson(Map<String, dynamic> json) =>
      NotificationReponse(
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
  int? createdAt;
  int? modifiedAt;
  int? memberCreated;
  int? memberUpdated;
  dynamic deletedAt;
  int? id;
  String? uid;
  String? title;
  String? message;
  dynamic redirectUrl;
  String? readAt;
  String? screenName;
  ScreenParams? screenParams;
  String? type;

  Datum({
    this.createdAt,
    this.modifiedAt,
    this.memberCreated,
    this.memberUpdated,
    this.deletedAt,
    this.id,
    this.uid,
    this.title,
    this.message,
    this.redirectUrl,
    this.readAt,
    this.screenName,
    this.screenParams,
    this.type,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        createdAt: json["created_at"],
        modifiedAt: json["modified_at"],
        memberCreated: json["member_created"],
        memberUpdated: json["member_updated"],
        deletedAt: json["deleted_at"],
        id: json["id"],
        uid: json["uid"],
        title: json["title"],
        message: json["message"],
        redirectUrl: json["redirect_url"],
        readAt: json["read_at"] == null ? "" : json["read_at"],
        screenName: json["screen_name"],
        screenParams: json["screen_params"] == null
            ? null
            : ScreenParams.fromJson(json["screen_params"]),
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "created_at": createdAt,
        "modified_at": modifiedAt,
        "member_created": memberCreated,
        "member_updated": memberUpdated,
        "deleted_at": deletedAt,
        "id": id,
        "uid": uid,
        "title": title,
        "message": message,
        "redirect_url": redirectUrl,
        "read_at": readAt,
        "screen_name": screenName,
        "screen_params": screenParams?.toJson(),
        "type": type,
      };
}

class ScreenParams {
  int? id;

  ScreenParams({
    this.id,
  });

  factory ScreenParams.fromJson(Map<String, dynamic> json) => ScreenParams(
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
      };
}
