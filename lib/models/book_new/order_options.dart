// To parse this JSON data, do
//
//     final orderOptionsModel = orderOptionsModelFromJson(jsonString);

import 'dart:convert';

OrderOptionsModel orderOptionsModelFromJson(String str) =>
    OrderOptionsModel.fromJson(json.decode(str));

String orderOptionsModelToJson(OrderOptionsModel data) =>
    json.encode(data.toJson());

class OrderOptionsModel {
  String? message;
  bool? success;
  Data? data;
  dynamic code;

  OrderOptionsModel({
    this.message,
    this.success,
    this.data,
    this.code,
  });

  factory OrderOptionsModel.fromJson(Map<String, dynamic> json) =>
      OrderOptionsModel(
        message: json["Message"],
        success: json["Success"],
        data: json["Data"] == null ? null : Data.fromJson(json["Data"]),
        code: json["Code"],
      );

  Map<String, dynamic> toJson() => {
        "Message": message,
        "Success": success,
        "Data": data?.toJson(),
        "Code": code,
      };
}

class Data {
  List<AssociateList>? serviceTypeList;
  List<AssociateList>? serviceClassList;
  List<AssociateList>? vehicleTypeList;
  List<AssociateList>? paymentModeList;
  List<AssociateList>? pickupWindowList;
  List<AssociateList>? customerList;
  List<AssociateList>? associateList;
  List<AssociateList>? customerListforBooking;
  List<AssociateList>? lclOrderTypes;
  List<AssociateList>? lclExpressSubServiceTypes;

