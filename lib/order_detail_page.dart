import 'dart:collection';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:vors_project/util/globals.dart';
import 'package:vors_project/util/home_page_items.dart';
import 'package:vors_project/util/order.dart';
import 'package:vors_project/util/order_content.dart';
import 'package:flutter/services.dart';
import 'package:vors_project/main.dart';


class OrderDetailPage extends StatefulWidget {

  final bool isCurrent;
  final int orderId;
  final bool active;
  final String restaurantName;
  final int restaurantId;

  OrderDetailPage(this.isCurrent, this.orderId, this.active, this.restaurantName, this.restaurantId);

  @override
  _OrderDetailPageState createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {

  late List<OrderedDish> dishes = [];
  late String title = "";
  double totalPrice = 0;
  bool dishesFetched = false;
  bool priceAddedUp = false;
  bool dishesAreOrdered = false;
  final tableNumberController = TextEditingController();

  @override
  void initState(){
    super.initState();
    if (widget.isCurrent) {
      title = "Current";
    } else if (widget.active) {
      title = "Active";
    } else {
      title = "Past";
    }
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
    if (!priceAddedUp && dishesFetched) {
      for (OrderedDish dish in dishes) {
        totalPrice += dish.price * dish.orderCount;
      }
      priceAddedUp = true;
    }

    if(!widget.isCurrent && !dishesAreOrdered && dishesFetched){
      Map<OrderedDish, int> dishesWithQuantity = new HashMap();
      for (OrderedDish dish in dishes) {
        dishesWithQuantity.putIfAbsent(dish, () => 0);
        dishesWithQuantity.update(dish, (value) => value+1);
      }
      List<OrderedDish> countedDishes = [];
      dishesWithQuantity.forEach((key, value) {
        OrderedDish orderedDish = new OrderedDish(key.id, key.name, key.price, value);
        countedDishes.add(orderedDish);
      });
      dishes = countedDishes;
      dishesAreOrdered = true;
    }

    return ListView.separated(
      padding: const EdgeInsets.all(8),
      itemCount: dishes.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          child: Container(
            height: 60,
            color: Colors.white,
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: RichText(
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(
                        text: (index+1).toString()+'. ${dishes[index].name}',
                        style: style.copyWith(color: Color(0xFF17B2E0),
                        ),
                      ),
                    ),
                  ),
                  RichText(text: TextSpan(
                    text: "${dishes[index].orderCount} x ",
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
                        text: dishes[index].price.toStringAsFixed(2),
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

  String convertDishIds(List<OrderedDish> dishes) {
    List<String> ids = [];
    for (OrderedDish dish in dishes) {
      for (int i = 0; i < dish.orderCount; i++) {
        ids.add(dish.id.toString());
      }
    }
    return ids.reduce((id1, id2) => id1+','+id2);
  }

  Widget confirmOrReorderButton() {
    if (widget.isCurrent) {
      return Material(
        borderRadius: BorderRadius.circular(30.0),
        color: Color(0xFF17B2E0),
        child: MaterialButton(
          minWidth: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(15.0),
          onPressed: () => {
            setState(() {
              if (tableNumberController.text.isNotEmpty) {
                submitOrder(customerId, widget.restaurantId,
                    convertDishIds(dishes), tableNumberController.text).then((value) => {
                      if (value) {
                        setState(() {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            DefaultSnackBar().withText('Order submitted.', context),
                          );
                        })
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          DefaultSnackBar().withText('Connection failed.', context),
                        )
                      }
                });

              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  DefaultSnackBar().withText('Please enter your table number.', context),
                );
              }
            })
          },
          child: Text("Confirm",
              textAlign: TextAlign.center,
              style: style.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold)
          ),
        ),
      );
    } else if (!widget.active) {
      return Material(
        borderRadius: BorderRadius.circular(30.0),
        color: Color(0xFF17B2E0),
        child: MaterialButton(
          minWidth: MediaQuery
              .of(context)
              .size
              .width,
          padding: EdgeInsets.all(15.0),
          onPressed: () => {},
          child: Text("Reorder",
              textAlign: TextAlign.center,
              style: style.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold)
          ),
        ),
      );
    }  else return Material();
  }

  Widget tableNumberField() {
    if(widget.isCurrent) {
      return TextFormField(
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        inputFormatters: [
          // ignore: deprecated_member_use
          WhitelistingTextInputFormatter.digitsOnly,
        ],
        controller: tableNumberController,
        obscureText: false,
        style: style.copyWith(color: Colors.white.withOpacity(0.8)),
        decoration: InputDecoration(
          errorMaxLines: 1,
          errorText: 'Null',
          errorStyle: TextStyle(
            color: Colors.transparent,
            fontSize: 0,
          ),
          filled: true,
          fillColor: Color(0xFF17B2E0),
          hintText: "Enter table number...",
          hintStyle: TextStyle(
            fontFamily: 'Futura',
            color: Colors.white.withOpacity(0.8),
          ),
        ),
      );
    } else return Material();
  }

  @override
  Widget build(BuildContext context) {

    if (widget.isCurrent) {
      dishes = currentOrders[widget.restaurantId];
      dishesFetched = true;
    } else {
      if (!dishesFetched) {
        fetchOrderContent(widget.orderId, dishes).then((value) =>
        {
          setState(() {
            dishesFetched = true;
            dishes.forEach((element) {print(element.orderCount);});
            build(context);
          })
        });
      }
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
              child: Column(
                children: [
                  RichText(text: TextSpan(
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
                        text: totalPrice.toStringAsFixed(2),
                        style: style.copyWith(color: Color(0xFF17B2E0),
                          fontSize: 30,
                        ),
                      ),
                    ],),),
                  tableNumberField(),
                  Container(
                    width: 140,
                    child: confirmOrReorderButton(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}