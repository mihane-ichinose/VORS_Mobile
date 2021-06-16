import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vors_project/util/restaurant.dart';

import 'menu_page.dart';


class RestaurantPage extends StatefulWidget {
  final int customerId;
  final String username;
  final int restaurantId;
  final String restaurantName;
  final String imgUrl;

  RestaurantPage(this.customerId, this.username, this.restaurantId, this.restaurantName, this.imgUrl);

  @override
  _RestaurantPageState createState() => _RestaurantPageState();
}

class _RestaurantPageState extends State<RestaurantPage> {

  @override
  void initState() {
    super.initState();
  }

  Future<bool> _goToUser(BuildContext context, RestaurantPage restaurantPage) {
    return Navigator.of(context)
        .pushNamed('/user', arguments: restaurantPage)
    // We want to pop the user profile here.
        .then((_) => false);
  }

  Future<bool> _goToMenu(BuildContext context, args, Restaurant restaurant) {
    return Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => MenuPage(args.customerId, args.username, restaurant.restaurantId, restaurant.name, restaurant.imgUrl)))
    // We want to go to menu with reference of restaurantId here.
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
      onPressed: () => _goToMenu(context, args, new Restaurant(restaurantId: 0, name: "", description: "", imgUrl: "", rating: 5.0)),
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
          color: Colors.white.withOpacity(0.8),
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

    final args = ModalRoute.of(context)!.settings.arguments;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(args),
      body: _buildHeader(args),
    );
  }
}