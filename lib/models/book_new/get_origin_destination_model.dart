// To parse this JSON data, do
//
//     final getOriginDestinationModel = getOriginDestinationModelFromJson(jsonString);

import 'dart:convert';

GetOriginDestinationModel getOriginDestinationModelFromJson(String str) =>
    GetOriginDestinationModel.fromJson(json.decode(str));

String getOriginDestinationModelToJson(GetOriginDestinationModel data) =>
    json.encode(data.toJson());

class GetOriginDestinationModel {
  String? message;
  bool? success;
  List<Datum>? data;
  dynamic code;

  GetOriginDestinationModel({
    this.message,
    this.success,
    this.data,
    this.code,
  });

  factory GetOriginDestinationModel.fromJson(Map<String, dynamic> json) =>
      GetOriginDestinationModel(
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
  dynamic address;
  int? lookupId;
  String? lookupName;
  dynamic lookupNameCaption;
  dynamic codeMasterId;
  CodeMasterName? codeMasterName;
  bool? disabled;
  dynamic controllable;
  dynamic poc;
  dynamic pocContactNumber;
  dynamic amount;
  dynamic name;
  dynamic productType;
  dynamic isAsnUploadAllowed;
  int? id;
  dynamic vcServiceTypeIds;
  dynamic customerCategory;

  Datum({
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

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        address: json["Address"],
        lookupId: json["LookupId"],
        lookupName: json["LookupName"],
        lookupNameCaption: json["LookupNameCaption"],
        codeMasterId: json["CodeMasterId"],
        codeMasterName: codeMasterNameValues.map[json["CodeMasterName"]]!,
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
        "CodeMasterName": codeMasterNameValues.reverse[codeMasterName],
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

enum CodeMasterName { LOCATION }

final codeMasterNameValues = EnumValues({"Location": CodeMasterName.LOCATION});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
