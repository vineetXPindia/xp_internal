import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xp_internal/models/login_model.dart';
import 'package:xp_internal/screens/capacity/capacity.dart';
import 'package:xp_internal/screens/home/home.dart';

import 'package:xp_internal/screens/login/login_page.dart';
import 'package:xp_internal/screens/orders/book_new_order.dart';
import 'package:xp_internal/screens/orders/manage_orders.dart';
import 'package:xp_internal/screens/orders/orders.dart';
import 'package:xp_internal/screens/profile/profile_page.dart';
import 'package:xp_internal/screens/tracking/order_tracking.dart';

Future<void> main() async {
  String? userId;
  String? authToken;
  String? userType;
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var loginData = prefs.getString('userResponse');
  LoginDataModel loginModel = LoginDataModel();
  if (loginData != null && loginData.isNotEmpty) {
    loginModel = loginDataModelFromJson(loginData.toString());
    userId = loginModel.data?.userId;
    authToken = loginModel.data?.authToken;
    userType = loginModel.data?.userType;
  }

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: loginModel.data?.authToken == null ? LoginPage() : Home(),
    routes: {
      '/Home': (context) => const Home(),
      '/LoginPage': (context) => LoginPage(),
    },
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'XP Internal',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: CapacityPage(),
    );
  }
}
