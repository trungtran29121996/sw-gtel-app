class RouteHandoverReponse {
  bool? success;
  String? message;
  int? errorCode;
  Data? data;

  RouteHandoverReponse({
    this.success,
    this.message,
    this.errorCode,
    this.data,
  });

  factory RouteHandoverReponse.fromJson(Map<String, dynamic> json) =>
      RouteHandoverReponse(
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
  int? sourceType;
  int? totalCod;
  int? shippingFee;
  int? countOfRoute;
  int? successfulRequests;
  int? failedRequests;
  List<PackageItemSummary>? packageItemSummary;

  Data({
    this.sourceType,
    this.totalCod,
    this.shippingFee,
    this.countOfRoute,
    this.successfulRequests,
    this.failedRequests,
    this.packageItemSummary,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        sourceType: json["source_type"],
        totalCod: json["total_cod"],
        shippingFee: json["shipping_fee"],
        countOfRoute: json["count_of_route"],
        successfulRequests: json["successful_requests"],
        failedRequests: json["failed_requests"],
        packageItemSummary: json["package_item_summary"] == null
            ? []
            : List<PackageItemSummary>.from(json["package_item_summary"]!
                .map((x) => PackageItemSummary.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "source_type": sourceType,
        "total_cod": totalCod,
        "shipping_fee": shippingFee,
        "count_of_route": countOfRoute,
        "successful_requests": successfulRequests,
        "failed_requests": failedRequests,
        "package_item_summary": packageItemSummary == null
            ? []
            : List<dynamic>.from(packageItemSummary!.map((x) => x.toJson())),
      };
}

class PackageItemSummary {
  String? name;
  int? quantity;

  PackageItemSummary({
    this.name,
    this.quantity,
  });

  factory PackageItemSummary.fromJson(Map<String, dynamic> json) =>
      PackageItemSummary(
        name: json["name"],
        quantity: json["quantity"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "quantity": quantity,
      };
}
