import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xp_internal/constants/colors.dart';
import 'package:xp_internal/models/login_model.dart';
import 'package:http/http.dart' as http;
import 'package:xp_internal/models/tickets/raised_tickets_model.dart';

class RaiseTickets extends StatefulWidget {
  RaiseTickets({super.key});

  @override
  State<RaiseTickets> createState() => _RaiseTicketsState();
}

class _RaiseTicketsState extends State<RaiseTickets> {
  final TextEditingController _descriptionController = TextEditingController();
  final ValueNotifier<List<bool>> selectedService =
      ValueNotifier([true, false]);
  final ValueNotifier<String?> selectedPanel = ValueNotifier(null);
  final ValueNotifier<String?> selectedSubPanel = ValueNotifier(null);
  int _countWords(String text) {
    return text.trim().isEmpty ? 0 : text.trim().split(RegExp(r'\s+')).length;
  }

  bool isLoading = true;
  RaisedTicketsModel? raisedTickets;
  late String userId;
  late String userType;
  late String authToken;
  late String userName;
  Future<void> initializeUser() async {
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userData = prefs.getString('userResponse');
    LoginDataModel loginModel = LoginDataModel();
    if (userData != null && userData.isNotEmpty) {
      loginModel = loginDataModelFromJson(userData.toString());
      String? firstName = loginModel.data?.firstName;
      String? lastName = loginModel.data?.lastName;
      userId = loginModel.data!.userId.toString();
      userType = loginModel.data!.userType.toString();
      authToken = loginModel.data!.authToken.toString();
      userName = '$firstName $lastName';
    }
  }

  @override
  void initState() {
    super.initState();
    getRaisedTickets();
  }

  Future<void> getRaisedTickets() async {
    await initializeUser();
    var headers = {
      "UserId": userId,
      "UserType": userType,
      "AuthToken": authToken,
      "UserName": userName,
      "Content-Type": "application/json"
    };
    var body = jsonEncode({
      "UserId": null,
      "StartIndex": 1,
      "EndIndex": 5,
      "FromDate": null,
      "ToDate": null,
      "TicketNO": "",
      "TicketRaisedBy": "",
      "TicketAssignedTo": "",
      "TicketStatus": null,
      "TicketPriorityStatus": null,
      "FilterType": "YTD",
      "ScreenName": "inProgress"
    });
    try {
      var response = await http.post(
        Uri.parse('https://qacore.xpindia.in/api/v2/get-ticket'),
        headers: headers,
        body: body,
      );
      if (response.statusCode == 200) {
        setState(() {
          raisedTickets = raisedTicketsModelFromJson(response.body);
          print(response.body);
          isLoading = false;
        });
      } else {
        setState(() {
          print('unable to load: ${response.body}');
          isLoading = false;
        });
      }
    } catch (e) {
      print('Exception: $e');
    }
  }

  String _trimToWordLimit(String text, int wordLimit) {
    List<String> words = text.trim().split(RegExp(r'\s+'));
    return words.take(wordLimit).join(' ');
  }

  final List<String> toggles = ['Raise Ticket', 'Raised Tickets'];
  final List<String> panels = ['Orders', 'Capacity', 'LoadBoard', 'Customers'];
  final List<String> subPanels = ['Sub1', 'Sub2', 'Sub3'];

