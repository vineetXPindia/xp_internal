// To parse this JSON data, do
//
//     final capacityUnloadingModel = capacityUnloadingModelFromJson(jsonString);

import 'dart:convert';

CapacityUnloadingModel capacityUnloadingModelFromJson(String str) =>
    CapacityUnloadingModel.fromJson(json.decode(str));

String capacityUnloadingModelToJson(CapacityUnloadingModel data) =>
    json.encode(data.toJson());

class CapacityUnloadingModel {
  String? message;
  bool? success;
  List<Datum>? data;
  dynamic code;

  CapacityUnloadingModel({
    this.message,
    this.success,
    this.data,
    this.code,
  });

  factory CapacityUnloadingModel.fromJson(Map<String, dynamic> json) =>
      CapacityUnloadingModel(
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
  int? vehicleTypeId;
  String? vehicleType;
  int? vehicleId;
  String? vehicleNumber;
  int? driverId;
  String? driverName;
  String? driverNumber;
  int? ffvid;
  String? ffvName;
  int? capacityTypeId;
  String? capacityType;
  String? currentLocation;
  String? branch;
  String? zone;
  int? haltingHours;
  int? totalCount;
  String? latitude;
  String? longitude;
  DateTime? tentativeDateTime;
  dynamic departuredate;
  dynamic destinationLatitude;
  dynamic destinationLongitude;
  dynamic dynamicEta;
  DateTime? arrivalDate;
  String? customerName;
  dynamic from;
  dynamic to;
  String? productType;

  Datum({
    this.vehicleTypeId,
    this.vehicleType,
    this.vehicleId,
    this.vehicleNumber,
    this.driverId,
    this.driverName,
    this.driverNumber,
    this.ffvid,
    this.ffvName,
    this.capacityTypeId,
    this.capacityType,
    this.currentLocation,
    this.branch,
    this.zone,
    this.haltingHours,
    this.totalCount,
    this.latitude,
    this.longitude,
    this.tentativeDateTime,
    this.departuredate,
    this.destinationLatitude,
    this.destinationLongitude,
    this.dynamicEta,
    this.arrivalDate,
    this.customerName,
    this.from,
    this.to,
    this.productType,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        vehicleTypeId: json["VehicleTypeId"],
        vehicleType: json["VehicleType"],
        vehicleId: json["VehicleId"],
        vehicleNumber: json["VehicleNumber"],
        driverId: json["DriverId"],
        driverName: json["DriverName"],
        driverNumber: json["DriverNumber"],
        ffvid: json["FFVID"],
        ffvName: json["FFVName"],
        capacityTypeId: json["CapacityTypeID"],
        capacityType: json["CapacityType"],
        currentLocation: json["CurrentLocation"],
        branch: json["Branch"],
        zone: json["Zone"],
        haltingHours: json["HaltingHours"],
        totalCount: json["TotalCount"],
        latitude: json["Latitude"],
        longitude: json["Longitude"],
        tentativeDateTime: json["TentativeDateTime"] == null
            ? null
            : DateTime.parse(json["TentativeDateTime"]),
        departuredate: json["Departuredate"],
        destinationLatitude: json["DestinationLatitude"],
        destinationLongitude: json["DestinationLongitude"],
        dynamicEta: json["DynamicETA"],
        arrivalDate: json["ArrivalDate"] == null
            ? null
            : DateTime.parse(json["ArrivalDate"]),
        customerName: json["CustomerName"],
        from: json["From"],
        to: json["To"],
        productType: json["ProductType"],
      );

  Map<String, dynamic> toJson() => {
        "VehicleTypeId": vehicleTypeId,
        "VehicleType": vehicleType,
        "VehicleId": vehicleId,
        "VehicleNumber": vehicleNumber,
        "DriverId": driverId,
        "DriverName": driverName,
        "DriverNumber": driverNumber,
        "FFVID": ffvid,
        "FFVName": ffvName,
        "CapacityTypeID": capacityTypeId,
        "CapacityType": capacityType,
        "CurrentLocation": currentLocation,
        "Branch": branch,
        "Zone": zone,
        "HaltingHours": haltingHours,
        "TotalCount": totalCount,
        "Latitude": latitude,
        "Longitude": longitude,
        "TentativeDateTime": tentativeDateTime?.toIso8601String(),
        "Departuredate": departuredate,
        "DestinationLatitude": destinationLatitude,
        "DestinationLongitude": destinationLongitude,
        "DynamicETA": dynamicEta,
        "ArrivalDate": arrivalDate?.toIso8601String(),
        "CustomerName": customerName,
        "From": from,
        "To": to,
        "ProductType": productType,
      };
}
