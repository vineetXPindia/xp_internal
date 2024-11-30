// To parse this JSON data, do
//
//     final pendingProvisionalModel = pendingProvisionalModelFromJson(jsonString);

import 'dart:convert';

PendingProvisionalModel pendingProvisionalModelFromJson(String str) =>
    PendingProvisionalModel.fromJson(json.decode(str));

String pendingProvisionalModelToJson(PendingProvisionalModel data) =>
    json.encode(data.toJson());

class PendingProvisionalModel {
  String? message;
  bool? success;
  Data data;
  dynamic code;

  PendingProvisionalModel({
    required this.message,
    required this.success,
    required this.data,
    required this.code,
  });

  factory PendingProvisionalModel.fromJson(Map<String, dynamic> json) =>
      PendingProvisionalModel(
        message: json["Message"],
        success: json["Success"],
        data: Data.fromJson(json["Data"]),
        code: json["Code"],
      );

  Map<String, dynamic> toJson() => {
        "Message": message,
        "Success": success,
        "Data": data.toJson(),
        "Code": code,
      };
}

class Data {
  List<ProvisionalOrdersList> provisionalOrdersList;
  int? provisionalOrdersCount;
  List<ZonesStat> zonesStats;
  List<CalanderList> calanderList;

  Data({
    required this.provisionalOrdersList,
    required this.provisionalOrdersCount,
    required this.zonesStats,
    required this.calanderList,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        provisionalOrdersList: List<ProvisionalOrdersList>.from(
            json["ProvisionalOrdersList"]
                .map((x) => ProvisionalOrdersList.fromJson(x))),
        provisionalOrdersCount: json["ProvisionalOrdersCount"],
        zonesStats: List<ZonesStat>.from(
            json["ZonesStats"].map((x) => ZonesStat.fromJson(x))),
        calanderList: List<CalanderList>.from(
            json["CalanderList"].map((x) => CalanderList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "ProvisionalOrdersList":
            List<dynamic>.from(provisionalOrdersList.map((x) => x.toJson())),
        "ProvisionalOrdersCount": provisionalOrdersCount,
        "ZonesStats": List<dynamic>.from(zonesStats.map((x) => x.toJson())),
        "CalanderList": List<dynamic>.from(calanderList.map((x) => x.toJson())),
      };
}

class CalanderList {
  String start;
  String title;

  CalanderList({
    required this.start,
    required this.title,
  });

  factory CalanderList.fromJson(Map<String, dynamic> json) => CalanderList(
        start: json["start"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "start": start,
        "title": title,
      };
}

class ProvisionalOrdersList {
  String? freightType;
  // int branchId;
  String? branchName;
  // String branchCode;
  int? zoneId;
  String? zoneName;
  int? orderId;
  int? orderDetailId;
  String? orderIdCode;
  // String? serviceTypeId;
  String? serviceType;
  // String? serviceClassId;
  // PaymentMode serviceClass;
  // dynamic allocatedServiceClass;
  DateTime pickupDate;
  DateTime fromPickupTime;
  DateTime toPickupTime;
  // dynamic originId;
  String from;
  // dynamic destinationId;
  String to;
  // dynamic pickup1Id;
  // dynamic pickup2Id;
  // dynamic via1Id;
  // dynamic via2Id;
  String? via1;
  String? via2;
  // dynamic customerId;
  String? customerName;
  // int payload;
  double? amount;
  // DateTime edd;
  // int vehicleTypeId;
  String? vehicleType;
  // dynamic allocatedVehicleType;
  // dynamic paymentModeId;
  PaymentMode paymentMode;
  // bool isConfirmed;
  // bool isRejected;
  DateTime lbPublishedDate;
  // dynamic userId;
  // dynamic orderBy;
  // dynamic startIndex;
  // dynamic pageLength;
  // dynamic filterBy;
  // dynamic keyword;
  // dynamic keywordDate;
  // dynamic filterStatus;
  // dynamic fromDate;
  // dynamic toDate;
  dynamic dateType;
  // dynamic destLatitude;
  // dynamic destLongitude;
  // dynamic deliveryRegionId;
  // dynamic deliveryStateIds;
  // dynamic deliveryStateNames;
  // dynamic originStateId;
  // dynamic originDistrictId;
  // dynamic originLocationId;
  // dynamic originPostcodeId;

  ProvisionalOrdersList({
    required this.freightType,
    // required this.branchId,
    required this.branchName,
    // required this.branchCode,
    required this.zoneId,
    required this.zoneName,
    required this.orderId,
    required this.orderDetailId,
    required this.orderIdCode,
    // required this.serviceTypeId,
    required this.serviceType,
    // required this.serviceClassId,
    // required this.serviceClass,
    // required this.allocatedServiceClass,
    required this.pickupDate,
    required this.fromPickupTime,
    required this.toPickupTime,
    // required this.originId,
    required this.from,
    // required this.destinationId,
    required this.to,
    // required this.pickup1Id,
    // required this.pickup2Id,
    // required this.via1Id,
    // required this.via2Id,
    required this.via1,
    required this.via2,
    // required this.customerId,
    required this.customerName,
    // required this.payload,
    required this.amount,
    // required this.edd,
    // required this.vehicleTypeId,
    required this.vehicleType,
    // required this.allocatedVehicleType,
    // required this.paymentModeId,
    required this.paymentMode,
    // required this.isConfirmed,
    // required this.isRejected,
    required this.lbPublishedDate,
    // required this.userId,
    // required this.orderBy,
    // required this.startIndex,
    // required this.pageLength,
    // required this.filterBy,
    // required this.keyword,
    // required this.keywordDate,
    // required this.filterStatus,
    // required this.fromDate,
    // required this.toDate,
    required this.dateType,
    // required this.destLatitude,
    // required this.destLongitude,
    // required this.deliveryRegionId,
    // required this.deliveryStateIds,
    // required this.deliveryStateNames,
    // required this.originStateId,
    // required this.originDistrictId,
    // required this.originLocationId,
    // required this.originPostcodeId,
  });

  factory ProvisionalOrdersList.fromJson(Map<String, dynamic> json) =>
      ProvisionalOrdersList(
        // freightType: [json["FreightType"],
        // branchId: json["BranchId"],
        branchName: json["BranchName"],
        // branchCode: json["BranchCode"],
        zoneId: json["ZoneId"],
        zoneName: json["ZoneName"],
        orderId: json["OrderId"],
        orderDetailId: json["OrderDetailId"],
        orderIdCode: json["OrderIdCode"],
        // serviceTypeId: json["ServiceTypeId"],
        serviceType: json["ServiceType"]!,
        // serviceClassId: json["ServiceClassId"],
        // serviceClass: paymentModeValues.map[json["ServiceClass"]]!,
        // allocatedServiceClass: json["AllocatedServiceClass"],
        pickupDate: DateTime.parse(json["PickupDate"]),
        fromPickupTime: DateTime.parse(json["FromPickupTime"]),
        toPickupTime: DateTime.parse(json["ToPickupTime"]),
        // originId: json["OriginId"],
        from: json["From"],
        // destinationId: json["DestinationId"],
        to: json["To"],
        // pickup1Id: json["Pickup1Id"],
        // pickup2Id: json["Pickup2Id"],
        // via1Id: json["Via1Id"],
        // via2Id: json["Via2Id"],
        via1: json["Via1"],
        via2: json["Via2"],
        //customerId: json["CustomerId"],
        customerName: json["CustomerName"],
        // payload: json["Payload"],
        amount: json["Amount"],
        // edd: DateTime.parse(json["EDD"]),
        //vehicleTypeId: json["VehicleTypeId"],
        vehicleType: json["VehicleType"],
        // allocatedVehicleType: json["AllocatedVehicleType"],
        // paymentModeId: json["PaymentModeId"],
        paymentMode: paymentModeValues.map[json["PaymentMode"]]!,
        // isConfirmed: json["IsConfirmed"],
        // isRejected: json["IsRejected"],
        lbPublishedDate: DateTime.parse(json["LBPublishedDate"]),
        freightType: json["FreightType"],
        // userId: json["UserId"],
        // orderBy: json["OrderBy"],
        // startIndex: json["StartIndex"],
        // pageLength: json["PageLength"],
        // filterBy: json["FilterBy"],
        // keyword: json["Keyword"],
        // keywordDate: json["KeywordDate"],
        // filterStatus: json["FilterStatus"],
        // fromDate: json["FromDate"],
        // toDate: json["ToDate"],
        dateType: json["DateType"],
        // destLatitude: json["DestLatitude"],
        // destLongitude: json["DestLongitude"],
        // deliveryRegionId: json["DeliveryRegionId"],
        // deliveryStateIds: json["DeliveryStateIds"],
        // deliveryStateNames: json["DeliveryStateNames"],
        // originStateId: json["OriginStateId"],
        // originDistrictId: json["OriginDistrictId"],
        // originLocationId: json["OriginLocationId"],
        // originPostcodeId: json["OriginPostcodeId"],
      );

  Map<String, dynamic> toJson() => {
        "FreightType": freightTypeValues.reverse[freightType],
        // "BranchId": branchId,
        "BranchName": branchName,
        // "BranchCode": branchCode,
        "ZoneId": zoneId,
        "ZoneName": zoneName,
        "OrderId": orderId,
        "OrderDetailId": orderDetailId,
        "OrderIdCode": orderIdCode,
        "ServiceType": serviceType,
        //"ServiceClassId": serviceClassId,
        // "ServiceClass": paymentModeValues.reverse[serviceClass],
        // "AllocatedServiceClass": allocatedServiceClass,
        "PickupDate": pickupDate.toIso8601String(),
        "FromPickupTime": fromPickupTime.toIso8601String(),
        "ToPickupTime": toPickupTime.toIso8601String(),
        //"OriginId": originId,
        "From": from,
        //"DestinationId": destinationId,
        "To": to,
        // "Pickup1Id": pickup1Id,
        // "Pickup2Id": pickup2Id,
        // "Via1Id": via1Id,
        // "Via2Id": via2Id,
        "Via1": via1,
        "Via2": via2,
        //"CustomerId": customerId,
        "CustomerName": customerName,
        //"Payload": payload,
        "Amount": amount,
        //"EDD": edd.toIso8601String(),
        //"VehicleTypeId": vehicleTypeId,
        "VehicleType": vehicleType,
        // "AllocatedVehicleType": allocatedVehicleType,
        // "PaymentModeId": paymentModeId,
        // "PaymentMode": paymentModeValues.reverse[paymentMode],
        // "IsConfirmed": isConfirmed,
        // "IsRejected": isRejected,
        "LBPublishedDate": lbPublishedDate.toIso8601String(),
        // "UserId": userId,
        // "OrderBy": orderBy,
        // "StartIndex": startIndex,
        // "PageLength": pageLength,
        // "FilterBy": filterBy,
        // "Keyword": keyword,
        // "KeywordDate": keywordDate,
        // "FilterStatus": filterStatus,
        // "FromDate": fromDate,
        // "ToDate": toDate,
        "DateType": dateType,
        // "DestLatitude": destLatitude,
        // "DestLongitude": destLongitude,
        // "DeliveryRegionId": deliveryRegionId,
        // "DeliveryStateIds": deliveryStateIds,
        // "DeliveryStateNames": deliveryStateNames,
        // "OriginStateId": originStateId,
        // "OriginDistrictId": originDistrictId,
        // "OriginLocationId": originLocationId,
        // "OriginPostcodeId": originPostcodeId,
      };
}

enum FreightType { DYNAMIC }

final freightTypeValues = EnumValues({"Dynamic": FreightType.DYNAMIC});

enum PaymentMode { CREDIT, EXPRESS, PAID }

final paymentModeValues = EnumValues({
  "Credit": PaymentMode.CREDIT,
  "Express": PaymentMode.EXPRESS,
  "Paid": PaymentMode.PAID
});

class ZonesStat {
  dynamic address;
  int lookupId;
  String lookupName;
  dynamic lookupNameCaption;
  dynamic codeMasterId;
  dynamic codeMasterName;
  bool disabled;
  dynamic controllable;
  dynamic poc;
  dynamic pocContactNumber;
  dynamic amount;
  dynamic name;
  dynamic productType;
  dynamic isAsnUploadAllowed;
  dynamic id;
  dynamic vcServiceTypeIds;
  dynamic customerCategory;

  ZonesStat({
    required this.address,
    required this.lookupId,
    required this.lookupName,
    required this.lookupNameCaption,
    required this.codeMasterId,
    required this.codeMasterName,
    required this.disabled,
    required this.controllable,
    required this.poc,
    required this.pocContactNumber,
    required this.amount,
    required this.name,
    required this.productType,
    required this.isAsnUploadAllowed,
    required this.id,
    required this.vcServiceTypeIds,
    required this.customerCategory,
  });

  factory ZonesStat.fromJson(Map<String, dynamic> json) => ZonesStat(
        address: json["Address"],
        lookupId: json["LookupId"],
        lookupName: json["LookupName"],
        lookupNameCaption: json["LookupNameCaption"],
        codeMasterId: json["CodeMasterId"],
        codeMasterName: json["CodeMasterName"],
        disabled: json["Disabled"],
        controllable: json["Controllable"],
        poc: json["POC"],
        pocContactNumber: json["POCContactNumber"],
        amount: json["Amount"],
        name: json["Name"],
        productType: json["product_type"],
        isAsnUploadAllowed: json["IsASNUploadAllowed"],
        id: json["Id"],
        vcServiceTypeIds: json["vc_service_type_ids"],
        customerCategory: json["CustomerCategory"],
      );

  Map<String, dynamic> toJson() => {
        "Address": address,
        "LookupId": lookupId,
        "LookupName": lookupName,
        "LookupNameCaption": lookupNameCaption,
        "CodeMasterId": codeMasterId,
        "CodeMasterName": codeMasterName,
        "Disabled": disabled,
        "Controllable": controllable,
        "POC": poc,
        "POCContactNumber": pocContactNumber,
        "Amount": amount,
        "Name": name,
        "product_type": productType,
        "IsASNUploadAllowed": isAsnUploadAllowed,
        "Id": id,
        "vc_service_type_ids": vcServiceTypeIds,
        "CustomerCategory": customerCategory,
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
