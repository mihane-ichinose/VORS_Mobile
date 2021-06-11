// import 'package:flutter/scheduler.dart' show timeDilation;
// import 'package:flutter/material.dart';
// import 'package:flutter_login/flutter_login.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'constants.dart';
// import 'custom_route.dart';
// import 'restaurant_page.dart';
// import 'users.dart';
//
// class LoginScreen extends StatelessWidget {
//   static const routeName = '/auth';
//
//   Duration get loginTime => Duration(milliseconds: timeDilation.ceil() * 2250);
//
//   Future<String?> _loginUser(LoginData data) {
//     return Future.delayed(loginTime).then((_) {
//       if (!mockUsers.containsKey(data.name)) {
//         return 'User not exists';
//       }
//       if (mockUsers[data.name] != data.password) {
//         return 'Password does not match';
//       }
//       return null;
//     });
//   }
//
//   Future<String?> _recoverPassword(String name) {
//     return Future.delayed(loginTime).then((_) {
//       if (!mockUsers.containsKey(name)) {
//         return 'User not exists';
//       }
//       return null;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return FlutterLogin(
//       title: Constants.appName,
//       //logo: '',
//       logoTag: Constants.logoTag,
//       titleTag: Constants.titleTag,
//       userValidator: (value) {
//         if (!value!.contains('@')) {
//           return "Email must contain '@'.";
//         }
//         return null;
//       },
//       passwordValidator: (value) {
//         if (value!.isEmpty) {
//           return 'Password is empty';
//         }
//         return null;
//       },
//       onLogin: (loginData) {
//         print('Login info');
//         print('Name: ${loginData.name}');
//         print('Password: ${loginData.password}');
//         return _loginUser(loginData);
//       },
//       onSignup: (loginData) {
//         print('Signup info');
//         print('Name: ${loginData.name}');
//         print('Password: ${loginData.password}');
//         return _loginUser(loginData);
//       },
//       onSubmitAnimationCompleted: () {
//         Navigator.of(context).pushReplacement(FadePageRoute(
//           builder: (context) => DashboardScreen(),
//         ));
//       },
//       onRecoverPassword: (name) {
//         print('Recover password info');
//         print('Name: $name');
//         return _recoverPassword(name);
//         // Show new password dialog
//       },
//       showDebugButtons: false,
//     );
//   }
// }
// TODO: Need login credential validation.
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  //LoginPage({Key? key, Title? title}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  Future<bool> _gotoRestaurant(BuildContext context) {
    return Navigator.of(context)
        .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false)
    // We will clean all existing routes when login.
        .then((_) => false);
  }

  TextStyle style = TextStyle(
    fontFamily: 'Futura',
    color: Colors.white,
    fontSize: 26,
  );

  @override
  Widget build(BuildContext context) {

    final userNameField = TextField(
      obscureText: false,
      style: style,
      decoration: InputDecoration(
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

    final passwordField = TextField(
      obscureText: true,
      // The obscured word seems not supportable by font Futura.
      style: TextStyle(color: Colors.white, fontSize: 26),
      decoration: InputDecoration(
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
        onPressed: () => _gotoRestaurant(context),
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
        onPressed: () {},
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