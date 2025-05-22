class RoutingCpnStartReponse {
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
  int? volume;
  int? countofpackage;
  int? countofroute;
  int? distanceReal;
  int? distanceRouting;
  int? distance;
  int? distanceRequests;
  int? duration;
  int? servicelevel;
  String? fromAddress;
  int? fromLat;
  int? fromLon;
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
  int? shippingFee;
  String? note;
  List<RouteRequestListStart>? routeRequestList;
  List<SequenceListStart>? sequenceList;
  dynamic fromFleetAddressInfo;
  ToFleetAddressInfo? toFleetAddressInfo;

  RoutingCpnStartReponse({
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
    this.volume,
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
    this.shippingFee,
    this.note,
    this.routeRequestList,
    this.sequenceList,
    this.fromFleetAddressInfo,
    this.toFleetAddressInfo,
  });

  factory RoutingCpnStartReponse.fromJson(Map<String, dynamic> json) =>
      RoutingCpnStartReponse(
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
        volume: json["volume"],
        countofpackage: json["countofpackage"],
        countofroute: json["countofroute"],
        distanceReal: json["distance_real"],
        distanceRouting: json["distance_routing"],
        distance: json["distance"],
        distanceRequests: json["distance_requests"],
        duration: json["duration"],
        servicelevel: json["servicelevel"],
        fromAddress: json["from_address"],
        fromLat: json["from_lat"],
        fromLon: json["from_lon"],
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
        shippingFee: json["shipping_fee"],
        note: json["note"],
        routeRequestList: json["route_request_list"] == null
            ? []
            : List<RouteRequestListStart>.from(json["route_request_list"]!
                .map((x) => RouteRequestListStart.fromJson(x))),
        sequenceList: json["sequence_list"] == null
            ? []
            : List<SequenceListStart>.from(json["sequence_list"]!
                .map((x) => SequenceListStart.fromJson(x))),
        fromFleetAddressInfo: json["from_fleet_address_info"],
        toFleetAddressInfo: json["to_fleet_address_info"] == null
            ? null
            : ToFleetAddressInfo.fromJson(json["to_fleet_address_info"]),
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
        "volume": volume,
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
        "shipping_fee": shippingFee,
        "note": note,
        "route_request_list": routeRequestList == null
            ? []
            : List<dynamic>.from(routeRequestList!.map((x) => x.toJson())),
        "sequence_list": sequenceList == null
            ? []
            : List<dynamic>.from(sequenceList!.map((x) => x.toJson())),
        "from_fleet_address_info": fromFleetAddressInfo,
        "to_fleet_address_info": toFleetAddressInfo?.toJson(),
      };
}

class RouteRequestListStart {
  String? id;
  int? routeId;
  int? requestId;
  int? status;
  int? seqIndex;
  RequestInfo? requestInfo;

  RouteRequestListStart({
    this.id,
    this.routeId,
    this.requestId,
    this.status,
    this.seqIndex,
    this.requestInfo,
  });

