
import 'package:flutter/material.dart';

class DefaultSnackBar {
  SnackBar withText(String text, BuildContext context) {
    return SnackBar(
      content: Text(text),
      backgroundColor: Color(0xFF43F2EB),
      action: SnackBarAction(
        label: "GOT IT",
        textColor: Color(0xFF17B2E0),
        onPressed: () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        },
      ),
    );
  }
}

class DefaultSignUpTextField {
  late String text;
  late TextStyle style;

  DefaultSignUpTextField withText(String text) {
    this.text = text;
    return this;
  }

  DefaultSignUpTextField withStyle(TextStyle style) {
    this.style = style;
    return this;
  }

  TextField build() {
    return TextField(
      controller: TextEditingController(),
      obscureText: false,
      style: this.style,
      decoration: InputDecoration(
        filled: true,
        fillColor: Color(0xFF43F2EB),
        contentPadding: EdgeInsets.all(15.0),
        hintText: this.text,
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
  }

  TextField buildAsPasswordField() {
    return TextField(
      controller: TextEditingController(),
      obscureText: true,
      enableSuggestions: false,
      autocorrect: false,
      style: this.style,
      decoration: InputDecoration(
        filled: true,
        fillColor: Color(0xFF43F2EB),
        contentPadding: EdgeInsets.all(15.0),
        hintText: this.text,
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
  }
}

class DefaultLoginTextFormField {
  late String text;
  TextEditingController controller = TextEditingController();
  late TextStyle style;

  DefaultLoginTextFormField withText(String text) {
    this.text = text;
    return this;
  }

  DefaultLoginTextFormField withController(TextEditingController controller) {
    this.controller = controller;
    return this;
  }

  DefaultLoginTextFormField withStyle(TextStyle style) {
    this.style = style;
    return this;
  }

  TextFormField build() {
    return TextFormField(
      // validator: ,
      controller: this.controller,
      obscureText: false,
      style: style,
      decoration: InputDecoration(
        errorMaxLines: 1,
        errorText: 'Null',
        errorStyle: TextStyle(
          color: Colors.transparent,
          fontSize: 0,
        ),
        filled: true,
        fillColor: Color(0xFF43F2EB),
        contentPadding: EdgeInsets.all(15.0),
        hintText: this.text,
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
  }

  TextFormField buildAsPasswordField() {
    return TextFormField(
      // validator: ,
      controller: this.controller,
      obscureText: true,
      enableSuggestions: false,
      autocorrect: false,
      style: style,
      decoration: InputDecoration(
        errorMaxLines: 1,
        errorText: 'Null',
        errorStyle: TextStyle(
          color: Colors.transparent,
          fontSize: 0,
        ),
        filled: true,
        fillColor: Color(0xFF43F2EB),
        contentPadding: EdgeInsets.all(15.0),
        hintText: this.text,
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
  }
}