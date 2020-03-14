import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_uuid/contactCard.dart';
import 'package:flutter_uuid/educationCard.dart';
import 'package:flutter_uuid/models/users.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  List<Widget> cards = List<Widget>();

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
          ),
          new ListTile(
            title: new Text("Logout"),
            onTap: () {
              logout();
              Navigator.popUntil(context, ModalRoute.withName('/login'));
            },
          )
        ]),
      ),
      body: ListView.builder(
        itemCount: 1,
        itemBuilder: (BuildContext context, int index) {
          return cards.isEmpty
              ? ListView(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  children: <Widget>[contactCard(), educationCard()],
                )
              : ListView(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  children: cards,
                );
        },
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 30, right: 20),
        child: FloatingActionButton(
          child: Icon(Icons.sync),
          onPressed: refreshProfilePage,
          backgroundColor: Colors.blue,
      ),)
    );
  } 

  Future<Null> refreshProfilePage() async {
    await Future.delayed(Duration(milliseconds: 500));

    Widget c = contactCard();
    Widget e = educationCard();

    setState(() {
      cards = <Widget>[c, e];
    });

    return null;
  }

  logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
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
