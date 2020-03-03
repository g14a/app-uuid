import 'dart:convert';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_uuid/models/models.dart';
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
    this._getUsers();
  }

  Future<List<PersonModel>> _getUsers() async {
    final String url = "https://jsonplaceholder.typicode.com/users";
    var data = await http.get(url);

    List<dynamic> jsonData = json.decode(data.body);
    debugPrint(data.body);

    List<PersonModel> users = [];

    for (var p in jsonData) {
      print("came into the loop");
      PersonModel person = PersonModel(p['username'],p['id'],p['name'],p['email']);
      print("the value is ${person.title}");
      users.add(person);
    }

    return users;
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
            future: _getUsers(),
            builder: (BuildContext context, AsyncSnapshot<List<PersonModel>> snapshot) {
              if (snapshot.data == null) {
                print("null data");
                return Container(
                  child: Center(
                    child: Text("Loading..."),
                  ),
                );
              } else {
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        title: Text(snapshot.data[index].userId),
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
