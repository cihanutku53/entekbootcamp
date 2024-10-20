import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/token_model.dart';

final dio = Dio();

class LoginViewModel {
  Future<bool> login(String email, String pasword) async {
    try {
      final repsonse = await dio.post("https://reqres.in/api/login",
          data: {"email": email, "password": pasword});

      if (repsonse.statusCode == 200) {
        inspect(repsonse.data);
        saveToken(repsonse.data["token"]);
        return true;
      }
    } catch (e) {
      return false;
    }
    return false;
  }

  void saveToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
    final String? token1 = prefs.getString('token');
    inspect(token1);
    print("username");
  }

  void deleteToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove("token");
  }

  bool logout() {
    deleteToken();
    return true;
  }
}
