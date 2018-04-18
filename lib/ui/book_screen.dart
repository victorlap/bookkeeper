import 'package:book_keeper/model/book.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class BookScreen extends StatelessWidget {
  final Book _book;
  final double _appBarHeight = 256.0;

  BookScreen(this._book);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new CustomScrollView(
        slivers: <Widget>[
          new SliverAppBar(
            expandedHeight: _appBarHeight,
            pinned: true,
            flexibleSpace: new FlexibleSpaceBar(
              title: new Container(
                  child: new Text(
                _book.title,
              )),
              centerTitle: true,
              background: new Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  new Image.network(_book.thumb, fit: BoxFit.cover),
                  // This gradient ensures that the toolbar icons are distinct
                  // against the background image.
                  const DecoratedBox(
                    decoration: const BoxDecoration(
                      gradient: const LinearGradient(
                        begin: const Alignment(0.0, -1.0),
                        end: const Alignment(0.0, -0.4),
                        colors: const <Color>[
                          const Color(0x60000000),
                          const Color(0x00000000)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          new SliverList(
            delegate: new SliverChildListDelegate(
              <Widget>[
                new _InfoContainer(
                  title: 'Auteur',
                  info: _book.author ?? 'Onbekend',
                ),
                new _InfoContainer(
                  title: 'Uitgever',
                  info: _book.publisher,
                ),
                new _InfoContainer(
                  title: 'Uitgegeven op',
                  info: _book.publishedAt,
                ),
                new _InfoContainer(
                  title: 'Categorie',
                  info: _book.category,
                ),
                new _InfoContainer(
                  title: 'Beschrijving',
                  info: _book.description,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoContainer extends StatelessWidget {
  final String title;
  final String info;

  _InfoContainer({this.title, this.info});

  @override
  Widget build(BuildContext context) {
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new Container(
            margin: new EdgeInsets.all(8.0),
            child: new Text(
              title,
              style: const TextStyle(
                fontSize: 24.0,
              ),
            )),
        new Container(
          margin: new EdgeInsets.symmetric(horizontal: 8.0),
          child: new Text(info),
        ),
      ],
    );
  }

}
