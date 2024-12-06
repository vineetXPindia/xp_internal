import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xp_internal/constants/colors.dart';
import 'package:xp_internal/models/book_new/get_origin_destination_model.dart';
import 'package:xp_internal/models/book_new/order_options.dart';
import 'package:xp_internal/models/login_model.dart';
import 'package:http/http.dart' as http;

class BookNewOrder extends StatefulWidget {
  const BookNewOrder({super.key});

  @override
  State<BookNewOrder> createState() => _BookNewOrderState();
}

class _BookNewOrderState extends State<BookNewOrder> {
  final String title = 'Book New Order';
  String? selectedValue;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  TimeOfDay? toTime;
  AssociateList? selectedCustomer;
  String? pocName;
  String? pocNumber;

  LoginDataModel loginModel = LoginDataModel();
  GetOriginDestinationModel? originDestination;
  OrderOptionsModel? orderDetails;

  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _textController = TextEditingController();
  final TextEditingController originController = TextEditingController();
  final TextEditingController destinationController = TextEditingController();
  final TextEditingController pocNameController = TextEditingController();
  final TextEditingController pocNumberController = TextEditingController();

  List<bool> selectedService = <bool>[true, false];
  List<String> customers = <String>[];
  List<String> vehicleTypes = <String>[];
  List<String> originList = [];
  List<AssociateList>? customerList;

  late String userId;
  late String userType;
  late String authToken;
  late String userName;

  Future<void> initializeUser() async {
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userData = prefs.getString('userResponse');
    loginModel = loginDataModelFromJson(userData.toString());
    String? firstName = loginModel.data?.firstName;
    String? lastName = loginModel.data?.lastName;
    userId = loginModel.data!.userId.toString();
    userType = loginModel.data!.userType.toString();
    authToken = loginModel.data!.authToken.toString();
    userName = '$firstName $lastName';
  }

  Future<void> getOrderDetails() async {
    WidgetsFlutterBinding.ensureInitialized();
    await initializeUser();
    var headers = {
      "UserId": userId,
      "UserType": userType,
      "UserName": userName,
      "AuthToken": authToken,
      "Content-Type": "application/json"
    };
    var response = await http.get(
      Uri.parse('https://qaapi.xpindia.in/api/get-order-options'),
      headers: headers,
    );
    if (response.statusCode == 200) {
      setState(() {
        orderDetails = orderOptionsModelFromJson(response.body);
      });
      customerList = orderDetails?.data?.customerList;
      print(customerList);
      if (customerList != null) {
        for (var customer in customerList!) {
          customers.add(customer.lookupName!);
        }
      }
      List<AssociateList>? vehicleTypeList =
          orderDetails?.data?.vehicleTypeList;
      if (vehicleTypeList != null) {
        for (var vehicle in vehicleTypeList) {
          vehicleTypes.add(vehicle.lookupName!);
        }
      }
      // print(customers);
      // print(vehicleTypes);
    } else {
      throw Exception('Unable to Load');
    }
  }

  Future<void> getOriginDestination(String keyword) async {
    await initializeUser();
    final Map<String, String> queryParams = {
      'keyword': keyword,
      'isOrigin': '${true}'
    };
    var response = await http.get(
        Uri.parse('https://qaapi.xpindia.in/api/get-origin-destination')
            .replace(queryParameters: queryParams));
    if (response.statusCode == 200) {
      setState(() {
        originDestination = getOriginDestinationModelFromJson(response.body);
        originList =
            originDestination!.data!.map((datum) => datum.lookupName!).toList();
      });
      // print(originList);
      // print(vehicleTypes);
    }
  }

  _onOriginSearchTextChanged() {
    final keyword = originController.text;
    if (keyword.length == 3) {
      getOriginDestination(keyword);
    } else if (keyword.length < 3) {
      setState(() {
        originList =
            []; // Clear the list if the keyword is less than 3 characters
      });
    }
  }

  _onDestinationSearchTextChanged() {
    final keyword = destinationController.text;
    if (keyword.length >= 3) {
      getOriginDestination(keyword);
    } else if (keyword.length < 3) {
      setState(() {
        originList =
            []; // Clear the list if the keyword is less than 3 characters
      });
    }
  }

  @override
  void initState() {
    getOrderDetails();
    originController.addListener(_onOriginSearchTextChanged);
    destinationController.addListener(_onDestinationSearchTextChanged);
    super.initState();
  }

