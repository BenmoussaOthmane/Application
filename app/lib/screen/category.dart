import 'package:flutter/material.dart';

class Category extends StatefulWidget {
  static final String id = 'category';
  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Text(
            'Category'
          ),
        ),
      ),
    );
  }
}