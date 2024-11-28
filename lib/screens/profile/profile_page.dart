import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xp_internal/constants/colors.dart';
import 'package:xp_internal/models/login_model.dart';
import 'package:xp_internal/screens/home/home.dart';
import 'package:xp_internal/screens/login/login_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? firstName;
  String? lastName;
  String? email;
  String? phoneNumber;
  String? dateOfJoining;

  @override
  void initState() {
    super.initState();
    loadUserInfo();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    loadUserInfo(); // Load user info whenever the widget is built
  }

  Future<void> loadUserInfo() async {
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    LoginDataModel loginModel = LoginDataModel();
    var userData = prefs.getString('userResponse');

    if (userData != null && userData.isNotEmpty) {
      loginModel =
          loginDataModelFromJson(prefs.getString("userResponse").toString());
      setState(() {
        firstName = loginModel.data?.firstName;
        lastName = loginModel.data?.lastName;
        email = loginModel.data?.email;
        phoneNumber = loginModel.data?.phone;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String title = "My Profile";
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: newCardBG,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        height: screenHeight * 0.7,
        margin: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.1, vertical: screenHeight * 0.05),
        padding: EdgeInsets.symmetric(
            vertical: screenHeight * 0.02, horizontal: screenWidth * 0.05),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(screenWidth * 0.05),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                offset: Offset(3, 3),
                color: Colors.grey.withOpacity(0.3),
                blurRadius: 5,
              )
            ]),
        child: Column(
          children: [
            profileImage(context, screenWidth, screenHeight),
            SizedBox(
              height: screenHeight * 0.02,
            ),
            // Edit button
            GestureDetector(
              onTap: () {
                loadUserInfo();
              },
              child: Container(
                padding: EdgeInsets.all(screenWidth * 0.02),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(screenWidth * 0.03),
                ),
                child: Text(
                  'Edit Details',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: screenWidth * 0.04),
                ),
              ),
            ),
            SizedBox(
              height: screenHeight * 0.03,
            ),
            infoCard(context, screenHeight, screenWidth),
          ],
        ),
      ),
    );
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('userResponse');
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
      (Route<dynamic> route) => false,
    );
  }

  Widget profileImage(
      BuildContext context, double screenWidth, double screenHeight) {
    return Container(
      height: screenHeight * 0.15,
      width: screenHeight * 0.15,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(screenWidth * 0.5),
      ),
      child: Icon(
        Icons.person,
        size: screenWidth * 0.3,
        color: Colors.white,
      ),
    );
  }

  Widget infoCard(
      BuildContext context, double screenHeight, double screenWidth) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: EdgeInsets.all(screenWidth * 0.02),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black12.withOpacity(0.6),
                offset: Offset(1, 2),
                blurRadius: 5,
              )
            ],
            color: Colors.white,
            borderRadius: BorderRadius.circular(screenWidth * 0.02),
          ),
          child: Column(
            children: [
              infoRow('First Name', firstName, screenHeight, screenWidth),
              infoRow('Last Name', lastName, screenHeight, screenWidth),
              infoRow('Email', email, screenHeight, screenWidth),
              infoRow('Phone Number', phoneNumber, screenHeight, screenWidth),
              infoRow('Date of Joining', "", screenHeight, screenWidth),
            ],
          ),
        ),
        SizedBox(
          height: screenHeight * 0.04,
        ),
        GestureDetector(
          onTap: () async {
            await logout();
          },
          child: Container(
            padding: EdgeInsets.all(screenWidth * 0.02),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(screenWidth * 0.03),
            ),
            child: Text(
              'Logout',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: screenWidth * 0.04),
            ),
          ),
        )
      ],
    );
  }

  Widget infoRow(
      String label, String? value, double screenHeight, double screenWidth) {
    return Container(
      margin: EdgeInsets.only(bottom: screenHeight * 0.03),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "$label:",
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
          Text(
            value ?? "",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
