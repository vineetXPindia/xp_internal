import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xp_internal/constants/colors.dart';
import 'package:xp_internal/models/Capacity/capacity_at_unloading.dart';
import 'package:xp_internal/models/available_capacity_model.dart';
import 'package:xp_internal/models/login_model.dart';
import 'package:xp_internal/widgets/top_bar.dart';
import 'package:http/http.dart' as http;

class CapacityPage extends StatefulWidget {
  const CapacityPage({super.key});

  @override
  State<CapacityPage> createState() => _CapacityPageState();
}

class _CapacityPageState extends State<CapacityPage> {
  CapacityModel? availableCapacity;
  CapacityUnloadingModel? capacityAtUnloading;

  bool isLoading = true;
  late String userType;
  late String userId;
  late String authToken;
  late String userName;
  @override
  void initState() {
    super.initState();
    fetchAvailableCapacity();
  }

  Future<void> fetchCapacity(String? selectedCapacity) async {
    if (selectedCapacity == 'Available Capacity') {
      fetchAvailableCapacity();
    } else if (selectedCapacity == 'Capacity at Unloading') {
      fetchCapacityUnloading();
    }
  }

  //method to get available capacity
  Future<void> fetchAvailableCapacity() async {
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    LoginDataModel dataModel = LoginDataModel();

    var userData = prefs.getString('userResponse');
    if (userData != null && userData.isNotEmpty) {
      dataModel = loginDataModelFromJson(userData.toString());
      String? firstName = dataModel.data?.firstName;
      String? lastName = dataModel.data?.lastName;
      userType = dataModel.data!.userType.toString();
      userId = dataModel.data!.userId.toString();
      authToken = dataModel.data!.authToken.toString();
      userName = "$firstName $lastName";
    }
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
        var data = availableCapacity?.data;
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
    SharedPreferences prefs = await SharedPreferences.getInstance();
    LoginDataModel loginModel = LoginDataModel();
    var userData = prefs.getString('userResponse');
    if (userData != null && userData.isNotEmpty) {
      loginModel = loginDataModelFromJson(userData.toString());
      userId = loginModel.data!.userId.toString();
      userType = loginModel.data!.userType.toString();
      authToken = loginModel.data!.authToken.toString();
      String? firstName = loginModel.data!.firstName.toString();
      String? lastName = loginModel.data!.lastName.toString();
      userName = "$firstName $lastName";
    }
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
        var data = capacityAtUnloading?.data;
        isLoading = false;
        for (var item in data!) {
          print(item.vehicleNumber);
        }
      });
    } else {
      showDialog(
          context: context, builder: (context) => Text('Error in loading'));
      setState(() {
        isLoading = false;
      });
      throw Exception('Unable to load');
    }
  }

  Widget build(BuildContext context) {
    final String title = 'Capacity';
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    // Value notifiers to manage state
    final ValueNotifier<List<bool>> selectedService =
        ValueNotifier([true, false]);
    final ValueNotifier<String?> selectedValue = ValueNotifier(null);

    final List<Widget> serviceToggle = <Widget>[
      Text(
        'FCL',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      Text(
        'LCL',
        style: TextStyle(fontWeight: FontWeight.bold),
      )
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
            ValueListenableBuilder<List<bool>>(
              valueListenable: selectedService,
              builder: (context, value, child) {
                return ToggleButtons(
                  onPressed: (int index) {
                    selectedService.value = List.generate(
                      value.length,
                      (i) => i == index,
                    );
                  },
                  children: serviceToggle,
                  isSelected: value,
                  selectedColor: Colors.white,
                  fillColor: Colors.blue.shade900.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(screenWidth * 0.04),
                  constraints: BoxConstraints(
                      minHeight: screenHeight * 0.06,
                      minWidth: screenWidth * 0.4),
                );
              },
            ),
            Container(
              margin: EdgeInsets.only(top: screenHeight * 0.02),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(screenWidth * 0.04),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: screenWidth * 0.01,
                      horizontal: screenWidth * 0.03),
                  child: Container(
                    margin: EdgeInsets.only(
                        left: screenWidth * 0.01, right: screenWidth * 0.03),
                    child: ValueListenableBuilder<String?>(
                      valueListenable: selectedValue,
                      builder: (context, value, child) {
                        return DropdownButton<String>(
                          borderRadius:
                              BorderRadius.circular(screenWidth * 0.04),
                          dropdownColor: Colors.white,
                          value: value, // Holds the currently selected value
                          hint: const Text(
                              'Available Capacity'), // Placeholder text
                          isExpanded:
                              true, // Ensures dropdown matches container width
                          underline:
                              const SizedBox(), // Removes default underline
                          icon: const Icon(
                              Icons.arrow_drop_down), // Dropdown icon
                          items: const [
                            DropdownMenuItem(
                              // these are the options in dropdown menu,
                              value: "Available Capacity",
                              child: Text("Available Capacity"),
                            ),
                            DropdownMenuItem(
                              value: "Capacity at Unloading",
                              child: Text("Capacity at Unloading"),
                            ),
                            DropdownMenuItem(
                              value: "Future Capacity",
                              child: Text("Future Capacity"),
                            ),
                          ],
                          onChanged: (String? newValue) {
                            selectedValue.value = newValue;
                            var selectedCapacity =
                                selectedValue.value! ?? 'Available Capacity';
                            fetchCapacity(selectedValue.value);
                          },
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
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
                    'Total (${availableCapacity?.data?.length ?? 0}):',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text('Dedicated(), ',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('Dynamic()',
                      style: TextStyle(fontWeight: FontWeight.bold))
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
                ? Center(
                    child: Container(
                    margin: EdgeInsets.all(screenWidth * 0.01),
                    child: Center(
                      child: CircularProgressIndicator(
                        color: Colors.blue.shade900,
                      ),
                    ),
                  ))
                : Expanded(
                    child: ((capacityAtUnloading?.data?.length ?? 0) > 0)
                        ? displayCapacity(screenHeight, screenWidth)
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

  Widget displayCapacity(double screenHeight, double screenWidth) {
    return ListView.builder(
        itemCount: availableCapacity?.data?.length ?? 0,
        itemBuilder: (context, index) {
          var res = availableCapacity?.data?[index];
          return Padding(
            padding: EdgeInsets.all(screenWidth * 0.02),
            child: Container(
              padding: EdgeInsets.symmetric(
                  vertical: screenHeight * 0.02,
                  horizontal: screenWidth * 0.01),
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
                  infoRow('Branch', '${res?.branch}'),
                  infoRow('FFV Name', '${res?.ffVname}'),
                  infoRow('Capacity Type', '${res?.capacityType}'),
                  infoRow('Vehicle Type', '${res?.vechileTypeName}'),
                  infoRow('Vehicle No.', '${res?.vechileNumber}'),
                  infoRow("Location", '${res?.locationName}'),
                ],
              ),
            ),
          );
        });
  }

  Widget infoRow(String label, String title) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(left: 5, bottom: 2),
              width: 100,
              child: Column(
                children: [
                  Text(
                    label,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black38),
                  ),
                ],
              ),
            ),
            Flexible(
              child: Text(
                title,
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        Divider(
          height: 5,
          thickness: 1,
          color: Colors.grey.withOpacity(0.3),
        )
      ],
    );
  }

  // Widget infoRow(String label, String value,
  //     {TextStyle? labelStyle, TextStyle? valueStyle}) {
  //   return Row(
  //     children: [
  //       Column(
  //         children: [
  //           Text(
  //             label,
  //             style: labelStyle ??
  //                 TextStyle(
  //                   fontWeight: FontWeight.normal,
  //                   fontSize: 14,
  //                   color: Colors.black.withOpacity(0.5),
  //                 ),
  //           ),
  //         ],
  //       ),
  //       SizedBox(
  //         width: 10,
  //       ),
  //       Column(
  //         children: [
  //           Text(
  //             value,
  //             style: valueStyle ??
  //                 const TextStyle(
  //                   fontWeight: FontWeight.bold,
  //                   fontSize: 14,
  //                   color: Colors.black,
  //                 ),
  //           ),
  //         ],
  //       )
  //     ],
  //   );
  // }
}
