import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:vors_project/util/dish.dart';
import 'package:vors_project/util/star_rating.dart';


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
  bool dishCommentsFetched = false;
  List<String> comments = [];

  final commentController = TextEditingController();

  late double currentRating = 5.0;

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

  Widget _buildHeader() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: RichText(
                  maxLines: 100,
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(
                    text: widget.dishIndex.toString()+". "+widget.dishName,
                    style: style.copyWith(color: Color(0xFF17B2E0),
                    ),
                  ),
                ),
              ),
             SizedBox(
               width: 10,
             ),
             RichText(text: TextSpan(
               text: (widget.rating >= 0.1) ?
              widget.rating.toStringAsFixed(1) : "No ratings",
              style: style.copyWith(color: Color(0xFF17B2E0),),
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
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Ingredients:",
                style: style.copyWith(color: Color(0xFF17B2E0),),
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Flexible(
                child: RichText(
                  maxLines: 100,
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
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Allergens:",
                style: style.copyWith(color: Color(0xFF17B2E0),),
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Flexible(
                child: RichText(
                  maxLines: 100,
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(
                    text: widget.allergens,
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Dish type: "+((widget.type == "VEGAN") ? "Vegan" : ((widget.type == "VEGETARIAN") ? "Vegetarian" : "Non vegetarian")),
                style: style.copyWith(color: Color(0xFF17B2E0),),
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text("Price",
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

  Widget _buildCommentSection() {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount:comments.length,
      itemBuilder: (BuildContext context, int index) {
        return Text(comments[index]);
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    if(!dishCommentsFetched) {
      fetchDishComments(widget.dishId, comments).then((value) => {
        setState(() {
          dishCommentsFetched = true;
          comments.forEach((element) => print(element));
          build(context);
        })
      });
    }

    final commentField = TextFormField(
      controller: commentController,
      obscureText: false,
      style: style.copyWith(color: Color(0xFF43F2EB),),
      decoration: InputDecoration(
        errorMaxLines: 1,
        errorText: 'Null',
        errorStyle: TextStyle(
          color: Colors.transparent,
          fontSize: 0,
        ),
        filled: true,
        fillColor: Color(0xFFF2F2F2),
        //contentPadding: EdgeInsets.all(15.0),
        hintText: "Add comment...",
        hintStyle: TextStyle(
          fontFamily: 'Futura',
          color: Color(0xFF43F2EB).withOpacity(0.8),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32.0),
          borderSide: BorderSide.none,
        ),
      ),
    );

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

    final submitButton = Material(
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xFF43F2EB),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(15.0),
        onPressed: () {},
        child: Text("➜",
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
        body:
        SingleChildScrollView(
          child:
          Column(
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
              ),
              SizedBox(
                height: 20,
              ),
              StarRating(
                rating: currentRating,
                onRatingChanged: (rating) => setState(() => this.currentRating = rating), color: Color(0xFF17B2E0),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      child: commentField,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                    width: 80,
                    child: submitButton,
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Comments:",
                    style: style.copyWith(color: Color(0xFF43F2EB),),
                  ),
                ],
              ),
              _buildCommentSection(),
            ],
          ),
        ),
      ),
    );
  }
}