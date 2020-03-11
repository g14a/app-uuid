import 'dart:convert';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_uuid/models/users.dart';
import 'package:http/http.dart' as http;

class ProfilePage extends StatefulWidget {
  ProfilePage({Key key, this.title}) : super(key:key);

  final String title;

  @override
  ProfilePageState createState() => new ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {

  @override
  void initState() {
    super.initState();
    this._getContact();
  }

  Future<ContactInfoModel> _getContact() async {
    final String url = "http://192.168.1.2:8000/users/c16a/contactinfo";
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
                      return new Container(
                       child: Card(
                         child: Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: Column(
                           children: <Widget>[
                             Padding(
                               padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                               child: Row(
                               children: <Widget>[
                                 Padding(
                                   padding: const EdgeInsets.all(8),
                                   child: Icon (
                                    Icons.person,
                                    size: 20.0,
                                  ),
                                 ),
                                 Text(snapshot.data.name),
                                 Spacer(),
                               ],
                              ),
                             ),
                             Padding(
                               padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                               child: Row(
                               mainAxisAlignment: MainAxisAlignment.spaceAround,
                               children: <Widget>[
                                 Padding(
                                   padding: const EdgeInsets.all(8),
                                   child: Icon (
                                    Icons.phone,
                                    size: 20.0,
                                  ),
                                 ),
                                 Text(snapshot.data.phone),
                                 Spacer(),
                               ],
                              ),
                             ),
                             Padding(
                               padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                               child: Row(
                               children: <Widget>[
                                 Padding(
                                   padding: const EdgeInsets.all(8),
                                   child: Icon (
                                    Icons.email,
                                    size: 20.0,
                                  ),
                                 ),
                                 Text(snapshot.data.email),
                                 Spacer(),
                               ],
                              ),
                             ),
                             Padding(
                               padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                               child: Row(
                               children: <Widget>[
                                 Padding(
                                   padding: const EdgeInsets.all(8),
                                   child: Icon (
                                    Icons.location_city,
                                    size: 20.0,
                                  ),
                                 ),
                                 Text(snapshot.data.address),
                                 Spacer(),
                               ],
                              ),
                             ),
                           ],
                         ),
                         )
                       ),
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
