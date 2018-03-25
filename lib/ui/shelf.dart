import 'package:book_keeper/model/book.dart';
import 'package:book_keeper/ui/book_tile.dart';
import 'package:flutter/material.dart';
import 'package:book_keeper/ui/search.dart';

class ShelfScreen extends StatefulWidget {
  @override
  createState() => new _ShelfScreen();
}

class _ShelfScreen extends State<ShelfScreen> {
  List<Book> _books = [];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('My Books'),
        actions: <Widget>[
          new IconButton(icon: new Icon(Icons.add), onPressed: _add)
        ],
      ),
      body: new ListView.builder(
          itemBuilder: (BuildContext context, int index) =>
              _buildBookTile(context, _books[index]),
          itemCount: _books.length),
    );
  }

  Widget _buildBookTile(BuildContext context, Book book) {
    return new BookTile(book);
  }

  void _add() {
    Navigator.of(context).push(
      new MaterialPageRoute(
        builder: (context) {
          return new SearchScreen();
        },
      ),
    );
  }
}
