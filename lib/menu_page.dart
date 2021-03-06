import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:vors_project/order_detail_page.dart';
import 'package:vors_project/util/dish.dart';
import 'package:vors_project/dish_page.dart';
import 'package:vors_project/util/general.dart';
import 'package:vors_project/util/globals.dart';

const MAX_DESCRIPTION_LENGTH = 83;
const MAX_NAME_LENGTH = 17;

class MenuPage extends StatefulWidget {

  final int customerId;
  final String username;
  final int restaurantId;
  final String restaurantName;
  final String imgUrl;


  MenuPage(this.customerId, this.username, this.restaurantId, this.restaurantName, this.imgUrl);

  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {

  late List<Dish> dishes = [];
  late List<Dish> searched = [];

  var dishesFetched = false;


  void awaitDishes() async {
    dishes = await fetchAllDishes(widget.restaurantId);
    searched = dishes;
  }

  @override
  void initState(){
    super.initState();
    awaitDishes();
  }

  Future<bool> _goToDishDetails(BuildContext context, Dish dish, int dishIndex) {
    return Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) =>
        DishPage(dish.dishId, dishIndex, dish.name, dish.ingredients, dish.allergens, dish.dishType, dish.price, widget.restaurantName, widget.restaurantId)))
        .then((_) {
          setState(() {
            currentOrderButton();
          });
          return false;
    });
  }

  Future<bool> _goToCurrentOrder(BuildContext context, int restaurantId) {
    return Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) =>
        OrderDetailPage(true, 0, false, widget.restaurantName, widget.restaurantId)))
        .then((_) {
      setState(() {
        currentOrderButton();
      });
      return false;
    });
  }

  TextStyle style = TextStyle(
    fontFamily: 'Futura',
    color: Colors.white,
    fontSize: 26,
  );

  Container _buildSearch() {

    final searchField = TextField(
      onChanged: (text) => {
        updateDishes(text)
      },
      obscureText: false,
      style: style.copyWith(fontSize: 20),
      decoration: InputDecoration(
        filled: true,
        fillColor: Color(0xFF43F2EB),
        contentPadding: EdgeInsets.all(15.0),
        hintText: "Search...",
        hintStyle: TextStyle(
          fontFamily: 'Futura',
          color: Colors.white.withOpacity(0.8),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32.0),
          borderSide: BorderSide.none,
        ),
      ),
    );

    return Container(
      color: Color(0xFF17B2E0),
      padding: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          searchField,
        ],
      )
    );
  }

  ImageProvider<Object> imageGenerator(String imgUrl) {
    if (imgUrl == "") {
      return AssetImage("assets/images/no_image.png");
    } else {
      return NetworkImage(imgUrl);
    }
  }

  String formulateDishName(int index, String name) {
    String newName = name;
    if (name.length > MAX_NAME_LENGTH) {
      newName = name.substring(0,MAX_NAME_LENGTH)+'...';
    }
    return index.toString()+'. ' + newName +'\n';
  }

  Widget _buildHeader() {
    return ListView.separated(
      padding: const EdgeInsets.all(8),
      itemCount: searched.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () => _goToDishDetails(context, searched[index], index+1),
          child: Container(
            height: 120,
            color: Colors.white,
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(formulateDishName(index+1, searched[index].name),
                        style: style.copyWith(color: Color(0xFF17B2E0)),),
                      RichText(text: TextSpan(
                        text: "",
                        style: style.copyWith(color: Color(0xFF17B2E0)),
                        children: <TextSpan>[
                          TextSpan(
                            text: "??",
                            style: style.copyWith(color: Color(0xFF17B2E0),
                              fontFamily: "Arial",
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: searched[index].price.toStringAsFixed(2),
                            style: style.copyWith(color: Color(0xFF17B2E0),),
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
                            text: '${searched[index].ingredients}',
                            style: style.copyWith(color: Colors.black,
                              fontSize: 18,),
                        ),
                      ),
                      ),
                    ],
                  ),
                ],
              )
            ),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }

  Widget currentOrderButton() {

    if (!currentOrders.containsKey(widget.restaurantId)) {
      return Material();
    } else {
      return Material(
        borderRadius: BorderRadius.circular(30.0),
        color: Color(0xFF43F2EB),
        child: MaterialButton(
          minWidth: 100,
          padding: EdgeInsets.all(10.0),
          onPressed: () => {
            _goToCurrentOrder(context, widget.restaurantId)
          },
          child: FittedBox(
            fit: BoxFit.contain,
            child: Text("Current order",
              textAlign: TextAlign.center,
              style: style.copyWith(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      );
    }
  }

  AppBar _buildAppBar() {

    return AppBar(
      title: Center(
        child: Text(
          formulateString(widget.restaurantName, 20),
          style: style.copyWith(color: Colors.white,
            fontWeight: FontWeight.bold,),
        ),
      ),
      backgroundColor: Color(0xFF17B2E0),
    );
  }

  @override
  Widget build(BuildContext context) {

    if (dishes.length == 0 && !dishesFetched) {

      fetchAllDishes(widget.restaurantId).then((value) => {
        setState(() {
          dishesFetched = true;
          build(context);
        })
      });
    }

    return Material(
      child: Scaffold(
        appBar: _buildAppBar(),
        body: Column(
          children: [
            Image(image: imageGenerator(widget.imgUrl)),
            _buildSearch(),
            Expanded(
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  _buildHeader(),
                  Positioned(
                    bottom: 50,
                    child: currentOrderButton(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  updateDishes(String search) {
    print(search);
    if (search == "" || search == null) {
      searched = dishes;
      setState(() {
        _buildHeader();
      });
      return;
    }
    searched = [];
    for(Dish dish in dishes) {
      if (dish.name.toLowerCase().contains(search.toLowerCase())) {
        searched.add(dish);
        print(dish.name);
      }
    }
    setState(() {
      _buildHeader();
    });
  }
}