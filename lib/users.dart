import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

const mockUsers = {
  'sj4918@ic.ac.uk': '12345',
  '@.com': '.',
}; // Debug only.

const url = 'https://jsonplaceholder.typicode.com/Userss/1';

Future<User> fetchAuthentication(String credential, String password) async {
  final response = await http.get(
    Uri.parse(url),
    headers: {
      HttpHeaders.authorizationHeader: 'Basic your_api_token_here',
    },
  );

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    var responseJson = json.decode(response.body);
    print("Connection established.");
    return responseJson[''][''][''].map((p) => User.fromJson(p));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    print("Connection failed.");
    throw Exception('Connection failed.');
  }
}

Future<User> updateUsers(bool isAuthenticated, int customerId) async {
  final response = await http.put(
    Uri.parse(url),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      'isAuthenticated': isAuthenticated,
      'customerId': customerId,
    }),
  );

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return User.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to update Users.');
  }
}

class User {
  final bool isAuthenticated;
  final int customerId;

  User({
    required this.isAuthenticated,
    required this.customerId,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      isAuthenticated: json['isAuthenticated'],
      customerId: json['customerId'],
    );
  }

  bool getAuthentication() {
    return this.isAuthenticated;
  }

  int getCustomerId() {
    return this.customerId;
  }

}