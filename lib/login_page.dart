import 'package:flutter/material.dart';
import 'package:vors_project/users.dart';

class LoginPage extends StatefulWidget {
  //LoginPage({Key? key, Title? title}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final _loginKey = GlobalKey<FormState>();

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  Future<bool> _gotoRestaurant(BuildContext context) {
    return Navigator.of(context)
        .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false)
    // We will clean all existing routes when login.
        .then((_) => false);
  }

  Future<bool> _signup(BuildContext context) {
    return Navigator.of(context)
        .pushReplacementNamed('/signup')
    // We don't want to pop the signup here.
        .then((_) => false);
  }

  TextStyle style = TextStyle(
    fontFamily: 'Futura',
    color: Colors.white,
    fontSize: 26,
  );

  @override
  Widget build(BuildContext context) {

    bool userEmpty = false;
    bool userNotExists = false;
    bool passwordMismatch = false;
    bool passwordEmpty = false;

    final userNameField = TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          userEmpty = true;
          return ''; // Username empty.
        } else {
          userEmpty = false;
        }
        if (!mockUsers.containsKey(value)) {
          userNotExists = true;
          return ''; // User not exists
        } else {
          userNotExists = false;
        }
        if (mockUsers[value] != passwordController.text) {
          passwordMismatch = true;
          return ''; // Password does not match
        } else {
          passwordMismatch = false;
        }
        return null;
      },
      controller: usernameController,
      obscureText: false,
      style: style,
      decoration: InputDecoration(
        errorMaxLines: 1,
        errorText: 'Null',
        errorStyle: TextStyle(
          color: Colors.transparent,
          fontSize: 0,
        ),
        filled: true,
        fillColor: Color(0xFF43F2EB),
        contentPadding: EdgeInsets.all(15.0),
        hintText: "Username",
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

    final passwordField = TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty){
          passwordEmpty = true;
          return ''; // The password is empty.
        } else {
          passwordEmpty = false;
        }
        return null;
      },
      controller: passwordController,
      obscureText: true,
      // The obscured word seems not supportable by font Futura.
      style: TextStyle(color: Colors.white, fontSize: 26),
      decoration: InputDecoration(
        errorMaxLines: 1,
        errorText: 'Null',
        errorStyle: TextStyle(
          color: Colors.transparent,
          fontSize: 0,
        ),
        filled: true,
        fillColor: Color(0xFF43F2EB),
        contentPadding: EdgeInsets.all(15.0),
        hintText: "Password",
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

    final loginButton = Material(
      borderRadius: BorderRadius.circular(30.0),
      color: Colors.white,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(15.0),
        onPressed: () {
          if (_loginKey.currentState!.validate()) {
            // If both forms are valid, displays a snackbar.

            userNotExists = passwordMismatch = passwordEmpty = true;
            _gotoRestaurant(context);
            } else {
            if (userEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Please enter your username.'),
                  backgroundColor: Colors.deepOrange,
                  action: SnackBarAction(
                    label: "GOT IT",
                    textColor: Colors.white,
                    onPressed: () {
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    },
                  ),
                ),
              );
            } else if (userNotExists) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Username does not exist.'),
                  backgroundColor: Colors.deepOrange,
                  action: SnackBarAction(
                    label: "GOT IT",
                    textColor: Colors.white,
                    onPressed: () {
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    },
                  ),
                ),
              );
            } else if (passwordEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Password is empty.'),
                  backgroundColor: Colors.deepOrange,
                  action: SnackBarAction(
                    label: "GOT IT",
                    textColor: Colors.white,
                    onPressed: () {
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    },
                  ),
                ),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Please check your password.'),
                  backgroundColor: Colors.deepOrange,
                  action: SnackBarAction(
                    label: "GOT IT",
                    textColor: Colors.white,
                    onPressed: () {
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    },
                  ),
                ),
              );
            }
          }
        },
        child: Text("Log in",
          textAlign: TextAlign.center,
          style: style.copyWith(
            color: Color(0xFF17B2E0),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );

    final signUpButton = Material(
      borderRadius: BorderRadius.circular(30.0),
      color: Colors.transparent,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(15.0, 0, 15.0, 0),
        onPressed: () => _signup(context),
        child: Text("Sign up.",
            textAlign: TextAlign.center,
            style: style.copyWith(
              color: Color(0xFF43F2EB),
              fontSize: 20,
              fontWeight: FontWeight.bold,
            )),
      ),
    );

    final forgotButton = Material(
      borderRadius: BorderRadius.circular(30.0),
      color: Colors.transparent,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(15.0, 0, 15.0, 0),
        onPressed: () {},
        child: Text("here.",
            textAlign: TextAlign.center,
            style: style.copyWith(
              color: Color(0xFF43F2EB),
              fontSize: 15,
              fontWeight: FontWeight.bold,
            )),
      ),
    );

    return Scaffold(
      backgroundColor: Color(0xFF17B2E0),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            // color: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 40.0,
                  ),
                  Text("VORS", style: TextStyle(fontFamily: "Futura", fontSize: 90, color: Colors.white)),
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
                  Form(
                    key: _loginKey,
                    child: Column(
                      children: <Widget> [
                        Container(
                          width: 300,
                          child: userNameField,
                        ),
                        SizedBox(height: 25.0),
                        Container(
                          width: 300,
                          child: passwordField,
                        ),
                        SizedBox(
                          height: 35.0,
                        ),
                        Container(
                          width: 150,
                          child: loginButton,
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                      ],
                    )
                  ),
                  Text("Don't have an account?", style: TextStyle(fontFamily: "Futura", fontSize: 20, color: Colors.white)),
                  Container(
                    width: 150,
                    child: signUpButton,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text("Forgot your password?", style: TextStyle(fontFamily: "Futura", fontSize: 15, color: Colors.white)),
                  Container(
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Center(
                            child: Text("Click ", style: TextStyle(fontFamily: "Futura", fontSize: 15, color: Colors.white)),
                          ),
                          Center(
                            child: Container(
                              width: 70,
                              child: forgotButton,
                            ),
                          ),
                        ],
                      ),
                    ),
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