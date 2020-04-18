import 'package:flutter/material.dart';
import 'package:flutter_uuid/services/auth_service.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddHealhInfo extends StatefulWidget {
  @override
  _AddHealthInfoState createState() => _AddHealthInfoState();
}

class _AddHealthInfoState extends State<AddHealhInfo> {
  final hospitalController = TextEditingController();
  final bloodGroupController = TextEditingController();

  bool validate = false;

  @override
  void dispose() {
    hospitalController.dispose();
    bloodGroupController.dispose();
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
                  hospitalController.text.isNotEmpty ||
                    bloodGroupController.text.isNotEmpty
                      ? validate = true
                      : validate = false;
                });
                if (await addHealthInfo() && validate) {
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
                        controller: hospitalController,
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
                        controller: bloodGroupController,
                      ),
                      SizedBox(height: 10.0),
                                          ],
                  )),
            ]));
  }

  Future<bool> addHealthInfo() async {
    var hospital = hospitalController.text;
    var bloodGroup = bloodGroupController.text;

    if (hospital.isNotEmpty || bloodGroup.isNotEmpty) {
      var request = AddHealthInfoRequest(hospital, bloodGroup);
      return AddInfoService.addHealthInfo(request);
    }

    return false;
  }
}
