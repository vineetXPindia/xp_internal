// To parse this JSON data, do
//
//     final lclReviseAllocationModel = lclReviseAllocationModelFromJson(jsonString);

import 'dart:convert';

LclReviseAllocationModel lclReviseAllocationModelFromJson(String str) =>
    LclReviseAllocationModel.fromJson(json.decode(str));

String lclReviseAllocationModelToJson(LclReviseAllocationModel data) =>
    json.encode(data.toJson());

class LclReviseAllocationModel {
  dynamic message;
  bool? success;
  List<Datum>? data;
  dynamic code;

  LclReviseAllocationModel({
    this.message,
    this.success,
    this.data,
    this.code,
  });

  factory LclReviseAllocationModel.fromJson(Map<String, dynamic> json) =>
      LclReviseAllocationModel(
        message: json["Message"],
        success: json["Success"],
        data: json["Data"] == null
            ? []
            : List<Datum>.from(json["Data"]!.map((x) => Datum.fromJson(x))),
        code: json["Code"],
      );

  Map<String, dynamic> toJson() => {
        "Message": message,
        "Success": success,
        "Data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "Code": code,
      };
}

class Datum {
  dynamic xptsId;
  dynamic isFirst;
  dynamic numberOfTallys;
  dynamic isTallyClosed;
  dynamic isScanCompleted;
  dynamic dbBookingId;
  dynamic bookingId;
  dynamic originName;
  dynamic postCode;
  dynamic originLocation;
  dynamic gateway;
  String? xptsNo;
  String? vehicleNumber;
  String? driverName;
  dynamic driver;
  dynamic originBranch;
  dynamic originZone;
  dynamic ordersCount;
  dynamic customerName;
  dynamic serviceTypeId;
  String? serviceTypeName;
  dynamic destination;
  dynamic boxCount;
  dynamic weight;
  int? totalCount;
  int? manifestId;
  dynamic dbTallyno;
  dynamic tallyNo;
  dynamic driverNo;
  dynamic executiveNo;
  dynamic dtPlacementDate;
  int? intFfvId;
  String? vcFfvname;
  int? vehicleTypeId;
  String? vehicleType;
  dynamic orderIds;
  dynamic gatewayId;
  dynamic gatewayname;
  dynamic pickupExecutive;
  dynamic via1Gateway;
  dynamic via1Name;
  dynamic via2Gateway;
  dynamic via2Name;
  dynamic origin;
  dynamic vehicleId;
  dynamic destinationGateway;
  dynamic dlNumber;
  dynamic executiveNumber;
  dynamic vehicleLatitude;
  dynamic vehicleLongitude;
  dynamic vehicleLocation;
  dynamic fromDate;
  dynamic toDate;
  dynamic xpcnDetails;
  bool? originPermission;
  bool? via1Permission;
  bool? via2Permission;
  bool? destPermission;
  dynamic via1;
  dynamic via2;
  String? loadingStatus;
  dynamic genTally;
  dynamic xpcnId;
  dynamic destinationLocationBook;
  dynamic destDeliveryGatewayBook;
  dynamic isLoadingTallyEnabled;
  int? decWeight;
  dynamic orderType;
  dynamic isReschedule;
  dynamic ffvId;
  dynamic placementDate;
  dynamic placementDateUpdatedBy;
  dynamic capacityType;
  dynamic destinationId;
  int? revise;
  bool? btIsValidated;

