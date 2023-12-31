import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:nusantara_tes/ui/login_page.dart';
import 'package:nusantara_tes/utils/apiEndpoint.dart';
import 'package:dio/dio.dart';

class RegisterController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController pwdController = TextEditingController();
  TextEditingController pwd2Controller = TextEditingController();
  final isLoading = false.obs;

  Future<void> register() async {
    try {
      isLoading(true);
      final dio = Dio(BaseOptions(headers: {'Accept': 'Application/json'}));
      var url = APiEndpoint.baseUrl + APiEndpoint.authEndpoints.registerEmail;
      var body = {
        'name': nameController.text,
        'email': emailController.text.trim(),
        'password': pwdController.text,
        'password_confirmation': pwd2Controller.text
      };
      final response = await dio.post(url, data: body);
      if (response.statusCode == 200) {
        nameController.text = '';
        emailController.text = '';
        pwdController.text = '';
        pwd2Controller.text = '';

        print("user created:${response.data}");
        Get.snackbar("Success", "Register berhasil");
        Get.to(() => const LoginPage());
      }
    } catch (e) {
      isLoading(false);
      print("error : $e");
      Get.snackbar("Error", "Register gagal");
    }
  }
}
