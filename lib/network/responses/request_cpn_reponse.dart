class RequsetCPN {
  int? createdAt;
  int? modifiedAt;
  int? requestId;
  dynamic orderCodeOfProvider;
  String? orderCodeOfClient;
  String? note;
  int? clientId;
  int? countOfParcels;
  int? rlength;
  int? rwidth;
  int? rheight;
  int? rweight;
  int? rvolume;
  int? requestTotalPrice;
  List<String> urlPictures;
  RequestProviderInfo? requestProviderInfo;
  List<RequestPackageItem> requestPackageItems;

  RequsetCPN({
    this.createdAt,
    this.modifiedAt,
    this.requestId,
    this.orderCodeOfProvider,
    this.orderCodeOfClient,
    this.note,
    this.clientId,
    this.countOfParcels,
    this.rlength,
    this.rwidth,
    this.rheight,
    this.rweight,
    this.rvolume,
    this.requestTotalPrice,
    required this.urlPictures,
    this.requestProviderInfo,
    required this.requestPackageItems,
  });

  factory RequsetCPN.fromJson(Map<String, dynamic> json) => RequsetCPN(
        createdAt: json["created_at"],
        modifiedAt: json["modified_at"],
        requestId: json["request_id"],
        orderCodeOfProvider: json["order_code_of_provider"],
        orderCodeOfClient: json["order_code_of_client"],
        note: json["note"],
        clientId: json["client_id"],
        countOfParcels: json["count_of_parcels"],
        rlength: json["rlength"],
        rwidth: json["rwidth"],
        rheight: json["rheight"],
        rweight: json["rweight"],
        rvolume: json["rvolume"],
        requestTotalPrice: json["request_total_price"],
        urlPictures: List<String>.from(json["url_pictures"]!.map((x) => x)),
        requestProviderInfo: json["request_provider_info"] == null
            ? null
            : RequestProviderInfo.fromJson(json["request_provider_info"]),
        requestPackageItems: json["request_package_items"] == null
            ? []
            : List<RequestPackageItem>.from(json["request_package_items"]!
                .map((x) => RequestPackageItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "created_at": createdAt,
        "modified_at": modifiedAt,
        "request_id": requestId,
        "order_code_of_provider": orderCodeOfProvider,
        "order_code_of_client": orderCodeOfClient,
        "note": note,
        "client_id": clientId,
        "count_of_parcels": countOfParcels,
        "rlength": rlength,
        "rwidth": rwidth,
        "rheight": rheight,
        "rweight": rweight,
        "rvolume": rvolume,
        "request_total_price": requestTotalPrice,
        "url_pictures": List<dynamic>.from(urlPictures.map((x) => x)),
        "request_provider_info": requestProviderInfo?.toJson(),
        "request_package_items":
            List<dynamic>.from(requestPackageItems.map((x) => x.toJson())),
      };
}

class RequestPackageItem {
  int? createdAt;
  int? modifiedAt;
  int? memberCreated;
  int? memberUpdated;
  dynamic deletedAt;
  int? requestItemId;
  int? requestId;
  String? name;
  int? quantity;
  int? weight;
  int? price;
  int? amount;

  RequestPackageItem({
    this.createdAt,
    this.modifiedAt,
    this.memberCreated,
    this.memberUpdated,
    this.deletedAt,
    this.requestItemId,
    this.requestId,
    this.name,
    this.quantity,
    this.weight,
    this.price,
    this.amount,
  });

  factory RequestPackageItem.fromJson(Map<String, dynamic> json) =>
      RequestPackageItem(
        createdAt: json["created_at"],
        modifiedAt: json["modified_at"],
        memberCreated: json["member_created"],
        memberUpdated: json["member_updated"],
        deletedAt: json["deleted_at"],
        requestItemId: json["request_item_id"],
        requestId: json["request_id"],
        name: json["name"],
        quantity: json["quantity"],
        weight: json["weight"],
        price: json["price"],
        amount: json["amount"],
      );

  Map<String, dynamic> toJson() => {
        "created_at": createdAt,
        "modified_at": modifiedAt,
        "member_created": memberCreated,
        "member_updated": memberUpdated,
        "deleted_at": deletedAt,
        "request_item_id": requestItemId,
        "request_id": requestId,
        "name": name,
        "quantity": quantity,
        "weight": weight,
        "price": price,
        "amount": amount,
      };
}

class RequestProviderInfo {
  int? createdAt;
  int? modifiedAt;
  int? memberCreated;
  int? memberUpdated;
  dynamic deletedAt;
  int? requestProviderId;
  int? portalId;
  int? clientId;
  int? memberId;
  bool? isMain;
  int? status;
  int? requestProviderGroupId;
  int? originServiceProviderId;
  MemberInfo? memberInfo;

  RequestProviderInfo({
    this.createdAt,
    this.modifiedAt,
    this.memberCreated,
    this.memberUpdated,
    this.deletedAt,
    this.requestProviderId,
    this.portalId,
    this.clientId,
    this.memberId,
    this.isMain,
    this.status,
    this.requestProviderGroupId,
    this.originServiceProviderId,
    this.memberInfo,
  });

  factory RequestProviderInfo.fromJson(Map<String, dynamic> json) =>
      RequestProviderInfo(
        createdAt: json["created_at"],
        modifiedAt: json["modified_at"],
        memberCreated: json["member_created"],
        memberUpdated: json["member_updated"],
        deletedAt: json["deleted_at"],
        requestProviderId: json["request_provider_id"],
        portalId: json["portal_id"],
        clientId: json["client_id"],
        memberId: json["member_id"],
        isMain: json["is_main"],
        status: json["status"],
        requestProviderGroupId: json["request_provider_group_id"],
        originServiceProviderId: json["origin_service_provider_id"],
        memberInfo: json["member_info"] == null
            ? null
            : MemberInfo.fromJson(json["member_info"]),
      );

  Map<String, dynamic> toJson() => {
        "created_at": createdAt,
        "modified_at": modifiedAt,
        "member_created": memberCreated,
        "member_updated": memberUpdated,
        "deleted_at": deletedAt,
        "request_provider_id": requestProviderId,
        "portal_id": portalId,
        "client_id": clientId,
        "member_id": memberId,
        "is_main": isMain,
        "status": status,
        "request_provider_group_id": requestProviderGroupId,
        "origin_service_provider_id": originServiceProviderId,
        "member_info": memberInfo?.toJson(),
      };
}

class MemberInfo {
  int? createdAt;
  int? modifiedAt;
  int? memberCreated;
  int? memberUpdated;
  dynamic deletedAt;
  int? memberId;
  int? portalId;
  String? portalCode;
  int? clientId;
  String? phone;
  String? email;
  String? name;
  String? title;
  String? contactName;
  String? companyName;
  int? businessStatus;
  String? businessLicense;
  String? demand;
  String? address;
  int? wardId;
  String? countryPrefix;
  String? invoiceTaxCode;
  String? invoiceCompanyName;
  String? invoiceEmail;
  String? invoicePhone;
  int? invoiceWid;
  String? invoiceAddress;
  int? bankId;
  int? bankBranchId;
  String? bankAccountHolder;
  String? bankAccountNumber;
  String? bankAccount;
  int? status;
  String? groupId;
  int? serviceProviderId;
  int? requestProviderId;
  int? depotServiceProviderId;
  int? depotRequestProviderId;
  bool? isMain;
  bool? isAdmin;
  String? depots;
  String? deviceToken;
  String? myVehicle;
  String? drivingLicence;
  int? transportType;
  bool? transportTypeChange;
  int? subMemberType;
  String? departmentTitle;
  Images? images;
  String? uid;

  MemberInfo({
    this.createdAt,
    this.modifiedAt,
    this.memberCreated,
    this.memberUpdated,
    this.deletedAt,
    this.memberId,
    this.portalId,
    this.portalCode,
    this.clientId,
    this.phone,
    this.email,
    this.name,
    this.title,
    this.contactName,
    this.companyName,
    this.businessStatus,
    this.businessLicense,
    this.demand,
    this.address,
    this.wardId,
    this.countryPrefix,
    this.invoiceTaxCode,
    this.invoiceCompanyName,
    this.invoiceEmail,
    this.invoicePhone,
    this.invoiceWid,
    this.invoiceAddress,
    this.bankId,
    this.bankBranchId,
    this.bankAccountHolder,
    this.bankAccountNumber,
    this.bankAccount,
    this.status,
    this.groupId,
    this.serviceProviderId,
    this.requestProviderId,
    this.depotServiceProviderId,
    this.depotRequestProviderId,
    this.isMain,
    this.isAdmin,
    this.depots,
    this.deviceToken,
    this.myVehicle,
    this.drivingLicence,
    this.transportType,
    this.transportTypeChange,
    this.subMemberType,
    this.departmentTitle,
    this.images,
    this.uid,
  });

  factory MemberInfo.fromJson(Map<String, dynamic> json) => MemberInfo(
        createdAt: json["created_at"],
        modifiedAt: json["modified_at"],
        memberCreated: json["member_created"],
        memberUpdated: json["member_updated"],
        deletedAt: json["deleted_at"],
        memberId: json["member_id"],
        portalId: json["portal_id"],
        portalCode: json["portal_code"],
        clientId: json["client_id"],
        phone: json["phone"],
        email: json["email"],
        name: json["name"],
        title: json["title"],
        contactName: json["contact_name"],
        companyName: json["company_name"],
        businessStatus: json["business_status"],
        businessLicense: json["business_license"],
        demand: json["demand"],
        address: json["address"],
        wardId: json["ward_id"],
        countryPrefix: json["country_prefix"],
        invoiceTaxCode: json["invoice_tax_code"],
        invoiceCompanyName: json["invoice_company_name"],
        invoiceEmail: json["invoice_email"],
        invoicePhone: json["invoice_phone"],
        invoiceWid: json["invoice_wid"],
        invoiceAddress: json["invoice_address"],
        bankId: json["bank_id"],
        bankBranchId: json["bank_branch_id"],
        bankAccountHolder: json["bank_account_holder"],
        bankAccountNumber: json["bank_account_number"],
        bankAccount: json["bank_account"],
        status: json["status"],
        groupId: json["group_id"],
        serviceProviderId: json["service_provider_id"],
        requestProviderId: json["request_provider_id"],
        depotServiceProviderId: json["depot_service_provider_id"],
        depotRequestProviderId: json["depot_request_provider_id"],
        isMain: json["is_main"],
        isAdmin: json["is_admin"],
        depots: json["depots"],
        deviceToken: json["device_token"],
        myVehicle: json["my_vehicle"],
        drivingLicence: json["driving_licence"],
        transportType: json["transport_type"],
        transportTypeChange: json["transport_type_change"],
        subMemberType: json["sub_member_type"],
        departmentTitle: json["department_title"],
        images: json["images"] == null ? null : Images.fromJson(json["images"]),
        uid: json["uid"],
      );

  Map<String, dynamic> toJson() => {
        "created_at": createdAt,
        "modified_at": modifiedAt,
        "member_created": memberCreated,
        "member_updated": memberUpdated,
        "deleted_at": deletedAt,
        "member_id": memberId,
        "portal_id": portalId,
        "portal_code": portalCode,
        "client_id": clientId,
        "phone": phone,
        "email": email,
        "name": name,
        "title": title,
        "contact_name": contactName,
        "company_name": companyName,
        "business_status": businessStatus,
        "business_license": businessLicense,
        "demand": demand,
        "address": address,
        "ward_id": wardId,
        "country_prefix": countryPrefix,
        "invoice_tax_code": invoiceTaxCode,
        "invoice_company_name": invoiceCompanyName,
        "invoice_email": invoiceEmail,
        "invoice_phone": invoicePhone,
        "invoice_wid": invoiceWid,
        "invoice_address": invoiceAddress,
        "bank_id": bankId,
        "bank_branch_id": bankBranchId,
        "bank_account_holder": bankAccountHolder,
        "bank_account_number": bankAccountNumber,
        "bank_account": bankAccount,
        "status": status,
        "group_id": groupId,
        "service_provider_id": serviceProviderId,
        "request_provider_id": requestProviderId,
        "depot_service_provider_id": depotServiceProviderId,
        "depot_request_provider_id": depotRequestProviderId,
        "is_main": isMain,
        "is_admin": isAdmin,
        "depots": depots,
        "device_token": deviceToken,
        "my_vehicle": myVehicle,
        "driving_licence": drivingLicence,
        "transport_type": transportType,
        "transport_type_change": transportTypeChange,
        "sub_member_type": subMemberType,
        "department_title": departmentTitle,
        "images": images?.toJson(),
        "uid": uid,
      };
}

class Images {
  Images();

  factory Images.fromJson(Map<String, dynamic> json) => Images();

  Map<String, dynamic> toJson() => {};
}
