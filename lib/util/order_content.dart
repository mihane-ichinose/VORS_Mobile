import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

const orderContentUrl = 'http://84.238.224.41:5005/customer/order_content';

class OrderedDish {
  final int id;
  final String name;
  final double price;
  late int orderCount;

  OrderedDish(this.id, this.name, this.price, this.orderCount);

  String toString() {
    return " " + id.toString() + " " + name + " "
        + price.toString();
  }

  void increaseOrder() {
    this.orderCount += 1;
  }



  @override
  bool operator ==(Object other) {
    if(!(other is OrderedDish)) {
      return false;
    }
    var o = other;
    return this.id == o.id;
  }

  @override
  int get hashCode {
    return id;
  }
}


OrderedDish fromJson(Map<String, dynamic> json) {
  int id = json['id'];
  String name = json['name'];
  double price = json['price'];
  int orderCount = 1;

  return OrderedDish(id, name, price, orderCount);
}


Future<void> fetchOrderContent(int orderId, List<OrderedDish> dishes) async {


  final response = await http.get(
    Uri.parse(orderContentUrl + "?orderId=" + orderId.toString()),
    headers: {},
  );

  print(orderId);

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the orders
    print("Connection established.");
    Iterable dishesJson = json.decode(response.body);
    dishesJson.forEach((dish) {
      dishes.add(fromJson(dish));
    });
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    print("Connection failed.");
    throw Exception('Connection failed.');
  }
}