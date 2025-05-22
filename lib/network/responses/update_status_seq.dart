class UpdateSeqReponse {
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

  UpdateSeqReponse({
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

  factory UpdateSeqReponse.fromJson(Map<String, dynamic> json) =>
      UpdateSeqReponse(
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