  Widget build(BuildContext context) {
    final String title = 'Tickets';
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    final List<Widget> serviceToggle = <Widget>[
      Text('Raise Ticket', style: TextStyle(fontWeight: FontWeight.bold)),
      Text('Raised Tickets', style: TextStyle(fontWeight: FontWeight.bold))
    ];

    return Scaffold(
      backgroundColor: newCardBG,
      appBar: AppBar(
        centerTitle: true,
        surfaceTintColor: Colors.transparent,
        backgroundColor: newCardBG,
        title: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: screenHeight * 0.02),
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
                isSelected: value,
                selectedColor: Colors.white,
                fillColor: Colors.blue.shade900,
                borderRadius: BorderRadius.circular(screenWidth * 0.04),
                constraints: BoxConstraints(
                    minHeight: screenHeight * 0.06,
                    minWidth: screenWidth * 0.4),
                children: serviceToggle,
              );
            },
          ),
          // _buildToggleButtons(screenWidth, screenHeight),
          SizedBox(height: screenHeight * 0.02),
          ValueListenableBuilder(
              valueListenable: selectedService,
              builder: (context, value, child) {
                return value[0]
                    ? _buildRaiseTicketForm(screenWidth, screenHeight)
                    : Flexible(
                        child:
                            _buildRaisedTicketsList(screenWidth, screenHeight));
              }),
        ],
      ),
    );
  }

  // Widget _buildToggleButtons(double screenWidth, double screenHeight) {
  Widget _buildRaiseTicketForm(double screenWidth, double screenHeight) {
    return Column(
      children: [
        _buildTextField('Executive Name', screenWidth, screenHeight),
        SizedBox(height: screenHeight * 0.02),
        _buildDropdown('Select Panel', panels, selectedPanel.value,
            (String? newValue) {
          selectedPanel.value = newValue;
        }, screenWidth),
        SizedBox(height: screenHeight * 0.02),
        _buildDropdown(
          'Select Sub Panel',
          subPanels,
          selectedSubPanel.value,
          (String? newValue) {
            selectedSubPanel.value = newValue;
          },
          screenWidth,
        ),
        SizedBox(height: screenHeight * 0.02),
        _buildDescriptionField(screenWidth, screenHeight),
        SizedBox(height: screenHeight * 0.02),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text('Attach Supporting Document'),
          ],
        ),
        SizedBox(height: screenHeight * 0.04),
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Colors.blue.shade900,
              borderRadius: BorderRadius.circular(screenWidth * 0.025),
              boxShadow: [
                BoxShadow(
                    offset: Offset(0, 3), color: Colors.black38, blurRadius: 5)
              ]),
          child: Text(
            'Raise Ticket',
            style: TextStyle(
                color: Colors.white,
                fontSize: screenWidth * 0.045,
                fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  Widget _buildRaisedTicketsList(double screenWidth, double screenHeight) {
    var data = raisedTickets?.data;
    return ListView.builder(
      shrinkWrap: true,
      itemCount: raisedTickets?.data?.length ?? 0,
      itemBuilder: (context, index) {
        String priorityLabel;
        switch (data![index].priority) {
          case 1:
            priorityLabel = "High";
            break;
          case 2:
            priorityLabel = "Medium";
            break;
          case 3:
            priorityLabel = "Low";
            break;
          default:
            priorityLabel = "High";
        }
        String statusLabel;
        switch (data[index].status) {
          case 1:
            statusLabel = "Pending";
            break;
          case 2:
            statusLabel = "In Progress";
            break;
          case 3:
            statusLabel = "Closed";
            break;
          default:
            statusLabel = "Pending";
        }
        // var res = selectedValue == 'Available Capacity' ? availableCapacity?.data![index] : capacityAtUnloading?.data![index];
        return Padding(
          padding: EdgeInsets.all(screenWidth * 0.02),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
            padding: EdgeInsets.symmetric(
                vertical: screenHeight * 0.02, horizontal: screenWidth * 0.03),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    infoRowLeft('Ticket Number', '${data[index].ticketNo}'),
                    infoRowRight('Priority', priorityLabel)
                  ],
                ),
                Divider(
                  color: Colors.lightBlueAccent.withOpacity(0.25),
                  height: screenHeight * 0.01,
                  indent: screenWidth * 0.04,
                  endIndent: screenWidth * 0.04,
                ),
                infoRow(screenWidth, screenHeight, 'Ticket Issued Date',
                    formatDate(data[index].startDate.toString())),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    infoRowLeft('Raised By', '${data[index].userName}'),
                    infoRowRight('Assigned By', '${data[index].assignedBy}'),
                    infoRowRight('Assigned To', '${data[index].assignedTo}')
                  ],
                ),
                infoRow(screenWidth, screenHeight, 'Assigned D & T: ',
                    formatDate(data[index].assignedDate.toString())),
                infoRow(screenWidth, screenHeight, 'Start Date Time',
                    formatDate(data[index].startDate.toString())),
                infoRow(screenWidth, screenHeight, 'Status', statusLabel)
                // SizedBox(
                //   height: screenHeight * 0.005,
                // ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTextField(String hint, double screenWidth, double screenHeight) {
    return SizedBox(
      width: screenWidth * 0.9,
      child: TextField(
        decoration: InputDecoration(
          hintText: hint,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(screenWidth * 0.04),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _buildDropdown(
    String hint,
    List<String> items,
    String? selectedValue,
    ValueChanged<String?> onChanged,
    double screenWidth,
  ) {
    return SizedBox(
      width: screenWidth * 0.9,
      child: ValueListenableBuilder<String?>(
        valueListenable: selectedPanel,
        builder: (context, value, child) {
          return DropdownButtonFormField<String>(
            value: selectedValue,
            items: items
                .map((item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(item),
                    ))
                .toList(),
            onChanged: onChanged,
            dropdownColor: Colors.white,
            decoration: InputDecoration(
              hintText: hint,
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(screenWidth * 0.04),
                borderSide: BorderSide.none,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildDescriptionField(double screenWidth, double screenHeight) {
    return SizedBox(
      width: screenWidth * 0.9,
      child: TextField(
        controller: _descriptionController,
        maxLines: 4,
        onChanged: (text) {
          if (_countWords(text) > 300) {
            _descriptionController.text = _trimToWordLimit(text, 300);
            _descriptionController.selection = TextSelection.fromPosition(
              TextPosition(offset: _descriptionController.text.length),
            );
          }
        },
        decoration: InputDecoration(
          hintText: 'Provide Description (max 300 words)',
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(screenWidth * 0.04),
            borderSide: BorderSide.none,
          ),
        ),
      ),
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

  String formatDate(String dateTime) {
    try {
      DateTime parsedDate = DateTime.parse(dateTime);
      return DateFormat('dd-MM-yyyy hh:mm a')
          .format(parsedDate); // Returns date only
    } catch (e) {
      return 'Invalid Date';
    }
  }

  // String formatTime(String dateTime) {
  //   try {
  //     DateTime parsedDate = DateTime.parse(dateTime);
  //     return DateFormat('hh:mm a')
  //         .format(parsedDate); // Returns time in hh:mm AM/PM
  //   } catch (e) {
  //     return 'Invalid Time';
  //   }
  // }
}
