import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

const orderListUrl = 'http://84.238.224.41:5005/customer/orders';

class OrderList {
  final int orderId;
  final int restaurantId;
  final int tableNumber;
  final bool active;

  OrderList({
    required this.orderId,
    required this.restaurantId,
    required this.tableNumber,
    required this.active,
  });

  String toString() {
    return " " + orderId.toString() + " " + restaurantId.toString() + " " + tableNumber.toString() + " " + active.toString();
  }
}


OrderList fromJson(Map<String, dynamic> json) {
  int id = json['id'];
  int restaurantId = json['restaurantId'];
  int tableNumber = json['tableNumber'];
  bool active = json['active'];
  return OrderList(orderId: id, restaurantId: restaurantId, tableNumber: tableNumber, active: active);
}


Future<List<OrderList>> fetchAllOrderLists(int customerId) async {

  List<OrderList> orderList = [];

  final response = await http.get(
    Uri.parse(orderListUrl + "?customerId=" + customerId.toString()),
    headers: {},
  );

  print(response.body);

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the order list.
    print("Connection established.");
    Iterable orderListJson = json.decode(response.body);
    orderListJson.forEach((json) {
      orderList.add(fromJson(json));
    });
    return orderList;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    print("Connection failed.");
    throw Exception('Connection failed.');
  }
}