import 'dart:convert';

class DriverReponse {
  int? createdAt;
  int? modifiedAt;
  int? memberCreated;
  int? memberUpdated;
  dynamic deletedAt;
  int? driverId;
  int? clientId;
  int? serviceProviderId;
  int? memberId;
  bool? isMain;
  List<dynamic>? drivingLicense;
  int? status;
  String? deviceId;
  List<int>? listWid;
  List<int>? listDid;
  MemberInfo? memberInfo;
  DriverReponse? serviceProviderInfo;
  int? portalId;
  bool? sharePortal;
  String? spType;
  dynamic parentId;

  DriverReponse({
    this.createdAt,
    this.modifiedAt,
    this.memberCreated,
    this.memberUpdated,
    this.deletedAt,
    this.driverId,
    this.clientId,
    this.serviceProviderId,
    this.memberId,
    this.isMain,
    this.drivingLicense,
    this.status,
    this.deviceId,
    this.listWid,
    this.listDid,
    this.memberInfo,
    this.serviceProviderInfo,
    this.portalId,
    this.sharePortal,
    this.spType,
    this.parentId,
  });

  factory DriverReponse.fromRawJson(String str) =>
      DriverReponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DriverReponse.fromJson(Map<String, dynamic> json) => DriverReponse(
        createdAt: json["created_at"],
        modifiedAt: json["modified_at"],
        memberCreated: json["member_created"],
        memberUpdated: json["member_updated"],
        deletedAt: json["deleted_at"],
        driverId: json["driver_id"],
        clientId: json["client_id"],
        serviceProviderId: json["service_provider_id"],
        memberId: json["member_id"],
        isMain: json["is_main"],
        drivingLicense: json["driving_license"] == null
            ? []
            : List<dynamic>.from(json["driving_license"]!.map((x) => x)),
        status: json["status"],
        deviceId: json["device_id"],
        listWid: json["list_wid"] == null
            ? []
            : List<int>.from(json["list_wid"]!.map((x) => x)),
        listDid: json["list_did"] == null
            ? []
            : List<int>.from(json["list_did"]!.map((x) => x)),
        memberInfo: json["member_info"] == null
            ? null
            : MemberInfo.fromJson(json["member_info"]),
        serviceProviderInfo: json["service_provider_info"] == null
            ? null
            : DriverReponse.fromJson(json["service_provider_info"]),
        portalId: json["portal_id"],
        sharePortal: json["share_portal"],
        spType: json["sp_type"],
        parentId: json["parent_id"],
      );

  Map<String, dynamic> toJson() => {
        "created_at": createdAt,
        "modified_at": modifiedAt,
        "member_created": memberCreated,
        "member_updated": memberUpdated,
        "deleted_at": deletedAt,
        "driver_id": driverId,
        "client_id": clientId,
        "service_provider_id": serviceProviderId,
        "member_id": memberId,
        "is_main": isMain,
        "driving_license": drivingLicense == null
            ? []
            : List<dynamic>.from(drivingLicense!.map((x) => x)),
        "status": status,
        "device_id": deviceId,
        "list_wid":
            listWid == null ? [] : List<dynamic>.from(listWid!.map((x) => x)),
        "list_did":
            listDid == null ? [] : List<dynamic>.from(listDid!.map((x) => x)),
        "member_info": memberInfo?.toJson(),
        "service_provider_info": serviceProviderInfo?.toJson(),
        "portal_id": portalId,
        "share_portal": sharePortal,
        "sp_type": spType,
        "parent_id": parentId,
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
  String? taxId;
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
    this.taxId,
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

  factory MemberInfo.fromRawJson(String str) =>
      MemberInfo.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

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
        taxId: json["tax_id"],
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
        "tax_id": taxId,
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

  factory Images.fromRawJson(String str) => Images.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Images.fromJson(Map<String, dynamic> json) => Images();

  Map<String, dynamic> toJson() => {};
}
