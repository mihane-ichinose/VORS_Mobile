import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:vors_project/util/dish.dart';

const orderContentUrl = 'http://84.238.224.41:5005/customer/order_content';

class OrderedDish {
  final int id;
  final String name;
  final double price;

  OrderedDish(this.id, this.name, this.price);


  String toString() {
    return " " + id.toString() + " " + name + " "
        + price.toString();
  }
}


OrderedDish fromJson(Map<String, dynamic> json) {
  int id = json['id'];
  String name = json['name'];
  double price = json['price'];

  return OrderedDish(id, name, price);
}


Future<List<OrderedDish>> fetchOrderContent(int orderId) async {

  List<OrderedDish> dishes = [];

  final response = await http.get(
    Uri.parse(orderContentUrl + "?orderId=" + orderId.toString()),
    headers: {},
  );

  print(response.body);

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the orders
    print("Connection established.");
    Iterable dishesJson = json.decode(response.body);
    dishesJson.forEach((dish) {
      dishes.add(fromJson(dish));
    });
    return dishes;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    print("Connection failed.");
    throw Exception('Connection failed.');
  }
}