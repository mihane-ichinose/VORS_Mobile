import 'package:flutter/material.dart';
import 'package:vors_project/util/restaurant.dart';

TextField newSearchField(TextStyle style) {
  return TextField(
    obscureText: false,
    style: style,
    decoration: InputDecoration(
      filled: true,
      fillColor: Color(0xFF43F2EB),
      contentPadding: EdgeInsets.all(15.0),
      hintText: "Search...",
      hintStyle: TextStyle(
        fontFamily: 'Futura',
        color: Colors.white,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(32.0),
        borderSide: BorderSide.none,
      ),
    ),
  );
}

Scaffold restaurantBox(Restaurant restaurant) {
  return Scaffold(
    backgroundColor: Color(0xFF17B2E0),
    body: SingleChildScrollView(
      child: Center(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(36.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 40.0,
                ),
                Text("Sign Up", style: TextStyle(fontFamily: "Futura", fontSize: 90, color: Colors.black)),
                SizedBox(
                  height: 10.0,
                ),
                Text("Virtual ordering", style: TextStyle(fontFamily: "Futura", fontSize: 25, color: Colors.black)),
                SizedBox(
                  height: 10.0,
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}