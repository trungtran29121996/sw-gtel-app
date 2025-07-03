class ChangePassWordReponse {
  bool? success;
  String? message;
  int? errorCode;
  Data? data;

  ChangePassWordReponse({
    this.success,
    this.message,
    this.errorCode,
    this.data,
  });

  factory ChangePassWordReponse.fromJson(Map<String, dynamic> json) =>
      ChangePassWordReponse(
        success: json["success"],
        message: json["message"],
        errorCode: json["error_code"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "error_code": errorCode,
        "data": data!.toJson(),
      };
}

class Data {
  String portalId;
  String clientId;
  int status;
  String memberId;
  MemberInfo memberInfo;
  String groupId;
  String uid;
  String role;
  String token;
  String refreshToken;

  Data({
    required this.portalId,
    required this.clientId,
    required this.status,
    required this.memberId,
    required this.memberInfo,
    required this.groupId,
    required this.uid,
    required this.role,
    required this.token,
    required this.refreshToken,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        portalId: json["portal_id"],
        clientId: json["client_id"],
        status: json["status"],
        memberId: json["member_id"],
        memberInfo: MemberInfo.fromJson(json["member_info"]),
        groupId: json["group_id"],
        uid: json["uid"],
        role: json["role"],
        token: json["token"],
        refreshToken: json["refresh_token"],
      );

  Map<String, dynamic> toJson() => {
        "portal_id": portalId,
        "client_id": clientId,
        "status": status,
        "member_id": memberId,
        "member_info": memberInfo.toJson(),
        "group_id": groupId,
        "uid": uid,
        "role": role,
        "token": token,
        "refresh_token": refreshToken,
      };
}

class MemberInfo {
  String createdAt;
  String modifiedAt;
  String memberCreated;
  String memberUpdated;
  bool isDeleted;
  dynamic deletedAt;
  String memberId;
  String portalId;
  String portalCode;
  String clientId;
  String phone;
  String email;
  String name;
  String title;
  String contactName;
  String companyName;
  int businessStatus;
  String businessLicense;
  String demand;
  String address;
  String wardId;
  String countryPrefix;
  String invoiceTaxCode;
  String invoiceCompanyName;
  String invoiceEmail;
  String invoicePhone;
  int invoiceWid;
  String invoiceAddress;
  String bankId;
  String bankBranchId;
  String bankAccountHolder;
  String bankAccountNumber;
  String bankAccount;
  int status;
  String groupId;
  String serviceProviderId;
  String requestProviderId;
  String depotServiceProviderId;
  String depotRequestProviderId;
  bool isMain;
  bool isAdmin;
  String depots;
  String deviceToken;
  String myVehicle;
  String drivingLicence;
  int transportType;
  bool transportTypeChange;
  int subMemberType;
  String departmentTitle;
  Images images;
  String uid;

  MemberInfo({
    required this.createdAt,
    required this.modifiedAt,
    required this.memberCreated,
    required this.memberUpdated,
    required this.isDeleted,
    required this.deletedAt,
    required this.memberId,
    required this.portalId,
    required this.portalCode,
    required this.clientId,
    required this.phone,
    required this.email,
    required this.name,
    required this.title,
    required this.contactName,
    required this.companyName,
    required this.businessStatus,
    required this.businessLicense,
    required this.demand,
    required this.address,
    required this.wardId,
    required this.countryPrefix,
    required this.invoiceTaxCode,
    required this.invoiceCompanyName,
    required this.invoiceEmail,
    required this.invoicePhone,
    required this.invoiceWid,
    required this.invoiceAddress,
    required this.bankId,
    required this.bankBranchId,
    required this.bankAccountHolder,
    required this.bankAccountNumber,
    required this.bankAccount,
    required this.status,
    required this.groupId,
    required this.serviceProviderId,
    required this.requestProviderId,
    required this.depotServiceProviderId,
    required this.depotRequestProviderId,
    required this.isMain,
    required this.isAdmin,
    required this.depots,
    required this.deviceToken,
    required this.myVehicle,
    required this.drivingLicence,
    required this.transportType,
    required this.transportTypeChange,
    required this.subMemberType,
    required this.departmentTitle,
    required this.images,
    required this.uid,
  });

  factory MemberInfo.fromJson(Map<String, dynamic> json) => MemberInfo(
        createdAt: json["created_at"],
        modifiedAt: json["modified_at"],
        memberCreated: json["member_created"],
        memberUpdated: json["member_updated"],
        isDeleted: json["is_deleted"],
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
        images: Images.fromJson(json["images"]),
        uid: json["uid"],
      );

  Map<String, dynamic> toJson() => {
        "created_at": createdAt,
        "modified_at": modifiedAt,
        "member_created": memberCreated,
        "member_updated": memberUpdated,
        "is_deleted": isDeleted,
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
        "images": images.toJson(),
        "uid": uid,
      };
}

class Images {
  Images();

  factory Images.fromJson(Map<String, dynamic> json) => Images();

  Map<String, dynamic> toJson() => {};
}
