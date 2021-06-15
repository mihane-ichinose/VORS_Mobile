import 'dart:async';
import 'package:http/http.dart' as http;

// TODO: url.
const url = '';

Future<Dish> fetchDish(int dishId) async {

  final response = await http.get(
    Uri.parse(url + "?dishId=" + dishId.toString()),
    headers: {},
  );

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the dish details
    print("Connection established.");
    return Dish.fromString(response.body);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    print("Connection failed.");
    throw Exception('Connection failed.');
  }
}

class Dish {
  final int dishId;
  final String name;
  final String ingredients;
  final String allergens;
  final String type;
  final double rating;


  Dish({
    required this.dishId,
    required this.name,
    required this.ingredients,
    required this.allergens,
    required this.type,
    required this.rating,
  });


  // Details are of format "<id>,<name>,<description><imgUrl><rating>" or just "-1"
  factory Dish.fromString(String dishDetails) {
    var details = dishDetails.split(",");
    int id = int.parse(details.elementAt(0));
    String name = "";
    String ingredients = "";
    String allergens = "";
    String type = "";
    double rating = 0.0;

    if (id != -1) {
      name = details.elementAt(1);
      ingredients = details.elementAt(2);
      allergens = details.elementAt(3);
      type = details.elementAt(4);
      rating = double.parse(details.elementAt(5));
    }
    return Dish(
      dishId: id,
      name: name,
      ingredients: ingredients,
      allergens: allergens,
      type: type,
      rating: rating,
    );
  }
}