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
  var isLoading = false.obs;
  var isSuccess = false.obs;
  final Future<SharedPreferences> _pref = SharedPreferences.getInstance();

  Future<void> login() async {
    isLoading(true);
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
        var token = responseData['token'];
        print(token);
        final SharedPreferences prefs = await _pref;
        await prefs.setString('token', token);
        isSuccess(true);
        Get.snackbar("Sukses", "Login berhasil");

        Get.to(() => const HomePage());
      }
    } catch (e) {
      isLoading(false);
      Get.snackbar("Failed", "Login Gagal");
      print("error login: $e");
    }
  }
}
