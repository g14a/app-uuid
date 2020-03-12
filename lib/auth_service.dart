import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static Future<bool> login(LoginRequest request) async {
    var url = "http://192.168.1.3:8000/users/signin";

    SharedPreferences prefs = await SharedPreferences.getInstance();

    final response = await http.post(url, body: json.encode(request.toJson()));

    print(response.headers['token']);
    
    if(response.statusCode == 200) {
      prefs.setString('token', response.headers['token']);
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