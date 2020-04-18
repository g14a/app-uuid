import 'package:flutter/material.dart';
import 'package:flutter_uuid/services/auth_service.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddEducationInfo extends StatefulWidget {
  @override
  _AddEducationInfoState createState() => _AddEducationInfoState();
}

class _AddEducationInfoState extends State<AddEducationInfo> {
  final primarySchoolController = TextEditingController();
  final secondarySchoolController = TextEditingController();
  final universityController = TextEditingController();

  bool validate = false;

  @override
  void dispose() {
    primarySchoolController.dispose();
    secondarySchoolController.dispose();
    universityController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Add Education Info"),
          leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Icon (
              Icons.arrow_back,
            ),
          ),
          actions: <Widget>[
            FlatButton(
              textColor: Colors.white,
              child: Text("SAVE", style: TextStyle(fontSize: 15)),
              onPressed: () async {
                setState(() {
                  primarySchoolController.text.isNotEmpty ||
                    secondarySchoolController.text.isNotEmpty || 
                      universityController.text.isNotEmpty
                      ? validate = true
                      : validate = false;
                });
                if (await addEducationInfo() && validate) {
                  Navigator.of(context).pushNamed("/login");
                } else {
                  Fluttertoast.showToast(
                      msg: "Error",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0);
                }
              },
            ),
          ],
        ),
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                  padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
                  child: Column(
                    children: <Widget>[
                      TextField(
                        decoration: InputDecoration(
                            labelText: 'Primary School',
                            labelStyle: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.green))),
                        controller: primarySchoolController,
                      ),
                      SizedBox(height: 10.0),
                      TextField(
                        decoration: InputDecoration(
                            labelText: 'Secondary School ',
                            labelStyle: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.green))),
                        controller: secondarySchoolController,
                      ),
                      SizedBox(height: 10.0),
                      TextField(
                        decoration: InputDecoration(
                            labelText: 'University ',
                            labelStyle: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.green))),
                        controller: universityController,
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(height: 50.0)
                    ],
                  )),
            ]));
  }

  Future<bool> addEducationInfo() async {
    var primary = primarySchoolController.text;
    var secondary = secondarySchoolController.text;
    var university = universityController.text;

    if (primary.isNotEmpty || secondary.isNotEmpty || university.isNotEmpty) {
      var request = AddEducationInfoRequest(primary, secondary, university);
      return AddInfoService.addEducationInfo(request);
    }

    return false;
  }
}
