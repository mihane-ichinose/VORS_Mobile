import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:vors_project/order_detail_page.dart';
import 'package:vors_project/util/home_page_items.dart';
import 'package:vors_project/util/orderList.dart';


class OrderPage extends StatefulWidget {

  final int customerId;

  const OrderPage(this.customerId);

  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {

  late List<OrderList> orderList = [];
  late List<OrderList> activeOrderList = [];
  late List<OrderList> pastOrderList = [];

  void awaitDishes() async {
    orderList = await fetchAllOrderLists(widget.customerId);
    activeOrderList = orderList.where((i) => i.active).toList();
    pastOrderList = orderList.where((i) => !i.active).toList();
    print(activeOrderList.toString());
    print(pastOrderList.toString());
  }

  @override
  void initState(){
    super.initState();
    awaitDishes();
  }

  Future<bool> _goToOrderDetails(BuildContext context, int index, String restaurantName) {
    return Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => new OrderDetailPage(orderList[index].orderId, orderList[index].active, restaurantName)))
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
                    fontWeight: FontWeight.bold,)
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
          onTap: () => _goToOrderDetails(context, index, "Pizzeria"),
          child: Container(
            height: 60,
            color: Colors.white,
            child: Container(
              child:
              Text("at Pizzeria", // TODO: implement restaurant fetch here by restaurantId after branch merged.
                style: style.copyWith(color: Color(0xFF17B2E0)),),
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
          onTap: () => _goToOrderDetails(context, index, "Pizzeria"),
          child: Container(
            height: 60,
            color: Colors.white,
            child: Container(
              child:
              Text("at Pizzeria", // TODO: implement restaurant fetch here by restaurantId after branch merged.
                style: style.copyWith(color: Color(0xFF17B2E0)),),
            ),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }

  @override
  Widget build(BuildContext context) {

    //final args = ModalRoute.of(context)!.settings.arguments as RestaurantPage;


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