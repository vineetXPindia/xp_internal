// To parse this JSON data, do
//
//     final capacityModel = capacityModelFromJson(jsonString);

import 'dart:convert';

CapacityModel capacityModelFromJson(String str) =>
    CapacityModel.fromJson(json.decode(str));

String capacityModelToJson(CapacityModel data) => json.encode(data.toJson());

class CapacityModel {
  String? message;
  bool? success;
  List<Datum>? data;
  dynamic code;

  CapacityModel({
    this.message,
    this.success,
    this.data,
    this.code,
  });

  factory CapacityModel.fromJson(Map<String, dynamic> json) => CapacityModel(
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
  int? capacityId;
  String? capacityType;
  int? ffVid;
  String? ffVname;
  dynamic districtId;
  dynamic districtName;
  dynamic locationId;
  String? locationName;
  int? vechileTypeId;
  String? vechileTypeName;
  int? vechileId;
  String? vechileNumber;
  int? driverId;
  String? driverName;
  String? driverPhonenumber;
  dynamic recordDate;
  dynamic createdBy;
  dynamic createdByName;
  String? branch;
  String? zone;
  dynamic errorMessage;
  int? noOfVehicles;
  dynamic isNew;
  String? latitude;
  String? longitude;
  bool? isCapacityAvailable;
  dynamic inactiveReason;
  String? inactiveBy;
  DateTime? inactiveDate;
  int? standingHours;
  DateTime? capacityAddedDate;
  int? absentDaysStreak;
  String? vehicleServiceType;
  String? idleTime;
  dynamic currentDate;
  dynamic availableDate;

  Datum({
    this.capacityId,
    this.capacityType,
    this.ffVid,
    this.ffVname,
    this.districtId,
    this.districtName,
    this.locationId,
    this.locationName,
    this.vechileTypeId,
    this.vechileTypeName,
    this.vechileId,
    this.vechileNumber,
    this.driverId,
    this.driverName,
    this.driverPhonenumber,
    this.recordDate,
    this.createdBy,
    this.createdByName,
    this.branch,
    this.zone,
    this.errorMessage,
    this.noOfVehicles,
    this.isNew,
    this.latitude,
    this.longitude,
    this.isCapacityAvailable,
    this.inactiveReason,
    this.inactiveBy,
    this.inactiveDate,
    this.standingHours,
    this.capacityAddedDate,
    this.absentDaysStreak,
    this.vehicleServiceType,
    this.idleTime,
    this.currentDate,
    this.availableDate,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        capacityId: json["capacityId"],
        capacityType: json["capacityType"],
        ffVid: json["FFVid"],
        ffVname: json["FFVname"],
        districtId: json["DistrictId"],
        districtName: json["DistrictName"],
        locationId: json["LocationId"],
        locationName: json["LocationName"],
        vechileTypeId: json["VechileTypeId"],
        vechileTypeName: json["VechileTypeName"],
        vechileId: json["VechileId"],
        vechileNumber: json["VechileNumber"],
        driverId: json["DriverId"],
        driverName: json["DriverName"],
        driverPhonenumber: json["DriverPhonenumber"],
        recordDate: json["recordDate"],
        createdBy: json["CreatedBy"],
        createdByName: json["CreatedByName"],
        branch: json["Branch"],
        zone: json["Zone"],
        errorMessage: json["ErrorMessage"],
        noOfVehicles: json["NoOfVehicles"],
        isNew: json["IsNew"],
        latitude: json["Latitude"],
        longitude: json["Longitude"],
        isCapacityAvailable: json["IsCapacityAvailable"],
        inactiveReason: json["inactiveReason"],
        inactiveBy: json["inactiveBy"],
        inactiveDate: json["inactiveDate"] == null
            ? null
            : DateTime.parse(json["inactiveDate"]),
        standingHours: json["StandingHours"],
        capacityAddedDate: json["CapacityAddedDate"] == null
            ? null
            : DateTime.parse(json["CapacityAddedDate"]),
        absentDaysStreak: json["AbsentDaysStreak"],
        vehicleServiceType: json["VehicleServiceType"],
        idleTime: json["IdleTime"],
        currentDate: json["CurrentDate"],
        availableDate: json["AvailableDate"],
      );

  Map<String, dynamic> toJson() => {
        "capacityId": capacityId,
        "capacityType": capacityType,
        "FFVid": ffVid,
        "FFVname": ffVname,
        "DistrictId": districtId,
        "DistrictName": districtName,
        "LocationId": locationId,
        "LocationName": locationName,
        "VechileTypeId": vechileTypeId,
        "VechileTypeName": vechileTypeName,
        "VechileId": vechileId,
        "VechileNumber": vechileNumber,
        "DriverId": driverId,
        "DriverName": driverName,
        "DriverPhonenumber": driverPhonenumber,
        "recordDate": recordDate,
        "CreatedBy": createdBy,
        "CreatedByName": createdByName,
        "Branch": branch,
        "Zone": zone,
        "ErrorMessage": errorMessage,
        "NoOfVehicles": noOfVehicles,
        "IsNew": isNew,
        "Latitude": latitude,
        "Longitude": longitude,
        "IsCapacityAvailable": isCapacityAvailable,
        "inactiveReason": inactiveReason,
        "inactiveBy": inactiveBy,
        "inactiveDate": inactiveDate?.toIso8601String(),
        "StandingHours": standingHours,
        "CapacityAddedDate": capacityAddedDate?.toIso8601String(),
        "AbsentDaysStreak": absentDaysStreak,
        "VehicleServiceType": vehicleServiceType,
        "IdleTime": idleTime,
        "CurrentDate": currentDate,
        "AvailableDate": availableDate,
      };
}
