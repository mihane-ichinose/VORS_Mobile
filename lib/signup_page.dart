import 'package:flutter/material.dart';
import 'package:vors_project/util/home_page_items.dart';

class SignupPage extends StatefulWidget {
  final int customerId;
  final String username;

  SignupPage(this.customerId, this.username);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {

  final usernameController = TextEditingController();

  Future<bool> _gotoRestaurant(BuildContext context) {
    SignupPage signupPage = new SignupPage(1, usernameController.text); // Debug only.
    return Navigator.of(context)
        .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false,
    arguments: signupPage).then((_) => false);
    // We will clean all existing routes when login.

  }

  Future<bool> _gotoLogin(BuildContext context) {
    return Navigator.of(context)
        .pushReplacementNamed('/logout')
    // Back to login.
        .then((_) => false);
  }

  TextStyle style = TextStyle(
    fontFamily: 'Futura',
    color: Colors.white,
    fontSize: 26,
  );

  @override
  Widget build(BuildContext context) {

    final userNameField = DefaultSignUpTextField()
        .withStyle(style)
        .withText("Username")
        .build();

    final passwordField = DefaultSignUpTextField()
        .withStyle(style)
        .withText("Password")
        .build();

    final confirmPasswordField = DefaultSignUpTextField()
        .withStyle(style)
        .withText("Confirm password")
        .build();

    final signupButton = Material(
      borderRadius: BorderRadius.circular(30.0),
      color: Colors.white,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(15.0),
        onPressed: () {
          _gotoLogin(context);
        },
        child: Text("Sign up",
          textAlign: TextAlign.center,
          style: style.copyWith(
            color: Color(0xFF17B2E0),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );

    final loginButton = Material(
      borderRadius: BorderRadius.circular(30.0),
      color: Colors.transparent,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(15.0, 0, 15.0, 0),
        onPressed: () => _gotoLogin(context),
        child: Text("Back to login.",
            textAlign: TextAlign.center,
            style: style.copyWith(
              color: Color(0xFF43F2EB),
              fontSize: 20,
              fontWeight: FontWeight.bold,
            )),
      ),
    );

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
                  Text("Sign Up", style: TextStyle(fontFamily: "Futura", fontSize: 90, color: Colors.white)),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text("Virtual ordering", style: TextStyle(fontFamily: "Futura", fontSize: 25, color: Colors.white)),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text("for", style: TextStyle(fontFamily: "Futura", fontSize: 25, color: Colors.white)),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text("Rapid service", style: TextStyle(fontFamily: "Futura", fontSize: 25, color: Colors.white)),
                  SizedBox(height: 45.0, width: 20),
                  Container(
                    width: 300,
                    child: userNameField,
                  ),
                  SizedBox(height: 25.0),
                  Container(
                    width: 300,
                    child: passwordField,
                  ),
                  SizedBox(height: 25.0),
                  Container(
                    width: 300,
                    child: confirmPasswordField,
                  ),
                  SizedBox(
                    height: 35.0,
                  ),
                  Container(
                    width: 150,
                    child: signupButton,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text("Already have an account?", style: TextStyle(fontFamily: "Futura", fontSize: 20, color: Colors.white)),
                  Container(
                    width: 150,
                    child: loginButton,
                  ),
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
}