// To parse this JSON data, do
//
//     final lclCapacityModel = lclCapacityModelFromJson(jsonString);

import 'dart:convert';

LclCapacityModel lclCapacityModelFromJson(String str) =>
    LclCapacityModel.fromJson(json.decode(str));

String lclCapacityModelToJson(LclCapacityModel data) =>
    json.encode(data.toJson());

class LclCapacityModel {
  String? message;
  bool? success;
  List<Datum>? data;
  dynamic code;

  LclCapacityModel({
    this.message,
    this.success,
    this.data,
    this.code,
  });

  factory LclCapacityModel.fromJson(Map<String, dynamic> json) =>
      LclCapacityModel(
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
  CapacityType? capacityType;
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
  DriverName? driverName;
  DriverPhonenumber? driverPhonenumber;
  dynamic recordDate;
  dynamic createdBy;
  dynamic createdByName;
  Branch? branch;
  Branch? zone;
  dynamic errorMessage;
  int? noOfVehicles;
  dynamic isNew;
  String? latitude;
  String? longitude;
  bool? isCapacityAvailable;
  String? inactiveReason;
  String? inactiveBy;
  DateTime? inactiveDate;
  int? standingHours;
  DateTime? capacityAddedDate;
  int? absentDaysStreak;
  VehicleServiceType? vehicleServiceType;
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
        capacityType: capacityTypeValues.map[json["capacityType"]]!,
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
        driverName: driverNameValues.map[json["DriverName"]]!,
        driverPhonenumber:
            driverPhonenumberValues.map[json["DriverPhonenumber"]]!,
        recordDate: json["recordDate"],
        createdBy: json["CreatedBy"],
        createdByName: json["CreatedByName"],
        branch: branchValues.map[json["Branch"]]!,
        zone: branchValues.map[json["Zone"]]!,
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
        vehicleServiceType:
            vehicleServiceTypeValues.map[json["VehicleServiceType"]]!,
        idleTime: json["IdleTime"],
        currentDate: json["CurrentDate"],
        availableDate: json["AvailableDate"],
      );

  Map<String, dynamic> toJson() => {
        "capacityId": capacityId,
        "capacityType": capacityTypeValues.reverse[capacityType],
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
        "DriverName": driverNameValues.reverse[driverName],
        "DriverPhonenumber": driverPhonenumberValues.reverse[driverPhonenumber],
        "recordDate": recordDate,
        "CreatedBy": createdBy,
        "CreatedByName": createdByName,
        "Branch": branchValues.reverse[branch],
        "Zone": branchValues.reverse[zone],
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
        "VehicleServiceType":
            vehicleServiceTypeValues.reverse[vehicleServiceType],
        "IdleTime": idleTime,
        "CurrentDate": currentDate,
        "AvailableDate": availableDate,
      };
}

enum Branch { LUCKNOW, MUMBAI, NO_GPS }

final branchValues = EnumValues({
  "LUCKNOW": Branch.LUCKNOW,
  "MUMBAI": Branch.MUMBAI,
  "NO GPS": Branch.NO_GPS
});

enum CapacityType { DEDICATED }

final capacityTypeValues = EnumValues({"Dedicated": CapacityType.DEDICATED});

enum DriverName { ANGSUL_BASAK, EMPTY }

final driverNameValues = EnumValues(
    {"Angsul Basak": DriverName.ANGSUL_BASAK, "-": DriverName.EMPTY});

enum DriverPhonenumber { EMPTY, THE_7003923267 }

final driverPhonenumberValues = EnumValues({
  "-": DriverPhonenumber.EMPTY,
  "7003923267": DriverPhonenumber.THE_7003923267
});

enum VehicleServiceType { LCL }

final vehicleServiceTypeValues = EnumValues({"LCL": VehicleServiceType.LCL});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
