import 'package:book_keeper/model/book.dart';
import 'package:book_keeper/ui/book_screen.dart';
import 'package:flutter/material.dart';
import 'package:book_keeper/api/database.dart';
import 'package:cached_network_image/cached_network_image.dart';

class BookTile extends StatefulWidget {
  final DatabaseManager _databaseManager;
  final Book _book;

  BookTile(this._databaseManager, this._book);

  @override
  createState() => new _BookTile(_databaseManager, _book);
}

class _BookTile extends State<BookTile> {
  final DatabaseManager _databaseManager;
  final Book _book;
  bool _favorite;

  _BookTile(this._databaseManager, this._book) {
    _favorite = _databaseManager.hasFavorite(_book.id);
  }

  @override
  Widget build(BuildContext context) {
    return new ListTile(
      leading: new CachedNetworkImage(
        placeholder: new CircularProgressIndicator(),
        imageUrl: _book.thumb,
      ),
      title: new Text(_book.title),
      trailing: new IconButton(
        icon: new Icon(Icons.favorite),
        onPressed: _favorited,
        color: _favorite ? Colors.red : null,
      ),
      onTap: () => _tap(context),
    );
  }

  void _tap(context) {
    Navigator.of(context).push(
      new MaterialPageRoute(
        builder: (context) {
          return new BookScreen(_book);
        },
      ),
    );
  }

  void _favorited() {
    if (_favorite) {
      _databaseManager.deleteBook(_book);
    } else {
      _databaseManager.sendBook(_book);
    }
    _favorite = !_favorite;
    setState(() {});
  }
}
