import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:nusantara_tes/ui/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/apiEndpoint.dart';

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController pwdController = TextEditingController();

  final Future<SharedPreferences> _pref = SharedPreferences.getInstance();

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

        Map<String, dynamic> responseData = response.data;

        // final json = jsonDecode(response.data);
        var token = responseData['token'];
        print(token);
        final SharedPreferences prefs = await _pref;
        await prefs.setString('token', token);
        Get.to(HomePage());
      }
    } catch (e) {
      print("error login: $e");
    }
  }
}
