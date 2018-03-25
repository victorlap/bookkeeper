import 'package:book_keeper/api/database.dart';
import 'package:book_keeper/ui/shelf.dart';
import 'package:flutter/material.dart';

class BookKeeper extends StatelessWidget {
  final DatabaseManager _databaseManager = new DatabaseManager();

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Book Keeper',
      home: new ShelfScreen(_databaseManager),
    );
  }
}