import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:vors_project/util/globals.dart';

import 'home_page_items.dart';

const ordersUrl = 'http://84.238.224.41:5005/customer/orders';
const submitOrderUrl = 'http://84.238.224.41:5005/customer/new_order';

class Order {
  final int id;
  final int customerId;
  final int restaurantId;
  final int tableNumber;
  final bool active;

  Order({
    required this.id,
    required this.customerId,
    required this.restaurantId,
    required this.tableNumber,
    required this.active,
  });

  String toString() {
    return " " + customerId.toString() + " " + restaurantId.toString() + " " + tableNumber.toString() + " " + active.toString();
  }
}


Order fromJson(Map<String, dynamic> json) {
  int id = json['id'];
  int customerId = json['customerId'];
  int restaurantId = json['restaurantId'];
  int tableNumber = json['tableNumber'];
  bool active = json['active'];
  return Order(id: id, customerId: customerId, restaurantId: restaurantId,
      tableNumber: tableNumber, active: active);
}

Future<List<Order>> fetchAllOrders(int customerId, List<Order> orders) async {

  final response = await http.get(
    Uri.parse(ordersUrl + "?customerId=" + customerId.toString()),
    headers: {},
  );

  print(response.body);

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the order list.
    print("Connection established.");
    Iterable orderListJson = json.decode(response.body);
    orderListJson.forEach((json) {
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

Future<bool> submitOrder(int customerId, int restaurantId, String dishIds, String tableNumber) async {
  final response = await http.post(
    Uri.parse(submitOrderUrl + "?customerId=" + customerId.toString()
        + "&restaurantId=" + restaurantId.toString() + "&dishIds=" + dishIds
        + '&tableNumber=' + tableNumber),
    headers: {},
  );

  print(response.body);

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    print("Connection established.");
    currentOrders.remove(restaurantId);
    return true;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    print("Connection failed.");
    return false;
  }
}
