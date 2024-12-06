import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xp_internal/constants/colors.dart';
import 'package:xp_internal/models/Capacity/capacity_at_unloading.dart';
import 'package:xp_internal/models/Capacity/future_capacity_model.dart';
import 'package:xp_internal/models/Capacity/available_capacity_model.dart';
import 'package:xp_internal/models/Capacity/lcl_capacity/get_lcl_capacity.dart';
import 'package:xp_internal/models/login_model.dart';

import 'package:http/http.dart' as http;

class CapacityPage extends StatefulWidget {
  const CapacityPage({super.key});

  @override
  State<CapacityPage> createState() => _CapacityPageState();
}

class _CapacityPageState extends State<CapacityPage> {
  List<bool> selectedService = <bool>[true, false];
  CapacityModel? availableCapacity;
  CapacityUnloadingModel? capacityAtUnloading;
  FutureCapacityModel? futureCapacity;

  LclCapacityModel? lclCapacity;
  String selectedCapacity = 'Available Capacity';
  var optionsList = [
    'Available Capacity',
    'Capacity at Unloading',
    'Future Capacity'
  ];
  bool isLoading = true;
  late String userType;
  late String userId;
  late String authToken;
  late String userName;
  @override
  void initState() {
    super.initState();
    fetchCapacity();
    getLclCapacity();
  }

  ///////////////////////////
  Future<void> initializeUser() async {
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    LoginDataModel loginModel = LoginDataModel();

    var userData = prefs.getString('userResponse');
    if (userData != null && userData.isNotEmpty) {
      loginModel = loginDataModelFromJson(userData.toString());
      String? firstName = loginModel.data?.firstName;
      String? lastName = loginModel.data?.lastName;
      userName = '$firstName $lastName';
      userId = loginModel.data!.userId.toString();
      userType = loginModel.data!.userType.toString();
      authToken = loginModel.data!.authToken.toString();
    }
  }

  Future<void> fetchCapacity() async {
    if (selectedCapacity == 'Available Capacity') {
      await fetchAvailableCapacity();
    } else if (selectedCapacity == 'Capacity at Unloading') {
      await fetchCapacityUnloading();
    } else if (selectedCapacity == 'Future Capacity') {
      await fetchFutureCapacity();
    }
  }

