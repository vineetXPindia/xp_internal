import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xp_internal/constants/colors.dart';
import 'package:xp_internal/models/book_new/get_origin_destination_model.dart';
import 'package:xp_internal/models/book_new/order_options.dart';
import 'package:xp_internal/models/login_model.dart';
import '../../../widgets/utility.dart';
import 'package:http/http.dart' as http;

class BookNewLclOrder extends StatefulWidget {
  const BookNewLclOrder({super.key});

  @override
  State<BookNewLclOrder> createState() => _BookNewLclOrderState();
}

class _BookNewLclOrderState extends State<BookNewLclOrder> {
  final String title = 'Book New LCL Order';
  String? selectedService;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  TimeOfDay? toTime;
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController originController = TextEditingController();
  final TextEditingController destinationController = TextEditingController();
  final TextEditingController pocNameController = TextEditingController();

  List<String> customers = [];
  List<String> vehicleTypes = [];
  List<String> originList = [];
  String? selectedOrigin;

  List<String> origin = <String>['Chennai', 'Bangalore', 'Hyderabad'];
  String? selectedCustomer;
  bool isDropdownVisible = false;
  final List<String> services = <String>[
    'Single Route',
    'Multiple Route',
    'Break Bulk',
    'Aggregation'
  ];
  late String userId;
  late String userType;
  late String userName;
  late String authToken;
  OrderOptionsModel? orderOptions;
  GetOriginDestinationModel? originDestination;
  bool isLoading = true;

  Future<void> initializeUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userData = prefs.getString('userResponse');
    LoginDataModel loginModel = LoginDataModel();
    if (userData != null && userData.isNotEmpty) {
      loginModel = loginDataModelFromJson(userData.toString());
      String? firstName = loginModel.data?.firstName;
      String? lastName = loginModel.data?.lastName;
      userId = loginModel.data!.userId.toString();
      userType = loginModel.data!.userType.toString();
      userName = '$firstName $lastName';
      authToken = loginModel.data!.authToken.toString();
    }
  }

  Future<void> getOrderDetails() async {
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
        headers: headers);
    if (response.statusCode == 200) {
      setState(() {
        isLoading = false;
        orderOptions = orderOptionsModelFromJson(response.body);
      });
      List<AssociateList>? customerList = orderOptions?.data?.customerList;
      List<AssociateList>? vehicleTypeList =
          orderOptions?.data?.vehicleTypeList;
      if (customerList != null) {
        for (var customer in customerList) {
          customers.add(customer.lookupName!);
        }
      }
      if (vehicleTypeList != null) {
        for (var vehicle in vehicleTypeList) {
          vehicleTypes.add(vehicle.lookupName!);
        }
      }
      // print(customers);
    } else {
      setState(() {
        isLoading = false;
      });
      throw Exception('Unable to load');
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
      print(vehicleTypes);
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
    super.initState();
    getOrderDetails();
    originController.addListener(_onOriginSearchTextChanged);
    destinationController.addListener(_onDestinationSearchTextChanged);
    // getOriginDestination('gur');
  }

  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

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
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ////////////////////////////////////////////////////////////////////
              Container(
                decoration: BoxDecoration(
                  color: Colors.blue.shade900,
                  borderRadius: BorderRadius.circular(screenWidth * 0.04),
                ),
                child: DropdownButton(
                    dropdownColor: Colors.blue.shade900,
                    borderRadius: BorderRadius.circular(screenWidth * 0.04),
                    icon: Icon(
                      Icons.arrow_drop_down_circle_rounded,
                      color: Colors.white,
                    ),
                    hint: Text(
                      'Select Service Type ',
                      style: TextStyle(color: Colors.white),
                    ),
                    padding:
                        EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
                    value: selectedService,
                    underline: SizedBox(),
                    items: services.map((String service) {
                      return DropdownMenuItem(
                        value: service,
                        child: Text(
                          service,
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedService = newValue;
                      });
                    }),
              ),
              SizedBox(height: screenHeight * 0.015),
              ////////////////////////////////////////////////////////////////////////////////
              buildDropdown(screenHeight, screenWidth, customers,
                  Icons.people_alt_rounded, 'Select Customer'),
              SizedBox(height: screenHeight * 0.01),
              ////////////////////////////////////////////////////////////////////////////////
              buildDropdown(screenHeight, screenWidth, vehicleTypes,
                  Icons.local_shipping_rounded, 'Select Vehicle Type'),
              SizedBox(
                height: screenHeight * 0.01,
              ),
              Row(
                children: [
                  Icon(Icons.calendar_month_rounded),
                  SizedBox(
                    width: screenWidth * 0.02,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        _selectDate(context);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.01),
                        child: AbsorbPointer(
                          child: TextField(
                            controller: _dateController,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(screenWidth * 0.05),
                                borderSide: BorderSide.none,
                              ),
                              hintText: 'Select Date',
                            ),
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
              SizedBox(height: screenHeight * 0.01),
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
              inputField(
                  screenHeight, screenWidth, 'Enter POC Name', Icons.person),
              SizedBox(height: screenHeight * 0.01),
              inputField(screenHeight, screenWidth, 'Enter POC Number',
                  Icons.phone_rounded),
              SizedBox(
                height: screenHeight * 0.01,
              ),
              inputField(
                  screenHeight, screenWidth, 'Remarks', Icons.feedback_rounded),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  selectedService == 'Multiple Route'
                      ? GestureDetector(
                          onTap: () {},
                          child: Container(
                            padding: EdgeInsets.all(screenWidth * 0.01),
                            decoration: BoxDecoration(
                              color: Colors.blue.shade900,
                              borderRadius: BorderRadius.circular(
                                screenWidth * 0.02,
                              ),
                            ),
                            child: Text(
                              'Add More',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: screenWidth * 0.045,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        )
                      : SizedBox(),
                ],
              ),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(screenWidth * 0.02),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(screenWidth * 0.04),
                      color: Colors.blue.shade900,
                    ),
                    child: Text(
                      'Book Order',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: screenWidth * 0.045,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: screenHeight * 0.02,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        String convertedDateTime =
            '${picked.year.toString()}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}';
        _dateController.text = convertedDateTime;
      });
    }
  }

  Widget inputField(
      double screenHeight, double screenWidth, String hint, IconData iconData) {
    return Row(
      children: [
        Icon(iconData),
        SizedBox(
          width: screenWidth * 0.02,
        ),
        Expanded(
          child: TextField(
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
