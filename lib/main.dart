// import 'package:flutter/services.dart';
// import 'package:flutter/material.dart';
// import 'restaurant_page.dart';
// import 'login_page.dart';
// import 'transition_route_observer.dart';
//
// void main() {
//   SystemChrome.setSystemUIOverlayStyle(
//     SystemUiOverlayStyle(
//       systemNavigationBarColor:
//       SystemUiOverlayStyle.dark.systemNavigationBarColor,
//     ),
//   );
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//
//   static const int _customCyanPrimaryValue = 0xFF17B2E0;
//   static const MaterialColor customCyan = MaterialColor(_customCyanPrimaryValue,
//     <int, Color> {
//       50: Color(_customCyanPrimaryValue),
//       100: Color(_customCyanPrimaryValue),
//       200: Color(_customCyanPrimaryValue),
//       300: Color(_customCyanPrimaryValue),
//       400: Color(_customCyanPrimaryValue),
//       500: Color(_customCyanPrimaryValue),
//       600: Color(_customCyanPrimaryValue),
//       700: Color(_customCyanPrimaryValue),
//       800: Color(_customCyanPrimaryValue),
//       900: Color(_customCyanPrimaryValue),
//     },
//   );
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'VORS',
//       theme: ThemeData(
//         // brightness: Brightness.dark,
//         primarySwatch: customCyan,
//         accentColor: customCyan,
//         textSelectionTheme: TextSelectionThemeData(cursorColor: Colors.purple),
//         // fontFamily: 'SourceSansPro',
//         textTheme: TextTheme(
//           headline3: TextStyle(
//             fontFamily: 'Futura',
//             fontSize: 45.0,
//             // fontWeight: FontWeight.w400,
//             color: Colors.white,
//           ),
//           button: TextStyle(
//             // Futura is similar to NotoSans but the uppercases look a bit better IMO
//             fontFamily: 'Futura',
//           ),
//           caption: TextStyle(
//             fontFamily: 'Futura',
//             fontSize: 12.0,
//             fontWeight: FontWeight.normal,
//             color: customCyan,
//           ),
//           headline1: TextStyle(fontFamily: 'Futura'),
//           headline2: TextStyle(fontFamily: 'Futura'),
//           headline4: TextStyle(fontFamily: 'Futura'),
//           headline5: TextStyle(fontFamily: 'Futura'),
//           headline6: TextStyle(fontFamily: 'Futura'),
//           subtitle1: TextStyle(fontFamily: 'Futura'),
//           bodyText1: TextStyle(fontFamily: 'Futura'),
//           bodyText2: TextStyle(fontFamily: 'Futura'),
//           subtitle2: TextStyle(fontFamily: 'Futura'),
//           overline: TextStyle(fontFamily: 'Futura'),
//         ),
//       ),
//       home: LoginScreen(),
//       navigatorObservers: [TransitionRouteObserver()],
//       initialRoute: LoginScreen.routeName,
//       routes: {
//         LoginScreen.routeName: (context) => LoginScreen(),
//         DashboardScreen.routeName: (context) => DashboardScreen(),
//       },
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:vors_project/login_page.dart';
import 'package:vors_project/restaurant_page.dart';
import 'package:vors_project/user_page.dart';

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
      home: LoginPage(),
      routes: {
        "/logout": (_) => new LoginPage(),
        "/login": (_) => new RestaurantPage(),
        "/user": (_) => new UserPage(),
      },
    );
  }
}

