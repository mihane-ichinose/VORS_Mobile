import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vors_project/main.dart';
import 'package:vors_project/user_page.dart';

import 'package:vors_project/util/restaurant_page_items.dart';
import 'package:vors_project/util/restaurant.dart';



class RestaurantPage extends StatefulWidget {
  final int customerId;
  final String username;
  final List<Restaurant> restaurants = [];
  List<Restaurant> searched = [];


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
      onChanged: (text) {
        print(text);
        updateRestaurants(args, text);
      },
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


  Widget _buildRestaurants(args, restaurants) {
    return restaurantsList(restaurants, context);
  }

  updateRestaurants(args, String search) {
    print(search);
    if (search == "" || search == null) {
      setState(() {
        _buildRestaurants(args, this.widget.restaurants);
      });
      return;
    }
    this.widget.searched = [];
    for(Restaurant restaurant in this.widget.restaurants) {
      if (restaurant.name.toLowerCase().contains(search.toLowerCase())) {
        this.widget.searched.add(restaurant);
        print(restaurant.name);
      }
    }
    setState(() {
      _buildRestaurants(args, this.widget.searched);
    });
  }


  @override
  Widget build(BuildContext context) {

    print(customerId);

    final args = ModalRoute
        .of(context)!
        .settings
        .arguments;


    if (widget.restaurants.length == 0) {
      fetchAllRestaurants(this.widget.restaurants).then((value) =>
      {
        setState(() {
          for (Restaurant restaurant in this.widget.restaurants) {
            this.widget.searched.add(restaurant);
          }
          _buildRestaurants(args, this.widget.searched);
        })
      });
    }

    var result = Scaffold(
        backgroundColor: Colors.white,
        appBar: _buildAppBar(args),
        body: _buildRestaurants(args, this.widget.searched)
    );

    return result;

  }
}
