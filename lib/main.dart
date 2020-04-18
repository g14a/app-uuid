import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_uuid/pages/addContactInfo.dart';
import 'package:flutter_uuid/pages/addeducationinfo.dart';
import 'package:flutter_uuid/pages/login.dart';
import 'package:flutter_uuid/pages/profile.dart';
import 'package:flutter_uuid/pages/signup.dart';
import 'package:flutter_uuid/pages/settings.dart';

void main () => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
        primarySwatch: Colors.green
      ),
      home: new SignupPage(),
      routes: <String, WidgetBuilder> {
        "/login": (BuildContext context) => new LoginPage(),
        "/profile": (BuildContext context) => new ProfilePage(title: "Welcome"),
        "/addcontactinfo": (BuildContext context) => new AddContactInfo(),
        "/addeducationinfo": (BuildContext context) => new AddEducationInfo(),
        "/settings": (BuildContext context) => new SettingsPage()
      },
    );
  }
}