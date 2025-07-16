class UpdateStatusSeqReponse {
  bool? success;
  String? message;
  int? errorCode;

  UpdateStatusSeqReponse({
    this.success,
    this.message,
    this.errorCode,
  });

  UpdateStatusSeqReponse copyWith({
    bool? success,
    String? message,
    int? errorCode,
  }) =>
      UpdateStatusSeqReponse(
        success: success ?? this.success,
        message: message ?? this.message,
        errorCode: errorCode ?? this.errorCode,
      );

  factory UpdateStatusSeqReponse.fromJson(Map<String, dynamic> json) =>
      UpdateStatusSeqReponse(
        success: json["success"],
        message: json["message"],
        errorCode: json["error_code"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "error_code": errorCode,
      };
}
