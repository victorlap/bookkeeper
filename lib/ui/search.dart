import 'dart:async';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:book_keeper/api/client.dart';
import 'package:googleapis/books/v1.dart';
import 'package:book_keeper/ui/book_tile.dart';
import 'package:book_keeper/model/book.dart';

class SearchScreen extends StatefulWidget {
  @override
  createState() => new _SearchScreen();
}

class _SearchScreen extends State<SearchScreen> {
  Future<Volumes> _volumes;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('Search'),
          actions: <Widget>[
            new IconButton(icon: new Icon(Icons.camera_alt), onPressed: scan),
            new IconButton(icon: new Icon(Icons.bookmark), onPressed: () {
              this._volumes = search("9789026144646");
              setState(() => {});
            }),
          ],
        ),
        body: new FutureBuilder<Volumes>(
          future: _volumes, // a Future<String> or null
          builder: (BuildContext context, AsyncSnapshot<Volumes> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none: return new Text('Press button to start');
              case ConnectionState.waiting: return new Text('Awaiting result...');
              default:
                if (snapshot.hasError)
                  return new Text('Error: ${snapshot.error}');
                else
                  return _buildVolumes(snapshot.data);
            }
          },
        )
    );
  }

  Widget _buildVolumes(Volumes volumes) {
    return new ListView.builder(
        itemBuilder: (BuildContext context, int index) =>
            _buildBookTile(context, volumes.items[index]),
        itemCount: volumes.items.length
    );
  }

  String barcode;
  Future scan() async {
    try {
      String barcode = await BarcodeScanner.scan();
      setState(() => this._volumes = search(barcode));
      setState(() => this.barcode = barcode);
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          this.barcode = 'The user did not grant the camera permission!';
        });
      } else {
        setState(() => this.barcode = 'Unknown error: $e');
      }
    } on FormatException {
      setState(() => this.barcode =
      'null (User returned using the "back"-button before scanning anything. Result)');
    } catch (e) {
      setState(() => this.barcode = 'Unknown error: $e');
    }
  }

  Widget _buildBookTile(BuildContext context, Volume volume) {
    return new BookTile(new Book.fromVolume(volume));
  }
}
