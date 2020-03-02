import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_uuid/page_two.dart';

void main () => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: new ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: new HomePage(),
      routes: <String, WidgetBuilder>{
        "/a": (BuildContext context) => new NewPage("New Page"),
      });
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("UUID"),
        elevation: defaultTargetPlatform == TargetPlatform.android ? 5.0 : 0.0,
      ),
      drawer: new Drawer(
        child: new ListView(
          children: <Widget> [
            new UserAccountsDrawerHeader(
              accountName: new Text("Gowtham Munukutla"), 
              accountEmail: new Text("gowtham@atlan.com"),
              currentAccountPicture: new CircleAvatar(
                backgroundColor: Colors.black,
                child: new Text("GM"),
              ),
            ),
            new ListTile(
              title: new Text("Page one"),
              trailing: new Icon(Icons.arrow_back),
              onTap: () => Navigator.of(context).pushNamed("/a"),
            ),
             new ListTile(
              title: new Text("Page Two"),
              trailing: new Icon(Icons.arrow_forward)
            ),
            new Divider(),
             new ListTile(
              title: new Text("Close"),
              trailing: new Icon(Icons.close),
              onTap: () => Navigator.of(context).pop(),
            )
          ]
        ),
      ),
      body: new Container(
        child: new Center(
          child: new Text("Home"),
        ),
      ),
    );
  }
}
