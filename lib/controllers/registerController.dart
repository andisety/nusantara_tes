

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:nusantara_tes/utils/apiEndpoint.dart';
import 'package:dio/dio.dart';

class RegisterController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController pwdController = TextEditingController();
  TextEditingController pwd2Controller = TextEditingController();

  Future<void> register() async {
    try {
      final dio = Dio(
        BaseOptions(headers: {'Accept': 'Application/json'})
      );
      var url = APiEndpoint.baseUrl + APiEndpoint.authEndpoints.registerEmail;
      var body = {
        'name': nameController.text,
        'email': emailController.text.trim(),
        'password': pwdController.text,
        'password_confirmation': pwd2Controller.text
      };
      final response = await dio.post(url,
          data: body);
      if (response.statusCode == 200) {
        print("user created:${response.data}");
      }
    } catch (e) {
      print("error : $e");
    }
  }
}
