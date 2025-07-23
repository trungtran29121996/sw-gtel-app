// To parse this JSON data, do
//
//     final subAccountReponse = subAccountReponseFromJson(jsonString);

import 'dart:convert';

SubAccountReponse subAccountReponseFromJson(String str) =>
    SubAccountReponse.fromJson(json.decode(str));

String subAccountReponseToJson(SubAccountReponse data) =>
    json.encode(data.toJson());

class SubAccountReponse {
  bool? success;
  String? message;
  int? errorCode;
  List<Datum>? data;
  Meta? meta;

  SubAccountReponse({
    this.success,
    this.message,
    this.errorCode,
    this.data,
    this.meta,
  });

  factory SubAccountReponse.fromJson(Map<String, dynamic> json) =>
      SubAccountReponse(
        success: json["success"],
        message: json["message"],
        errorCode: json["error_code"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "error_code": errorCode,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "meta": meta?.toJson(),
      };
}

class Datum {
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
  String? uid;

  Datum({
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
    this.uid,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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
        "uid": uid,
      };
}

class Meta {
  int? totalItems;
  int? itemCount;
  int? itemsPerPage;
  int? totalPages;
  int? currentPage;

  Meta({
    this.totalItems,
    this.itemCount,
    this.itemsPerPage,
    this.totalPages,
    this.currentPage,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        totalItems: json["total_items"],
        itemCount: json["item_count"],
        itemsPerPage: json["items_per_page"],
        totalPages: json["total_pages"],
        currentPage: json["current_page"],
      );

  Map<String, dynamic> toJson() => {
        "total_items": totalItems,
        "item_count": itemCount,
        "items_per_page": itemsPerPage,
        "total_pages": totalPages,
        "current_page": currentPage,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
