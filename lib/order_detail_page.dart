import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:vors_project/util/dish.dart';
import 'package:vors_project/util/home_page_items.dart';
import 'package:vors_project/util/order_content.dart';


class OrderDetailPage extends StatefulWidget {

  final int orderId;
  final bool active;
  final String restaurantName;

  const OrderDetailPage(this.orderId, this.active, this.restaurantName);

  @override
  _OrderDetailPageState createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {

  late List<OrderedDish> dishes = [];
  late String title = "";
  double totalPrice = 0;
  bool dishesFetched = false;


  // void awaitDishes() async {
  //   dishes = await fetchOrderContent(widget.orderId);
  //   print(dishes.toString());
  // }

  @override
  void initState(){
    super.initState();
    if (widget.active) title = "Active";
    else title = "Past";
    // awaitDishes();
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
            Text("at "+widget.restaurantName,
                style: style.copyWith(color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,)
            ),
          ],
        ),
      )
    );
  }


  Widget _buildDishList() {
    for (OrderedDish dish in dishes) {
      totalPrice += dish.price;
    }
    return ListView.separated(
      padding: const EdgeInsets.all(8),
      itemCount: dishes.length,
      itemBuilder: (BuildContext context, int index) {
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
                  Text((index+1).toString()+'. ${dishes[index].name}\n',
                    style: style.copyWith(color: Color(0xFF17B2E0)),),
                  RichText(text: TextSpan(
                    text: "${dishes[index].price} x ",
                    style: style.copyWith(color: Color(0xFF17B2E0)),
                    children: <TextSpan>[
                      TextSpan(
                        text: "£",
                        style: style.copyWith(color: Color(0xFF17B2E0),
                          fontFamily: "Arial",
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: "${dishes[index].price}",
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

    if (!dishesFetched) {
      fetchOrderContent(widget.orderId, dishes).then((value) => {
        setState(() {
          dishesFetched = true;
          build(context);
        })
      });
    }

    return Material(
      child: Scaffold(
        body: Column(
          children: [
            _buildAppBar(),
            Expanded(
              flex: 2,
              child: _buildDishList(),
            ),
            Expanded(
              flex: 1,
              child: RichText(text: TextSpan(
              text: "Total: ",
              style: style.copyWith(color: Color(0xFF43F2EB),
                fontSize: 30,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: "£",
                  style: style.copyWith(color: Color(0xFF17B2E0),
                    fontFamily: "Arial",
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: totalPrice.toString(),
                  style: style.copyWith(color: Color(0xFF17B2E0),
                    fontSize: 30,
                  ),
                ),
              ],),),
            ),
          ],
        ),
      ),
    );
  }
}