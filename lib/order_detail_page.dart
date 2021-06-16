import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:vors_project/util/home_page_items.dart';
import 'package:vors_project/util/order.dart';


class OrderDetailPage extends StatefulWidget {

  final int orderId;
  final bool active;
  final String restaurantName;

  const OrderDetailPage(this.orderId, this.active, this.restaurantName);

  @override
  _OrderDetailPageState createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {

  late List<Order> orders = [];
  late String title = "";

  void awaitDishes() async {
    orders = await fetchAllOrders(widget.orderId);
    print(orders.toString());
  }

  @override
  void initState(){
    super.initState();
    if (widget.active) title = "Active";
    else title = "Past";
    awaitDishes();
  }

  TextStyle style = TextStyle(
    fontFamily: 'Futura',
    color: Colors.white,
    fontSize: 26,
  );

  AppBar _buildAppBar() {

    return AppBar(
      toolbarHeight: 100,
      backgroundColor: Color(0xFF17B2E0),
      title: Center(
        child: Column(
          children: <Widget>[
            Text(title+" order",
                style: style.copyWith(color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,)
            ),
            SizedBox(
              height: 10.0,
            ),
            Text("at Pizzeria", // TODO: implement restaurant fetch here by restaurantId after branch merged.
                style: style.copyWith(color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,)
            ),
          ],
        ),
      )
    );
  }

  final List<double> prices = <double>[5.99, 6.99, 6.49, 6.49, 6.49, 6.49, 6.49, 6.49, 6.49, 6.49];
  late double totalPrice = 0.00;

  Widget _buildOrderList() {
    return ListView.separated(
      padding: const EdgeInsets.all(8),
      itemCount: orders.length,
      itemBuilder: (BuildContext context, int index) {
        totalPrice += prices[index];
        return GestureDetector(
          onTap: () => ScaffoldMessenger
              .of(context)
              .showSnackBar(DefaultSnackBar().withText(
              'Clicked item number '+index.toString(), context),),
          child: Container(
            height: 60,
            color: Colors.white,
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text((index+1).toString()+'. ${orders[index].name}\n',
                    style: style.copyWith(color: Color(0xFF17B2E0)),),
                  RichText(text: TextSpan(
                    text: "${orders[index].orderCount} x ",
                    style: style.copyWith(color: Color(0xFF17B2E0)),
                    children: <TextSpan>[
                      TextSpan(
                        text: "£",
                        style: style.copyWith(color: Color(0xFF17B2E0),
                          fontFamily: "Ariel",
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: "${prices[index]}",
                        style: style.copyWith(color: Color(0xFF17B2E0),),
                      ),
                    ],
                  ),
                  ),
                ],
              ),
            ),
            ),
          );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Material(
      child: Scaffold(
        body: Column(
          children: [
            _buildAppBar(),
            SizedBox(
              height: 10.0,
            ),
            RichText(text: TextSpan(
              text: "Total: ",
              style: style.copyWith(color: Color(0xFF43F2EB),
              fontSize: 30,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: "£",
                  style: style.copyWith(color: Color(0xFF17B2E0),
                    fontFamily: "Ariel",
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: totalPrice.toString(),
                  style: style.copyWith(color: Color(0xFF17B2E0),
                  fontSize: 30,
                  ),
                ),
              ],
            ),
            ),
            Expanded(
              child: _buildOrderList(),
            ),
          ],
        ),
      ),
    );
  }
}