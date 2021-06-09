// import 'package:flutter/services.dart';
// import 'package:flutter/material.dart';
// import 'dashboard_screen.dart';
// import 'login_screen.dart';
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

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'VORS',
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFF17B2E0),
        fontFamily: "Futura.bold",
      ),
      home: MyHomePage(title: 'VORS Login'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
        contentPadding: EdgeInsets.all(20.0),
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
          contentPadding: EdgeInsets.all(20.0),
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
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {},
        child: Text("Log in",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Color(0xFF17B2E0),
                fontWeight: FontWeight.bold)
        ),
      ),
    );

    final signUpButton = Material(
      borderRadius: BorderRadius.circular(30.0),
      color: Colors.transparent,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {},
        child: Text("Sign up.",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Color(0xFF43F2EB), fontWeight: FontWeight.bold, fontSize: 30)),
      ),
    );

    final forgotButton = Material(
      borderRadius: BorderRadius.circular(30.0),
      color: Colors.transparent,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(0, 15.0, 20.0, 15.0),
        onPressed: () {},
        child: Text("here.",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Color(0xFF43F2EB), fontWeight: FontWeight.bold, fontSize: 20)),
      ),
    );

    return Scaffold(
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
                    height: 70.0,
                  ),
                  Text("VORS", style: TextStyle(fontFamily: "Futura", fontWeight: FontWeight.bold, fontSize: 100, color: Colors.white)),
                  SizedBox(
                    height: 15.0,
                  ),
                  Text("Virtual ordering", style: TextStyle(fontFamily: "Futura", fontWeight: FontWeight.bold, fontSize: 30, color: Colors.white)),
                  SizedBox(
                    height: 15.0,
                  ),
                  Text("for", style: TextStyle(fontFamily: "Futura", fontWeight: FontWeight.bold, fontSize: 30, color: Colors.white)),
                  SizedBox(
                    height: 15.0,
                  ),
                  Text("Rapid service", style: TextStyle(fontFamily: "Futura", fontWeight: FontWeight.bold, fontSize: 30, color: Colors.white)),
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
                    width: 100,
                    child: loginButton,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text("Don't have an account?", style: TextStyle(fontFamily: "Futura", fontSize: 30, color: Colors.white)),
                  Container(
                    width: 150,
                    child: signUpButton,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text("Forgot your password?", style: TextStyle(fontFamily: "Futura", fontSize: 20, color: Colors.white)),
                  Container(
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Center(
                            child: Text("Click ", style: TextStyle(fontFamily: "Futura", fontSize: 20, color: Colors.white)),
                          ),
                          Center(
                            child: Container(
                              width: 60,
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