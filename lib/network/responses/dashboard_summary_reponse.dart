class DashboardSummaryReponse {
  bool? success;
  String? message;
  int? errorCode;
  Data? data;

  DashboardSummaryReponse({
    this.success,
    this.message,
    this.errorCode,
    this.data,
  });

  factory DashboardSummaryReponse.fromJson(Map<String, dynamic> json) =>
      DashboardSummaryReponse(
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
  int? shippingFee;
  int? totalCod;
  int? successCount;
  int? failedCount;
  int? onTimeRate;

  Data({
    this.shippingFee,
    this.totalCod,
    this.successCount,
    this.failedCount,
    this.onTimeRate,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        shippingFee: json["shipping_fee"] == null ? 0 : json["shipping_fee"],
        totalCod: json["total_cod"] == null ? 0 : json["total_cod"],
        successCount: json["success_count"] == null ? 0 : json["success_count"],
        failedCount: json["failed_count"] == null ? 0 : json["failed_count"],
        onTimeRate: json["on_time_rate"] == null ? 0 : json["on_time_rate"],
      );

  Map<String, dynamic> toJson() => {
        "shipping_fee": shippingFee,
        "total_cod": totalCod,
        "success_count": successCount,
        "failed_count": failedCount,
        "on_time_rate": onTimeRate,
      };
}
