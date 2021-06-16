import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

const ordersUrl = 'http://84.238.224.41:5005/customer/order_content';

class Order {
  final int dishId;
  final int restaurantId;
  final String name;
  final int orderCount;

  Order({
    required this.dishId,
    required this.restaurantId,
    required this.name,
    required this.orderCount,
  });

  String toString() {
    return " " + dishId.toString() + " " + restaurantId.toString() + " " + name + " " + orderCount.toString();
  }
}


Order fromJson(Map<String, dynamic> json) {
  int id = json['id'];
  int restaurantId = json['restaurantId'];
  String name = "";
  if (json['name'] is String) {
    name = json['name'];
  }
  int orderCount = json['orderCount'];
  return Order(dishId: id, restaurantId: restaurantId, name: name, orderCount: orderCount);
}


Future<List<Order>> fetchAllOrders(int orderId) async {

  List<Order> orders = [];

  final response = await http.get(
    Uri.parse(ordersUrl + "?orderId=" + orderId.toString()),
    headers: {},
  );

  print(response.body);

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the orders
    print("Connection established.");
    Iterable ordersJson = json.decode(response.body);
    ordersJson.forEach((json) {
      orders.add(fromJson(json));
    });
    return orders;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    print("Connection failed.");
    throw Exception('Connection failed.');
  }
}