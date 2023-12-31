import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/apiEndpoint.dart';

class UserController extends GetxController {
  Future<String> getToken() async {
    String? token = await SharedPreferences.getInstance()
        .then((prefs) => prefs.getString('token'));
    return 'Bearer $token';
  }

  logout() async {
    try {
      var url = '${APiEndpoint.baseUrl}/api/user/logout';
      final dio = Dio();
      dio.options.headers['Accept'] = 'Application/json';
      dio.options.headers['Authorization'] = await getToken();
      var token = getToken();
      print(token);
      var response = await dio.delete(url);
      if (response.statusCode == 200) {}
    } catch (e) {
      print("error logout$e");
    } finally {}
  }
}
