import 'package:flutter/material.dart';
import 'package:vors_project/restaurant_page.dart';

class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  Future<bool> _logout(BuildContext context) {
    return Navigator.of(context)
        .pushReplacementNamed('/logout')
    // We don't want to pop the screen, just replace it completely
        .then((_) => false);
  }

  TextStyle style = TextStyle(
    fontFamily: 'Futura',
    color: Colors.white,
    fontSize: 26,
  );

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Color(0xFF17B2E0),
      title: Container(
        child: Center(
          child: Text("My account",
            style: style.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(args) {
    // TODO: Need the user profile here.
    return Container(
      child: Column(
        children: <Widget>[
          Text("Customer id: "+args.customerId.toString(),
            style: style.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Text("Username: "+args.username,
            style: style.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 10.0),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    final args = ModalRoute.of(context)!.settings.arguments as RestaurantPage;

    final logoutButton = Material(
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xFF17B2E0),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(15.0),
        onPressed: () => _logout(context),
        child: Text("Logout",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold)
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: Scaffold(
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 40.0,
                ),
                _buildHeader(args),
                Container(
                  width: 150,
                  child: logoutButton,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
