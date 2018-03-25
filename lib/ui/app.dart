import 'package:flutter/material.dart';
import 'package:book_keeper/ui/shelf.dart';

class BookKeeper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Book Keeper',
      home: new ShelfScreen(),
      routes: <String, WidgetBuilder> {
      }
    );
  }
}