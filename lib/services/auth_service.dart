import 'package:flutter_uuid/pages/addeducationinfo.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_uuid/constants.dart';

class AuthService {
  static Future<bool> login(LoginRequest request) async {
    var url = "${AppConstants.baseURL}" + "users/signin";

    SharedPreferences prefs = await SharedPreferences.getInstance();

    final response = await http.post(url, body: json.encode(request.toJson()));

    print(response.headers['token']);

    if (response.statusCode == 200) {
      prefs.setString('token', response.headers['token']);
      return true;
    }

    return false;
  }

  static Future<bool> signup(SignUpRequest request) async {
    var url = "${AppConstants.baseURL}" + "users/signup";

    final response = await http.post(url, body: json.encode(request.toJson()));

    if (response.statusCode == 200) {
      return true;
    }

    return false;
  }
}

class AddInfoService {
  static Future<bool> addContactInfo(AddContactInfoRequest request) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String currentUser = prefs.getString('username');

    var url = "${AppConstants.baseURL}" + "users/$currentUser/addcontactinfo";

    final response = await http.post(url, body: json.encode(request.toJson()));

    if (response.statusCode == 200) {
      return true;
    }

    return false;
  }

    static Future<bool> addEducationInfo(AddEducationInfoRequest request) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String currentUser = prefs.getString('username');

    var url = "${AppConstants.baseURL}" + "users/$currentUser/addeducationinfo";

    final response = await http.post(url, body: json.encode(request.toJson()));

    if (response.statusCode == 200) {
      return true;
    }

    return false;
  }

   static Future<bool> addHealthInfo(AddHealthInfoRequest request) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String currentUser = prefs.getString('username');

    var url = "${AppConstants.baseURL}" + "users/$currentUser/addhealthinfo";

    final response = await http.post(url, body: json.encode(request.toJson()));

    if (response.statusCode == 200) {
      return true;
    }

    return false;
  }
}


class LoginRequest {
  String username;
  String password;

  LoginRequest(this.username, this.password);

  Map<String, String> toJson() {
    var map = Map<String, String>();
    map["username"] = username;
    map["password"] = password;
    return map;
  }
}

class SignUpRequest {
  String username;
  String password;

  SignUpRequest(this.username, this.password);

  Map<String, String> toJson() {
    var map = Map<String, String>();
    map["username"] = username;
    map["password"] = password;

    return map;
  }
}

class AddContactInfoRequest {
  String name, email, phone;

  AddContactInfoRequest(this.name, this.email, this.phone);

  Map<String, String> toJson() {
    var map = Map<String, String>();
    map["name"] = name;
    map["email"] = email;
    map["phone"] = phone;

    return map;
  }
}

class AddEducationInfoRequest {
  String primarySchool, secondarySchool, university;

  AddEducationInfoRequest(this.primarySchool, this.secondarySchool, this.university);

  Map<String, String> toJson() {
    var map = Map<String, String>();
    map["primary"] = primarySchool;
    map["secondary"] = secondarySchool;
    map["university"] = university;

    return map;
  }
}

class AddHealthInfoRequest {
  String birthHospital, bloodGroup;

  AddHealthInfoRequest(this.birthHospital, this.bloodGroup);

  Map<String, String> toJson() {
    var map = Map<String, String>();
    map["birthhospital"] = birthHospital;
    map["bloodgroup"] = bloodGroup;

    return map;
  }
}
