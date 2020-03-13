import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_uuid/contactCard.dart';
import 'package:flutter_uuid/educationCard.dart';
import 'package:flutter_uuid/models/users.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  ProfilePageState createState() => new ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  String initials = "";
  String nameText = "";
  String email = "";

  @override
  void initState() {
    super.initState();
    setNameInitials();
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
            accountName: new Text(nameText),
            accountEmail: new Text(email),
            currentAccountPicture: new CircleAvatar(
              backgroundColor: Colors.black,
              child: new Text(initials),
            ),
          ),
          new ListTile(
            title: new Text("Settings"),
          )
        ]),
      ),
      body: new ListView(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        children: <Widget>[contactCard(), educationCard()],
      ),
    );
  }

  Future<void> setNameInitials() async {

    ContactInfoModel model = await getContactInfo();

    List textArray = model.name.split(' ').toList();

    setState(() {
      initials = textArray[0][0] + textArray[1][0];
      nameText = model.name;
      email = model.email;
    });
  }
}
