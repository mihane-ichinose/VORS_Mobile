import 'package:flutter/material.dart';
import 'package:vors_project/login_page.dart';
import 'package:vors_project/restaurant_page.dart';
import 'package:vors_project/signup_page.dart';
import 'package:vors_project/user_page.dart';

import 'order_page.dart';

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
      home: OrderPage(0, "", 2, "Pizzeria", 1),
      routes: {
        "/logout": (context) => new LoginPage(0, ""),
        "/login": (context) => new RestaurantPage(0, "", 2, "Pizzeria", "wr"),
        "/user": (context) => new UserPage(),
        "/signup": (context) => new SignupPage(),
      },
    );
  }
}

