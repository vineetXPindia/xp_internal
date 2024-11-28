import 'package:flutter/material.dart';
import 'package:xp_internal/constants/colors.dart';

class ManageLclOrders extends StatefulWidget {
  const ManageLclOrders({super.key});

  @override
  State<ManageLclOrders> createState() => _ManageLclOrdersState();
}

class _ManageLclOrdersState extends State<ManageLclOrders> {
  List<bool> selectedToggle = <bool>[true, false];
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    String title = 'Manage LCL Orders';

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
            Container(
              decoration: BoxDecoration(
                color: Colors.blue.shade900,
                borderRadius: BorderRadius.circular(screenWidth * 0.035),
              ),
              padding: EdgeInsets.all(screenWidth * 0.015),
              child: LayoutBuilder(
                builder: (context, constraints) => ToggleButtons(
                  constraints: BoxConstraints.expand(width: screenWidth / 2.3),
                  borderRadius: BorderRadius.all(
                    Radius.circular(screenWidth * 0.03),
                  ),
                  textStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: screenWidth * 0.04,
                  ),
                  selectedColor: Colors.black,
                  fillColor: Colors.white,
                  color: Colors.white,
                  isSelected: selectedToggle,
                  children: <Widget>[
                    Text('Next 7 Days'),
                    Text('Beyond 7 Days'),
                  ],
                  onPressed: (int index) {
                    setState(() {
                      for (int i = 0; i < selectedToggle.length; i++) {
                        selectedToggle[i] = i == index;
                      }
                    });
                  },
                ),
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
}
