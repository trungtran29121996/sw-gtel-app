class ScanListBarcodeReponse {
  bool? success;
  String? message;
  int? errorCode;
  List<int>? data;

  ScanListBarcodeReponse({
    this.success,
    this.message,
    this.errorCode,
    this.data,
  });

  ScanListBarcodeReponse copyWith({
    bool? success,
    String? message,
    int? errorCode,
    List<int>? data,
  }) =>
      ScanListBarcodeReponse(
        success: success ?? this.success,
        message: message ?? this.message,
        errorCode: errorCode ?? this.errorCode,
        data: data ?? this.data,
      );

  factory ScanListBarcodeReponse.fromJson(Map<String, dynamic> json) =>
      ScanListBarcodeReponse(
        success: json["success"],
        message: json["message"],
        errorCode: json["error_code"],
        data: json["data"] == null
            ? []
            : List<int>.from(json["data"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "error_code": errorCode,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x)),
      };
}
