import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/books.dart';
import '../utils/apiEndpoint.dart';

class BookController extends GetxController {
  var datum = <Datum>[].obs;
  RxList<Datum> booksList = <Datum>[].obs;
  var url = APiEndpoint.baseUrl + APiEndpoint.authEndpoints.books;
  var isLoading = false.obs;

  Future<String> getToken() async {
    String? token = await SharedPreferences.getInstance()
        .then((prefs) => prefs.getString('token'));
    return token.toString();
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    fetchdata();
  }

  fetchdata() async {
    try {
      isLoading(true);

      final dio = Dio();
      dio.options.headers['Accept'] = 'Application/json';
      dio.options.headers['Authorization'] =
          'Bearer 1079|eS6VzQd61l7DgEPRraRzip12JMmub8cIj94GkqFi';
      var token = getToken();
      print(token);

      var response = await dio.get(url);

      if (response.statusCode == 200) {
        Books books = Books.fromJson(response.data);
        booksList.assignAll(books.data);
        // var data = List<Datum>.from(
        //         jsonDecode(response.data['data']).map((e) => Books.fromJson(e)))
        //     .toList();
        // datum.value = data;
      }
    } catch (e) {
      print("error get book $e");
    } finally {
      isLoading(false);
    }
  }
}
