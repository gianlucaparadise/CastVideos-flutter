import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class VideoBrowserRoute extends StatelessWidget {
  VideoBrowserRoute({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.title),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.cast),
            title: Text('Video 1'),
          ),
          ListTile(
            leading: Icon(Icons.cast),
            title: Text('Video 2'),
          ),
          ListTile(
            leading: Icon(Icons.cast),
            title: Text('Video 3'),
          ),
        ],
      ),
    );
  }
}
