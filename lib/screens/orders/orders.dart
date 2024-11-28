import 'package:flutter/material.dart';
import 'package:xp_internal/constants/colors.dart';
import 'package:xp_internal/screens/orders/book_new_order.dart';
import 'package:xp_internal/screens/orders/manage_orders.dart';
import '../../widgets/top_bar.dart';

class OrdersPage extends StatefulWidget {
  OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  List<bool> selectedService = <bool>[true, false];
  final String title = 'My Orders';
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: newCardBG,
        title: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      backgroundColor: newCardBG,
      body: Container(
        padding: EdgeInsets.symmetric(
            vertical: screenHeight * 0.01, horizontal: screenWidth * 0.05),
        child: Column(
          children: [
            // TopBar(
            //   screenWidth: screenWidth,
            //   screenHeight: screenHeight,
            //   title: title,
            // ),
            Container(
              padding: EdgeInsets.all(screenWidth * 0.03),
              child: LayoutBuilder(
                builder: (context, constraints) => ToggleButtons(
                  //this toggle is not working
                  constraints: BoxConstraints.expand(
                      width: screenWidth * 0.4, height: screenHeight * 0.06),
                  borderRadius: BorderRadius.all(
                    Radius.circular(screenWidth * 0.04),
                  ),
                  textStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: screenWidth * 0.05,
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
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => BookNewOrder()));
              },
              child: _cardBuilder('Book New Order',
                  'lib/assets/icons/orders.png', screenHeight, screenWidth),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ManageOrders()));
              },
              child: _cardBuilder('Manage Orders',
                  'lib/assets/icons/manage.png', screenHeight, screenWidth),
            )
          ],
        ),
      ),
    );
  }

  Widget _cardBuilder(
      String title, String assetPath, double screenHeight, double screenWidth) {
    return Container(
      margin: EdgeInsets.only(top: screenHeight * 0.035),
      width: screenWidth * 0.6,
      height: screenHeight * 0.25,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(screenWidth * 0.07),
        boxShadow: [
          BoxShadow(
              offset: Offset(0, 2),
              color: Colors.black26.withOpacity(0.3),
              blurRadius: 5),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(assetPath, height: screenHeight * 0.08),
          SizedBox(
            height: screenHeight * 0.02,
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
