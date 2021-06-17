import 'dart:ui';

import 'package:flutter/material.dart';


const MAX_DESCRIPTION_LENGTH = 83;
const MAX_NAME_LENGTH = 17;

class DishPage extends StatefulWidget {

  final int dishId;
  final int dishIndex;
  final String dishName;
  final double rating;
  final String ingredients;
  final String allergens;
  final String type;
  final double price;


  DishPage(this.dishId, this.dishIndex, this.dishName, this.rating, this.ingredients, this.allergens, this.type, this.price,);

  @override
  _DishPageState createState() => _DishPageState();
}

class _DishPageState extends State<DishPage> {

  @override
  void initState(){
    super.initState();
  }

  TextStyle style = TextStyle(
    fontFamily: 'Futura',
    color: Colors.white,
    fontSize: 26,
  );

  AppBar _buildAppBar() {

    return AppBar(
      title: Center(
        child: Text(
          "Dish details",
          style: style.copyWith(color: Colors.white,
          fontWeight: FontWeight.bold,),
        ),
      ),
      backgroundColor: Color(0xFF17B2E0),
    );
  }

  String formulateDishName(int index, String name) {
    String newName = name;
    if (name.length > MAX_NAME_LENGTH) {
      newName = name.substring(0,MAX_NAME_LENGTH)+'...';
    }
    return index.toString()+'. ' + newName +'\n';
  }

  Widget _buildHeader() {
    return Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(formulateDishName(widget.dishIndex, widget.dishName),
                          style: style.copyWith(color: Color(0xFF17B2E0)),),
                        RichText(text: TextSpan(
                          text: (widget.rating >= 0.1) ?
                          widget.rating.toStringAsFixed(1) : "No ratings",
                          style: style.copyWith(color: Color(0xFF17B2E0)),
                          children: <TextSpan>[
                            TextSpan(
                              text: (widget.rating >= 0.1) ? "★" : "",
                              style: style.copyWith(color: Color(0xFF17B2E0),
                                fontFamily: "Arial",
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Flexible(
                          child: RichText(
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            text: TextSpan(
                              text: widget.ingredients,
                              style: style.copyWith(color: Colors.black,
                                fontSize: 18,),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text("Price each",
                          style: style.copyWith(color: Color(0xFF17B2E0)),),
                        RichText(text: TextSpan(
                          text: "£",
                          style: style.copyWith(color: Color(0xFF17B2E0),
                            fontFamily: "Arial",
                            fontWeight: FontWeight.bold,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: widget.price.toString(),
                              style: style.copyWith(color: Color(0xFF17B2E0),),
                            ),
                          ],
                        ),),
                      ],
                    ),
                  ],
                ),
    );
  }

  @override
  Widget build(BuildContext context) {

    final orderButton = Material(
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xFF43F2EB),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(15.0),
        onPressed: () {},
        child: Text("Add to order",
          textAlign: TextAlign.center,
          style: style.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );

    return Material(
      child: Scaffold(
        appBar: _buildAppBar(),
        body: Column(
          children: [
            SizedBox(
              height: 40,
            ),
            _buildHeader(),
            SizedBox(
              height: 20,
            ),
            Container(
              width: 200,
              height: 50,
              child: orderButton,
            )
          ],
        ),
      ),
    );
  }
}