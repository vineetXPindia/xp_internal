import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xp_internal/constants/colors.dart';
import 'package:xp_internal/models/login_model.dart';
import 'package:xp_internal/models/pending_provisional_model.dart';
import 'package:http/http.dart' as http;

import '../../models/manage_orders/reschedule_orders_model.dart';

class ManageOrders extends StatefulWidget {
  const ManageOrders({super.key});

  @override
  State<ManageOrders> createState() => _ManageOrdersState();
}

class _ManageOrdersState extends State<ManageOrders> {
  String selectedOption = 'Pending/Provisional Orders';
  var optionsList = [
    'Pending/Provisional Orders',
    'Reschedule/Cancel Orders',
    'Allocate Vehicle to Order',
    'Revise/Cancel Allocation'
  ];
  List<bool> selectedToggle = <bool>[true, false];
  PendingProvisionalModel? pendingOrders;
  RescheduleOrdersModel? rescheduledOrders;
  bool isLoading = true;
  late String userType;
  late String userId;
  late String authToken;
  late String userName;
  late String firstName;
  late String lastName;

  @override
  void initState() {
    super.initState();
    fetchPendingOrders("7 Days");
  }

  Future<void> fetchOrders(String selectedOption) async {
    if (selectedOption == 'Reschedule/Cancel Orders') {
      fetchRescheduledOrders();
    }
  }

  Future<void> initializeUser() async {
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userData = prefs.getString('userResponse');
    LoginDataModel loginModel = LoginDataModel();
    if (userData != null && userData.isNotEmpty) {
      loginModel = loginDataModelFromJson(userData.toString());
      firstName = loginModel.data!.firstName.toString();
      lastName = loginModel.data!.lastName.toString();
      userId = loginModel.data!.userId.toString();
      userType = loginModel.data!.userType.toString();
      userName = '$firstName $lastName';
      authToken = loginModel.data!.authToken.toString();
    }
  }

  Future<void> fetchRescheduledOrders() async {
    await initializeUser();
    var headers = {
      "UserType": userType,
      "UserName": userName,
      "UserId": userId,
      "AuthToken": authToken
    };
    var response = await http.get(
      Uri.parse('https://qaapi.xpindia.in/api/get-rescheduled-orders'),
      headers: headers,
    );
    if (response.statusCode == 200) {
      setState(() {
        rescheduledOrders = rescheduleOrdersModelFromJson(response.body);
        isLoading = false;
      });
      print(response.body);
    } else {
      setState(() {
        isLoading = false;
      });
      throw Exception('Unable to Load');
    }
  }

