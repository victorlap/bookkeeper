import 'package:flutter/material.dart';
import 'package:book_keeper/model/book.dart';
import 'package:cached_network_image/cached_network_image.dart';

class BookScreen extends StatelessWidget {
  final Book _book;

  BookScreen(this._book);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(),
        body: new ListView(children: <Widget>[
          new Column(children: <Widget>[
            new CachedNetworkImage(
                placeholder: new CircularProgressIndicator(),
                imageUrl: _book.thumb),
            new Title(
                color: Colors.blueAccent,
                child: new Text(_book.title)),
          ]),
          new Text(_book.description ?? ''),
        ]));
  }
}
