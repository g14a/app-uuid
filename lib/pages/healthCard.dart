import 'dart:convert';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_uuid/pages/login.dart';
import 'package:flutter_uuid/models/models.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Container healthCard() {
  return Container(
      child: FutureBuilder(
    future: _getHealthInfo(),
    builder:
        (BuildContext context, AsyncSnapshot<HealthInfoModel> snapshot) {
      if (snapshot.data == null) {
        return Container(
            child: Card(
                child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 8.0, bottom: 8.0, left: 2.0),
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Icon(
                                    FontAwesomeIcons.school,
                                    size: 15.0,
                                  ),
                                ),
                                Text("No Health Data. Try adding it in Settings"),
                                Spacer(),
                              ],
                            ),
                          ),
                        ]))));
      } else {
        return ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: 1,
            itemBuilder: (BuildContext context, int index) {
              return new Container(
                // ContactInfo Card
                child: Card(
                    child: Padding(
                  padding: const EdgeInsets.only(left: 25, right: 20.0, bottom: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 2.0),
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Icon(
                                FontAwesomeIcons.hospital,
                                size: 15.0,
                              ),
                            ),
                            Text(" " + snapshot.data.birthHospital),
                            Spacer(),
                            Padding(
                              padding: const EdgeInsets.only(top: 20, right: 5),
                              child: Icon(
                                Icons.local_hospital,
                                size: 60.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 2.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Icon(
                                FontAwesomeIcons.tint,
                                size: 15.0,
                              ),
                            ),
                            Text(snapshot.data.bloodGroup),
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

Future<HealthInfoModel> _getHealthInfo() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String currentUser = await getUsername();
  String jwtToken = prefs.getString('token');

  final String url = "http://192.168.1.5:8000/users/$currentUser/healthinfo";
  
  var response = await http.get(Uri.encodeFull(url), headers: {
    "Accept": "application/json",
    "Authorization": 'Bearer $jwtToken'
  });

  final jsonData = json.decode(response.body);

  HealthInfoModel healthInfoModel = HealthInfoModel(
      jsonData['birthhospital'], jsonData['bloodgroup']);

  return healthInfoModel;
}
