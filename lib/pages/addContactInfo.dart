import 'package:flutter/material.dart';
import 'package:flutter_uuid/services/auth_service.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddContactInfo extends StatefulWidget {
  @override
  _AddContactInfoState createState() => _AddContactInfoState();
}

class _AddContactInfoState extends State<AddContactInfo> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  bool validate = false;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
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
          title: new Text("Add Contact Info"),
          leading: GestureDetector(
            onTap: () {},
            child: Icon(
              Icons.arrow_back,
            ),
          ),
          actions: <Widget>[
            FlatButton(
              textColor: Colors.white,
              child: Text("SAVE", style: TextStyle(fontSize: 15)),
              onPressed: () async {
                setState(() {
                  usernameController.text.isEmpty ||
                          passwordController.text.isEmpty
                      ? validate = true
                      : validate = false;
                });
                if (await addContactInfo() && validate) {
                  Navigator.of(context).pushNamed("/login");
                } else {
                  Fluttertoast.showToast(
                      msg: "Unable to sign up",
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
                            labelText: 'Name',
                            labelStyle: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.green))),
                        controller: nameController,
                      ),
                      SizedBox(height: 10.0),
                      TextField(
                        decoration: InputDecoration(
                            labelText: 'Email ',
                            labelStyle: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.green))),
                        controller: emailController,
                      ),
                      SizedBox(height: 10.0),
                      TextField(
                        decoration: InputDecoration(
                            labelText: 'Phone ',
                            labelStyle: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.green))),
                        controller: phoneController,
                      ),
                      SizedBox(height: 50.0),
                      Container(
                          height: 60.0,
                          child: Material(
                            borderRadius: BorderRadius.circular(40.0),
                            shadowColor: Colors.greenAccent,
                            color: Colors.green,
                            elevation: 7.0,
                            child: GestureDetector(
                              onTap: () async {
                                setState(() {
                                  usernameController.text.isEmpty ||
                                          passwordController.text.isEmpty
                                      ? validate = true
                                      : validate = false;
                                });
                                if (await addContactInfo() && validate) {
                                  Navigator.of(context).pushNamed("/login");
                                } else {
                                  Fluttertoast.showToast(
                                      msg: "Unable to sign up",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                }
                              },
                              child: Center(
                                child: Text(
                                  'Signup',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Montserrat'),
                                ),
                              ),
                            ),
                          )),
                      SizedBox(height: 30.0),
                      Container(
                        height: 60.0,
                        color: Colors.transparent,
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.black,
                                  style: BorderStyle.solid,
                                  width: 1.0),
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(40.0)),
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).pushNamed("/login");
                            },
                            child: Center(
                              child: Text('Already have an account?  Login',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Montserrat')),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
            ]));
  }

  Future<bool> addContactInfo() async {
    var name = nameController.text;
    var email = emailController.text;
    var phone = phoneController.text;

    if (name.isNotEmpty || email.isNotEmpty || phone.isNotEmpty) {
      var request = AddContactInfoRequest(name, email, phone);
      return AddInfoService.addContactInfo(request);
    }

    return false;
  }
}
