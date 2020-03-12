import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_uuid/contactCard.dart';
import 'package:flutter_uuid/educationCard.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  ProfilePageState createState() => new ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
        elevation: defaultTargetPlatform == TargetPlatform.android ? 5.0 : 0.0,
      ),
      drawer: new Drawer(
        child: new ListView(children: <Widget>[
          new UserAccountsDrawerHeader(
            accountName: new Text("Gowtham Munukutla"),
            accountEmail: new Text("gowtham@atlan.com"),
            currentAccountPicture: new CircleAvatar(
              backgroundColor: Colors.black,
              child: new Text("GM"),
            ),
          ),
        ]),
      ),
      body: new ListView(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        children: <Widget>[contactCard(), educationCard()],
      ),
    );
  }
}
