import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:vors_project/util/dish.dart';
import 'package:vors_project/util/home_page_items.dart';


class MenuPage extends StatefulWidget {
  final int customerId;
  final String username;

  MenuPage(this.customerId, this.username);

  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {

  late List<Dish> dishes = [];

  @override
  void initState(){
    super.initState();
    fetchAllDishes(dishes, 5).then((value) {
      for (Dish dish in dishes) {
        print(dish);
      }
    });

  }

  TextStyle style = TextStyle(
    fontFamily: 'Futura',
    color: Colors.white,
    fontSize: 26,
  );

  AppBar _buildAppBar(args) {

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
          color: Colors.white,
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
      // actions: <Widget>[
      //   userBtn,
      //   SizedBox(width: 10),
      // ],
    );
  }

  final List<double> prices = <double>[5.99, 6.99, 6.49, 6.49, 6.49, 6.49, 6.49, 6.49, 6.49, 6.49];
  // final List<Dish> dishes = <Dish>[
  //   new Dish(dishId: 1,
  //       name: "Margherita",
  //       ingredients: "Pizza dough, tomato sauce, cheese, tomato",
  //       allergens: "none",
  //       type: "non-vegeterian",
  //       rating: 4.8),
  //   new Dish(dishId: 2,
  //       name: "Pepperoni",
  //       ingredients: "Pizza dough, tomato sauce, cheese, pepperoni",
  //       allergens: "none",
  //       type: "non-vegeterian",
  //       rating: 4.9),
  //   new Dish(dishId: 3,
  //       name: "Quattro formaggi",
  //       ingredients: "Pizza dough, tomato sauce, cheese, cheddar, emmental,",
  //       allergens: "none",
  //       type: "vegeterian",
  //       rating: 4.7),
  //   new Dish(dishId: 3,
  //       name: "Quattro formaggi",
  //       ingredients: "Pizza dough, tomato sauce, cheese, cheddar, emmental,",
  //       allergens: "none",
  //       type: "vegeterian",
  //       rating: 4.7),
  //   new Dish(dishId: 3,
  //       name: "Quattro formaggi",
  //       ingredients: "Pizza dough, tomato sauce, cheese, cheddar, emmental,",
  //       allergens: "none",
  //       type: "vegeterian",
  //       rating: 4.7),
  //   new Dish(dishId: 3,
  //       name: "Quattro formaggi",
  //       ingredients: "Pizza dough, tomato sauce, cheese, cheddar, emmental,",
  //       allergens: "none",
  //       type: "vegeterian",
  //       rating: 4.7),
  //   new Dish(dishId: 3,
  //       name: "Quattro formaggi",
  //       ingredients: "Pizza dough, tomato sauce, cheese, cheddar, emmental,",
  //       allergens: "none",
  //       type: "vegeterian",
  //       rating: 4.7),
  //   new Dish(dishId: 3,
  //       name: "Quattro formaggi",
  //       ingredients: "Pizza dough, tomato sauce, cheese, cheddar, emmental,",
  //       allergens: "none",
  //       type: "vegeterian",
  //       rating: 4.7),
  //   new Dish(dishId: 3,
  //       name: "Quattro formaggi",
  //       ingredients: "Pizza dough, tomato sauce, cheese, cheddar, emmental,",
  //       allergens: "none",
  //       type: "vegeterian",
  //       rating: 4.7),
  //   new Dish(dishId: 3,
  //       name: "Quattro formaggi",
  //       ingredients: "Pizza dough, tomato sauce, cheese, cheddar, emmental,",
  //       allergens: "none",
  //       type: "vegeterian",
  //       rating: 4.7),
  // ];

  Widget _buildHeader(args) {
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
            height: 100,
            color: Colors.white,
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text((index+1).toString()+'. ${dishes[index].name}\n',
                        style: style.copyWith(color: Color(0xFF17B2E0)),),
                      RichText(text: TextSpan(
                        text: "from ",
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('${dishes[index].ingredients}',
                        style: style.copyWith(color: Colors.black,
                          fontSize: 18,),
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

    final args = ModalRoute.of(context)!.settings.arguments;

    return Material(
      child: Scaffold(
        body: Column(
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Image.asset("assets/images/pizzeria_sample.jpg",
                  width: double.infinity,
                ),
                Container(
                  width: 150,
                  height: 40,
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.8),
                      borderRadius: BorderRadius.all(Radius.circular(10.0))
                  ),
                  child: Center(
                    child: Text("Pizzeria",
                      style: style.copyWith(color: Color(0xFF43F2EB)),
                      textAlign: TextAlign.center,
                    ),
                  )
                ),
              ],
            ),
            _buildAppBar(args),
            Expanded(
              child: _buildHeader(args),
            ),
          ],
        ),
      ),
    );
  }
}