  Datum({
    this.xptsId,
    this.isFirst,
    this.numberOfTallys,
    this.isTallyClosed,
    this.isScanCompleted,
    this.dbBookingId,
    this.bookingId,
    this.originName,
    this.postCode,
    this.originLocation,
    this.gateway,
    this.xptsNo,
    this.vehicleNumber,
    this.driverName,
    this.driver,
    this.originBranch,
    this.originZone,
    this.ordersCount,
    this.customerName,
    this.serviceTypeId,
    this.serviceTypeName,
    this.destination,
    this.boxCount,
    this.weight,
    this.totalCount,
    this.manifestId,
    this.dbTallyno,
    this.tallyNo,
    this.driverNo,
    this.executiveNo,
    this.dtPlacementDate,
    this.intFfvId,
    this.vcFfvname,
    this.vehicleTypeId,
    this.vehicleType,
    this.orderIds,
    this.gatewayId,
    this.gatewayname,
    this.pickupExecutive,
    this.via1Gateway,
    this.via1Name,
    this.via2Gateway,
    this.via2Name,
    this.origin,
    this.vehicleId,
    this.destinationGateway,
    this.dlNumber,
    this.executiveNumber,
    this.vehicleLatitude,
    this.vehicleLongitude,
    this.vehicleLocation,
    this.fromDate,
    this.toDate,
    this.xpcnDetails,
    this.originPermission,
    this.via1Permission,
    this.via2Permission,
    this.destPermission,
    this.via1,
    this.via2,
    this.loadingStatus,
    this.genTally,
    this.xpcnId,
    this.destinationLocationBook,
    this.destDeliveryGatewayBook,
    this.isLoadingTallyEnabled,
    this.decWeight,
    this.orderType,
    this.isReschedule,
    this.ffvId,
    this.placementDate,
    this.placementDateUpdatedBy,
    this.capacityType,
    this.destinationId,
    this.revise,
    this.btIsValidated,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        xptsId: json["XptsID"],
        isFirst: json["IsFirst"],
        numberOfTallys: json["NumberOfTallys"],
        isTallyClosed: json["IsTallyClosed"],
        isScanCompleted: json["IsScanCompleted"],
        dbBookingId: json["DBBookingId"],
        bookingId: json["BookingId"],
        originName: json["OriginName"],
        postCode: json["PostCode"],
        originLocation: json["OriginLocation"],
        gateway: json["Gateway"],
        xptsNo: json["XPTSNo"],
        vehicleNumber: json["VehicleNumber"],
        driverName: json["DriverName"],
        driver: json["Driver"],
        originBranch: json["OriginBranch"],
        originZone: json["OriginZone"],
        ordersCount: json["OrdersCount"],
        customerName: json["CustomerName"],
        serviceTypeId: json["ServiceTypeId"],
        serviceTypeName: json["ServiceTypeName"],
        destination: json["Destination"],
        boxCount: json["BoxCount"],
        weight: json["Weight"],
        totalCount: json["TotalCount"],
        manifestId: json["ManifestId"],
        dbTallyno: json["DBTallyno"],
        tallyNo: json["TallyNo"],
        driverNo: json["driverNo"],
        executiveNo: json["ExecutiveNo"],
        dtPlacementDate: json["dt_placement_date"],
        intFfvId: json["int_ffv_id"],
        vcFfvname: json["vc_ffvname"],
        vehicleTypeId: json["vehicle_type_id"],
        vehicleType: json["vehicle_type"],
        orderIds: json["order_ids"],
        gatewayId: json["GatewayId"],
        gatewayname: json["Gatewayname"],
        pickupExecutive: json["pickupExecutive"],
        via1Gateway: json["via1Gateway"],
        via1Name: json["via1_name"],
        via2Gateway: json["via2Gateway"],
        via2Name: json["via2_name"],
        origin: json["Origin"],
        vehicleId: json["vehicleId"],
        destinationGateway: json["Destination_Gateway"],
        dlNumber: json["DL_Number"],
        executiveNumber: json["ExecutiveNumber"],
        vehicleLatitude: json["VehicleLatitude"],
        vehicleLongitude: json["VehicleLongitude"],
        vehicleLocation: json["VehicleLocation"],
        fromDate: json["FromDate"],
        toDate: json["ToDate"],
        xpcnDetails: json["XPCNDetails"],
        originPermission: json["OriginPermission"],
        via1Permission: json["Via1Permission"],
        via2Permission: json["Via2Permission"],
        destPermission: json["DestPermission"],
        via1: json["Via1"],
        via2: json["Via2"],
        loadingStatus: json["LoadingStatus"],
        genTally: json["GenTally"],
        xpcnId: json["XpcnId"],
        destinationLocationBook: json["DestinationLocationBook"],
        destDeliveryGatewayBook: json["DestDeliveryGatewayBook"],
        isLoadingTallyEnabled: json["isLoadingTallyEnabled"],
        decWeight: json["dec_weight"],
        orderType: json["OrderType"],
        isReschedule: json["IsReschedule"],
        ffvId: json["ffvId"],
        placementDate: json["PlacementDate"],
        placementDateUpdatedBy: json["PlacementDateUpdatedBy"],
        capacityType: json["CapacityType"],
        destinationId: json["DestinationId"],
        revise: json["revise"],
        btIsValidated: json["bt_isValidated"],
      );

  Map<String, dynamic> toJson() => {
        "XptsID": xptsId,
        "IsFirst": isFirst,
        "NumberOfTallys": numberOfTallys,
        "IsTallyClosed": isTallyClosed,
        "IsScanCompleted": isScanCompleted,
        "DBBookingId": dbBookingId,
        "BookingId": bookingId,
        "OriginName": originName,
        "PostCode": postCode,
        "OriginLocation": originLocation,
        "Gateway": gateway,
        "XPTSNo": xptsNo,
        "VehicleNumber": vehicleNumber,
        "DriverName": driverName,
        "Driver": driver,
        "OriginBranch": originBranch,
        "OriginZone": originZone,
        "OrdersCount": ordersCount,
        "CustomerName": customerName,
        "ServiceTypeId": serviceTypeId,
        "ServiceTypeName": serviceTypeName,
        "Destination": destination,
        "BoxCount": boxCount,
        "Weight": weight,
        "TotalCount": totalCount,
        "ManifestId": manifestId,
        "DBTallyno": dbTallyno,
        "TallyNo": tallyNo,
        "driverNo": driverNo,
        "ExecutiveNo": executiveNo,
        "dt_placement_date": dtPlacementDate,
        "int_ffv_id": intFfvId,
        "vc_ffvname": vcFfvname,
        "vehicle_type_id": vehicleTypeId,
        "vehicle_type": vehicleType,
        "order_ids": orderIds,
        "GatewayId": gatewayId,
        "Gatewayname": gatewayname,
        "pickupExecutive": pickupExecutive,
        "via1Gateway": via1Gateway,
        "via1_name": via1Name,
        "via2Gateway": via2Gateway,
        "via2_name": via2Name,
        "Origin": origin,
        "vehicleId": vehicleId,
        "Destination_Gateway": destinationGateway,
        "DL_Number": dlNumber,
        "ExecutiveNumber": executiveNumber,
        "VehicleLatitude": vehicleLatitude,
        "VehicleLongitude": vehicleLongitude,
        "VehicleLocation": vehicleLocation,
        "FromDate": fromDate,
        "ToDate": toDate,
        "XPCNDetails": xpcnDetails,
        "OriginPermission": originPermission,
        "Via1Permission": via1Permission,
        "Via2Permission": via2Permission,
        "DestPermission": destPermission,
        "Via1": via1,
        "Via2": via2,
        "LoadingStatus": loadingStatus,
        "GenTally": genTally,
        "XpcnId": xpcnId,
        "DestinationLocationBook": destinationLocationBook,
        "DestDeliveryGatewayBook": destDeliveryGatewayBook,
        "isLoadingTallyEnabled": isLoadingTallyEnabled,
        "dec_weight": decWeight,
        "OrderType": orderType,
        "IsReschedule": isReschedule,
        "ffvId": ffvId,
        "PlacementDate": placementDate,
        "PlacementDateUpdatedBy": placementDateUpdatedBy,
        "CapacityType": capacityType,
        "DestinationId": destinationId,
        "revise": revise,
        "bt_isValidated": btIsValidated,
      };
}
