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
            onTap: () {
              Navigator.pop(context);
            },
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
                  nameController.text.isNotEmpty ||
                    emailController.text.isNotEmpty|| 
                      phoneController.text.isNotEmpty
                      ? validate = true
                      : validate = false;
                });
                
                if (await addContactInfo() && validate) {
                  Navigator.of(context).pushNamed("/profile");
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
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(height: 50.0)
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
