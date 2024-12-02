import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xp_internal/constants/colors.dart';
import 'package:xp_internal/models/login_model.dart';
import 'package:http/http.dart' as http;
import 'package:xp_internal/models/manage_orders/lcl/lcl_reschedule_manage_model.dart';
import 'package:xp_internal/models/manage_orders/reschedule_orders_model.dart';

class ManageLclOrders extends StatefulWidget {
  const ManageLclOrders({super.key});

  @override
  State<ManageLclOrders> createState() => _ManageLclOrdersState();
}

class _ManageLclOrdersState extends State<ManageLclOrders> {
  List<bool> selectedToggle = <bool>[true, false];
  late String userId;
  late String userType;
  late String authToken;
  late String userName;
  late String firstName;
  late String lastName;

  LclRescheduleModel? rescheduleOrdersLcl;
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    getRescheduleOrders();
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
      authToken = loginModel.data!.authToken.toString();
      userName = '$firstName $lastName';
    }
  }

  Future<void> getRescheduleOrders() async {
    await initializeUser();
    var headers = {
      "UserId": userId,
      "UserType": userType,
      "AuthToken": authToken,
      "UserName": userName
    };
    var body = {
      "int_start_index": "0",
      "int_end_index": "20",
      "dt_from_date": "",
      "dt_to_date": "",
      "FilterType": "YTD",
      "vc_filter_by": "",
      "vc_keyword": ""
    };
    var response = await http.post(
      Uri.parse(
          'https://qaapi.xpindia.in/api/get-all-lcl-booking-for-reschedule'),
      headers: headers,
      body: body,
    );
    if (response.statusCode == 200) {
      setState(() {
        rescheduleOrdersLcl = lclRescheduleModelFromJson(response.body);
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

  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    String title = 'Manage LCL Orders';
    return Scaffold(
      backgroundColor: newCardBG,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
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
                    _optionCardBuilder(screenHeight, screenWidth,
                        'Pending Provisional Orders'),
                    _optionCardBuilder(
                        screenHeight, screenWidth, 'Reschedule/Cancel Orders'),
                    _optionCardBuilder(
                        screenHeight, screenWidth, 'Allocate Vehicle to Order'),
                    _optionCardBuilder(
                        screenHeight, screenWidth, 'Revise/Cancel Allocation'),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: screenHeight * 0.01,
            ),
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
            SizedBox(
              height: screenHeight * 0.02,
            ),
            isLoading
                ? Center(
                    child: CircularProgressIndicator(
                      color: Colors.blue.shade900,
                    ),
                  )
                : Expanded(
                    child: ((rescheduleOrdersLcl?.data!.length ?? 0) > 0)
                        ? dataList(screenHeight, screenWidth)
                        : CircularProgressIndicator(
                            color: Colors.blue.shade900,
                          ),
                  ),
          ],
        ),
      ),
    );
  }

  Widget _optionCardBuilder(
      double screenHeight, double screenWidth, String title) {
    return Container(
      padding: EdgeInsets.all(screenWidth * 0.01),
      margin: EdgeInsets.only(right: screenWidth * 0.033),
      width: screenHeight * 0.13,
      height: screenHeight * 0.13,
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
      child: Center(
        child: Text(title),
      ),
    );
  }

  Widget dataList(double screenHeight, double screenWidth) {
    var data = rescheduleOrdersLcl?.data;
    // var data;
    // if (selectedOption == 'Pending/Provisional Orders') {
    //   data = pendingOrders?.data.provisionalOrdersList ?? []; ////fix this
    // } else if (selectedOption == 'Reschedule/Cancel Orders') {
    //   data = rescheduledOrders?.data ?? [];
    // }
    // String getServiceTypeName(ServiceType serviceType) {
    //   // Find the key (string name) that corresponds to the given enum value
    //   return serviceTypeValues.map.keys.firstWhere(
    //         (key) => serviceTypeValues.map[key] == serviceType,
    //     orElse: () => " ", // Fallback if no match is found
    //   );
    // }

    return ListView.builder(
        itemCount: data?.length ?? 0,
        itemBuilder: (context, index) {
          final orders = data?[index]; ////help me get it fixed
          // String? serviceType = orders?.vcServiceType;
          // String? vehicleTypeName = orders?.vcVehicleType;
          // String? branch = orders?.vcBranch;
          // String? customerName = orders?.vcCustomerName;
          // String paymentMode = orders?.;

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
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
                child: Column(
                  children: [
                    infoRow(screenWidth, screenHeight, 'Branch:',
                        '${orders?.vcBranch}'),
                    infoRow(screenWidth, screenHeight, 'Customer:',
                        '${orders?.vcCustomerName}'),
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
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            infoRowLeft('Booking Id', '${orders?.vcBookingId}'),
                            infoRowLeft('Pickup Date',
                                formatDate(orders!.dtPickUpDate.toString())),
                            infoRowLeft(
                                'Vehicle Type', '${orders?.vcVehicleType}')
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            infoRowRight('Service Type',
                                orders?.vcOrderType ?? "Not Available"),
                            infoRowRight('Pickup Window', 'pickup_window'),
                            infoRowRight(
                                'Payment Mode', '${orders?.vcPocName}'),
                          ],
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
                    infoRow(screenWidth, screenHeight, 'Route:',
                        '${orders?.vcPickupLocation}'),
                    infoRow(screenWidth, screenHeight, 'Amount', 'amt'),
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
                            'Cancel',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
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
                            'Reschedule',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  Widget infoRow(
      double screenWidth, double screenHeight, String label, String value) {
    return Row(
      children: [
        Text(
          label,
          style: TextStyle(color: Colors.black38, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          width: screenWidth * 0.01,
        ),
        Flexible(
          child: Text(
            value,
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
      ],
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
