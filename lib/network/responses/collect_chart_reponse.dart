class CollectedChartReponse {
  bool? success;
  String? message;
  int? errorCode;
  DataNum data;

  CollectedChartReponse({
    this.success,
    this.message,
    this.errorCode,
    required this.data,
  });

  factory CollectedChartReponse.fromJson(Map<String, dynamic> json) =>
      CollectedChartReponse(
        success: json["success"],
        message: json["message"],
        errorCode: json["error_code"],
        data: DataNum.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "error_code": errorCode,
        "data": data.toJson(),
      };
}

class DataNum {
  List<CollectedAmount> collectedAmount;
  int maxCash;
  int maxCod;
  List<ColorElement> color;

  DataNum({
    required this.collectedAmount,
    required this.maxCash,
    required this.maxCod,
    required this.color,
  });

  factory DataNum.fromJson(Map<String, dynamic> json) => DataNum(
        collectedAmount: List<CollectedAmount>.from(
            json["collected_amount"].map((x) => CollectedAmount.fromJson(x))),
        maxCash: json["max_cash"],
        maxCod: json["max_cod"],
        color: List<ColorElement>.from(
            json["color"].map((x) => ColorElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "collected_amount":
            List<dynamic>.from(collectedAmount.map((x) => x.toJson())),
        "max_cash": maxCash,
        "max_cod": maxCod,
        "color": List<dynamic>.from(color.map((x) => x.toJson())),
      };
}

class CollectedAmount {
  int index;
  String label;
  TotalAmount totalAmount;

  CollectedAmount({
    required this.index,
    required this.label,
    required this.totalAmount,
  });

  factory CollectedAmount.fromJson(Map<String, dynamic> json) =>
      CollectedAmount(
        index: json["index"],
        label: json["label"],
        totalAmount: TotalAmount.fromJson(json["total_amount"]),
      );

  Map<String, dynamic> toJson() => {
        "index": index,
        "label": label,
        "total_amount": totalAmount.toJson(),
      };
}

class TotalAmount {
  ColorElement cash;
  ColorElement cod;

  TotalAmount({
    required this.cash,
    required this.cod,
  });

  factory TotalAmount.fromJson(Map<String, dynamic> json) => TotalAmount(
        cash: ColorElement.fromJson(json["cash"]),
        cod: ColorElement.fromJson(json["cod"]),
      );

  Map<String, dynamic> toJson() => {
        "cash": cash.toJson(),
        "cod": cod.toJson(),
      };
}

class ColorElement {
  Label label;
  ColorEnum color;
  double amount;

  ColorElement({
    required this.label,
    required this.color,
    required this.amount,
  });

  factory ColorElement.fromJson(Map<String, dynamic> json) => ColorElement(
        label: labelValues.map[json["label"]]!,
        color: colorEnumValues.map[json["color"]]!,
        amount: json["amount"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "label": labelValues.reverse[label],
        "color": colorEnumValues.reverse[color],
        "amount": amount,
      };
}

enum ColorEnum { F97251, THE_00_B5_E2 }

final colorEnumValues = EnumValues(
    {"#F97251": ColorEnum.F97251, "#00B5E2": ColorEnum.THE_00_B5_E2});

enum Label { THU_H_COD, TIN_MT }

final labelValues =
    EnumValues({"Thu hộ (COD)": Label.THU_H_COD, "Tiền mặt": Label.TIN_MT});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
