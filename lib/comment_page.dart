import 'package:flutter/material.dart';
import 'package:vors_project/util/dish.dart';

List<Dish> currentOrder = [];

class CommentPage extends StatefulWidget {

  final String comment;

  CommentPage(this.comment);

  @override
  _CommentPageState createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {

  TextStyle style = TextStyle(
    fontFamily: 'Futura',
    color: Colors.white,
    fontSize: 26,
  );

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Color(0xFF17B2E0),
      title: Container(),
    );
  }

  Widget _buildComment() {
    return Container(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Text(widget.comment,
          style: style.copyWith(
            fontWeight: FontWeight.bold,
            color: Color(0xFF17B2E0),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildComment(),
            ],
          ),
        ),
    );
  }
}
