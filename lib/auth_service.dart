import 'package:flutter_uuid/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static Future<bool> login(LoginRequest request) async {
    var url = "http://192.168.1.5:8000/users/signin";

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
    var url = "http://192.168.1.5:8000/users/signup";

    print(request.toJson());

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