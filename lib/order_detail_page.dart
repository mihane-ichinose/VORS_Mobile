import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:vors_project/util/globals.dart';
import 'package:vors_project/util/home_page_items.dart';
import 'package:vors_project/util/order_content.dart';
import 'package:flutter/services.dart';


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
    if (!priceAddedUp) {
      for (OrderedDish dish in dishes) {
        totalPrice += dish.price * dish.orderCount;
      }
      priceAddedUp = true;
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

  Widget confirmOrReorderButton() {
    if (widget.isCurrent) {
      return Material(
        borderRadius: BorderRadius.circular(30.0),
        color: Color(0xFF17B2E0),
        child: MaterialButton(
          minWidth: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(15.0),
          onPressed: () => {},
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
          // border: OutlineInputBorder(
          //   borderRadius: BorderRadius.circular(32.0),
          //   borderSide: BorderSide.none,
          // ),
        ),
      );
    } else return Material();
  }

  @override
  Widget build(BuildContext context) {

    if (widget.isCurrent) {
      dishes = currentOrders[widget.restaurantId];
    } else {
      if (!dishesFetched) {
        fetchOrderContent(widget.orderId, dishes).then((value) =>
        {
          setState(() {
            dishesFetched = true;
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