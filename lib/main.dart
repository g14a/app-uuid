import 'dart:convert';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_uuid/models/users.dart';
import 'package:flutter_uuid/page_two.dart';
import 'package:http/http.dart' as http;

void main () => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: new ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: new MyHomePage(title: "Users"),
      routes: <String, WidgetBuilder>{
        "/a": (BuildContext context) => new NewPage("New Page"),
      });
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key:key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  void initState() {
    super.initState();
    this._getContact();
  }

  Future<ContactInfoModel> _getContact() async {
    final String url = "http://192.168.0.106:8000/users/c16a/contactinfo";
    var data = await http.get(
      Uri.encodeFull(url),
      headers: {
        "Accept": "application/json"
      }
    );

    debugPrint(data.body);
    final jsonData = json.decode(data.body);

    ContactInfoModel contactInfoModel = ContactInfoModel(jsonData['address'],jsonData['email'],jsonData['name'],jsonData['phone']);

    return contactInfoModel;
  }

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
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
        child: new FutureBuilder(
            future: _getContact(),
            builder: (BuildContext context, AsyncSnapshot<ContactInfoModel> snapshot) {
              if (snapshot.data == null) {
                return Container(
                  child: Center(
                    child: Text("Loading..."),
                  ),
                );
              } else {
                return ListView.builder(
                  itemCount: 1,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                            "https://images.pexels.com/photos/3839192/pexels-photo-3839192.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"
                          ),
                        ),
                        title: Text(snapshot.data.name),
                      );
                    }
                );
              }
            }
        )
      ),
    );
  }
}
