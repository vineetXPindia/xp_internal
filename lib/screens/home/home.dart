import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xp_internal/constants/colors.dart';
import 'package:xp_internal/models/login_model.dart';
import 'package:xp_internal/screens/capacity/capacity.dart';
import 'package:xp_internal/screens/orders/book_new_order.dart';
import 'package:xp_internal/screens/orders/manage_lcl_orders.dart';
import 'package:xp_internal/screens/orders/manage_orders.dart';
import 'package:xp_internal/screens/orders/orders.dart';

import 'package:xp_internal/screens/profile/profile_page.dart';
import 'package:xp_internal/screens/tickets/raise_tickets.dart';
import 'package:xp_internal/screens/tracking/order_tracking.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  void initState() {
    super.initState();
    getUser();
  }

  String? firstName;
  Future<void> getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var loginData = prefs.getString('userResponse');
    LoginDataModel loginModel = LoginDataModel();
    if (loginData != null && loginData.isNotEmpty) {
      loginModel = loginDataModelFromJson(loginData.toString());
      setState(() {
        firstName = loginModel.data?.firstName;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    List<String> carouselItems = <String>[
      'lib/assets/cover_image/carousel1.png',
      'lib/assets/cover_image/carousel2.jpg'
    ];
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                height: screenHeight * 0.13,
              ),
              Positioned(
                top: screenHeight * 0.050,
                left: screenWidth * 0.05,
                right: screenWidth * 0.05,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      'lib/assets/icons/xp_logo_square.png',
                      height: screenHeight * 0.07,
                      width: screenHeight * 0.07,
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RaiseTickets(),
                            ),
                          );
                        },
                        child: Image.asset(
                          'lib/assets/icons/support.png',
                          height: screenHeight * 0.06,
                          width: screenHeight * 0.06,
                        ))
                  ],
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
                height: screenHeight * 0.08,
                child: profilePanel(context, screenWidth, screenHeight),
              ),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => OrdersPage()));
                },
                child: Container(
                  margin: EdgeInsets.only(
                      top: screenHeight * 0.02,
                      left: screenWidth * 0.06,
                      right: screenWidth * 0.03),
                  child: cardBuilder(
                    context,
                    screenWidth,
                    screenHeight,
                    'lib/assets/icons/orders.png',
                    'Orders',
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CapacityPage()));
                },
                child: Container(
                  margin: EdgeInsets.only(
                      top: screenHeight * 0.02,
                      left: screenWidth * 0.03,
                      right: screenWidth * 0.06),
                  child: cardBuilder(context, screenWidth, screenHeight,
                      'lib/assets/icons/capacity.png', 'Capacity'),
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => OrderTracking()));
            },
            child: Container(
              margin: EdgeInsets.symmetric(
                  vertical: screenHeight * 0.02,
                  horizontal: screenWidth * 0.06),
              width: screenWidth,
              height: screenHeight * 0.14,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white.withOpacity(0.70),
                boxShadow: [
                  BoxShadow(
                      offset: Offset(0, 2),
                      color: Colors.lightBlueAccent.withOpacity(0.5),
                      blurRadius: 5),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Track My Order',
                        style: TextStyle(
                            fontSize: screenWidth * 0.05,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Track order update with XP-India',
                        style: TextStyle(fontSize: screenWidth * 0.04),
                      ),
                    ],
                  ),
                  Image.asset(
                    height: screenHeight * 0.08,
                    width: screenHeight * 0.08,
                    'lib/assets/icons/tracking.png',
                  )
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
            width: screenWidth,
            height: screenHeight * 0.17,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white.withOpacity(0.70),
              boxShadow: [
                BoxShadow(
                    offset: Offset(0, 2),
                    color: Colors.lightBlueAccent.withOpacity(0.5),
                    blurRadius: 5),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      height: screenHeight * 0.08,
                      width: screenHeight * 0.08,
                      'lib/assets/icons/pod_image.png',
                    ),
                    Text(
                      'Check/Upload POD',
                      style: TextStyle(fontSize: screenWidth * 0.04),
                    )
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: screenHeight * 0.02,
          ),
          Container(
            width: screenWidth,
            height: screenHeight * 0.2,
            margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
            child: PageView.builder(
              controller: PageController(),
              itemCount: carouselItems.length *
                  1000, // Large arbitrary number to simulate infinite looping
              itemBuilder: (context, index) {
                final loopedIndex =
                    index % carouselItems.length; // Wrap around the index
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                            carouselItems[loopedIndex]), // Use loopedIndex
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(screenWidth * 0.05),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget profilePanel(
      BuildContext context, double screenWidth, double screenHeight) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ProfilePage()));
      },
      child: Container(
        padding: EdgeInsets.all(screenHeight * 0.02),
        width: screenWidth * 0.9,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white.withOpacity(0.70),
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 2),
                color: Colors.lightBlueAccent.withOpacity(0.5),
                blurRadius: 5),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Hi, $firstName',
              style: TextStyle(
                  fontSize: screenWidth * 0.06,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            Icon(Icons.arrow_forward_ios)
          ],
        ),
      ),
    );
  }

  // Widget manageOrdersTab(
  Future<void> _dialogBuilderManageOrders(
      BuildContext context, double screenHeight, double screenWidth) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Center(
            child: Text(
              'Choose Service Type',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ManageOrders()));
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.03,
                        vertical: screenHeight * 0.01),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(screenWidth * 0.025),
                      color: Colors.blue.shade900.withOpacity(0.7),
                    ),
                    child: Text(
                      'FCL',
                      style: TextStyle(
                          fontSize: screenWidth * 0.05,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ManageLclOrders()));
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.03,
                        vertical: screenHeight * 0.01),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade900.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(screenWidth * 0.025),
                    ),
                    child: Text(
                      'LCL',
                      style: TextStyle(
                          fontSize: screenWidth * 0.05,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Future<void> _dialogBuilder(
      BuildContext context, double screenHeight, double screenWidth) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Center(
            child: Text(
              'Choose Service Type',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BookNewOrder()));
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.03,
                        vertical: screenHeight * 0.01),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(screenWidth * 0.025),
                      color: Colors.blue.shade900.withOpacity(0.7),
                    ),
                    child: Text(
                      'FCL',
                      style: TextStyle(
                          fontSize: screenWidth * 0.05,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BookNewOrder()));
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.03,
                        vertical: screenHeight * 0.01),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade900.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(screenWidth * 0.025),
                    ),
                    child: Text(
                      'LCL',
                      style: TextStyle(
                          fontSize: screenWidth * 0.05,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget cardBuilder(BuildContext context, double screenWidth,
      double screenHeight, String imageAsset, String title) {
    return Container(
      height: screenHeight * 0.14,
      width: screenHeight * 0.183,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.70),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
              offset: Offset(0, 2),
              color: Colors.lightBlueAccent.withOpacity(0.5),
              blurRadius: 5),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            imageAsset,
            height: screenHeight * 0.06,
            width: screenHeight * 0.06,
          ),
          Text(
            title,
            style: TextStyle(
                fontSize: screenWidth * 0.05, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
