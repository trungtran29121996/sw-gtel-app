class DataCnpRouteReponse {
  int? createdAt;
  int? modifiedAt;
  int? memberCreated;
  int? memberUpdated;
  dynamic deletedAt;
  int? clientId;
  int? portalId;
  int? routeId;
  String? historyId;
  String? orderCodeOfClient;
  int? routeCoreId;
  int? requestType;
  int? serviceProviderId;
  int? offerId;
  int? driverId;
  double? weight;
  int? countofpackage;
  int? countofroute;
  int? distanceReal;
  int? distanceRouting;
  int? distance;
  int? distanceRequests;
  int? duration;
  int? servicelevel;
  String? fromAddress;
  double? fromLat;
  double? fromLon;
  int? fromFleetAddressId;
  String? fileName;
  String? toAddress;
  double? toLat;
  double? toLon;
  int? toFleetAddressId;
  int? startTime;
  int? endTime;
  int? realStartTime;
  int? realEndTime;
  int? sourceType;
  int? kindOfPlan;
  String? addServices;
  String? countryPrefix;
  int? vehicleId;
  int? status;
  String? note;
  List<SequenceList>? sequenceList;
  DriverInfo? driverInfo;
  dynamic vehicleInfo;
  dynamic statusInfo;
  List<CountEachHandlingUnit>? countEachHandlingUnit;
  List<String>? routeAddressList;

  DataCnpRouteReponse({
    this.createdAt,
    this.modifiedAt,
    this.memberCreated,
    this.memberUpdated,
    this.deletedAt,
    this.clientId,
    this.portalId,
    this.routeId,
    this.historyId,
    this.orderCodeOfClient,
    this.routeCoreId,
    this.requestType,
    this.serviceProviderId,
    this.offerId,
    this.driverId,
    this.weight,
    this.countofpackage,
    this.countofroute,
    this.distanceReal,
    this.distanceRouting,
    this.distance,
    this.distanceRequests,
    this.duration,
    this.servicelevel,
    this.fromAddress,
    this.fromLat,
    this.fromLon,
    this.fromFleetAddressId,
    this.fileName,
    this.toAddress,
    this.toLat,
    this.toLon,
    this.toFleetAddressId,
    this.startTime,
    this.endTime,
    this.realStartTime,
    this.realEndTime,
    this.sourceType,
    this.kindOfPlan,
    this.addServices,
    this.countryPrefix,
    this.vehicleId,
    this.status,
    this.note,
    this.sequenceList,
    this.driverInfo,
    this.vehicleInfo,
    this.statusInfo,
    this.countEachHandlingUnit,
    this.routeAddressList,
  });

  factory DataCnpRouteReponse.fromJson(Map<String, dynamic> json) =>
      DataCnpRouteReponse(
        createdAt: json["created_at"],
        modifiedAt: json["modified_at"],
        memberCreated: json["member_created"],
        memberUpdated: json["member_updated"],
        deletedAt: json["deleted_at"],
        clientId: json["client_id"],
        portalId: json["portal_id"],
        routeId: json["route_id"],
        historyId: json["history_id"],
        orderCodeOfClient: json["order_code_of_client"],
        routeCoreId: json["route_core_id"],
        requestType: json["request_type"],
        serviceProviderId: json["service_provider_id"],
        offerId: json["offer_id"],
        driverId: json["driver_id"],
        weight: json["weight"]?.toDouble(),
        countofpackage: json["countofpackage"],
        countofroute: json["countofroute"],
        distanceReal: json["distance_real"],
        distanceRouting: json["distance_routing"],
        distance: json["distance"],
        distanceRequests: json["distance_requests"],
        duration: json["duration"],
        servicelevel: json["servicelevel"],
        fromAddress: json["from_address"],
        fromLat: json["from_lat"]?.toDouble(),
        fromLon: json["from_lon"]?.toDouble(),
        fromFleetAddressId: json["from_fleet_address_id"],
        fileName: json["file_name"],
        toAddress: json["to_address"],
        toLat: json["to_lat"]?.toDouble(),
        toLon: json["to_lon"]?.toDouble(),
        toFleetAddressId: json["to_fleet_address_id"],
        startTime: json["start_time"],
        endTime: json["end_time"],
        realStartTime: json["real_start_time"],
        realEndTime: json["real_end_time"],
        sourceType: json["source_type"],
        kindOfPlan: json["kind_of_plan"],
        addServices: json["add_services"],
        countryPrefix: json["country_prefix"],
        vehicleId: json["vehicle_id"],
        status: json["status"],
        note: json["note"],
        sequenceList: json["sequence_list"] == null
            ? []
            : List<SequenceList>.from(
                json["sequence_list"]!.map((x) => SequenceList.fromJson(x))),
        driverInfo: json["driver_info"] == null
            ? null
            : DriverInfo.fromJson(json["driver_info"]),
        vehicleInfo: json["vehicle_info"],
        statusInfo: json["status_info"],
        countEachHandlingUnit: json["count_each_handling_unit"] == null
            ? []
            : List<CountEachHandlingUnit>.from(json["count_each_handling_unit"]!
                .map((x) => CountEachHandlingUnit.fromJson(x))),
        routeAddressList: json["route_address_list"] == null
            ? []
            : List<String>.from(json["route_address_list"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "created_at": createdAt,
        "modified_at": modifiedAt,
        "member_created": memberCreated,
        "member_updated": memberUpdated,
        "deleted_at": deletedAt,
        "client_id": clientId,
        "portal_id": portalId,
        "route_id": routeId,
        "history_id": historyId,
        "order_code_of_client": orderCodeOfClient,
        "route_core_id": routeCoreId,
        "request_type": requestType,
        "service_provider_id": serviceProviderId,
        "offer_id": offerId,
        "driver_id": driverId,
        "weight": weight,
        "countofpackage": countofpackage,
        "countofroute": countofroute,
        "distance_real": distanceReal,
        "distance_routing": distanceRouting,
        "distance": distance,
        "distance_requests": distanceRequests,
        "duration": duration,
        "servicelevel": servicelevel,
        "from_address": fromAddress,
        "from_lat": fromLat,
        "from_lon": fromLon,
        "from_fleet_address_id": fromFleetAddressId,
        "file_name": fileName,
        "to_address": toAddress,
        "to_lat": toLat,
        "to_lon": toLon,
        "to_fleet_address_id": toFleetAddressId,
        "start_time": startTime,
        "end_time": endTime,
        "real_start_time": realStartTime,
        "real_end_time": realEndTime,
        "source_type": sourceType,
        "kind_of_plan": kindOfPlan,
        "add_services": addServices,
        "country_prefix": countryPrefix,
        "vehicle_id": vehicleId,
        "status": status,
        "note": note,
        "sequence_list": sequenceList == null
            ? []
            : List<dynamic>.from(sequenceList!.map((x) => x.toJson())),
        "driver_info": driverInfo?.toJson(),
        "vehicle_info": vehicleInfo,
        "status_info": statusInfo,
        "count_each_handling_unit": countEachHandlingUnit == null
            ? []
            : List<dynamic>.from(countEachHandlingUnit!.map((x) => x.toJson())),
        "route_address_list": routeAddressList == null
            ? []
            : List<dynamic>.from(routeAddressList!.map((x) => x)),
      };
}

class CountEachHandlingUnit {
  int? handlingUnitId;
  int? count;

  CountEachHandlingUnit({
    this.handlingUnitId,
    this.count,
  });

  factory CountEachHandlingUnit.fromJson(Map<String, dynamic> json) =>
      CountEachHandlingUnit(
        handlingUnitId: json["handling_unit_id"],
        count: json["count"],
      );

  Map<String, dynamic> toJson() => {
        "handling_unit_id": handlingUnitId,
        "count": count,
      };
}

class DriverInfo {
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
  List<dynamic>? listWid;
  List<dynamic>? listDid;
  MemberInfo? memberInfo;

  DriverInfo({
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
  });

  factory DriverInfo.fromJson(Map<String, dynamic> json) => DriverInfo(
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
            : List<dynamic>.from(json["list_wid"]!.map((x) => x)),
        listDid: json["list_did"] == null
            ? []
            : List<dynamic>.from(json["list_did"]!.map((x) => x)),
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
        "uid": uid,
      };
}

class SequenceList {
  int? createdAt;
  int? modifiedAt;
  int? memberCreated;
  int? memberUpdated;
  dynamic deletedAt;
  int? seqId;
  int? requestId;
  int? routeCoreId;
  int? stoppointType;
  double? latofstoppoint;
  double? lonofstoppoint;
  int? seqIndex;
  int? routeId;
  int? distancetonext;
  int? shouldArival;
  int? shouldArivalTime;
  int? countOfParcels;
  int? kindOfPlan;
  String? changedpickupDatetime;
  String? orderCodeOfProvider;
  String? transportId;
  int? status;

  SequenceList({
    this.createdAt,
    this.modifiedAt,
    this.memberCreated,
    this.memberUpdated,
    this.deletedAt,
    this.seqId,
    this.requestId,
    this.routeCoreId,
    this.stoppointType,
    this.latofstoppoint,
    this.lonofstoppoint,
    this.seqIndex,
    this.routeId,
    this.distancetonext,
    this.shouldArival,
    this.shouldArivalTime,
    this.countOfParcels,
    this.kindOfPlan,
    this.changedpickupDatetime,
    this.orderCodeOfProvider,
    this.transportId,
    this.status,
  });

  factory SequenceList.fromJson(Map<String, dynamic> json) => SequenceList(
        createdAt: json["created_at"],
        modifiedAt: json["modified_at"],
        memberCreated: json["member_created"],
        memberUpdated: json["member_updated"],
        deletedAt: json["deleted_at"],
        seqId: json["seq_id"],
        requestId: json["request_id"],
        routeCoreId: json["route_core_id"],
        stoppointType: json["stoppoint_type"],
        latofstoppoint: json["latofstoppoint"]?.toDouble(),
        lonofstoppoint: json["lonofstoppoint"]?.toDouble(),
        seqIndex: json["seq_index"],
        routeId: json["route_id"],
        distancetonext: json["distancetonext"],
        shouldArival: json["should_arival"],
        shouldArivalTime: json["should_arival_time"],
        countOfParcels: json["count_of_parcels"],
        kindOfPlan: json["kind_of_plan"],
        changedpickupDatetime: json["changedpickup_datetime"],
        orderCodeOfProvider: json["order_code_of_provider"],
        transportId: json["transport_id"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "created_at": createdAt,
        "modified_at": modifiedAt,
        "member_created": memberCreated,
        "member_updated": memberUpdated,
        "deleted_at": deletedAt,
        "seq_id": seqId,
        "request_id": requestId,
        "route_core_id": routeCoreId,
        "stoppoint_type": stoppointType,
        "latofstoppoint": latofstoppoint,
        "lonofstoppoint": lonofstoppoint,
        "seq_index": seqIndex,
        "route_id": routeId,
        "distancetonext": distancetonext,
        "should_arival": shouldArival,
        "should_arival_time": shouldArivalTime,
        "count_of_parcels": countOfParcels,
        "kind_of_plan": kindOfPlan,
        "changedpickup_datetime": changedpickupDatetime,
        "order_code_of_provider": orderCodeOfProvider,
        "transport_id": transportId,
        "status": status,
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
