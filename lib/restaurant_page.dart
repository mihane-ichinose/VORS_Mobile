import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:vors_project/login_page.dart';
// Debug only.
import 'package:vors_project/signup_page.dart';

class RestaurantPage extends StatefulWidget {
  final int customerId;
  final String username;

  RestaurantPage(this.customerId, this.username);

  @override
  _RestaurantPageState createState() => _RestaurantPageState();
}

class _RestaurantPageState extends State<RestaurantPage> {
  Future<bool> _goToUser(BuildContext context, RestaurantPage restaurantPage) {
    return Navigator.of(context)
        .pushNamed('/user', arguments: restaurantPage)
    // We want to pop the user profile here.
        .then((_) => false);
  }

  TextStyle style = TextStyle(
    fontFamily: 'Futura',
    color: Colors.white,
    fontSize: 26,
  );

  AppBar _buildAppBar(args) {

    final userBtn = IconButton(
      icon: const Icon(FontAwesomeIcons.user),
      color: Colors.black,
      tooltip: "User Profile",
      onPressed: () => _goToUser(context, new RestaurantPage(args.customerId, args.username)),
    );

    final searchField = TextField(
      obscureText: false,
      style: style,
      decoration: InputDecoration(
        filled: true,
        fillColor: Color(0xFF43F2EB),
        contentPadding: EdgeInsets.all(15.0),
        hintText: "Search...",
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

    return AppBar(
      backgroundColor: Color(0xFF17B2E0),
      title: searchField,
      actions: <Widget>[
        userBtn,
        SizedBox(width: 10),
      ],
    );
  }

  Widget _buildHeader(args) {
    // TODO: Need the restaurant list here.
    return Container();
  }

  @override
  Widget build(BuildContext context) {

    final args = ModalRoute.of(context)!.settings.arguments as SignupPage;
    // Debug only, here it should be LoginPage.

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(args),
      body: _buildHeader(args),
    );
  }
}