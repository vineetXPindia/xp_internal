// To parse this JSON data, do
//
//     final loginDataModel = loginDataModelFromJson(jsonString);

import 'dart:convert';

LoginDataModel loginDataModelFromJson(String str) =>
    LoginDataModel.fromJson(json.decode(str));

String loginDataModelToJson(LoginDataModel data) => json.encode(data.toJson());

class LoginDataModel {
  String? message;
  bool? success;
  Data? data;
  dynamic code;

  LoginDataModel({
    this.message,
    this.success,
    this.data,
    this.code,
  });

  factory LoginDataModel.fromJson(Map<String, dynamic> json) => LoginDataModel(
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
  String? userId;
  dynamic dbUserId;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  dynamic testingPhone;
  String? authToken;
  dynamic userStatus;
  String? userType;
  dynamic role;
  bool? isAdmin;
  bool? isAssociate;
  dynamic dateOfBirth;
  DateTime? dateOfJoining;
  List<Permission>? permissions;
  dynamic ffvId;
  String? code;
  dynamic profilePicUrl;
  List<dynamic>? branches;
  dynamic paymentMode;
  bool? selfRegistered;
  dynamic showXpcnFreightDetails;
  bool? administrator;
  dynamic productType;
  dynamic vehicleNumber;
  List<PermissionType>? permissionType;

  Data({
    this.userId,
    this.dbUserId,
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.testingPhone,
    this.authToken,
    this.userStatus,
    this.userType,
    this.role,
    this.isAdmin,
    this.isAssociate,
    this.dateOfBirth,
    this.dateOfJoining,
    this.permissions,
    this.ffvId,
    this.code,
    this.profilePicUrl,
    this.branches,
    this.paymentMode,
    this.selfRegistered,
    this.showXpcnFreightDetails,
    this.administrator,
    this.productType,
    this.vehicleNumber,
    this.permissionType,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        userId: json["UserId"],
        dbUserId: json["DBUserId"],
        firstName: json["FirstName"],
        lastName: json["LastName"],
        email: json["Email"],
        phone: json["Phone"],
        testingPhone: json["TestingPhone"],
        authToken: json["AuthToken"],
        userStatus: json["UserStatus"],
        userType: json["UserType"],
        role: json["Role"],
        isAdmin: json["IsAdmin"],
        isAssociate: json["IsAssociate"],
        dateOfBirth: json["DateOfBirth"],
        dateOfJoining: json["DateOfJoining"] == null
            ? null
            : DateTime.parse(json["DateOfJoining"]),
        permissions: json["Permissions"] == null
            ? []
            : List<Permission>.from(
                json["Permissions"]!.map((x) => Permission.fromJson(x))),
        ffvId: json["FfvId"],
        code: json["Code"],
        profilePicUrl: json["ProfilePicUrl"],
        branches: json["Branches"] == null
            ? []
            : List<dynamic>.from(json["Branches"]!.map((x) => x)),
        paymentMode: json["PaymentMode"],
        selfRegistered: json["SelfRegistered"],
        showXpcnFreightDetails: json["ShowXPCNFreightDetails"],
        administrator: json["Administrator"],
        productType: json["ProductType"],
        vehicleNumber: json["VehicleNumber"],
        permissionType: json["PermissionType"] == null
            ? []
            : List<PermissionType>.from(
                json["PermissionType"]!.map((x) => PermissionType.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "UserId": userId,
        "DBUserId": dbUserId,
        "FirstName": firstName,
        "LastName": lastName,
        "Email": email,
        "Phone": phone,
        "TestingPhone": testingPhone,
        "AuthToken": authToken,
        "UserStatus": userStatus,
        "UserType": userType,
        "Role": role,
        "IsAdmin": isAdmin,
        "IsAssociate": isAssociate,
        "DateOfBirth": dateOfBirth,
        "DateOfJoining": dateOfJoining?.toIso8601String(),
        "Permissions": permissions == null
            ? []
            : List<dynamic>.from(permissions!.map((x) => x.toJson())),
        "FfvId": ffvId,
        "Code": code,
        "ProfilePicUrl": profilePicUrl,
        "Branches":
            branches == null ? [] : List<dynamic>.from(branches!.map((x) => x)),
        "PaymentMode": paymentMode,
        "SelfRegistered": selfRegistered,
        "ShowXPCNFreightDetails": showXpcnFreightDetails,
        "Administrator": administrator,
        "ProductType": productType,
        "VehicleNumber": vehicleNumber,
        "PermissionType": permissionType == null
            ? []
            : List<dynamic>.from(permissionType!.map((x) => x.toJson())),
      };
}

class PermissionType {
  dynamic permissionId;
  dynamic permissionName;

  PermissionType({
    this.permissionId,
    this.permissionName,
  });

  factory PermissionType.fromJson(Map<String, dynamic> json) => PermissionType(
        permissionId: json["PermissionId"],
        permissionName: json["PermissionName"],
      );

  Map<String, dynamic> toJson() => {
        "PermissionId": permissionId,
        "PermissionName": permissionName,
      };
}

class Permission {
  int? rowNumber;
  int? screenId;
  ModuleName? moduleName;
  String? screenName;
  bool? isCreate;
  bool? isRead;
  bool? isUpdate;
  bool? isDelete;
  bool? isAllow;
  bool? isUserOtp;
  bool? isAdminOtp;
  int? permissionId;
  int? roleId;
  dynamic roleName;
  bool? create;
  bool? read;
  bool? update;
  bool? delete;
  bool? allow;
  bool? userOtp;
  bool? adminOtp;
  String? allowText;
  bool? screenIsLcl;

  Permission({
    this.rowNumber,
    this.screenId,
    this.moduleName,
    this.screenName,
    this.isCreate,
    this.isRead,
    this.isUpdate,
    this.isDelete,
    this.isAllow,
    this.isUserOtp,
    this.isAdminOtp,
    this.permissionId,
    this.roleId,
    this.roleName,
    this.create,
    this.read,
    this.update,
    this.delete,
    this.allow,
    this.userOtp,
    this.adminOtp,
    this.allowText,
    this.screenIsLcl,
  });

  factory Permission.fromJson(Map<String, dynamic> json) => Permission(
        rowNumber: json["RowNumber"],
        screenId: json["ScreenId"],
        moduleName: moduleNameValues.map[json["ModuleName"]]!,
        screenName: json["ScreenName"],
        isCreate: json["IsCreate"],
        isRead: json["IsRead"],
        isUpdate: json["IsUpdate"],
        isDelete: json["IsDelete"],
        isAllow: json["IsAllow"],
        isUserOtp: json["IsUserOTP"],
        isAdminOtp: json["IsAdminOTP"],
        permissionId: json["PermissionId"],
        roleId: json["RoleId"],
        roleName: json["RoleName"],
        create: json["Create"],
        read: json["Read"],
        update: json["Update"],
        delete: json["Delete"],
        allow: json["Allow"],
        userOtp: json["UserOTP"],
        adminOtp: json["AdminOTP"],
        allowText: json["AllowText"],
        screenIsLcl: json["ScreenIsLCL"],
      );

  Map<String, dynamic> toJson() => {
        "RowNumber": rowNumber,
        "ScreenId": screenId,
        "ModuleName": moduleNameValues.reverse[moduleName],
        "ScreenName": screenName,
        "IsCreate": isCreate,
        "IsRead": isRead,
        "IsUpdate": isUpdate,
        "IsDelete": isDelete,
        "IsAllow": isAllow,
        "IsUserOTP": isUserOtp,
        "IsAdminOTP": isAdminOtp,
        "PermissionId": permissionId,
        "RoleId": roleId,
        "RoleName": roleName,
        "Create": create,
        "Read": read,
        "Update": update,
        "Delete": delete,
        "Allow": allow,
        "UserOTP": userOtp,
        "AdminOTP": adminOtp,
        "AllowText": allowText,
        "ScreenIsLCL": screenIsLcl,
      };
}

enum ModuleName {
  ADMIN,
  APPROVALS,
  CAPACITY,
  CUSTOMERS,
  DASBHOARD,
  FFV,
  FINANCE,
  LOAD_BOARD,
  MESSAGE_CENTER,
  NOTIFICATION_CENTER,
  OPERATIONS,
  OPERATIONS_LCL,
  OPERATION_LCL,
  ORDERS,
  SERVICE,
  TICKETS
}

final moduleNameValues = EnumValues({
  "Admin": ModuleName.ADMIN,
  "Approvals": ModuleName.APPROVALS,
  "Capacity": ModuleName.CAPACITY,
  "Customers": ModuleName.CUSTOMERS,
  "Dasbhoard": ModuleName.DASBHOARD,
  "FFV": ModuleName.FFV,
  "Finance": ModuleName.FINANCE,
  "Load Board": ModuleName.LOAD_BOARD,
  "Message Center": ModuleName.MESSAGE_CENTER,
  "Notification Center": ModuleName.NOTIFICATION_CENTER,
  "Operations": ModuleName.OPERATIONS,
  "Operations LCL": ModuleName.OPERATIONS_LCL,
  "Operation LCL": ModuleName.OPERATION_LCL,
  "Orders": ModuleName.ORDERS,
  "Service": ModuleName.SERVICE,
  "Tickets": ModuleName.TICKETS
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
