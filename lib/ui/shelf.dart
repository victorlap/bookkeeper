import 'package:book_keeper/api/database.dart';
import 'package:book_keeper/model/book.dart';
import 'package:book_keeper/ui/book_tile.dart';
import 'package:book_keeper/ui/search.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class ShelfScreen extends StatefulWidget {
  final DatabaseManager _databaseManager;

  ShelfScreen(this._databaseManager);

  @override
  createState() => new _ShelfScreen(_databaseManager);
}

class _ShelfScreen extends State<ShelfScreen> {
  final DatabaseManager _databaseManager;

  _ShelfScreen(this._databaseManager);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('My Books'),
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.add),
            onPressed: _add,
          )
        ],
      ),
      body: new Column(
        children: <Widget>[
          new Flexible(
            child: new FirebaseAnimatedList(
              query: _databaseManager.reference,
              sort: (a, b) => b.value['title'].compareTo(a.value['title']),
              padding: new EdgeInsets.all(8.0),
              itemBuilder: _buildBookTile,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildBookTile(
      _, DataSnapshot snapshot, Animation<double> animation, index) {
    return new BookTile(_databaseManager, new Book.fromSnapshot(snapshot));
  }

  void _add() {
    Navigator.of(context).push(
      new MaterialPageRoute(
        builder: (context) {
          return new SearchScreen(_databaseManager);
        },
      ),
    );
  }
}
