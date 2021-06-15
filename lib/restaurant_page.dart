import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vors_project/util/home_page_items.dart';
import 'package:vors_project/util/restaurant_page_items.dart';
import 'package:vors_project/util/restaurant.dart';

final List<Restaurant> restaurants = [];

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

    final searchField = newSearchField(style);

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
    // TODO: Need the restaurant list here.
    fetchAllRestaurants(restaurants).then((value) {
      for (Restaurant restaurant in restaurants) {
        print(restaurant);
      }
    });
    return Scaffold(
      body: Column(
        children: restaurants.map((restaurant) => DefaultSignUpTextField()
        .withText(restaurant.name)
        .withStyle(style)
        .build())
            .toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    final args = ModalRoute.of(context)!.settings.arguments;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(args),
      // body: _buildRestaurants(args),
      body: _buildAppBar(args),
    );
  }
}