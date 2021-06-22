import 'dart:async';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;

const verifyUrl = 'http://84.238.224.41:5000/customer/verify';
const registerUrl = 'http://84.238.224.41:5000/customer/register';

Future<User> fetchAuthentication(String credential, String password) async {

  var bytes = utf8.encode(password);

  String passwordHash = sha256.convert(bytes).toString();

  final response = await http.get(
    Uri.parse(verifyUrl + "?usernameOrEmail="
              + credential + "&passwordHash=" + passwordHash),
    headers: {},
  );

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the user details
    print("Connection established.");
    return User.fromString(response.body);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    print("Connection failed.");
    throw Exception('Connection failed.');
  }
}

Future<String> fetchNewCustomer(String username, String email, String password) async {


  final response = await http.get(
    Uri.parse(registerUrl + "?name="
        + username + "&email=" + email + "&password=" + password),
    headers: {},
  );

  print(response.body);

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the user details
    print("Connection established.");
    return response.body;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    print("Connection failed.");
    throw Exception('Connection failed.');
  }
}

bool isEmailValid(String email) {
  return true;
}

class User {
  final int customerId;
  final String name;
  final String email;


  User({
    required this.customerId,
    required this.name,
    required this.email
  });


  // Details are of format "<id>,<name>,<email>" or just "-1"
  factory User.fromString(String userDetails) {
    var details = userDetails.split(",");
    int id = int.parse(details.elementAt(0));
    String name = "";
    String email = "";

    if (id != -1) {
      name = details.elementAt(1);
      email = details.elementAt(2);
    }
    return User(
      customerId: id,
      name: name,
      email: email
    );
  }

  int getCustomerId() {
    return this.customerId;
  }

}