import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:vors_project/util/dish.dart';
import 'package:vors_project/dish_page.dart';

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
  var dishesFetched = false;


  void awaitDishes() async {
    dishes = await fetchAllDishes(widget.restaurantId);
  }

  @override
  void initState(){
    super.initState();
    awaitDishes();
  }

  Future<bool> _goToDishDetails(BuildContext context, Dish dish, int dishIndex) {
    return Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) =>
        DishPage(dish.dishId, dishIndex, dish.name, dish.rating, dish.ingredients, dish.allergens, dish.dishType, dish.price)))
        .then((_) => false);
  }

  TextStyle style = TextStyle(
    fontFamily: 'Futura',
    color: Colors.white,
    fontSize: 26,
  );

  AppBar _buildAppBar() {

    final searchField = TextField(
      obscureText: false,
      style: style,
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

    return AppBar(
      backgroundColor: Color(0xFF17B2E0),
      title: Column(
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
      itemCount: dishes.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () => _goToDishDetails(context, dishes[index], index+1),
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
                      Text(formulateDishName(index+1, dishes[index].name),
                        style: style.copyWith(color: Color(0xFF17B2E0)),),
                      RichText(text: TextSpan(
                        text: "",
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Flexible(
                        child: RichText(
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          text: TextSpan(
                            text: '${dishes[index].ingredients}',
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
        body: Column(
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Image(image: imageGenerator(widget.imgUrl),
                ),
                Container(

                  height: 40,
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.8),
                      borderRadius: BorderRadius.all(Radius.circular(10.0))
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Center(
                        child: Text(" "+widget.restaurantName+" ",
                          style: style.copyWith(color: Color(0xFF43F2EB)),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            _buildAppBar(),
            Expanded(
              child: _buildHeader(),
            ),
          ],
        ),
      ),
    );
  }
}