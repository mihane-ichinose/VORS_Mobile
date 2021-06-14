import 'package:flutter/material.dart';
import 'package:vors_project/users.dart';
import 'package:vors_project/util/home_page_items.dart';

class LoginPage extends StatefulWidget {
  final int customerId;
  final String username;

  LoginPage(this.customerId, this.username);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final _loginKey = GlobalKey<FormState>();

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  late User user;
  late bool connectionFailed = false;

  void awaitUsers(String credential, String password) async {
    try {
      user = await fetchAuthentication(credential, password);
      connectionFailed = false;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        DefaultSnackBar().withText('Error: Connection failed.', context),
      );
      connectionFailed = true;
    }
  }

  @override
  void initState() {
    super.initState();
    awaitUsers(usernameController.text, passwordController.text);
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

    bool userEmpty = false;
    bool passwordEmpty = false;

    final userNameField = DefaultLoginTextFormField()
        .withText("Username")
        .withController(usernameController)
        .withStyle(style)
        .build();

      // validator: (value) {
      //
      //   if (connectionFailed) {
      //     return ''; // Connection failed.
      //   }
      //
      //   if (value == null || value.isEmpty) {
      //     userEmpty = true;
      //     return ''; // Username empty.
      //   } else {
      //     userEmpty = false;
      //   }
      //
      //   // if (!mockUsers.containsKey(value)) {
      //   //   userNotExists = true;
      //   //   return ''; // User not exists
      //   // } else {
      //   //   userNotExists = false;
      //   // }
      //
      //   // for(User u in _listUsers) {
      //   //   if (u.getUsername() == value || u.getEmail() == value) {
      //   //     currentUser = u;
      //   //     currentUsername = u.getUsername();
      //   //     break;
      //   //   } else {
      //   //     userNotExists = true;
      //   //   }
      //   // }
      //
      //   // if (currentUser.getPassword() != passwordController.text) {
      //   //   passwordMismatch = true;
      //   //   return ''; // Password does not match
      //   // } else {
      //   //   passwordMismatch = false;
      //   // }
      //   return null;
      // },


    final passwordField = DefaultLoginTextFormField()
        .withStyle(style)
        .withController(passwordController)
        .withText("Password")
        .build();
    // TextFormField(
    //   // validator: (value) {
    //   //   if (connectionFailed) {
    //   //     return ''; // Connection failed.
    //   //   }
    //   //
    //   //   if (value == null || value.isEmpty){
    //   //     passwordEmpty = true;
    //   //     return ''; // The password is empty.
    //   //   } else {
    //   //     passwordEmpty = false;
    //   //   }
    //   //   return null;
    //   // },


    final loginButton = Material(
      borderRadius: BorderRadius.circular(30.0),
      color: Colors.white,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(15.0),
        onPressed: () {
          credential = usernameController.text;
          password = passwordController.text;
          awaitUsers(credential, password);
          if (connectionFailed) return;
          // Connection failed message has the highest priority.
          else {
            if (_loginKey.currentState!.validate() && user.getAuthentication()) {
              // If both forms are valid and server is authenticated,
              // go to the restaurant page.
              //userNotExists = passwordMismatch =
              userEmpty = passwordEmpty = true;
              LoginPage loginPage = new LoginPage(user.getCustomerId(), usernameController.text);
              _gotoRestaurant(context, loginPage);
            } else if (userEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                DefaultSnackBar().withText('Please enter your username.', context),
              );
            } else if (!user.getAuthentication()) {
              ScaffoldMessenger.of(context).showSnackBar(
                DefaultSnackBar().withText('Please check your username and password.', context),
              );
            } else if (passwordEmpty) { // else
              ScaffoldMessenger.of(context).showSnackBar(
                DefaultSnackBar().withText('Please enter your password.', context),
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