  Future<void> fetchPendingOrders(String dateType) async {
    await initializeUser();
    var headers = {
      "UserType": userType,
      "UserId": userId,
      "AuthToken": authToken,
      "Username": userName
    };

    var body = {
      "OrderBy": "",
      "StartIndex": "${1}",
      "PageLength": "${20}",
      "FilterBy": "any",
      "Keyword": "",
      "KeywordDate": "",
      "FilterStatus": "",
      "ZoneName": "",
      "DateType": dateType,
      "FromDate": "null",
      "ToDate": "null"
    };

    var response = await http.post(
      Uri.parse('https://qaapi.xpindia.in/api/get-pending-provisional-orders'),
      headers: headers,
      body: body,
    );
    if (response.statusCode == 200) {
      setState(() {
        pendingOrders = pendingProvisionalModelFromJson(response.body);
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      throw Exception('unable to load');
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    String title = 'Manage FCL Orders';

    return Scaffold(
      backgroundColor: newCardBG,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        surfaceTintColor: Colors.transparent,
        title: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
        child: Column(
          children: [
            Container(
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
                  icon: Icon(Icons.arrow_drop_down_circle_rounded),
                  dropdownColor: Colors.white,
                  borderRadius: BorderRadius.circular(screenWidth * 0.03),
                  value: selectedOption,
                  items: optionsList.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedOption = newValue!;
                    });
                    fetchOrders(selectedOption);
                    /////////////////////////
                  }),
            ),
            SizedBox(height: screenHeight * 0.01),
            TextField(
              decoration: InputDecoration(
                icon: Icon(Icons.search),
                hintText: 'Search by Order id/ Location or Vehicle Type',
                hintStyle: TextStyle(
                    fontSize: screenWidth * 0.035, color: Colors.black54),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(screenWidth * 0.04),
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            Container(
              padding: EdgeInsets.all(screenWidth * 0.015),
              child: LayoutBuilder(
                builder: (context, constraints) => ToggleButtons(
                  constraints: BoxConstraints.expand(width: screenWidth * 0.4),
                  borderRadius: BorderRadius.all(
                    Radius.circular(screenWidth * 0.04),
                  ),
                  textStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: screenWidth * 0.04,
                  ),
                  selectedColor: Colors.white,
                  fillColor: Colors.blue.shade900,
                  color: Colors.black,
                  isSelected: selectedToggle,
                  children: <Widget>[
                    Text('Next 7 Days'),
                    Text('Beyond 7 Days'),
                  ],
                  onPressed: (int index) {
                    pendingOrders = null;
                    setState(() {
                      for (int i = 0; i < selectedToggle.length; i++) {
                        selectedToggle[i] = i == index;
                      }
                      fetchPendingOrders(
                          index == 0 ? "7 Days" : "Beyond 7 Days");
                    });
                  },
                ),
              ),
            ),
            isLoading
                ? Center(
                    child: Container(
                    margin: EdgeInsets.all(screenWidth * 0.1),
                    child: Center(
                      child: CircularProgressIndicator(
                        color: Colors.blue.shade900,
                      ),
                    ),
                  ))
                : Expanded(
                    child:
                        ((pendingOrders?.data.provisionalOrdersList?.length ??
                                    0) >
                                0)
                            ? next7DaysList(screenHeight, screenWidth)
                            : Center(
                                child: CircularProgressIndicator(
                                  color: Colors.blue.shade900,
                                ),
                              ),
                  ),
          ],
        ),
      ),
    );
  }

  Widget next7DaysList(double screenHeight, double screenWidth) {
    var data;
    if (selectedOption == 'Pending/Provisional Orders') {
      data = pendingOrders?.data.provisionalOrdersList;
    } else if (selectedOption == 'Reschedule/Cancel Orders') {
      data = rescheduledOrders?.data;
    }
    return ListView.builder(
        itemCount: data.toString().length ?? 0,
        itemBuilder: (context, index) {
          final orders = data![index];
          return Padding(
            padding: EdgeInsets.all(5),
            child: Container(
              margin: EdgeInsets.only(top: screenHeight * 0.01),
              padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(screenWidth * 0.07),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(0, 3),
                        color: Colors.black26,
                        blurRadius: 5)
                  ]),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Text(
                          '${orders.customerName}',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
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
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              'Branch:',
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 14,
                                color: CupertinoColors.black.withOpacity(0.5),
                              ),
                            ),
                            SizedBox(width: screenWidth * 0.02),
                            Text(
                              '${orders.branchName}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: CupertinoColors.black,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: screenHeight * 0.005),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                infoRowLeft(
                                    'Order Id', '${orders.orderIdCode}'),
                                SizedBox(
                                  height: screenHeight * 0.01,
                                ),
                                infoRowLeft(
                                    'Payment Mode',
                                    orders.paymentMode
                                        .toString()
                                        .split('.')
                                        .last)
                              ],
                            ),
                            Column(
                              children: [
                                infoRowCenter(
                                    'Service Type',
                                    orders.serviceType
                                        .toString()
                                        .split('.')
                                        .last),
                                SizedBox(
                                  height: screenHeight * 0.01,
                                ),
                                infoRowCenter('Pickup Date',
                                    formatDate(orders.pickupDate.toString())),
                              ],
                            ),
                            Column(
                              children: [
                                infoRowRight(
                                    'Vehicle Type',
                                    orders.vehicleType
                                        .toString()
                                        .split('.')
                                        .last),
                                SizedBox(
                                  height: screenHeight * 0.01,
                                ),
                                infoRowRight('Pickup Time',
                                    formatTime(orders.pickupDate.toString())),
                              ],
                            ),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Route:',
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 14,
                          color: CupertinoColors.black.withOpacity(0.5),
                        ),
                      ),
                      SizedBox(
                        width: screenWidth * 0.02,
                      ),
                      Text(
                        '${orders.from} - ${orders.to}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: CupertinoColors.black,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: screenHeight * 0.01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          vertical: screenWidth * 0.01,
                          horizontal: screenWidth * 0.02,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.red.shade700,
                          borderRadius:
                              BorderRadius.circular(screenWidth * 0.02),
                        ),
                        child: Text(
                          'Reject',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          vertical: screenWidth * 0.01,
                          horizontal: screenWidth * 0.02,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade900,
                          borderRadius:
                              BorderRadius.circular(screenWidth * 0.02),
                        ),
                        child: Text(
                          'Confirm',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        });
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

  Widget infoRowCenter(String label, String value,
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

  String formatDate(String dateTime) {
    try {
      DateTime parsedDate = DateTime.parse(dateTime);
      return DateFormat('yyyy-MM-dd').format(parsedDate); // Returns date only
    } catch (e) {
      return 'Invalid Date';
    }
  }

  String formatTime(String dateTime) {
    try {
      DateTime parsedDate = DateTime.parse(dateTime);
      return DateFormat('hh:mm a')
          .format(parsedDate); // Returns time in hh:mm AM/PM
    } catch (e) {
      return 'Invalid Time';
    }
  }
}
