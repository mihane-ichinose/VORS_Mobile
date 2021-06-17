import 'package:flutter/material.dart';
import 'package:vors_project/util/general.dart';
import 'package:vors_project/util/restaurant.dart';

import '../main.dart';
import '../menu_page.dart';

const MAX_NAME_LENGTH = 20;
const MAX_DESCRIPTION_LENGTH = 93;


TextStyle style = TextStyle(
  fontFamily: 'Futura',
  color: Colors.white,
  fontSize: 24,
  fontWeight: FontWeight.bold
);

TextField newSearchField(TextStyle style) {
  return TextField(
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
}


Future<bool> _goToMenu(BuildContext context, Restaurant restaurant) {
  return Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) =>
      MenuPage(customerId, username,
          restaurant.id, restaurant.name, restaurant.imageUrl)))
  // We want to go to menu with reference of restaurantId here.
      .then((_) => false);
}

DecorationImage imageGenerator(Restaurant restaurant) {
  if (restaurant.imageUrl == "") {
    return DecorationImage(
      fit: BoxFit.contain,
      alignment: FractionalOffset.topCenter,
      image: new AssetImage("assets/images/no_image.png"),
    );
  } else {
    return DecorationImage(
      fit: BoxFit.fitWidth,
      alignment: FractionalOffset.topCenter,
      image: new NetworkImage(restaurant.imageUrl),
    );
  }
}

Widget restaurantsList(List<Restaurant> restaurants, BuildContext context) {
  return ListView.builder(
      // Let the ListView know how many items it needs to build.
      itemCount: restaurants.length,
      // Provide a builder function.
      // Convert each item into a widget based on the type of item it is.
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            print('Restaurant ' + restaurants[index].id.toString() + ' was clicked.');
            _goToMenu(context, restaurants[index]);
          },
          child: Container(
            height: 300,
            padding: const EdgeInsets.all(8.0),
            margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xFF43F2EB), width: 3.0),
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: ListView(
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.all(0),
              children: <Widget> [
                Container(
                  height: 200,
                  child : new Padding(
                    padding: EdgeInsets.zero,
                    child : new Container(
                      decoration: new BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: imageGenerator(restaurants[index]),
                      ),
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 5.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          height: 28,
                          child: Text(
                            formulateString(restaurants[index].name, MAX_NAME_LENGTH),
                          style: style.copyWith(color: Color(0xFF17B2E0),),),
                        ),
                        Container(
                          height: 28,
                          child: RichText(
                            text: TextSpan(
                              text: (restaurants[index].rating >= 0.1) ?
                            restaurants[index].rating.toStringAsFixed(1) : "",
                            style: style.copyWith(color: Color(0xFF17B2E0),),
                              children: <TextSpan>[
                                TextSpan(
                                  text: (restaurants[index].rating >= 0.1) ?
                                  "★" : "",
                                  style: style.copyWith(color: Color(0xFF17B2E0),
                                  fontFamily: "Arial",
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      height: 35,
                      child: Text((restaurants[index].description != "") ?
                          formulateString(restaurants[index].description,
                              MAX_DESCRIPTION_LENGTH)
                          : "No description.",
                      style: style.copyWith(color: Colors.black,
                      fontSize: 14,),),
                    ),
                  ],
                )
              ],
            )
          ),
        );
      }
  );
}