  Data({
    this.serviceTypeList,
    this.serviceClassList,
    this.vehicleTypeList,
    this.paymentModeList,
    this.pickupWindowList,
    this.customerList,
    this.associateList,
    this.customerListforBooking,
    this.lclOrderTypes,
    this.lclExpressSubServiceTypes,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        serviceTypeList: json["ServiceTypeList"] == null
            ? []
            : List<AssociateList>.from(
                json["ServiceTypeList"]!.map((x) => AssociateList.fromJson(x))),
        serviceClassList: json["ServiceClassList"] == null
            ? []
            : List<AssociateList>.from(json["ServiceClassList"]!
                .map((x) => AssociateList.fromJson(x))),
        vehicleTypeList: json["VehicleTypeList"] == null
            ? []
            : List<AssociateList>.from(
                json["VehicleTypeList"]!.map((x) => AssociateList.fromJson(x))),
        paymentModeList: json["PaymentModeList"] == null
            ? []
            : List<AssociateList>.from(
                json["PaymentModeList"]!.map((x) => AssociateList.fromJson(x))),
        pickupWindowList: json["PickupWindowList"] == null
            ? []
            : List<AssociateList>.from(json["PickupWindowList"]!
                .map((x) => AssociateList.fromJson(x))),
        customerList: json["CustomerList"] == null
            ? []
            : List<AssociateList>.from(
                json["CustomerList"]!.map((x) => AssociateList.fromJson(x))),
        associateList: json["AssociateList"] == null
            ? []
            : List<AssociateList>.from(
                json["AssociateList"]!.map((x) => AssociateList.fromJson(x))),
        customerListforBooking: json["CustomerListforBooking"] == null
            ? []
            : List<AssociateList>.from(json["CustomerListforBooking"]!
                .map((x) => AssociateList.fromJson(x))),
        lclOrderTypes: json["LCLOrderTypes"] == null
            ? []
            : List<AssociateList>.from(
                json["LCLOrderTypes"]!.map((x) => AssociateList.fromJson(x))),
        lclExpressSubServiceTypes: json["LCLExpressSubServiceTypes"] == null
            ? []
            : List<AssociateList>.from(json["LCLExpressSubServiceTypes"]!
                .map((x) => AssociateList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "ServiceTypeList": serviceTypeList == null
            ? []
            : List<dynamic>.from(serviceTypeList!.map((x) => x.toJson())),
        "ServiceClassList": serviceClassList == null
            ? []
            : List<dynamic>.from(serviceClassList!.map((x) => x.toJson())),
        "VehicleTypeList": vehicleTypeList == null
            ? []
            : List<dynamic>.from(vehicleTypeList!.map((x) => x.toJson())),
        "PaymentModeList": paymentModeList == null
            ? []
            : List<dynamic>.from(paymentModeList!.map((x) => x.toJson())),
        "PickupWindowList": pickupWindowList == null
            ? []
            : List<dynamic>.from(pickupWindowList!.map((x) => x.toJson())),
        "CustomerList": customerList == null
            ? []
            : List<dynamic>.from(customerList!.map((x) => x.toJson())),
        "AssociateList": associateList == null
            ? []
            : List<dynamic>.from(associateList!.map((x) => x.toJson())),
        "CustomerListforBooking": customerListforBooking == null
            ? []
            : List<dynamic>.from(
                customerListforBooking!.map((x) => x.toJson())),
        "LCLOrderTypes": lclOrderTypes == null
            ? []
            : List<dynamic>.from(lclOrderTypes!.map((x) => x.toJson())),
        "LCLExpressSubServiceTypes": lclExpressSubServiceTypes == null
            ? []
            : List<dynamic>.from(
                lclExpressSubServiceTypes!.map((x) => x.toJson())),
      };
}

class AssociateList {
  dynamic address;
  int? lookupId;
  String? lookupName;
  double? lookupNameCaption;
  int? codeMasterId;
  CodeMasterName? codeMasterName;
  bool? disabled;
  dynamic controllable;
  Poc? poc;
  dynamic pocContactNumber;
  dynamic amount;
  dynamic name;
  ProductType? productType;
  bool? isAsnUploadAllowed;
  dynamic id;
  String? vcServiceTypeIds;
  String? customerCategory;

  AssociateList({
    this.address,
    this.lookupId,
    this.lookupName,
    this.lookupNameCaption,
    this.codeMasterId,
    this.codeMasterName,
    this.disabled,
    this.controllable,
    this.poc,
    this.pocContactNumber,
    this.amount,
    this.name,
    this.productType,
    this.isAsnUploadAllowed,
    this.id,
    this.vcServiceTypeIds,
    this.customerCategory,
  });

  factory AssociateList.fromJson(Map<String, dynamic> json) => AssociateList(
        address: json["Address"],
        lookupId: json["LookupId"],
        lookupName: json["LookupName"],
        lookupNameCaption: json["LookupNameCaption"]?.toDouble(),
        codeMasterId: json["CodeMasterId"],
        // codeMasterName: codeMasterNameValues.map[json["CodeMasterName"]]!,
        disabled: json["Disabled"],
        controllable: json["Controllable"],
        // poc: pocValues.map[json["POC"]]!,
        pocContactNumber: json["POCContactNumber"],
        amount: json["Amount"],
        name: json["Name"],
        // productType: productTypeValues.map[json["product_type"]]!,
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
        "CodeMasterName": codeMasterNameValues.reverse[codeMasterName],
        "Disabled": disabled,
        "Controllable": controllable,
        "POC": pocValues.reverse[poc],
        "POCContactNumber": pocContactNumber,
        "Amount": amount,
        "Name": name,
        "product_type": productTypeValues.reverse[productType],
        "IsASNUploadAllowed": isAsnUploadAllowed,
        "Id": id,
        "vc_service_type_ids": vcServiceTypeIds,
        "CustomerCategory": customerCategory,
      };
}

enum CodeMasterName {
  CASH,
  CREDIT,
  EMPTY,
  LCL_ORDER_TYPES,
  LCL_SUB_SERVICE_TYPES_EXPRESS,
  MODE,
  ORDERS_PAYMENT_MODE,
  ORDER_TYPE,
  PICKUP_WINDOW
}

final codeMasterNameValues = EnumValues({
  "Cash": CodeMasterName.CASH,
  "Credit": CodeMasterName.CREDIT,
  "": CodeMasterName.EMPTY,
  "LCL Order Types": CodeMasterName.LCL_ORDER_TYPES,
  "LCL Sub Service Types - Express":
      CodeMasterName.LCL_SUB_SERVICE_TYPES_EXPRESS,
  "Mode": CodeMasterName.MODE,
  "Orders Payment Mode": CodeMasterName.ORDERS_PAYMENT_MODE,
  "Order Type": CodeMasterName.ORDER_TYPE,
  "Pickup Window": CodeMasterName.PICKUP_WINDOW
});

enum Poc {
  BOTH_LSP,
  HIGH_VALUE_GOODS,
  LARGE_CAP,
  LSP,
  LSP_FCL,
  LSP_LCL,
  MEDIUM_CAP,
  SMALL_CAP
}

final pocValues = EnumValues({
  "Both (LSP)": Poc.BOTH_LSP,
  "High Value Goods": Poc.HIGH_VALUE_GOODS,
  "Large Cap": Poc.LARGE_CAP,
  "LSP": Poc.LSP,
  "LSP FCL": Poc.LSP_FCL,
  "LSP LCL": Poc.LSP_LCL,
  "Medium Cap": Poc.MEDIUM_CAP,
  "Small Cap": Poc.SMALL_CAP
});

enum ProductType { BOTH, FCL, LCL }

final productTypeValues = EnumValues(
    {"Both": ProductType.BOTH, "FCL": ProductType.FCL, "LCL": ProductType.LCL});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
