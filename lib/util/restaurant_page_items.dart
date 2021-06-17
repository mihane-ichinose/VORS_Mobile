import 'package:flutter/material.dart';
import 'package:vors_project/util/restaurant.dart';

import '../main.dart';
import '../menu_page.dart';

TextStyle style = TextStyle(
  fontFamily: 'Futura',
  color: Colors.white,
  fontSize: 26,
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

Scaffold restaurantBox(Restaurant restaurant) {
  return Scaffold(
    backgroundColor: Color(0xFF17B2E0),
    body: SingleChildScrollView(
      child: Center(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(36.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 40.0,
                ),
                Text("Sign Up", style: TextStyle(
                    fontFamily: "Futura", fontSize: 90, color: Colors.black)),
                SizedBox(
                  height: 10.0,
                ),
                Text("Virtual ordering", style: TextStyle(
                    fontFamily: "Futura", fontSize: 25, color: Colors.black)),
                SizedBox(
                  height: 10.0,
                ),
              ],
            ),
          ),
        ),
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
                      height: 10.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          height: 20,
                          child: Text(restaurants[index].name,
                          style: style.copyWith(color: Color(0xFF17B2E0),),),
                        ),
                        Container(
                          height: 20,
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
                                  fontFamily: "Ariel",
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
                    Row(
                      children: <Widget>[
                        Container(
                          height: 35,
                          child: Text((restaurants[index].description != "") ?
                          restaurants[index].description : "No description.",
                          style: style.copyWith(color: Colors.black,
                          fontSize: 20,),),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            )
          ),
          //     new AspectRatio(
          //     aspectRatio: 9 / 18,
          //     child: new Container(
          //       height: 200,
          //       decoration: new BoxDecoration(
          //           borderRadius: BorderRadius.circular(10),
          //           image: new DecorationImage(
          //             fit: BoxFit.fitWidth,
          //             alignment: FractionalOffset.topCenter,
          //             image: new NetworkImage(restaurants[index].imageUrl),
          //           )
          //       ),
          //     // ),
          //     // child: Text(restaurants[index].name),
          //   ),
          // ),
        );
      }
  );

}
