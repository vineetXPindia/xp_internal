import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xp_internal/constants/colors.dart';
import 'package:xp_internal/models/login_model.dart';
import 'package:xp_internal/models/pending_provisional_model.dart';
import 'package:http/http.dart' as http;

class ManageOrders extends StatefulWidget {
  const ManageOrders({super.key});

  @override
  State<ManageOrders> createState() => _ManageOrdersState();
}

class _ManageOrdersState extends State<ManageOrders> {
  List<bool> selectedToggle = <bool>[true, false];
  PendingProvisionalModel? pendingOrders;
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

  Future<void> fetchPendingOrders(String dateType) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var loginData = prefs.getString('userResponse');
    LoginDataModel loginModel = LoginDataModel();
    if (loginData != null && loginData.isNotEmpty) {
      loginModel = loginDataModelFromJson(loginData.toString());
      userType = loginModel.data!.userType.toString();
      userId = loginModel.data!.userId.toString();
      authToken = loginModel.data!.authToken.toString();
      firstName = loginModel.data!.firstName.toString();
      lastName = loginModel.data!.lastName.toString();
      userName = '$firstName $lastName';
    }
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
        Uri.parse(
            'https://qaapi.xpindia.in/api/get-pending-provisional-orders'),
        headers: headers,
        body: body);
    // print("Status Code: ${response.statusCode}");
    // print("Response Body: ${response.body}");

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
        title: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
        child: Column(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                padding: EdgeInsets.all(screenWidth * 0.02),
                child: Row(
                  children: [
                    _optionCardBuilder(
                        'lib/assets/icons/pending.png',
                        screenHeight,
                        screenWidth,
                        'Pending Provisional Orders'),
                    _optionCardBuilder('lib/assets/icons/cancel.png',
                        screenHeight, screenWidth, 'Reschedule/Cancel Orders'),
                    _optionCardBuilder('lib/assets/icons/allocate.png',
                        screenHeight, screenWidth, 'Allocate Vehicle to Order'),
                    _optionCardBuilder('lib/assets/icons/cancel.png',
                        screenHeight, screenWidth, 'Revise/Cancel Allocation'),
                  ],
                ),
              ),
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
    return ListView.builder(
        itemCount: pendingOrders?.data.provisionalOrdersList.length ?? 0,
        itemBuilder: (context, index) {
          final orders = pendingOrders!.data.provisionalOrdersList[index];
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
                      Text(
                        '${orders.customerName}',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  SizedBox(
                    height: screenHeight * 0.01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      infoRow('Order Id', '${orders.orderIdCode}'),
                      infoRow('Service Type', '${orders.serviceType}'),
                      infoRow('Origin', '${orders.from}')
                    ],
                  ),
                  SizedBox(
                    height: screenHeight * 0.01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      infoRow('Service Type', '${orders.serviceType}'),
                      infoRow('Vehicle Type', '${orders.vehicleType}'),
                      infoRow('Destination', '${orders.to}')
                    ],
                  ),
                  SizedBox(
                    height: screenHeight * 0.01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        padding: EdgeInsets.all(screenWidth * 0.01),
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(screenWidth * 0.02),
                          color: Colors.red,
                        ),
                        child: Text(
                          'Reject',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(screenWidth * 0.01),
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(screenWidth * 0.02),
                          color: Colors.blue.shade900,
                        ),
                        child: Text(
                          'Confirm',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }

  Widget _optionCardBuilder(
      String assetPath, double screenHeight, double screenWidth, String title) {
    return Container(
        padding: EdgeInsets.all(screenWidth * 0.02),
        margin: EdgeInsets.only(right: screenWidth * 0.033),
        width: screenHeight * 0.15,
        height: screenHeight * 0.15,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(screenWidth * 0.05),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 4),
              blurRadius: 5,
              color: Colors.black26,
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              assetPath,
              height: screenHeight * 0.05,
            ),
            Center(child: Text(title))
          ],
        ));
  }

  Widget infoRow(String label, String value,
      {TextStyle? labelStyle, TextStyle? valueStyle}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
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