  void dispose() {
    _dateController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: newCardBG,
      appBar: AppBar(
        backgroundColor: newCardBG,
        title: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(screenWidth * 0.015),
                child: LayoutBuilder(
                  builder: (context, constraints) => ToggleButtons(
                    constraints:
                        BoxConstraints.expand(width: screenWidth / 2.3),
                    borderRadius: BorderRadius.all(
                      Radius.circular(screenWidth * 0.03),
                    ),
                    textStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: screenWidth * 0.04,
                    ),
                    selectedColor: Colors.white,
                    fillColor: Colors.blue.shade900,
                    color: Colors.black,
                    isSelected: selectedService,
                    children: <Widget>[
                      Text('Single Route'),
                      Text('Multiple Route'),
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
              SizedBox(height: screenHeight * 0.01),
//////////////////////////////////////////////////////////// ->select customer
              Row(
                children: [
                  Icon(Icons.people_alt_rounded),
                  SizedBox(
                    width: screenWidth * 0.025,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(screenWidth * 0.04),
                    ),
                    child: DropdownMenu<AssociateList>(
                      menuStyle: MenuStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white),
                        padding: MaterialStateProperty.all(
                          EdgeInsets.only(top: -screenHeight * 0.1),
                        ),
                      ),
                      width: screenWidth * 0.825,
                      menuHeight: 200,
                      dropdownMenuEntries: customerList?.map((customer) {
                            return DropdownMenuEntry<AssociateList>(
                              value: customer,
                              label: customer.lookupName ??
                                  'Unknown', // Display lookupName
                            );
                          }).toList() ??
                          [], // Empty list fallback if customerList is null
                      onSelected: (AssociateList? selectedCustomer) {
                        setState(() {
                          // Save the selected customer
                          this.selectedCustomer = selectedCustomer;

                          // Access other properties of the selected customer
                          pocName = selectedCustomer?.poc?.toString() ??
                              "Not Available";
                          print(pocName);
                          print(pocNumber);
                          pocNumber =
                              selectedCustomer?.pocContactNumber?.toString() ??
                                  "Not Available";
                          pocNameController.text = pocName!;
                          pocNumberController.text = pocNumber!;
                        });
                      },
                      enabled: true,
                      enableSearch: true,
                      hintText: 'Select Customer',
                      enableFilter: true,
                      requestFocusOnTap: true,
                      inputDecorationTheme: InputDecorationTheme(
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        contentPadding:
                            EdgeInsets.only(left: screenWidth * 0.03),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: screenHeight * 0.01,
              ),
              //date selector
              Row(
                children: [
                  Icon(Icons.calendar_today_rounded),
                  SizedBox(
                    width: screenWidth * 0.02,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        _selectDate(context);
                      },
                      child: AbsorbPointer(
                        child: TextField(
                          controller: _dateController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            focusColor: Colors.white,
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(screenWidth * 0.05),
                                borderSide: BorderSide.none),
                            hintText: 'Select Date',
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: screenHeight * 0.01,
              ),
              Row(
                children: [
                  Icon(Icons.watch_later_rounded),
                  SizedBox(
                    width: screenWidth * 0.03,
                  ),
                  ///////////////////////////////////////// -> time picker
                  GestureDetector(
                    onTap: () async {
                      TimeOfDay? time = await showTimePicker(
                        barrierColor: Colors.black.withOpacity(0.8),
                        barrierDismissible: true,
                        barrierLabel: 'Select Pickup Time',
                        context: context,
                        helpText: 'Select Pickup Time',
                        initialTime: TimeOfDay.now(),
                      );
                      if (time != null) {
                        setState(() {
                          selectedTime = time;
                        });
                        toTime = _getTimeThreeHoursLater(selectedTime!);
                      }
                    },
                    child: Container(
                      width: screenWidth * 0.4,
                      height: screenHeight * 0.055,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(
                          screenWidth * 0.04,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          selectedTime != null
                              ? formatTime(selectedTime!)
                              : 'From',
                          style: TextStyle(
                            fontSize: screenWidth * 0.045,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: screenWidth * 0.02,
                  ),
                  ///////////////////////////////////////////// -> time picker
                  Container(
                    height: screenHeight * 0.055,
                    width: screenWidth * 0.4,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(
                        screenWidth * 0.04,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        toTime != null ? formatTime(toTime!) : 'To',
                        style: TextStyle(
                          fontSize: screenWidth * 0.045,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: screenHeight * 0.01,
              ),
              Row(
                children: [
                  Icon(Icons.local_shipping_rounded),
                  SizedBox(
                    width: screenWidth * 0.025,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(screenWidth * 0.04),
                    ),
                    child: DropdownMenu<String>(
                      menuStyle: MenuStyle(
                        backgroundColor: MaterialStateProperty.all(
                            Colors.white), // Dropdown menu background color
                        padding: MaterialStateProperty.all(
                          EdgeInsets.only(top: -screenHeight * 0.1),
                        ),
                      ),
                      width: screenWidth * 0.825,
                      menuHeight: 200,
                      // controller: controller,
                      dropdownMenuEntries: vehicleTypes
                          .map((e) => DropdownMenuEntry(value: e, label: e))
                          .toList(),
                      onSelected: (value) {
                        print(value);
                      },
                      enabled: true,
                      enableSearch: true,
                      hintText: 'Select Vehicle Type',
                      enableFilter: true,
                      requestFocusOnTap: true,
                      inputDecorationTheme: InputDecorationTheme(
                        border: InputBorder.none, // Removes the outline
                        enabledBorder:
                            InputBorder.none, // Removes the border when enabled
                        focusedBorder:
                            InputBorder.none, // Removes the border when focused
                        contentPadding:
                            EdgeInsets.only(left: screenWidth * 0.03),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: screenHeight * 0.01,
              ),
              Row(
                children: [
                  Icon(Icons.gps_fixed_rounded),
                  SizedBox(
                    width: screenWidth * 0.025,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.circular(screenWidth * 0.04)),
                    child: DropdownMenu<String>(
                      menuStyle: MenuStyle(
                        backgroundColor: MaterialStateProperty.all(
                            Colors.white), // Dropdown menu background color
                        padding: MaterialStateProperty.all(
                          EdgeInsets.only(top: -screenHeight * 0.1),
                        ),
                      ),
                      width: screenWidth * 0.825,
                      menuHeight: 200,
                      controller: originController,
                      dropdownMenuEntries: originList
                          .map((e) => DropdownMenuEntry(value: e, label: e))
                          .toList(),
                      onSelected: (value) {},
                      enabled: true,
                      enableSearch: true,
                      hintText: 'Select Origin',
                      enableFilter: true,
                      requestFocusOnTap: true,
                      inputDecorationTheme: InputDecorationTheme(
                        border: InputBorder.none, // Removes the outline
                        enabledBorder:
                            InputBorder.none, // Removes the border when enabled
                        focusedBorder:
                            InputBorder.none, // Removes the border when focused
                        contentPadding:
                            EdgeInsets.only(left: screenWidth * 0.03),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: screenHeight * 0.01,
              ),
              Row(
                children: [
                  Icon(Icons.location_on),
                  SizedBox(
                    width: screenWidth * 0.025,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.circular(screenWidth * 0.04)),
                    child: DropdownMenu<String>(
                      menuStyle: MenuStyle(
                        backgroundColor: MaterialStateProperty.all(
                            Colors.white), // Dropdown menu background color
                        padding: MaterialStateProperty.all(
                          EdgeInsets.only(top: -screenHeight * 0.1),
                        ),
                      ),
                      width: screenWidth * 0.825,
                      menuHeight: 200,
                      controller: destinationController,
                      dropdownMenuEntries: originList
                          .map((e) => DropdownMenuEntry(value: e, label: e))
                          .toList(),
                      onSelected: (value) {},
                      enabled: true,
                      enableSearch: true,
                      hintText: 'Select Destination',
                      enableFilter: true,
                      requestFocusOnTap: true,
                      inputDecorationTheme: InputDecorationTheme(
                        border: InputBorder.none, // Removes the outline
                        enabledBorder:
                            InputBorder.none, // Removes the border when enabled
                        focusedBorder:
                            InputBorder.none, // Removes the border when focused
                        contentPadding:
                            EdgeInsets.only(left: screenWidth * 0.03),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: screenHeight * 0.01,
              ),
              inputField(screenHeight, screenWidth, 'Enter POC Name',
                  Icons.person, pocNameController),
              SizedBox(
                height: screenHeight * 0.01,
              ),
              inputField(screenHeight, screenWidth, 'Enter POC Number',
                  Icons.phone_rounded, pocNumberController),
              SizedBox(
                height: screenHeight * 0.01,
              ),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.01),
                  padding: EdgeInsets.symmetric(
                      vertical: screenHeight * 0.02,
                      horizontal: screenWidth * 0.035),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(screenWidth * 0.05),
                    color: Colors.white,
                  ),
                  child: Row(
                    children: [
                      Align(
                        heightFactor: 1,
                        widthFactor: 1,
                        child: Icon(Icons.format_list_numbered),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: screenWidth * 0.02),
                        child: Text(
                          'Select Number of Vehicles:',
                          style: TextStyle(fontSize: screenWidth * 0.036),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: screenWidth * 0.15),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.02),
                          decoration: BoxDecoration(
                            color: Colors.black12.withOpacity(0.2),
                            borderRadius:
                                BorderRadius.circular(screenWidth * 0.02),
                          ),
                          child: Text(
                            '1',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: screenWidth * 0.04),
                          ),
                        ),
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.2, vertical: screenHeight * 0.015),
        color: newCardBG,
        child: FloatingActionButton(
          backgroundColor: Colors.blue.shade900,
          onPressed: () {},
          child: Text(
            'Check Prices',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget inputField(double screenHeight, double screenWidth, String hint,
      IconData iconData, TextEditingController controller) {
    return Row(
      children: [
        Icon(iconData),
        SizedBox(
          width: screenWidth * 0.02,
        ),
        Expanded(
          child: TextField(
            controller: controller,
            onTapOutside: (event) {
              FocusScope.of(context).unfocus();
            },
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              hintText: hint,
              hintStyle: TextStyle(fontWeight: FontWeight.normal),
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(screenWidth * 0.04),
              ),
            ),
          ),
        )
      ],
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    // TextEditingController _dateController = TextEditingController();
    final DateTime? picked = await showDatePicker(
        context: context, firstDate: DateTime.now(), lastDate: DateTime(2030));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        String convertedDateTime =
            '${picked.year.toString()}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}';
        _dateController.text = convertedDateTime;
      });
    }
  }

  // List<String> getSuggestions(String query) {
  //   List<String> matches = [];
  //   matches.addAll(customers);
  //   matches.retainWhere(
  //       (test) => test.toLowerCase().contains(query.toLowerCase()));
  //   return matches;
  // }

  // Widget searchableDropdown(double screenHeight, double screenWidth,
  //     String title, IconData iconInfo) {
  //   return Column(
  //     children: [
  //       Container(
  //         margin: EdgeInsets.only(top: screenHeight * 0.01),
  //         width: screenWidth * 0.9,
  //         child: TextField(
  //           onTapOutside: (event) => FocusScope.of(context).unfocus(),
  //           decoration: InputDecoration(
  //               filled: true,
  //               fillColor: Colors.white,
  //               labelText: title,
  //               border: OutlineInputBorder(
  //                 borderSide: BorderSide.none,
  //                 borderRadius: BorderRadius.circular(screenWidth * 0.05),
  //               ),
  //               prefixIcon: Align(
  //                 heightFactor: 1,
  //                 widthFactor: 1,
  //                 child: Icon(
  //                   iconInfo,
  //                   color: Colors.black,
  //                 ),
  //               )),
  //         ),
  //       ),
  //     ],
  //   );
  // }

  Widget textField(
      BuildContext context, double screenHeight, double screenWidth) {
    return Container(
      child: TypeAheadField(
        itemBuilder: (context, suggestions) {
          return ListTile(
            title: Text('Select Destination'),
            contentPadding:
                EdgeInsets.symmetric(horizontal: screenWidth * 0.01),
          );
        },
        onSelected: (suggestion) {},
        suggestionsCallback: (pattern) async {
          return;
        },
      ),
    );
  }

  TimeOfDay _getTimeThreeHoursLater(TimeOfDay time) {
    int newHour = time.hour + 3;
    if (newHour >= 24) {
      newHour -= 24; // Wrap around if it exceeds 24 hours
    }
    return TimeOfDay(hour: newHour, minute: time.minute);
  }

  String formatTime(TimeOfDay time) {
    // Convert TimeOfDay to DateTime
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, time.hour, time.minute);

    // Format DateTime to 12-hour time with am/pm
    return DateFormat('hh:mm a').format(dt);
  }
}
