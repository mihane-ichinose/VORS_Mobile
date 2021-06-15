import 'package:http/http.dart' as http;
import 'dart:convert';

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
    headers: {},
  );

  print(response.body);

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the user details
    print("Connection established.");
    Iterable restaurantsJson = json.decode(response.body);
    restaurantsJson.forEach((json) {
      restaurants.add(fromJson(json));
    });
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    print("Connection failed.");
    throw Exception('Connection failed.');
  }
}