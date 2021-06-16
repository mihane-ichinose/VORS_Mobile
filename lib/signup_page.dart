import 'package:flutter/material.dart';
import 'package:vors_project/util/home_page_items.dart';
import 'package:vors_project/util/users.dart';

class SignupPage extends StatefulWidget {

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {

  final usernameController = TextEditingController();

  bool connectionFailed = false;
  bool usernameFree = true;
  bool emailFree = true;

  Future<void> registerUser(String name, String email, String password) async {
    try {
      String result = await fetchNewCustomer(name, email, password);
      if (result == "1") {
        usernameFree = false;
      } else if (result == "2") {
        emailFree = false;
      }
      connectionFailed = false;
    } catch (e) {
      print(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(
        DefaultSnackBar().withText('Error: Connection failed.', context),
      );
      connectionFailed = true;
    }
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

    final emailField = DefaultSignUpTextField()
        .withStyle(style)
        .withText("Email")
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
          String name = userNameField.controller!.text;
          String email = emailField.controller!.text;
          String password = passwordField.controller!.text;
          String confirmedPassword = confirmPasswordField.controller!.text;

          if (name.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              DefaultSnackBar().withText('Please enter your username.', context),
            );
            return;
          } else if (email.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              DefaultSnackBar().withText(
                  'Please enter your email.', context),
            );
            return;
          } else if (!isEmailValid(email)) {
            ScaffoldMessenger.of(context).showSnackBar(
              DefaultSnackBar().withText(
                  'Please enter a real email.', context),
            );
            return;
          } else if (password.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              DefaultSnackBar().withText(
                  'Please enter your password.', context),
            );
            return;
          } else if (confirmedPassword.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              DefaultSnackBar().withText(
                  'Please confirm your password.', context),
            );
            return;
          } else if (password != confirmedPassword) {
            ScaffoldMessenger.of(context).showSnackBar(
              DefaultSnackBar().withText(
                  'Your confirmed password doesn\'t match.', context),
            );
            return;
          }

          usernameFree = true;
          emailFree = true;
          registerUser(name, email, password).then((value) {
            if (!usernameFree) {
              ScaffoldMessenger.of(context).showSnackBar(
                DefaultSnackBar().withText(
                    'Username is already taken.', context),
              );
            } else if (!emailFree) {
              ScaffoldMessenger.of(context).showSnackBar(
                DefaultSnackBar().withText(
                    'Email is already taken.', context),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                DefaultSnackBar().withText(
                    'User successfully registered.', context),
              );
              _gotoLogin(context);
            }
          });
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
                    child: emailField,
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