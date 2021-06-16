import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

const dishesUrl = 'http://84.238.224.41:5005/customer/dishes_of_restaurant';

class Dish {
  final int dishId;
  final String name;
  final String ingredients;
  final String allergens;
  final String dishType;
  final double rating;


  Dish({
    required this.dishId,
    required this.name,
    required this.ingredients,
    required this.allergens,
    required this.dishType,
    required this.rating,
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
  double rating = json['rating'];
  return Dish(dishId: id, name: name, ingredients: ingredients,
      allergens: allergens, dishType: dishType, rating: rating);
}


Future<List<Dish>> fetchAllDishes(int restaurantId) async {

  List<Dish> dishes = [];

  final response = await http.get(
    Uri.parse(dishesUrl + "?restaurantId=" + restaurantId.toString()),
    headers: {"Access-Control-Allow-Origin": "http://localhost:11817",},
  );

  print(response.body);

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the dishes
    print("Connection established.");
    Iterable restaurantsJson = json.decode(response.body);
    restaurantsJson.forEach((json) {
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