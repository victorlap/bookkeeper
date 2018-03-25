import 'package:flutter/material.dart';
import 'package:book_keeper/model/book.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:book_keeper/ui/book_screen.dart';

class BookTile extends StatelessWidget {
  final Book _book;

  BookTile(this._book);

  @override
  Widget build(BuildContext context) {
    return new ListTile(
      leading: new CachedNetworkImage(
          placeholder: new CircularProgressIndicator(),
          imageUrl: _book.thumb),
      title: new Text(_book.title),
      trailing: new IconButton(icon: new Icon(Icons.favorite), onPressed: ()=>{},),
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
}
