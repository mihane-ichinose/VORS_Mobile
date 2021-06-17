import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:vors_project/order_detail_page.dart';
import 'package:vors_project/util/order.dart';
import 'package:vors_project/util/restaurant.dart';


class OrderPage extends StatefulWidget {

  final int customerId;

  const OrderPage(this.customerId);

  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {

  late List<Order> orderList = [];
  late List<Order> activeOrderList = [];
  late List<Order> pastOrderList = [];
  bool areOrdersFetched = false;

  late List<Restaurant> restaurants = [];

  @override
  void initState(){
    super.initState();
    fetchAllRestaurants(restaurants);
  }

  Future<bool> _goToOrderDetails(BuildContext context, int index, String restaurantName) {
    return Navigator.of(context)
        .push(MaterialPageRoute(builder: (context)
          => new OrderDetailPage(orderList[index].id, orderList[index].active, restaurantName)))
        .then((_) => false);
  }

  TextStyle style = TextStyle(
    color: Colors.white,
    fontSize: 26,
    fontFamily: 'Futura',
  );

  AppBar _buildAppBar() {

    return AppBar(
        toolbarHeight: 100,
        backgroundColor: Color(0xFF17B2E0),
        title: Center(
          child: Column(
            children: <Widget>[
              Text("My orders",
                style: style.copyWith(color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        )
    );
  }

  Widget _buildActiveOrderList() {
    return ListView.separated(
      padding: const EdgeInsets.all(8),
      itemCount: activeOrderList.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () => _goToOrderDetails(context, index,
              restaurants.where((i) => i.id == activeOrderList[index].restaurantId).toList()[0].name.toString()),
          // onTap: () => print(activeOrderList[index].id),
          child: Container(
            height: 60,
            color: Colors.white,
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("at "+restaurants.where((i) => i.id == activeOrderList[index].restaurantId).toList()[0].name.toString(),
                    style: style.copyWith(color: Color(0xFF17B2E0)),),
                  Text("order ID: "+activeOrderList[index].id.toString(),
                    style: style.copyWith(color: Color(0xFF17B2E0)),),
                ],
              )

            ),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }

  Widget _buildPastOrderList() {
    return ListView.separated(
      padding: const EdgeInsets.all(8),
      itemCount: pastOrderList.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () => _goToOrderDetails(context, index,
              restaurants.where((i) => i.id == pastOrderList[index].restaurantId).toList()[0].name.toString()),
          // onTap: () => print(pastOrderList[index].id),

          child: Container(
            height: 60,
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("at "+restaurants.where((i) => i.id == pastOrderList[index].restaurantId).toList()[0].name.toString(),
                  style: style.copyWith(color: Color(0xFF17B2E0)),),
                Text("order ID: "+pastOrderList[index].id.toString(),
                  style: style.copyWith(color: Colors.grey,),),
              ],
            ),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }

  @override
  Widget build(BuildContext context) {

    if(orderList.length == 0 && !areOrdersFetched) {
      fetchAllOrders(widget.customerId, orderList).then((value) {
        setState(() {
              activeOrderList = orderList.where((i) => i.active).toList();
              pastOrderList = orderList.where((i) => !i.active).toList();
              areOrdersFetched = true;
              for (Order order in orderList) {
                print(order.id);
              }
          });
        });
      }

    return Material(
      child: Scaffold(
        appBar: _buildAppBar(),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10.0,
            ),
            Text("Active:",style: style.copyWith(color: Color(0xFF43F2EB),
              fontSize: 30,),
            ),
            Expanded(
              flex: 1,
              child: _buildActiveOrderList(),
            ),
            Text("Past:",style: style.copyWith(color: Color(0xFF43F2EB),
              fontSize: 30,),
            ),
            Expanded(
              flex: 2,
              child: _buildPastOrderList(),
            ),
          ],
        ),
      ),
    );
  }
}