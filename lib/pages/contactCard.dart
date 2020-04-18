import 'dart:convert';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_uuid/constants.dart';
import 'package:flutter_uuid/models/models.dart';
import 'package:flutter_uuid/pages/login.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Container contactCard() {
  return Container( 
      child: FutureBuilder(
    future: getContactInfo(),
    builder: (BuildContext context, AsyncSnapshot<ContactInfoModel> snapshot) {
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
                                    Icons.person,
                                    size: 15.0,
                                  ),
                                ),
                                Text(
                                    "No Contact Data. Try adding it in Settings"),
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
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: Icon(
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
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 8, right: 8),
                              child: Icon(
                                Icons.phone,
                                size: 20.0,
                              ),
                            ),
                            Text(snapshot.data.phone),
                            Spacer(),
                            Padding(
                              padding: const EdgeInsets.only(top: 10,right: 5),
                              child: Icon(
                                Icons.phone,
                                size: 70.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
                              child: Icon(
                                Icons.email,
                                size: 20.0,
                              ),
                            ),
                            Text(snapshot.data.email),
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

Future<ContactInfoModel> getContactInfo() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String currentUser = await getUsername();
  String jwtToken = prefs.getString('token');

  final String url =  "${AppConstants.baseURL}" + "users/$currentUser/contactinfo";

  var response = await http.get(Uri.encodeFull(url), headers: {
    "Accept": "application/json",
    "Authorization": 'Bearer $jwtToken'
  });

  final jsonData = json.decode(response.body);

  ContactInfoModel contactInfoModel = ContactInfoModel(jsonData['address'],
      jsonData['email'], jsonData['name'], jsonData['phone']);

  prefs.setString('name', jsonData['name']);

  return contactInfoModel;
}
