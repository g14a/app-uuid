import 'dart:convert';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_uuid/pages/login.dart';
import 'package:flutter_uuid/models/models.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_uuid/constants.dart';

Container educationCard() {
  return Container(
      child: FutureBuilder(
    future: _getEducationInfo(),
    builder:
        (BuildContext context, AsyncSnapshot<EducationInfoModel> snapshot) {
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
                                Text("No Education Data. Try adding it in Settings"),
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
                            Text(" " + snapshot.data.primary),
                            Spacer(),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 2.0, bottom: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Icon(
                                FontAwesomeIcons.university,
                                size: 18.0,
                              ),
                            ),
                            Text(snapshot.data.secondary),
                            Spacer(),
                            Padding(
                              padding: const EdgeInsets.only(top: 10, right: 5),
                              child: Icon(
                                Icons.school,
                                size: 70.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Icon(
                                Icons.school,
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
  String currentUser = await getUsername();
  String jwtToken = prefs.getString('token');

  final String url =  "${AppConstants.baseURL}" + "users/$currentUser/educationinfo";

  var response = await http.get(Uri.encodeFull(url), headers: {
    "Accept": "application/json",
    "Authorization": 'Bearer $jwtToken'
  });

  final jsonData = json.decode(response.body);

  EducationInfoModel educationInfoModel = EducationInfoModel(
      jsonData['primary'], jsonData['secondary'], jsonData['university']);

  return educationInfoModel;
}
