import 'dart:async';
import 'package:http/http.dart' as http;

// TODO: url.
const url = '';

Future<Restaurant> fetchRestaurant(int restaurantId) async {

  final response = await http.get(
    Uri.parse(url + "?restaurantId=" + restaurantId.toString()),
    headers: {},
  );

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the restaurant details
    print("Connection established.");
    return Restaurant.fromString(response.body);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    print("Connection failed.");
    throw Exception('Connection failed.');
  }
}

class Restaurant {
  final int restaurantId;
  final String name;
  final String description;
  final String imgUrl;
  final double rating;


  Restaurant({
    required this.restaurantId,
    required this.name,
    required this.description,
    required this.imgUrl,
    required this.rating,
  });


  // Details are of format "<id>,<name>,<description><imgUrl><rating>" or just "-1"
  factory Restaurant.fromString(String restaurantDetails) {
    var details = restaurantDetails.split(",");
    int id = int.parse(details.elementAt(0));
    String name = "";
    String description = "";
    String imgUrl = "";
    double rating = 0.0;

    if (id != -1) {
      name = details.elementAt(1);
      description = details.elementAt(2);
      imgUrl = details.elementAt(3);
      rating = double.parse(details.elementAt(4));
    }
    return Restaurant(
      restaurantId: id,
      name: name,
      description: description,
      imgUrl: imgUrl,
      rating: rating,
    );
  }
}