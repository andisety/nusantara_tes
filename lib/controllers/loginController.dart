import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/apiEndpoint.dart';

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController pwdController = TextEditingController();

  final Future<SharedPreferences> _Pref = SharedPreferences.getInstance();

  Future<void> login() async {
    try {
      final dio = Dio(BaseOptions(headers: {'Accept': 'Application/json'}));
      var url = APiEndpoint.baseUrl + APiEndpoint.authEndpoints.loginEmail;
      var body = {
        'email': emailController.text.trim(),
        'password': pwdController.text
      };

      final response = await dio.post(url, data: body);
      if (response.statusCode == 200) {
        print(response.data);
        final json = jsonDecode(response.data);
        var token = json['token'];
        final SharedPreferences? prefs = await _Pref;
        await prefs?.setString('token', token);
      }
    } catch (e) {
      print("error : $e");
    }
  }
}
