import 'dart:async';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:book_keeper/api/client.dart';
import 'package:book_keeper/api/database.dart';
import 'package:book_keeper/model/book.dart';
import 'package:book_keeper/ui/book_tile.dart';
import 'package:flutter/material.dart';
import 'package:googleapis/books/v1.dart';

class SearchScreen extends StatefulWidget {
  final DatabaseManager _databaseManager;

  SearchScreen(this._databaseManager);

  @override
  createState() => new _SearchScreen(_databaseManager);
}

class _SearchScreen extends State<SearchScreen> {
  Future<Volumes> _volumes;
  final DatabaseManager _databaseManager;

  _SearchScreen(this._databaseManager);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Search'),
      ),
      body: new Column(
        children: <Widget>[
          new Container(
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildButtonColumn(Icons.camera_alt, 'SCAN', _scan),
                buildButtonColumn(Icons.bookmark, 'EXAMPLE', () {
                  this._volumes = search("9789026144646");
                  setState(() => {});
                }),
              ],
            ),
          ),
          new Flexible(
            child: new FutureBuilder<Volumes>(
              future: _volumes,
              builder: (BuildContext context, AsyncSnapshot<Volumes> snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return new CircularProgressIndicator();
                  default:
                    if (snapshot.hasError)
                      return new Text('Error: ${snapshot.error}');
                    else
                      return _buildVolumes(snapshot.data);
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVolumes(Volumes volumes) {
    if (volumes == null) {
      return new Container();
    }

    return new ListView.builder(
      itemBuilder: (BuildContext context, int index) =>
          _buildBookTile(context, volumes.items[index]),
      itemCount: volumes.items.length,
    );
  }

  Future _scan() async {
    try {
      String barcode = await BarcodeScanner.scan();
      setState(() => this._volumes = search(barcode));
    } catch (e) {}
  }

  Widget _buildBookTile(BuildContext context, Volume volume) {
    return new BookTile(
      _databaseManager,
      new Book.fromVolume(volume),
    );
  }

  Widget buildButtonColumn(IconData icon, String label, onPressed) {
    Color color = Theme.of(context).primaryColor;

    return new FlatButton(
      onPressed: onPressed,
      child: new Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          new Icon(icon, color: color),
          new Container(
            margin: const EdgeInsets.only(top: 8.0),
            child: new Text(
              label,
              style: new TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w400,
                color: color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
