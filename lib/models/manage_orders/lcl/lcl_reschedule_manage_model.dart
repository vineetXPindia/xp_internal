// To parse this JSON data, do
//
//     final lclRescheduleModel = lclRescheduleModelFromJson(jsonString);

import 'dart:convert';

LclRescheduleModel lclRescheduleModelFromJson(String str) =>
    LclRescheduleModel.fromJson(json.decode(str));

String lclRescheduleModelToJson(LclRescheduleModel data) =>
    json.encode(data.toJson());

class LclRescheduleModel {
  dynamic message;
  bool? success;
  List<Datum>? data;
  dynamic code;

  LclRescheduleModel({
    this.message,
    this.success,
    this.data,
    this.code,
  });

  factory LclRescheduleModel.fromJson(Map<String, dynamic> json) =>
      LclRescheduleModel(
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
  int? totalCount;
  String? intStartIndex;
  String? intEndIndex;
  String? userId;
  String? vcBookingId;
  String? vcZone;
  String? vcBranch;
  String? vcOrigin;
  dynamic vcServiceType;
  String? vcCustomerName;
  int? intCustomerId;
  int? intVehicleTypeId;
  String? vcVehicleType;
  dynamic vcFilterBy;
  dynamic vcKeyword;
  dynamic intUserId;
  DateTime? dtPickUpDate;
  String? vcOriginId;
  int? intOrderTypeId;
  String? vcOrderType;
  String? vcOriginPostcode;
  int? intBookingId;
  String? vcRegion;
  String? vcDestination;
  String? vcPocName;
  String? vcPocNumber;
  String? vcConsigner;
  DateTime? dtFromDate;
  DateTime? dtToDate;
  String? vcPickupLocation;
  double? decApproxWeight;
  String? vcBoxes;
  String? vcXpcns;
  String? vcCapacityType;
  String? vcCc;
  dynamic dtReschduleDate;
  dynamic vcRescheduleBy;
  dynamic vcReason;
  dynamic dtOldBookingDate;
  dynamic isReschedule;
  String? vcVehicleNo;
  String? filterType;

  Datum({
    this.totalCount,
    this.intStartIndex,
    this.intEndIndex,
    this.userId,
    this.vcBookingId,
    this.vcZone,
    this.vcBranch,
    this.vcOrigin,
    this.vcServiceType,
    this.vcCustomerName,
    this.intCustomerId,
    this.intVehicleTypeId,
    this.vcVehicleType,
    this.vcFilterBy,
    this.vcKeyword,
    this.intUserId,
    this.dtPickUpDate,
    this.vcOriginId,
    this.intOrderTypeId,
    this.vcOrderType,
    this.vcOriginPostcode,
    this.intBookingId,
    this.vcRegion,
    this.vcDestination,
    this.vcPocName,
    this.vcPocNumber,
    this.vcConsigner,
    this.dtFromDate,
    this.dtToDate,
    this.vcPickupLocation,
    this.decApproxWeight,
    this.vcBoxes,
    this.vcXpcns,
    this.vcCapacityType,
    this.vcCc,
    this.dtReschduleDate,
    this.vcRescheduleBy,
    this.vcReason,
    this.dtOldBookingDate,
    this.isReschedule,
    this.vcVehicleNo,
    this.filterType,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        totalCount: json["TotalCount"],
        intStartIndex: json["int_start_index"],
        intEndIndex: json["int_end_index"],
        userId: json["UserId"],
        vcBookingId: json["vc_bookingId"],
        vcZone: json["vc_zone"],
        vcBranch: json["vc_branch"],
        vcOrigin: json["vc_origin"],
        vcServiceType: json["vc_ServiceType"],
        vcCustomerName: json["vc_CustomerName"],
        intCustomerId: json["int_CustomerId"],
        intVehicleTypeId: json["int_vehicle_type_id"],
        vcVehicleType: json["vc_vehicle_type"],
        vcFilterBy: json["vc_filter_by"],
        vcKeyword: json["vc_keyword"],
        intUserId: json["int_userId"],
        dtPickUpDate: json["dt_pickUpDate"] == null
            ? null
            : DateTime.parse(json["dt_pickUpDate"]),
        vcOriginId: json["vc_originId"],
        intOrderTypeId: json["int_orderType_id"],
        vcOrderType: json["vc_orderType"],
        vcOriginPostcode: json["vc_origin_postcode"],
        intBookingId: json["int_BookingId"],
        vcRegion: json["vc_region"],
        vcDestination: json["vc_destination"],
        vcPocName: json["vc_poc_name"],
        vcPocNumber: json["vc_poc_Number"],
        vcConsigner: json["vc_consigner"],
        dtFromDate: json["dt_from_date"] == null
            ? null
            : DateTime.parse(json["dt_from_date"]),
        dtToDate: json["dt_to_date"] == null
            ? null
            : DateTime.parse(json["dt_to_date"]),
        vcPickupLocation: json["vc_pickup_location"],
        decApproxWeight: json["dec_approx_weight"],
        vcBoxes: json["vc_Boxes"],
        vcXpcns: json["vc_xpcns"],
        vcCapacityType: json["vc_capacity_type"],
        vcCc: json["vc_cc"],
        dtReschduleDate: json["dt_reschdule_date"],
        vcRescheduleBy: json["vc_reschedule_by"],
        vcReason: json["vc_reason"],
        dtOldBookingDate: json["dt_old_booking_date"],
        isReschedule: json["IsReschedule"],
        vcVehicleNo: json["vc_vehicle_no"],
        filterType: json["FilterType"],
      );

  Map<String, dynamic> toJson() => {
        "TotalCount": totalCount,
        "int_start_index": intStartIndex,
        "int_end_index": intEndIndex,
        "UserId": userId,
        "vc_bookingId": vcBookingId,
        "vc_zone": vcZone,
        "vc_branch": vcBranch,
        "vc_origin": vcOrigin,
        "vc_ServiceType": vcServiceType,
        "vc_CustomerName": vcCustomerName,
        "int_CustomerId": intCustomerId,
        "int_vehicle_type_id": intVehicleTypeId,
        "vc_vehicle_type": vcVehicleType,
        "vc_filter_by": vcFilterBy,
        "vc_keyword": vcKeyword,
        "int_userId": intUserId,
        "dt_pickUpDate": dtPickUpDate?.toIso8601String(),
        "vc_originId": vcOriginId,
        "int_orderType_id": intOrderTypeId,
        "vc_orderType": vcOrderType,
        "vc_origin_postcode": vcOriginPostcode,
        "int_BookingId": intBookingId,
        "vc_region": vcRegion,
        "vc_destination": vcDestination,
        "vc_poc_name": vcPocName,
        "vc_poc_Number": vcPocNumber,
        "vc_consigner": vcConsigner,
        "dt_from_date": dtFromDate?.toIso8601String(),
        "dt_to_date": dtToDate?.toIso8601String(),
        "vc_pickup_location": vcPickupLocation,
        "dec_approx_weight": decApproxWeight,
        "vc_Boxes": vcBoxes,
        "vc_xpcns": vcXpcns,
        "vc_capacity_type": vcCapacityType,
        "vc_cc": vcCc,
        "dt_reschdule_date": dtReschduleDate,
        "vc_reschedule_by": vcRescheduleBy,
        "vc_reason": vcReason,
        "dt_old_booking_date": dtOldBookingDate,
        "IsReschedule": isReschedule,
        "vc_vehicle_no": vcVehicleNo,
        "FilterType": filterType,
      };
}
