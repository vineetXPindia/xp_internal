// To parse this JSON data, do
//
//     final rescheduleOrdersModel = rescheduleOrdersModelFromJson(jsonString);

import 'dart:convert';

RescheduleOrdersModel rescheduleOrdersModelFromJson(String str) =>
    RescheduleOrdersModel.fromJson(json.decode(str));

String rescheduleOrdersModelToJson(RescheduleOrdersModel data) =>
    json.encode(data.toJson());

class RescheduleOrdersModel {
  String? message;
  bool? success;
  List<Datum>? data;
  dynamic code;

  RescheduleOrdersModel({
    this.message,
    this.success,
    this.data,
    this.code,
  });

  factory RescheduleOrdersModel.fromJson(Map<String, dynamic> json) =>
      RescheduleOrdersModel(
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
        "Data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "Code": code,
      };
}

class Datum {
  int? orderId;
  String? orderIdCode;
  int? customerId;
  bool? confirmed;
  bool? rejected;
  bool? rescheduled;
  int? branchId;
  Branch? branchName;
  int? zoneId;
  Branch? zone;
  int? originId;
  String? origin;
  int? destinationId;
  String? destination;
  ServiceType? serviceType;
  PaymentMode? serviceClass;
  int? orderDetailId;
  DateTime? pickupDate;
  DateTime? fromPickUpTime;
  DateTime? toPickUpTime;
  String? from;
  String? to;
  String? customerName;
  VehicleTypeName? vehicleType;
  int? vehicleId;
  String? vehicleNumber;
  // int? payload;
  DateTime? edd;
  PaymentMode? paymentMode;
  double? amount;
  DateTime? createdDate;