  //method to get available capacity
  Future<void> fetchAvailableCapacity() async {
    WidgetsFlutterBinding.ensureInitialized();
    await initializeUser();
    var headers = {
      "UserType": userType,
      "UserId": userId,
      "AuthToken": authToken,
      "UserName": userName
    };
    var body = {
      "VehicleType": "",
      "FFVType": "",
      "BranchType": "",
      "ZoneType": "",
      "Type": "${1}"
    };
    var response = await http.post(
        Uri.parse('http://qaapi.xpindia.in/api/get-capacity'),
        headers: headers,
        body: body);
    if (response.statusCode == 200) {
      setState(() {
        availableCapacity = capacityModelFromJson(response.body);
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      throw Exception('Unable to load');
    }
  }

  //method to get capacity at unloading
  Future<void> fetchCapacityUnloading() async {
    WidgetsFlutterBinding.ensureInitialized();
    await initializeUser();
    var headers = {
      "UserId": userId,
      "UserType": userType,
      "UserName": userName,
      "AuthToken": authToken,
    };
    var bodyUnloading = {
      "StartIndex": "${1}",
      "PageLength": "${5}",
      "FilterBy": "",
      "Keyword": "",
      "FFVId": "",
      "VehicleTypeId": "",
      "BranchName": ""
    };
    var response = await http.post(
        Uri.parse('http://qaapi.xpindia.in/api/get-capacity-at-unloading'),
        headers: headers,
        body: bodyUnloading);
    if (response.statusCode == 200) {
      setState(() {
        capacityAtUnloading = capacityUnloadingModelFromJson(response.body);
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      throw Exception('Unable to load');
    }
  }

  Future<void> fetchFutureCapacity() async {
    WidgetsFlutterBinding.ensureInitialized();
    await initializeUser();
    var headers = {
      "UserId": userId,
      "UserType": userType,
      "UserName": userName,
      "AuthToken": authToken
    };
    var body = {
      "BranchName": "",
      "FFVId": "",
      "FilterApplied": "N7D",
      "FilterBy": "ANY",
      "Keyword": "",
      "StartIndex": "${1}",
      "PageLength": "${20}",
      "VehicleTypeId": "",
      "ZoneName": ""
    };
    var response = await http.post(
      Uri.parse('http://qaapi.xpindia.in/api/get-capacity-for-future'),
      headers: headers,
      body: body,
    );
    if (response.statusCode == 200) {
      setState(() {
        futureCapacity = futureCapacityModelFromJson(response.body);
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      throw Exception('Unable to Load');
    }
  }

  Future<void> getLclCapacity() async {
    WidgetsFlutterBinding.ensureInitialized();
    await initializeUser();
    var headers = {
      "UserId": userId,
      "UserType": userType,
      "UserName": userName,
      "AuthToken": authToken,
      "Content-Type": "application/json"
    };
    var body = jsonEncode({
      "VehicleType": "",
      "FFVType": "",
      "BranchType": "",
      "IsLclVehicle": true,
      "ZoneType": "",
      "Type": 1
    });
    var response = await http.post(
      Uri.parse('https://qaapi.xpindia.in/api/get-capacity'),
      headers: headers,
      body: body,
    );
    if (response.statusCode == 200) {
      setState(() {
        isLoading = false;
        lclCapacity = lclCapacityModelFromJson(response.body);
        print(response.body);
      });
    } else {
      setState(() {
        isLoading = false;
      });
      throw Exception('Unable to Load');
    }
  }

  Widget build(BuildContext context) {
    final String title = 'Capacity';
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    var itemCount = selectedService[0]
        ? availableCapacity?.data?.length
        : lclCapacity?.data?.length;
    if (selectedCapacity == 'Capacity at Unloading') {
      itemCount = capacityAtUnloading?.data?.length;
    } else if (selectedCapacity == 'Future Capacity') {
      itemCount = futureCapacity?.data?.length;
    }

    final List<Widget> serviceToggle = <Widget>[
      Text('FCL', style: TextStyle(fontWeight: FontWeight.bold)),
      Text('LCL', style: TextStyle(fontWeight: FontWeight.bold))
    ];
    return Scaffold(
      backgroundColor: newCardBG,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        backgroundColor: newCardBG,
        title: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(
            left: screenWidth * 0.05,
            right: screenWidth * 0.05,
            top: screenHeight * 0.02),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(screenWidth * 0.02),
              child: LayoutBuilder(
                builder: (context, constraints) => ToggleButtons(
                  //this toggle is not working
                  constraints: BoxConstraints.expand(
                      width: screenWidth * 0.4, height: screenHeight * 0.05),
                  borderRadius: BorderRadius.all(
                    Radius.circular(screenWidth * 0.04),
                  ),
                  textStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: screenWidth * 0.04,
                  ),
                  selectedColor: Colors.white,
                  fillColor: Colors.blue.shade900.withOpacity(0.7),
                  color: Colors.black,
                  isSelected: selectedService,
                  children: <Widget>[
                    Text('FCL'),
                    Text('LCL'),
                  ],
                  onPressed: (int index) {
                    setState(() {
                      for (int i = 0; i < selectedService.length; i++) {
                        selectedService[i] = i == index;
                      }
                    });
                  },
                ),
              ),
            ),
            SizedBox(
              height: screenHeight * 0.02,
            ),
            selectedService[0]
                ? Container(
                    width: screenWidth,
                    padding: EdgeInsets.only(
                        left: screenWidth * 0.05, right: screenWidth * 0.07),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(screenWidth * 0.04),
                      color: Colors.white,
                    ),
                    child: DropdownButton(
                        isExpanded: true,
                        underline: SizedBox(),
                        dropdownColor: Colors.white,
                        borderRadius: BorderRadius.circular(screenWidth * 0.03),
                        value: selectedCapacity,
                        items: optionsList.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(items),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedCapacity = newValue!;
                          });
                          fetchCapacity();
                        }),
                  )
                : SizedBox(),
            Container(
              margin: EdgeInsets.only(top: screenHeight * 0.02),
              height: screenHeight * 0.07,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(screenWidth * 0.05),
                color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Total ${itemCount ?? " "} :',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text('Dedicated(), ',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('Dynamic()',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            SizedBox(
              height: screenHeight * 0.02,
            ),
            TextField(
              onTapOutside: (event) {
                FocusScope.of(context).unfocus();
              },
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: 'Search by vehicle no. or type',
                hintStyle: TextStyle(color: Colors.black26),
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.black26,
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(screenWidth * 0.04),
                ),
              ),
            ),
            SizedBox(
              height: screenHeight * 0.01,
            ),
            isLoading
                ? Container(
                    padding: EdgeInsets.only(top: screenHeight * 0.1),
                    child: CircularProgressIndicator(
                      color: Colors.blue.shade900,
                    ),
                  )
                : Expanded(
                    child: selectedService[0]
                        ? displayCapacity(screenHeight, screenWidth)
                        : displayLclCapacity(screenHeight, screenWidth),
                  ),
          ],
        ),
      ),
    );
  }

  Widget displayLclCapacity(double screenHeight, double screenWidth) {
    var data = lclCapacity?.data;
    String getDriverName(DriverName? driverName) {
      // Find the key (string name) that corresponds to the given enum value
      return driverNameValues.map.keys.firstWhere(
        (key) => driverNameValues.map[key] == driverName,
        orElse: () => " ", // Fallback if no match is found
      );
    }

    String getBranchName(Branch? branch) {
      return branchValues.map.keys.firstWhere(
          (key) => branchValues.map[key] == branch,
          orElse: () => " ");
    }

    return ListView.builder(
        itemCount: lclCapacity?.data?.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.all(screenWidth * 0.02),
            child: Container(
              padding: EdgeInsets.all(screenWidth * 0.02),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(screenWidth * 0.04),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 2),
                      color: Colors.black12,
                      blurRadius: 5,
                    )
                  ]),
              child: Column(
                children: [
                  infoRow(screenWidth, screenHeight, 'Branch: ',
                      getBranchName(lclCapacity?.data![index].branch)),
                  infoRow(screenWidth, screenHeight, 'FFV Name: ',
                      '${lclCapacity?.data![index].ffVname}'),
                  SizedBox(height: screenHeight * 0.005),
                  Divider(
                    height: screenHeight * 0.01,
                    color: Colors.lightBlueAccent.withOpacity(0.5),
                  ),
                  SizedBox(height: screenHeight * 0.005),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          infoRowLeft('Vehicle Type',
                              '${lclCapacity?.data![index].vechileTypeName}')
                        ],
                      ),
                      Column(
                        children: [
                          infoRowRight('Vehicle Number',
                              '${lclCapacity?.data![index].vechileNumber}')
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.005),
                  Divider(
                    height: screenHeight * 0.01,
                    color: Colors.lightBlueAccent.withOpacity(0.5),
                  ),
                  SizedBox(height: screenHeight * 0.005),
                  infoRow(
                      screenWidth,
                      screenHeight,
                      'Location: ',
                      lclCapacity?.data![index].locationName ??
                          "Not Available"),
                  infoRow(screenWidth, screenHeight, 'Status: ',
                      '${lclCapacity?.data![index].isCapacityAvailable}')
                ],
              ),
            ),
          );
        });
  }

  Widget displayCapacity(double screenHeight, double screenWidth) {
    List<dynamic>? data;
    bool capacityAvailable;
    if (selectedCapacity == 'Available Capacity') {
      data = availableCapacity?.data;
    } else if (selectedCapacity == 'Capacity at Unloading') {
      data = capacityAtUnloading?.data;
    } else if (selectedCapacity == 'Future Capacity') {
      data = futureCapacity?.data;
    }
    return ListView.builder(
      physics: AlwaysScrollableScrollPhysics(),
      itemCount: data?.length ?? 0,
      itemBuilder: (context, index) {
        // var res = selectedValue == 'Available Capacity' ? availableCapacity?.data![index] : capacityAtUnloading?.data![index];
        return Padding(
          padding: EdgeInsets.all(screenWidth * 0.02),
          child: Container(
            padding: EdgeInsets.symmetric(
                vertical: screenHeight * 0.02, horizontal: screenWidth * 0.01),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(screenWidth * 0.05),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      offset: Offset(0, 3),
                      color: Colors.black26,
                      blurRadius: 5)
                ]),
            child: Column(
              children: [
                infoRow(
                  screenWidth,
                  screenHeight,
                  "FFV Name",
                  '${data?[index].ffvName}',
                ),
                SizedBox(
                  height: screenHeight * 0.005,
                ),
                Divider(
                  color: Colors.lightBlueAccent.withOpacity(0.25),
                  height: screenHeight * 0.01,
                  indent: screenWidth * 0.04,
                  endIndent: screenWidth * 0.04,
                ),
                SizedBox(
                  height: screenHeight * 0.005,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          infoRowLeft('Branch', '${data?[index].branch}'),
                          infoRowLeft(
                              'Capacity Type', '${data?[index].capacityType}'),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          infoRowRight(
                              'Vehicle Type', '${data?[index].vehicleType}'),
                          infoRowRight('Vehicle Number',
                              '${data?[index].vehicleNumber}'),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.005,
                ),
                Divider(
                  color: Colors.lightBlueAccent.withOpacity(0.25),
                  height: screenHeight * 0.01,
                  indent: screenWidth * 0.04,
                  endIndent: screenWidth * 0.04,
                ),
                SizedBox(
                  height: screenHeight * 0.005,
                ),
                infoRow(
                  screenWidth,
                  screenHeight,
                  'Location',
                  '${data?[index].currentLocation ?? "Not Available"}',
                ),
                selectedCapacity == 'Available Capacity'
                    ? Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.02),
                        child: Row(
                          children: [
                            Text(
                              'Status:',
                              style: TextStyle(
                                  color: CupertinoColors.black.withOpacity(0.5),
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: screenWidth * 0.02,
                            ),
                            Text(
                              data?[index].isCapacityAvailable
                                  ? 'Active'
                                  : 'Inactive',
                              style: TextStyle(
                                color: data?[index].isCapacityAvailable
                                    ? Colors.green.shade600
                                    : Colors.red.shade600,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      )
                    : SizedBox(),
                SizedBox(
                  height: screenHeight * 0.015,
                ),
                data?[index].currentLocation != null
                    ? Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade900,
                          borderRadius:
                              BorderRadius.circular(screenWidth * 0.025),
                        ),
                        child: Text(
                          'Track',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: screenWidth * 0.04,
                          ),
                        ),
                      )
                    : SizedBox()
              ],
            ),
          ),
        );
      },
    );
  }

  Widget infoRow(
      double screenWidth, double screenHeight, String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.015),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
                color: CupertinoColors.black.withOpacity(0.5),
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            width: screenWidth * 0.02,
          ),
          Flexible(
              child: Text(
            value,
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          )),
        ],
      ),
    );
  }

  Widget infoRowLeft(String label, String value,
      {TextStyle? labelStyle, TextStyle? valueStyle}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: labelStyle ??
              TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 14,
                color: CupertinoColors.black.withOpacity(0.5),
              ),
        ),
        Flexible(
          child: Text(
            value,
            style: valueStyle ??
                const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: CupertinoColors.black,
                ),
          ),
        )
      ],
    );
  }

  Widget infoRowRight(String label, String value,
      {TextStyle? labelStyle, TextStyle? valueStyle}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: labelStyle ??
              TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 14,
                color: CupertinoColors.black.withOpacity(0.5),
              ),
        ),
        Flexible(
          child: Text(
            value,
            style: valueStyle ??
                const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: CupertinoColors.black,
                ),
          ),
        )
      ],
    );
  }
}
