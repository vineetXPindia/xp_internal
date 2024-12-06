// To parse this JSON data, do
//
//     final raisedTicketsModel = raisedTicketsModelFromJson(jsonString);

import 'dart:convert';

RaisedTicketsModel raisedTicketsModelFromJson(String str) =>
    RaisedTicketsModel.fromJson(json.decode(str));

String raisedTicketsModelToJson(RaisedTicketsModel data) =>
    json.encode(data.toJson());

class RaisedTicketsModel {
  bool? success;
  String? message;
  List<Datum>? data;
  dynamic code;

  RaisedTicketsModel({
    this.success,
    this.message,
    this.data,
    this.code,
  });

  factory RaisedTicketsModel.fromJson(Map<String, dynamic> json) =>
      RaisedTicketsModel(
        success: json["Success"],
        message: json["Message"],
        data: json["Data"] == null
            ? []
            : List<Datum>.from(json["Data"]!.map((x) => Datum.fromJson(x))),
        code: json["Code"],
      );

  Map<String, dynamic> toJson() => {
        "Success": success,
        "Message": message,
        "Data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "Code": code,
      };
}

class Datum {
  int? userId;
  int? intRaiseTicketNo;
  String? ticketNo;
  String? userName;
  String? panel;
  String? subPanel;
  String? description;
  DateTime? createDate;
  String? ticketUrl;
  int? status;
  int? priority;
  String? remarks;
  String? assignedTo;
  bool? deleteStatus;
  String? assignedBy;
  DateTime? assignedDate;
  DateTime? startDate;
  DateTime? completeDate;
  DateTime? validationDate;
  bool? startDateStatus;
  bool? completeStatus;
  bool? validateStatus;
  String? validationDoneBy;
  String? cancelledby;
  int? totalRecords;
  dynamic validateImageUrl;
  dynamic validateRemarks;

  Datum({
    this.userId,
    this.intRaiseTicketNo,
    this.ticketNo,
    this.userName,
    this.panel,
    this.subPanel,
    this.description,
    this.createDate,
    this.ticketUrl,
    this.status,
    this.priority,
    this.remarks,
    this.assignedTo,
    this.deleteStatus,
    this.assignedBy,
    this.assignedDate,
    this.startDate,
    this.completeDate,
    this.validationDate,
    this.startDateStatus,
    this.completeStatus,
    this.validateStatus,
    this.validationDoneBy,
    this.cancelledby,
    this.totalRecords,
    this.validateImageUrl,
    this.validateRemarks,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        userId: json["UserID"],
        intRaiseTicketNo: json["intRaiseTicketNo"],
        ticketNo: json["ticketNo"],
        userName: json["userName"],
        panel: json["panel"],
        subPanel: json["subPanel"],
        description: json["description"],
        createDate: json["createDate"] == null
            ? null
            : DateTime.parse(json["createDate"]),
        ticketUrl: json["TicketUrl"],
        status: json["status"],
        priority: json["priority"],
        remarks: json["remarks"],
        assignedTo: json["assignedTo"],
        deleteStatus: json["deleteStatus"],
        assignedBy: json["assignedBy"],
        assignedDate: json["assignedDate"] == null
            ? null
            : DateTime.parse(json["assignedDate"]),
        startDate: json["startDate"] == null
            ? null
            : DateTime.parse(json["startDate"]),
        completeDate: json["completeDate"] == null
            ? null
            : DateTime.parse(json["completeDate"]),
        validationDate: json["validationDate"] == null
            ? null
            : DateTime.parse(json["validationDate"]),
        startDateStatus: json["startDateStatus"],
        completeStatus: json["completeStatus"],
        validateStatus: json["validateStatus"],
        validationDoneBy: json["validationDoneBy"],
        cancelledby: json["cancelledby"],
        totalRecords: json["totalRecords"],
        validateImageUrl: json["validateImageUrl"],
        validateRemarks: json["validateRemarks"],
      );

  Map<String, dynamic> toJson() => {
        "UserID": userId,
        "intRaiseTicketNo": intRaiseTicketNo,
        "ticketNo": ticketNo,
        "userName": userName,
        "panel": panel,
        "subPanel": subPanel,
        "description": description,
        "createDate": createDate?.toIso8601String(),
        "TicketUrl": ticketUrl,
        "status": status,
        "priority": priority,
        "remarks": remarks,
        "assignedTo": assignedTo,
        "deleteStatus": deleteStatus,
        "assignedBy": assignedBy,
        "assignedDate": assignedDate?.toIso8601String(),
        "startDate": startDate?.toIso8601String(),
        "completeDate": completeDate?.toIso8601String(),
        "validationDate": validationDate?.toIso8601String(),
        "startDateStatus": startDateStatus,
        "completeStatus": completeStatus,
        "validateStatus": validateStatus,
        "validationDoneBy": validationDoneBy,
        "cancelledby": cancelledby,
        "totalRecords": totalRecords,
        "validateImageUrl": validateImageUrl,
        "validateRemarks": validateRemarks,
      };
}
