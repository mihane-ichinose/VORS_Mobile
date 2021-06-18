import 'package:flutter/material.dart';
import 'package:vors_project/main.dart';
import 'package:vors_project/restaurant_page.dart';
import 'package:vors_project/user_page.dart';
import 'package:vors_project/util/users.dart';
import 'package:vors_project/util/home_page_items.dart';

class LoginPage extends StatefulWidget {

  LoginPage();

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final _loginKey = GlobalKey<FormState>();

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  User user = User(customerId: -1, name: "", email: "");
  bool connectionFailed = false;

  Future<void> authenticateUser(String credential, String password) async {
    try {

      user =  await fetchAuthentication(credential, password);
      customerId = user.customerId;
      username = user.name;
      email = user.email;
      connectionFailed = false;
    } catch (e) {
      print(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(
        DefaultSnackBar().withText('Error: Connection failed.', context),
      );
      connectionFailed = true;
    }
  }

  @override
  void initState() {
    super.initState();
  }


  Future<Object?> _gotoRestaurant(BuildContext context, LoginPage loginPage) {
    return Navigator.of(context)
        .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false,
        arguments: loginPage).then((_) => false);
    // We will clean all existing routes and pass in customerId when login.

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

    String credential = "";
    String password = "";

    final userNameField = DefaultLoginTextFormField()
        .withText("Username")
        .withController(usernameController)
        .withStyle(style)
        .build();


    final passwordField = DefaultLoginTextFormField()
        .withStyle(style)
        .withController(passwordController)
        .withText("Password")
        .buildAsPasswordField();

    final loginButton = Material(
      borderRadius: BorderRadius.circular(30.0),
      color: Colors.white,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(15.0),
        onPressed: () {
          credential = usernameController.text;
          password = passwordController.text;

          if (credential.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              DefaultSnackBar().withText('Please enter your username or email.', context),
            );
            return;
          } else if (password.isEmpty) { // else
            ScaffoldMessenger.of(context).showSnackBar(
              DefaultSnackBar().withText(
                  'Please enter your password.', context),
            );
            return;
          }

          authenticateUser(credential, password).then((value) {
          if (connectionFailed) return;
          // Connection failed message has the highest priority.
          else {
            if (user.customerId != -1) {
              // If both forms are valid and server is authenticated,
              // go to the restaurant page.
              LoginPage loginPage = new LoginPage();
              _gotoRestaurant(context, loginPage);
            } else if (user.customerId == -1) {
              ScaffoldMessenger.of(context).showSnackBar(
                DefaultSnackBar().withText('Please check your username and password.', context),
              );
            }
          }});
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
        child: Text("Click here.",
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
                  Text("Virtual Ordering", style: TextStyle(fontFamily: "Futura", fontSize: 25, color: Colors.white)),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text("for", style: TextStyle(fontFamily: "Futura", fontSize: 25, color: Colors.white)),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text("Rapid Service", style: TextStyle(fontFamily: "Futura", fontSize: 25, color: Colors.white)),
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
                            child: Container(
                              width: 100,
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