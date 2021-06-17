import 'dart:collection';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:vors_project/util/order.dart';

final restaurantsUrl = "http://84.238.224.41:5005/restaurants";


class Restaurant {
  int id;
  String name;
  String description;
  String imageUrl;
  double rating;

  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.rating
  });

  String toString() {
    return "" + id.toString() + " " + name;
  }

  // Details are of format "<id>,<name>,<description><imgUrl><rating>" or just "-1"
  factory Restaurant.fromString(String restaurantDetails) {
    var details = restaurantDetails.split(",");
    int id = int.parse(details.elementAt(0));
    String name = "";
    String description = "";
    String imageUrl = "";
    double rating = 0.0;

    if (id != -1) {
      name = details.elementAt(1);
      description = details.elementAt(2);
      imageUrl = details.elementAt(3);
      rating = double.parse(details.elementAt(4));
    }
    return Restaurant(
      id: id,
      name: name,
      description: description,
      imageUrl: imageUrl,
      rating: rating,
    );
  }

}

Restaurant fromJson(Map<String, dynamic> json) {
  int id = json['id'];
  String name = "";
  if (json['name'] is String) {
    name = json['name'];
  }
  String description = "";
  if (json['description'] is String) {
    description = json['description'];
  }
  String imageUrl = "";
  if (json['picture'] is String) {
    imageUrl = json['picture'];
  }
  double rating = json['rating'];
  return Restaurant(id: id, name: name, description: description,
      imageUrl: imageUrl, rating: rating);
}


Future<void> fetchAllRestaurants(List<Restaurant> restaurants) async {
  final response = await http.get(
      Uri.parse(restaurantsUrl),
      headers: {}
  );


  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the user details
    print("Connection established.");
    Iterable restaurantsJson = json.decode(response.body);
    restaurantsJson.forEach((json) {
      restaurants.add(fromJson(json));
    });
    // then parse the restaurant details
  } else {
  // If the server did not return a 200 OK response,
  // then throw an exception.
    throw Exception('Connection failed.');
  }

}
//
// Future<void> fetchRestaurantNamesToId(Map<int, String> names, List<Order> orders) async {
//   Set<int> ids = new HashSet();
//   for (Order order in orders) {
//     ids.add(order.restaurantId);
//   }
//   for (int id in ids) {
//     final response = await http.get(
//         Uri.parse("http://84.238.224.41:5005/customer/restaurant_name"
//              + "?restaurantId=" + id.toString()),
//         headers: {}
//     );
//     names.putIfAbsent(id, () => response.body);
//   }
// }