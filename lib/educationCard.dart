import 'dart:convert';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_uuid/models/users.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Container educationCard() {
  return Container(
    child: FutureBuilder(
    future: _getEducationInfo(),
    builder: (BuildContext context, AsyncSnapshot<EducationInfoModel> snapshot) {
      if (snapshot.data == null) {
        print("null data");
        return Container(
          child: Center(
            child: Text("Loading..."),
          ),
        );
      } else {
        print("came inside snapshot data");
        return ListView.builder(
            itemCount: 1,
            itemBuilder: (BuildContext context, int index) {
              return new Container(
                // ContactInfo Card
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
                              child: Icon(
                                Icons.person,
                                size: 20.0,
                              ),
                            ),
                            Text(snapshot.data.primary),
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
                              child: Icon(
                                Icons.phone,
                                size: 20.0,
                              ),
                            ),
                            Text(snapshot.data.secondary),
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
                              child: Icon(
                                Icons.email,
                                size: 20.0,
                              ),
                            ),
                            Text(snapshot.data.university),
                            Spacer(),
                          ],
                        ),
                      ),
                    ],
                  ),
                )),
              );
            });
      }
    },
  ));
}

Future<EducationInfoModel> _getEducationInfo() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String currentUser = prefs.getString('username');
  String jwtToken = prefs.getString('token');

  final String url = "http://192.168.1.3:8000/users/$currentUser/educationinfo";

  var data = await http.get(Uri.encodeFull(url), headers: {
    "Accept": "application/json",
    "Authorization": 'Bearer $jwtToken'
  });

  print(data.body);

  final jsonData = json.decode(data.body);

  EducationInfoModel educationInfoModel = EducationInfoModel(
      jsonData['primary'], jsonData['secondary'], jsonData['university']);

  return educationInfoModel;
}
