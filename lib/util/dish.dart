import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

const dishesUrl = 'http://84.238.224.41:5005/customer/dishes_of_restaurant';
const commentsUrl = 'http://84.238.224.41:5005/customer/dish_comments';
const ratingUrl = 'http://84.238.224.41:5005/customer/dish_rating';
const submitCommentUrl = 'http://84.238.224.41:5005/dish/comment';
const submitRatingUrl = 'http://84.238.224.41:5005/dish/rate';


class Dish {
  final int dishId;
  final String name;
  final String ingredients;
  final String allergens;
  final String dishType;
  final double rating;
  final double price;


  Dish({
    required this.dishId,
    required this.name,
    required this.ingredients,
    required this.allergens,
    required this.dishType,
    required this.rating,
    required this.price
  });

  String toString() {
    return "" + dishId.toString() + " " + name;
  }
}


Dish fromJson(Map<String, dynamic> json) {
  int id = json['id'];
  String name = "";
  if (json['name'] is String) {
    name = json['name'];
  }
  String ingredients = "";
  if (json['ingredients'] is String) {
    ingredients = json['ingredients'];
  }
  String allergens = "";
  if (json['allergens'] is String) {
    allergens = json['allergens'];
  }
  String dishType = "";
  if (json['dishType'] is String) {
    dishType = json['dishType'];
  }
  double price = json['price'];
  double rating = json['rating'];
  return Dish(dishId: id, name: name, ingredients: ingredients,
      allergens: allergens, dishType: dishType, rating: rating, price: price);
}


Future<List<Dish>> fetchAllDishes(int restaurantId) async {

  List<Dish> dishes = [];

  final response = await http.get(
    Uri.parse(dishesUrl + "?restaurantId=" + restaurantId.toString()),
    headers: {},
  );

  print(response.body);

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the dishes
    print("Connection established.");
    Iterable dishesJson = json.decode(response.body);
    dishesJson.forEach((json) {
      dishes.add(fromJson(json));
    });
    return dishes;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    print("Connection failed.");
    throw Exception('Connection failed.');
  }
}

Future<void> fetchDishComments(int dishId, List<String> comments) async {


  final response = await http.get(
    Uri.parse(commentsUrl + "?dishId=" + dishId.toString()),
    headers: {},
  );

  print(response.body);

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the dishes
    print("Connection established.");
    Iterable commentsJson = json.decode(response.body);
    commentsJson.forEach((json) {
      comments.add(json['comment']);
    });
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    print("Connection failed.");
    throw Exception('Connection failed.');
  }
}

Future<double> fetchDishRating(int dishId) async {

  final response = await http.get(
    Uri.parse(ratingUrl + "?dishId=" + dishId.toString()),
    headers: {},
  );

  print(response.body);

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the dishes
    print("Connection established.");
    return double.parse(response.body);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    print("Connection failed.");
    throw Exception('Connection failed.');
  }
}

Future<void> submitComment(int customerId, int dishId, String? comment) async {
  if (comment != null) {
    final response = await http.post(
      Uri.parse(submitCommentUrl + "?customerId=" + customerId.toString()
          + "&dishId=" + dishId.toString() + "&comment=" + comment),
      headers: {},
    );

    print(response.body);

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      print("Connection established.");
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      print("Connection failed.");
      throw Exception('Connection failed.');
    }
  }
}

Future<void> submitRating(int dishId, double rating) async {

  final response = await http.post(
    Uri.parse(submitRatingUrl + "?dishId=" + dishId.toString() +
        "&dishRating=" + rating.toString()),
    headers: {},
  );

  print(response.body);

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    print("Connection established - rating submitted");
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    print("Connection failed - rating failed");
    throw Exception('Connection failed.');
  }

}