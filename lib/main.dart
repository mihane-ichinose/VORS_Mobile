import 'package:flutter/material.dart';
import 'package:vors_project/login_page.dart';
import 'package:vors_project/restaurant_page.dart';
import 'package:vors_project/signup_page.dart';
import 'package:vors_project/user_page.dart';

import 'order_detail_page.dart';
import 'order_page.dart';

const apiUrl = "http://84.238.224.41:5005/";
int customerId = 0;
String username = "";

void main() => runApp(MyApp());
class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'VORS',
      theme: ThemeData(
        fontFamily: "Futura.bold",
      ),
      home: new LoginPage(),
      routes: {
        "/logout": (context) => new LoginPage(),
        "/login": (context) => new RestaurantPage(0, ""),
        "/user": (context) => new UserPage(),
        "/signup": (context) => new SignupPage(),
      },
    );
  }
}

