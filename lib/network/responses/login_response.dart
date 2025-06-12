import 'dart:convert';

class LoginReponse {
  String portalId;
  String clientId;
  int status;
  String memberId;
  MemberInfo memberInfo;
  String uid;
  String role;
  String token;
  String refreshToken;

  LoginReponse({
    required this.portalId,
    required this.clientId,
    required this.status,
    required this.memberId,
    required this.memberInfo,
    required this.uid,
    required this.role,
    required this.token,
    required this.refreshToken,
  });

  factory LoginReponse.fromJson(Map<String, dynamic> json) => LoginReponse(
        portalId: json["portal_id"],
        clientId: json["client_id"],
        status: json["status"],
        memberId: json["member_id"],
        memberInfo: MemberInfo.fromJson(json["member_info"]),
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
        "uid": uid,
        "role": role,
        "token": token,
        "refresh_token": refreshToken,
      };
}

class MemberInfo {
  String? createdAt;
  String? modifiedAt;
  String? memberCreated;
  String? memberUpdated;
  bool? isDeleted;
  dynamic deletedAt;
  String? memberId;
  String? portalId;
  String? portalCode;
  String? clientId;
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
  String? wardId;
  String? countryPrefix;
  String? taxId;
  String? bankAccount;
  int? status;
  String? groupId;
  String? serviceProviderId;
  String? requestProviderId;
  String? depotServiceProviderId;
  String? depotRequestProviderId;
  bool? isMain;
  bool? isAdmin;
  String? depots;
  String? deviceToken;
  String? myVehicle;
  String? drivingLicence;
  int? transportType;
  bool? transportTypeChange;
  Images? images;
  String? uid;

  MemberInfo({
    this.createdAt,
    this.modifiedAt,
    this.memberCreated,
    this.memberUpdated,
    this.isDeleted,
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
    this.images,
    this.uid,
  });

  factory MemberInfo.fromRawJson(String str) =>
      MemberInfo.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MemberInfo.fromJson(Map<dynamic, dynamic> json) => MemberInfo(
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
        images: json["images"] == null ? null : Images.fromJson(json["images"]),
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
