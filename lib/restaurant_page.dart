import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vors_project/main.dart';
import 'package:vors_project/user_page.dart';

import 'package:vors_project/util/restaurant_page_items.dart';
import 'package:vors_project/util/restaurant.dart';


import 'menu_page.dart';


// List<Restaurant> restaurants = [];

class RestaurantPage extends StatefulWidget {
  final int customerId;
  final String username;
  final List<Restaurant> restaurants = [];


  RestaurantPage(this.customerId, this.username);

  @override
  _RestaurantPageState createState() => _RestaurantPageState();
}

class _RestaurantPageState extends State<RestaurantPage> {

  @override
  void initState() {
    super.initState();
  }

  Future<bool> _goToUser(BuildContext context) {
    return Navigator.of(context)
        // .pushNamed('/user', arguments: restaurantPage)
    // We want to pop the user profile here.
        .push(MaterialPageRoute(builder: (context) =>
        UserPage()
        ))

        .then((_) => false);
  }

  Future<bool> _goToMenu(BuildContext context, args, Restaurant restaurant) {
    return Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) =>
        MenuPage(args.customerId, args.username,
            restaurant.id, restaurant.name, restaurant.imageUrl)))
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
      onPressed: () =>
          _goToUser(context)
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


  Widget _buildRestaurants(args) {
    return restaurantsList(this.widget.restaurants, context);
  }

  @override
  Widget build(BuildContext context) {

    print(customerId);

    final args = ModalRoute
        .of(context)!
        .settings
        .arguments;


    var body = _buildRestaurants(args);

    var result = Scaffold(
        backgroundColor: Colors.white,
        appBar: _buildAppBar(args),
        body: body
    );

    if (widget.restaurants.length == 0) {
      fetchAllRestaurants(this.widget.restaurants).then((value) =>
      {
        setState(() {
          body = _buildRestaurants(args);
        })
      });
    }

    return result;

  }
}
