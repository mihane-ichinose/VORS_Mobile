// import 'package:flutter/scheduler.dart' show timeDilation;
// import 'package:flutter/material.dart';
// import 'package:flutter_login/flutter_login.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'constants.dart';
// import 'custom_route.dart';
// import 'dashboard_screen.dart';
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