  Datum({
    this.orderId,
    this.orderIdCode,
    this.customerId,
    this.confirmed,
    this.rejected,
    this.rescheduled,
    this.branchId,
    this.branchName,
    this.zoneId,
    this.zone,
    this.originId,
    this.origin,
    this.destinationId,
    this.destination,
    this.serviceType,
    this.serviceClass,
    this.orderDetailId,
    this.pickupDate,
    this.fromPickUpTime,
    this.toPickUpTime,
    this.from,
    this.to,
    this.customerName,
    this.vehicleType,
    this.vehicleId,
    this.vehicleNumber,
    // this.payload,
    this.edd,
    this.paymentMode,
    this.amount,
    this.createdDate,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        orderId: json["OrderId"],
        orderIdCode: json["OrderIdCode"],
        customerId: json["CustomerId"],
        confirmed: json["Confirmed"],
        rejected: json["Rejected"],
        rescheduled: json["Rescheduled"],
        branchId: json["BranchId"],
        branchName: branchValues.map[json["Branch"]],
        zoneId: json["ZoneId"],
        zone: branchValues.map[json["Zone"]],
        originId: json["OriginId"],
        origin: json["Origin"],
        destinationId: json["DestinationId"],
        destination: json["Destination"],
        serviceType: serviceTypeValues.map[json["ServiceType"]],
        serviceClass: paymentModeValues.map[json["ServiceClass"]]!,
        orderDetailId: json["OrderDetailId"],
        pickupDate: json["PickupDate"] == null
            ? null
            : DateTime.parse(json["PickupDate"]),
        fromPickUpTime: json["FromPickUpTime"] == null
            ? null
            : DateTime.parse(json["FromPickUpTime"]),
        toPickUpTime: json["ToPickUpTime"] == null
            ? null
            : DateTime.parse(json["ToPickUpTime"]),
        from: json["From"],
        to: json["To"],
        customerName: json["CustomerName"],
        vehicleType: vehicleTypeNameValues.map[json["VehicleTypeName"]]!,
        vehicleId: json["VehicleId"],
        vehicleNumber: json["VehicleNumber"],
        // payload: json["Payload"],
        edd: json["Edd"] == null ? null : DateTime.parse(json["Edd"]),
        paymentMode: paymentModeValues.map[json["PaymentMode"]]!,
        amount: json["Amount"]?.toDouble(),
        createdDate: json["CreatedDate"] == null
            ? null
            : DateTime.parse(json["CreatedDate"]),
      );

  Map<String, dynamic> toJson() => {
        "OrderId": orderId,
        "OrderIdCode": orderIdCode,
        "CustomerId": customerId,
        "Confirmed": confirmed,
        "Rejected": rejected,
        "Rescheduled": rescheduled,
        "BranchId": branchId,
        "Branch": branchValues.reverse[branchName],
        "ZoneId": zoneId,
        "Zone": branchValues.reverse[zone],
        "OriginId": originId,
        "Origin": origin,
        "DestinationId": destinationId,
        "Destination": destination,
        "ServiceType": serviceTypeValues.reverse[serviceType],
        "ServiceClass": paymentModeValues.reverse[serviceClass],
        "OrderDetailId": orderDetailId,
        "PickupDate": pickupDate?.toIso8601String(),
        "FromPickUpTime": fromPickUpTime?.toIso8601String(),
        "ToPickUpTime": toPickUpTime?.toIso8601String(),
        "From": from,
        "To": to,
        "CustomerName": customerName,
        "VehicleTypeName": vehicleTypeNameValues.reverse[vehicleType],
        "VehicleId": vehicleId,
        "VehicleNumber": vehicleNumber,
        // "Payload": payload,
        "Edd": edd?.toIso8601String(),
        "PaymentMode": paymentModeValues.reverse[paymentMode],
        "Amount": amount,
        "CreatedDate": createdDate?.toIso8601String(),
      };
}

enum Branch {
  AHMEDABAD,
  ALLAHABAD,
  AMBALA,
  BADDI,
  BANGALORE,
  BATHINDA,
  BHUBANESHWAR,
  CHENNAI,
  COCHIN,
  COIMBATORE,
  DEHRADUN,
  DELHI,
  GOA,
  GURGAON,
  GUWAHATI,
  HISAR,
  HUBLI,
  HYDERABAD,
  INDORE,
  JAIPUR,
  JAMMU,
  JODHPUR,
  KOLKATA,
  LUCKNOW,
  LUDHIANA,
  MADURAI,
  MEERUT,
  MUMBAI,
  NAGPUR,
  PATNA,
  PUNE,
  RAIPUR,
  RANCHI,
  SRINAGAR,
  UDAIPUR,
  VAPI,
  WARANGAL
}

final branchValues = EnumValues({
  "AHMEDABAD": Branch.AHMEDABAD,
  "ALLAHABAD": Branch.ALLAHABAD,
  "AMBALA": Branch.AMBALA,
  "BADDI": Branch.BADDI,
  "BANGALORE": Branch.BANGALORE,
  "BATHINDA": Branch.BATHINDA,
  "BHUBANESHWAR": Branch.BHUBANESHWAR,
  "CHENNAI": Branch.CHENNAI,
  "COCHIN": Branch.COCHIN,
  "COIMBATORE": Branch.COIMBATORE,
  "DEHRADUN": Branch.DEHRADUN,
  "DELHI": Branch.DELHI,
  "GOA": Branch.GOA,
  "GURGAON": Branch.GURGAON,
  "GUWAHATI": Branch.GUWAHATI,
  "HISAR": Branch.HISAR,
  "HUBLI": Branch.HUBLI,
  "HYDERABAD": Branch.HYDERABAD,
  "INDORE": Branch.INDORE,
  "JAIPUR": Branch.JAIPUR,
  "JAMMU": Branch.JAMMU,
  "JODHPUR": Branch.JODHPUR,
  "KOLKATA": Branch.KOLKATA,
  "LUCKNOW": Branch.LUCKNOW,
  "LUDHIANA": Branch.LUDHIANA,
  "MADURAI": Branch.MADURAI,
  "MEERUT": Branch.MEERUT,
  "MUMBAI": Branch.MUMBAI,
  "NAGPUR": Branch.NAGPUR,
  "PATNA": Branch.PATNA,
  "PUNE": Branch.PUNE,
  "RAIPUR": Branch.RAIPUR,
  "RANCHI": Branch.RANCHI,
  "SRINAGAR": Branch.SRINAGAR,
  "UDAIPUR": Branch.UDAIPUR,
  "VAPI": Branch.VAPI,
  "WARANGAL": Branch.WARANGAL
});

enum PaymentMode { CASH, CREDIT, EXPRESS, MUMBAI, PAID, PREMIUM, TO_PAY }

final paymentModeValues = EnumValues({
  "Cash": PaymentMode.CASH,
  "Credit": PaymentMode.CREDIT,
  "Express": PaymentMode.EXPRESS,
  "Mumbai": PaymentMode.MUMBAI,
  "Paid": PaymentMode.PAID,
  "Premium": PaymentMode.PREMIUM,
  "To Pay": PaymentMode.TO_PAY
});

enum ServiceType { EXPRESS, FCL_AGGREGATION, FCL_BREAK_BULK, FCL_REGULAR }

final serviceTypeValues = EnumValues({
  "Express": ServiceType.EXPRESS,
  "FCL Aggregation": ServiceType.FCL_AGGREGATION,
  "FCL Break Bulk": ServiceType.FCL_BREAK_BULK,
  "FCL Regular": ServiceType.FCL_REGULAR
});

enum VehicleTypeName {
  EV,
  THE_10_FT_2_MT,
  THE_14_FT_3_MT,
  THE_17_FT_4_MT,
  THE_20_SXL_6_MT,
  THE_22_SXL_8_MT,
  THE_24_SXL_9_MT,
  THE_32_MXL_14_MT,
  THE_32_MXL_17_MT,
  THE_32_MXL_17_MT_HQ,
  THE_32_SXL_7_MT,
  THE_32_SXL_7_MT_HC,
  THE_32_SXL_9_MT,
  THE_32_SXL_9_MT_HC,
  THE_40_FT_24_MT,
  THE_40_FT_24_MT_HC,
  THE_40_FT_28_MT,
  THE_40_FT_28_MT_HC,
  THE_7_FT_08_MT,
  THE_8_FT_1_MT
}

final vehicleTypeNameValues = EnumValues({
  "EV": VehicleTypeName.EV,
  "10FT 2MT": VehicleTypeName.THE_10_FT_2_MT,
  "14FT 3MT": VehicleTypeName.THE_14_FT_3_MT,
  "17FT 4MT": VehicleTypeName.THE_17_FT_4_MT,
  "20SXL 6MT": VehicleTypeName.THE_20_SXL_6_MT,
  "22SXL 8MT": VehicleTypeName.THE_22_SXL_8_MT,
  "24SXL 9MT": VehicleTypeName.THE_24_SXL_9_MT,
  "32MXL 14MT": VehicleTypeName.THE_32_MXL_14_MT,
  "32MXL 17MT": VehicleTypeName.THE_32_MXL_17_MT,
  "32MXL 17MT HQ": VehicleTypeName.THE_32_MXL_17_MT_HQ,
  "32SXL 7MT": VehicleTypeName.THE_32_SXL_7_MT,
  "32SXL 7MT HC": VehicleTypeName.THE_32_SXL_7_MT_HC,
  "32SXL 9MT": VehicleTypeName.THE_32_SXL_9_MT,
  "32SXL 9MT HC": VehicleTypeName.THE_32_SXL_9_MT_HC,
  "40FT 24MT": VehicleTypeName.THE_40_FT_24_MT,
  "40FT 24MT HC": VehicleTypeName.THE_40_FT_24_MT_HC,
  "40FT 28MT": VehicleTypeName.THE_40_FT_28_MT,
  "40FT 28MT HC": VehicleTypeName.THE_40_FT_28_MT_HC,
  "7FT 0.8MT": VehicleTypeName.THE_7_FT_08_MT,
  "8FT 1MT": VehicleTypeName.THE_8_FT_1_MT
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
