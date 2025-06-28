class CreateCpnLotRequest {
  int rlength;
  int rwidth;
  int rheight;
  int rweight;
  String note;
  List<RequestPackageItem> requestPackageItems;
  List<String> urlPictures;

  CreateCpnLotRequest({
    required this.rlength,
    required this.rwidth,
    required this.rheight,
    required this.rweight,
    required this.note,
    required this.requestPackageItems,
    required this.urlPictures,
  });

  factory CreateCpnLotRequest.fromJson(Map<String, dynamic> json) =>
      CreateCpnLotRequest(
        rlength: json["rlength"],
        rwidth: json["rwidth"],
        rheight: json["rheight"],
        rweight: json["rweight"],
        note: json["note"],
        requestPackageItems: json["request_package_items"] == null
            ? []
            : List<RequestPackageItem>.from(json["request_package_items"]!
                .map((x) => RequestPackageItem.fromJson(x))),
        urlPictures: json["url_pictures"] == null
            ? []
            : List<String>.from(json["url_pictures"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "rlength": rlength,
        "rwidth": rwidth,
        "rheight": rheight,
        "rweight": rweight,
        "note": note,
        "request_package_items":
            List<dynamic>.from(requestPackageItems.map((x) => x.toJson())),
        "url_pictures": List<dynamic>.from(urlPictures.map((x) => x)),
      };
}

class RequestPackageItem {
  String? name;
  int? quantity;

  RequestPackageItem({
    this.name,
    this.quantity,
  });

  factory RequestPackageItem.fromJson(Map<String, dynamic> json) =>
      RequestPackageItem(
        name: json["name"],
        quantity: json["quantity"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "quantity": quantity,
      };
}
