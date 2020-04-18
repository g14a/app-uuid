import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Settings"),
      ),
      body: Container(
        child: ListView(children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10),
            child: ListTile(
              title: Text(
                "Contact Information",
                style: TextStyle(fontSize: 23),
              ),
              subtitle: Text(
                "Add your contact information and let others see it when needed.",
                style: TextStyle(fontSize: 11),
              ),
              trailing: Icon(Icons.phone),
              onTap: () => Navigator.of(context).pushNamed('/addcontactinfo'),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: ListTile(
              title: Text(
                "Education Information",
                style: TextStyle(fontSize: 23),
              ),
              subtitle: Text(
                "Add your education information and let others see it when needed.",
                style: TextStyle(fontSize: 11),
              ),
              trailing: Icon(Icons.school),
              onTap: () => Navigator.of(context).pushNamed('/addeducationinfo'),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: ListTile(
              title: Text(
                "Health Information",
                style: TextStyle(fontSize: 23),
              ),
              subtitle: Text(
                "Add your Health information and let others see it when needed.",
                style: TextStyle(fontSize: 12),
              ),
              trailing: Icon(Icons.local_hospital),
            ),
          )
        ]),
      ),
    );
  }
}