  factory RouteRequestListStart.fromJson(Map<String, dynamic> json) =>
      RouteRequestListStart(
        id: json["id"],
        routeId: json["route_id"],
        requestId: json["request_id"],
        status: json["status"],
        seqIndex: json["seq_index"],
        requestInfo: json["request_info"] == null
            ? null
            : RequestInfo.fromJson(json["request_info"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "route_id": routeId,
        "request_id": requestId,
        "status": status,
        "seq_index": seqIndex,
        "request_info": requestInfo?.toJson(),
      };
}

class RequestInfo {
  int? createdAt;
  int? modifiedAt;
  int? memberCreated;
  int? memberUpdated;
  dynamic deletedAt;
  int? requestId;
  String? orderCodeOfProvider;
  String? orderCodeOfClient;
  int? clientId;
  int? requestProviderId;
  int? originServiceProvider;
  int? originFleetAddressId;
  int? currentFleetAddressId;
  int? nextFleetAddressId;
  int? destFleetAddressId;
  int? distance;
  String? packageName;
  String? note;
  int? countOfParcels;
  int? rlength;
  int? rwidth;
  int? rheight;
  double? rweight;
  int? rvolume;
  int? handlingUnitId;
  int? cod;
  int? requestTotalPrice;
  int? serviceId;
  int? myServiceId;
  int? optPayer;
  int? kindOfRequest;
  int? kindOfTariff;
  int? baggageWeight;
  bool? isInsurance;
  int? shopId;
  int? shippingFee;
  int? vatFee;
  int? discount;
  int? status;
  int? payStatus;
  int? printStatus;
  int? printCount;
  int? stateVal;
  int? error;
  String? historyId;
  int? choicesp;
  List<dynamic>? discountCode;
  int? pickupTime;
  int? dropTime;
  int? pickupLat;
  int? pickupLon;
  String? pickupAddress;
  String? pickupW3Wcode;
  int? pickupWid;
  int? pickupDid;
  int? pickupPid;
  double? dropLat;
  double? dropLon;
  String? dropAddress;
  int? dropWid;
  int? dropDid;
  int? dropPid;
  String? dropW3Wcode;
  dynamic shipmentOrderId;
  String? receiverPhone;
  String? receiverName;
  String? senderPhone;
  String? senderName;
  List<dynamic>? listRequestId;
  String? requestType;
  dynamic assigneeId;
  int? assignedAt;
  int? updateExpiredAt;
  bool? isSenderDropoff;
  bool? isReceiverPickup;
  String? pickupTimePreferred;
  String? dropTimePreferred;
  int? pickupFailedCount;
  String? subReceiverInfo;
  String? subSenderInfo;
  int? dropFailedCount;
  List<RequestPackageItem>? requestPackageItems;
  List<ListSalePayment>? listSalePayment;
  BasePackagingInfo? basePackagingInfo;

  RequestInfo({
    this.createdAt,
    this.modifiedAt,
    this.memberCreated,
    this.memberUpdated,
    this.deletedAt,
    this.requestId,
    this.orderCodeOfProvider,
    this.orderCodeOfClient,
    this.clientId,
    this.requestProviderId,
    this.originServiceProvider,
    this.originFleetAddressId,
    this.currentFleetAddressId,
    this.nextFleetAddressId,
    this.destFleetAddressId,
    this.distance,
    this.packageName,
    this.note,
    this.countOfParcels,
    this.rlength,
    this.rwidth,
    this.rheight,
    this.rweight,
    this.rvolume,
    this.handlingUnitId,
    this.cod,
    this.requestTotalPrice,
    this.serviceId,
    this.myServiceId,
    this.optPayer,
    this.kindOfRequest,
    this.kindOfTariff,
    this.baggageWeight,
    this.isInsurance,
    this.shopId,
    this.shippingFee,
    this.vatFee,
    this.discount,
    this.status,
    this.payStatus,
    this.printStatus,
    this.printCount,
    this.stateVal,
    this.error,
    this.historyId,
    this.choicesp,
    this.discountCode,
    this.pickupTime,
    this.dropTime,
    this.pickupLat,
    this.pickupLon,
    this.pickupAddress,
    this.pickupW3Wcode,
    this.pickupWid,
    this.pickupDid,
    this.pickupPid,
    this.dropLat,
    this.dropLon,
    this.dropAddress,
    this.dropWid,
    this.dropDid,
    this.dropPid,
    this.dropW3Wcode,
    this.shipmentOrderId,
    this.receiverPhone,
    this.receiverName,
    this.senderPhone,
    this.senderName,
    this.listRequestId,
    this.requestType,
    this.assigneeId,
    this.assignedAt,
    this.updateExpiredAt,
    this.isSenderDropoff,
    this.isReceiverPickup,
    this.pickupTimePreferred,
    this.dropTimePreferred,
    this.pickupFailedCount,
    this.subReceiverInfo,
    this.subSenderInfo,
    this.dropFailedCount,
    this.requestPackageItems,
    this.listSalePayment,
    this.basePackagingInfo,
  });

  factory RequestInfo.fromJson(Map<String, dynamic> json) => RequestInfo(
        createdAt: json["created_at"],
        modifiedAt: json["modified_at"],
        memberCreated: json["member_created"],
        memberUpdated: json["member_updated"],
        deletedAt: json["deleted_at"],
        requestId: json["request_id"],
        orderCodeOfProvider: json["order_code_of_provider"],
        orderCodeOfClient: json["order_code_of_client"],
        clientId: json["client_id"],
        requestProviderId: json["request_provider_id"],
        originServiceProvider: json["origin_service_provider"],
        originFleetAddressId: json["origin_fleet_address_id"],
        currentFleetAddressId: json["current_fleet_address_id"],
        nextFleetAddressId: json["next_fleet_address_id"],
        destFleetAddressId: json["dest_fleet_address_id"],
        distance: json["distance"],
        packageName: json["package_name"],
        note: json["note"],
        countOfParcels: json["count_of_parcels"],
        rlength: json["rlength"],
        rwidth: json["rwidth"],
        rheight: json["rheight"],
        rweight: json["rweight"]?.toDouble(),
        rvolume: json["rvolume"],
        handlingUnitId: json["handling_unit_id"],
        cod: json["cod"],
        requestTotalPrice: json["request_total_price"],
        serviceId: json["service_id"],
        myServiceId: json["my_service_id"],
        optPayer: json["opt_payer"],
        kindOfRequest: json["kind_of_request"],
        kindOfTariff: json["kind_of_tariff"],
        baggageWeight: json["baggage_weight"],
        isInsurance: json["is_insurance"],
        shopId: json["shop_id"],
        shippingFee: json["shipping_fee"],
        vatFee: json["vat_fee"],
        discount: json["discount"],
        status: json["status"],
        payStatus: json["pay_status"],
        printStatus: json["print_status"],
        printCount: json["print_count"],
        stateVal: json["state_val"],
        error: json["error"],
        historyId: json["history_id"],
        choicesp: json["choicesp"],
        discountCode: json["discount_code"] == null
            ? []
            : List<dynamic>.from(json["discount_code"]!.map((x) => x)),
        pickupTime: json["pickup_time"],
        dropTime: json["drop_time"],
        pickupLat: json["pickup_lat"],
        pickupLon: json["pickup_lon"],
        pickupAddress: json["pickup_address"],
        pickupW3Wcode: json["pickup_w3wcode"],
        pickupWid: json["pickup_wid"],
        pickupDid: json["pickup_did"],
        pickupPid: json["pickup_pid"],
        dropLat: json["drop_lat"]?.toDouble(),
        dropLon: json["drop_lon"]?.toDouble(),
        dropAddress: json["drop_address"],
        dropWid: json["drop_wid"],
        dropDid: json["drop_did"],
        dropPid: json["drop_pid"],
        dropW3Wcode: json["drop_w3wcode"],
        shipmentOrderId: json["shipment_order_id"],
        receiverPhone: json["receiver_phone"],
        receiverName: json["receiver_name"],
        senderPhone: json["sender_phone"],
        senderName: json["sender_name"],
        listRequestId: json["list_request_id"] == null
            ? []
            : List<dynamic>.from(json["list_request_id"]!.map((x) => x)),
        requestType: json["request_type"],
        assigneeId: json["assignee_id"],
        assignedAt: json["assigned_at"],
        updateExpiredAt: json["update_expired_at"],
        isSenderDropoff: json["is_sender_dropoff"],
        isReceiverPickup: json["is_receiver_pickup"],
        pickupTimePreferred: json["pickup_time_preferred"],
        dropTimePreferred: json["drop_time_preferred"],
        pickupFailedCount: json["pickup_failed_count"],
        subReceiverInfo: json["sub_receiver_info"],
        subSenderInfo: json["sub_sender_info"],
        dropFailedCount: json["drop_failed_count"],
        requestPackageItems: json["request_package_items"] == null
            ? []
            : List<RequestPackageItem>.from(json["request_package_items"]!
                .map((x) => RequestPackageItem.fromJson(x))),
        listSalePayment: json["list_sale_payment"] == null
            ? []
            : List<ListSalePayment>.from(json["list_sale_payment"]!
                .map((x) => ListSalePayment.fromJson(x))),
        basePackagingInfo: json["base_packaging_info"] == null
            ? null
            : BasePackagingInfo.fromJson(json["base_packaging_info"]),
      );

  Map<String, dynamic> toJson() => {
        "created_at": createdAt,
        "modified_at": modifiedAt,
        "member_created": memberCreated,
        "member_updated": memberUpdated,
        "deleted_at": deletedAt,
        "request_id": requestId,
        "order_code_of_provider": orderCodeOfProvider,
        "order_code_of_client": orderCodeOfClient,
        "client_id": clientId,
        "request_provider_id": requestProviderId,
        "origin_service_provider": originServiceProvider,
        "origin_fleet_address_id": originFleetAddressId,
        "current_fleet_address_id": currentFleetAddressId,
        "next_fleet_address_id": nextFleetAddressId,
        "dest_fleet_address_id": destFleetAddressId,
        "distance": distance,
        "package_name": packageName,
        "note": note,
        "count_of_parcels": countOfParcels,
        "rlength": rlength,
        "rwidth": rwidth,
        "rheight": rheight,
        "rweight": rweight,
        "rvolume": rvolume,
        "handling_unit_id": handlingUnitId,
        "cod": cod,
        "request_total_price": requestTotalPrice,
        "service_id": serviceId,
        "my_service_id": myServiceId,
        "opt_payer": optPayer,
        "kind_of_request": kindOfRequest,
        "kind_of_tariff": kindOfTariff,
        "baggage_weight": baggageWeight,
        "is_insurance": isInsurance,
        "shop_id": shopId,
        "shipping_fee": shippingFee,
        "vat_fee": vatFee,
        "discount": discount,
        "status": status,
        "pay_status": payStatus,
        "print_status": printStatus,
        "print_count": printCount,
        "state_val": stateVal,
        "error": error,
        "history_id": historyId,
        "choicesp": choicesp,
        "discount_code": discountCode == null
            ? []
            : List<dynamic>.from(discountCode!.map((x) => x)),
        "pickup_time": pickupTime,
        "drop_time": dropTime,
        "pickup_lat": pickupLat,
        "pickup_lon": pickupLon,
        "pickup_address": pickupAddress,
        "pickup_w3wcode": pickupW3Wcode,
        "pickup_wid": pickupWid,
        "pickup_did": pickupDid,
        "pickup_pid": pickupPid,
        "drop_lat": dropLat,
        "drop_lon": dropLon,
        "drop_address": dropAddress,
        "drop_wid": dropWid,
        "drop_did": dropDid,
        "drop_pid": dropPid,
        "drop_w3wcode": dropW3Wcode,
        "shipment_order_id": shipmentOrderId,
        "receiver_phone": receiverPhone,
        "receiver_name": receiverName,
        "sender_phone": senderPhone,
        "sender_name": senderName,
        "list_request_id": listRequestId == null
            ? []
            : List<dynamic>.from(listRequestId!.map((x) => x)),
        "request_type": requestType,
        "assignee_id": assigneeId,
        "assigned_at": assignedAt,
        "update_expired_at": updateExpiredAt,
        "is_sender_dropoff": isSenderDropoff,
        "is_receiver_pickup": isReceiverPickup,
        "pickup_time_preferred": pickupTimePreferred,
        "drop_time_preferred": dropTimePreferred,
        "pickup_failed_count": pickupFailedCount,
        "sub_receiver_info": subReceiverInfo,
        "sub_sender_info": subSenderInfo,
        "drop_failed_count": dropFailedCount,
        "request_package_items": requestPackageItems == null
            ? []
            : List<dynamic>.from(requestPackageItems!.map((x) => x.toJson())),
        "list_sale_payment": listSalePayment == null
            ? []
            : List<dynamic>.from(listSalePayment!.map((x) => x.toJson())),
        "base_packaging_info": basePackagingInfo?.toJson(),
      };
}

class BasePackagingInfo {
  int? createdAt;
  int? modifiedAt;
  int? memberCreated;
  int? memberUpdated;
  dynamic deletedAt;
  int? handlingUnitId;
  int? groupId;
  int? plength;
  int? pheight;
  int? pwidth;
  double? minWeight;
  int? maxWeight;
  int? volume;
  String? units;
  String? unitsWeight;
  String? packageName;
  String? groupName;
  String? description;

  BasePackagingInfo({
    this.createdAt,
    this.modifiedAt,
    this.memberCreated,
    this.memberUpdated,
    this.deletedAt,
    this.handlingUnitId,
    this.groupId,
    this.plength,
    this.pheight,
    this.pwidth,
    this.minWeight,
    this.maxWeight,
    this.volume,
    this.units,
    this.unitsWeight,
    this.packageName,
    this.groupName,
    this.description,
  });

  factory BasePackagingInfo.fromJson(Map<String, dynamic> json) =>
      BasePackagingInfo(
        createdAt: json["created_at"],
        modifiedAt: json["modified_at"],
        memberCreated: json["member_created"],
        memberUpdated: json["member_updated"],
        deletedAt: json["deleted_at"],
        handlingUnitId: json["handling_unit_id"],
        groupId: json["group_id"],
        plength: json["plength"],
        pheight: json["pheight"],
        pwidth: json["pwidth"],
        minWeight: json["min_weight"]?.toDouble(),
        maxWeight: json["max_weight"],
        volume: json["volume"],
        units: json["units"],
        unitsWeight: json["units_weight"],
        packageName: json["package_name"],
        groupName: json["group_name"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "created_at": createdAt,
        "modified_at": modifiedAt,
        "member_created": memberCreated,
        "member_updated": memberUpdated,
        "deleted_at": deletedAt,
        "handling_unit_id": handlingUnitId,
        "group_id": groupId,
        "plength": plength,
        "pheight": pheight,
        "pwidth": pwidth,
        "min_weight": minWeight,
        "max_weight": maxWeight,
        "volume": volume,
        "units": units,
        "units_weight": unitsWeight,
        "package_name": packageName,
        "group_name": groupName,
        "description": description,
      };
}

class ListSalePayment {
  int? createdAt;
  int? modifiedAt;
  int? memberCreated;
  int? memberUpdated;
  dynamic deletedAt;
  int? salePaymentId;
  int? requestId;
  int? myServiceId;
  int? myExtraServiceId;
  int? type;
  int? vatPercent;
  double? vatFee;
  double? amountWithoutVat;
  double? amountWithVat;
  int? unitOfBasicTariff;
  String? unitName;
  int? unitValue;
  int? quantity;
  int? tariffId;
  String? fieldFee;
  String? fieldOfTariff;
  int? clientId;
  int? requestProviderId;
  int? serviceProviderId;
  int? contractSaleId;

  ListSalePayment({
    this.createdAt,
    this.modifiedAt,
    this.memberCreated,
    this.memberUpdated,
    this.deletedAt,
    this.salePaymentId,
    this.requestId,
    this.myServiceId,
    this.myExtraServiceId,
    this.type,
    this.vatPercent,
    this.vatFee,
    this.amountWithoutVat,
    this.amountWithVat,
    this.unitOfBasicTariff,
    this.unitName,
    this.unitValue,
    this.quantity,
    this.tariffId,
    this.fieldFee,
    this.fieldOfTariff,
    this.clientId,
    this.requestProviderId,
    this.serviceProviderId,
    this.contractSaleId,
  });

  factory ListSalePayment.fromJson(Map<String, dynamic> json) =>
      ListSalePayment(
        createdAt: json["created_at"],
        modifiedAt: json["modified_at"],
        memberCreated: json["member_created"],
        memberUpdated: json["member_updated"],
        deletedAt: json["deleted_at"],
        salePaymentId: json["sale_payment_id"],
        requestId: json["request_id"],
        myServiceId: json["my_service_id"],
        myExtraServiceId: json["my_extra_service_id"],
        type: json["type"],
        vatPercent: json["vat_percent"],
        vatFee: json["vat_fee"]?.toDouble(),
        amountWithoutVat: json["amount_without_vat"]?.toDouble(),
        amountWithVat: json["amount_with_vat"]?.toDouble(),
        unitOfBasicTariff: json["unit_of_basic_tariff"],
        unitName: json["unit_name"],
        unitValue: json["unit_value"],
        quantity: json["quantity"],
        tariffId: json["tariff_id"],
        fieldFee: json["field_fee"],
        fieldOfTariff: json["field_of_tariff"],
        clientId: json["client_id"],
        requestProviderId: json["request_provider_id"],
        serviceProviderId: json["service_provider_id"],
        contractSaleId: json["contract_sale_id"],
      );

  Map<String, dynamic> toJson() => {
        "created_at": createdAt,
        "modified_at": modifiedAt,
        "member_created": memberCreated,
        "member_updated": memberUpdated,
        "deleted_at": deletedAt,
        "sale_payment_id": salePaymentId,
        "request_id": requestId,
        "my_service_id": myServiceId,
        "my_extra_service_id": myExtraServiceId,
        "type": type,
        "vat_percent": vatPercent,
        "vat_fee": vatFee,
        "amount_without_vat": amountWithoutVat,
        "amount_with_vat": amountWithVat,
        "unit_of_basic_tariff": unitOfBasicTariff,
        "unit_name": unitName,
        "unit_value": unitValue,
        "quantity": quantity,
        "tariff_id": tariffId,
        "field_fee": fieldFee,
        "field_of_tariff": fieldOfTariff,
        "client_id": clientId,
        "request_provider_id": requestProviderId,
        "service_provider_id": serviceProviderId,
        "contract_sale_id": contractSaleId,
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
  double? weight;
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
        weight: json["weight"]?.toDouble(),
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

class SequenceListStart {
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

  SequenceListStart({
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

  factory SequenceListStart.fromJson(Map<String, dynamic> json) =>
      SequenceListStart(
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

class ToFleetAddressInfo {
  int? createdAt;
  int? modifiedAt;
  int? memberCreated;
  int? memberUpdated;
  dynamic deletedAt;
  int? addressId;
  String? name;
  int? relId;
  String? relType;
  dynamic w3WCode;
  String? contactName;
  String? address;
  String? phone;
  String? email;
  double? latitude;
  double? longitude;
  String? countryPrefix;
  int? wardId;
  int? pick;
  int? drop;
  int? kind;
  String? beginOut;
  int? periodOfOut;
  String? beginIn;
  int? periodOfIn;
  String? shortName;
  int? radiusOfPickupdrop;
  int? depotArea;
  bool? isDefault;
  int? clientId;
  int? portalId;

  ToFleetAddressInfo({
    this.createdAt,
    this.modifiedAt,
    this.memberCreated,
    this.memberUpdated,
    this.deletedAt,
    this.addressId,
    this.name,
    this.relId,
    this.relType,
    this.w3WCode,
    this.contactName,
    this.address,
    this.phone,
    this.email,
    this.latitude,
    this.longitude,
    this.countryPrefix,
    this.wardId,
    this.pick,
    this.drop,
    this.kind,
    this.beginOut,
    this.periodOfOut,
    this.beginIn,
    this.periodOfIn,
    this.shortName,
    this.radiusOfPickupdrop,
    this.depotArea,
    this.isDefault,
    this.clientId,
    this.portalId,
  });

  factory ToFleetAddressInfo.fromJson(Map<String, dynamic> json) =>
      ToFleetAddressInfo(
        createdAt: json["created_at"],
        modifiedAt: json["modified_at"],
        memberCreated: json["member_created"],
        memberUpdated: json["member_updated"],
        deletedAt: json["deleted_at"],
        addressId: json["address_id"],
        name: json["name"],
        relId: json["rel_id"],
        relType: json["rel_type"],
        w3WCode: json["w3w_code"],
        contactName: json["contact_name"],
        address: json["address"],
        phone: json["phone"],
        email: json["email"],
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
        countryPrefix: json["country_prefix"],
        wardId: json["ward_id"],
        pick: json["pick"],
        drop: json["drop"],
        kind: json["kind"],
        beginOut: json["begin_out"],
        periodOfOut: json["period_of_out"],
        beginIn: json["begin_in"],
        periodOfIn: json["period_of_in"],
        shortName: json["short_name"],
        radiusOfPickupdrop: json["radius_of_pickupdrop"],
        depotArea: json["depot_area"],
        isDefault: json["is_default"],
        clientId: json["client_id"],
        portalId: json["portal_id"],
      );

  Map<String, dynamic> toJson() => {
        "created_at": createdAt,
        "modified_at": modifiedAt,
        "member_created": memberCreated,
        "member_updated": memberUpdated,
        "deleted_at": deletedAt,
        "address_id": addressId,
        "name": name,
        "rel_id": relId,
        "rel_type": relType,
        "w3w_code": w3WCode,
        "contact_name": contactName,
        "address": address,
        "phone": phone,
        "email": email,
        "latitude": latitude,
        "longitude": longitude,
        "country_prefix": countryPrefix,
        "ward_id": wardId,
        "pick": pick,
        "drop": drop,
        "kind": kind,
        "begin_out": beginOut,
        "period_of_out": periodOfOut,
        "begin_in": beginIn,
        "period_of_in": periodOfIn,
        "short_name": shortName,
        "radius_of_pickupdrop": radiusOfPickupdrop,
        "depot_area": depotArea,
        "is_default": isDefault,
        "client_id": clientId,
        "portal_id": portalId,
      };
}
