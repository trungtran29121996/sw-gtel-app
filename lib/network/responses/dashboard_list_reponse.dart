class DashboardListReponse {
  bool? success;
  String? message;
  int? errorCode;
  List<Datum> data;

  DashboardListReponse({
    this.success,
    this.message,
    this.errorCode,
    required this.data,
  });

  factory DashboardListReponse.fromJson(Map<String, dynamic> json) =>
      DashboardListReponse(
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
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  String? serviceName;
  String? packageName;
  String? orderCodeOfClient;
  double? rweight;
  int? cod;
  int? shippingFee;
  String? completetime;
  RequestStatus? requestStatus;

  Datum({
    this.serviceName,
    this.packageName,
    this.orderCodeOfClient,
    this.rweight,
    this.cod,
    this.shippingFee,
    this.completetime,
    this.requestStatus,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        serviceName: json["service_name"],
        packageName: json["package_name"],
        orderCodeOfClient: json["order_code_of_client"],
        rweight: json["rweight"]?.toDouble(),
        completetime: json["complete_time"],
        cod: json["cod"],
        shippingFee: json["shipping_fee"],
        requestStatus: json["request_status"] == null
            ? null
            : RequestStatus.fromJson(json["request_status"]),
      );

  Map<String, dynamic> toJson() => {
        "service_name": serviceName,
        "package_name": packageName,
        "order_code_of_client": orderCodeOfClient,
        "rweight": rweight,
        "cod": cod,
        "shipping_fee": shippingFee,
        "complete_time": completetime,
        "request_status": requestStatus?.toJson(),
      };
}

class RequestStatus {
  String? label;
  String? textColor;
  String? backgroundColor;

  RequestStatus({
    this.label,
    this.textColor,
    this.backgroundColor,
  });

  factory RequestStatus.fromJson(Map<String, dynamic> json) => RequestStatus(
        label: json["label"],
        textColor: json["text_color"],
        backgroundColor: json["background_color"],
      );

  Map<String, dynamic> toJson() => {
        "label": label,
        "text_color": textColor,
        "background_color": backgroundColor,
      };
}
