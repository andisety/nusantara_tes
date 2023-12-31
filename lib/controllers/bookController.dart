import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/books.dart';
import '../ui/home.dart';
import '../utils/apiEndpoint.dart';

class BookController extends GetxController {
  TextEditingController isbnController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController subtitleController = TextEditingController();
  TextEditingController authorController = TextEditingController();
  TextEditingController publishedController = TextEditingController();
  TextEditingController publisherController = TextEditingController();
  TextEditingController pagesController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController webController = TextEditingController();

  var datum = <Datum>[].obs;
  RxList<Datum> booksList = <Datum>[].obs;

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
      var url = APiEndpoint.baseUrl + APiEndpoint.authEndpoints.books;
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
      }
    } catch (e) {
      print("error get book $e");
    } finally {
      isLoading(false);
    }
  }

  addBook() async {
    try {
      final dio = Dio();
      dio.options.headers['Accept'] = 'Application/json';
      dio.options.headers['Authorization'] =
          'Bearer 1079|eS6VzQd61l7DgEPRraRzip12JMmub8cIj94GkqFi';
      var url = APiEndpoint.baseUrl + APiEndpoint.authEndpoints.addBooks;
      var body = {
        'isbn': isbnController.text,
        'title': titleController.text,
        'subtitle': subtitleController.text,
        'author': authorController.text,
        'publisher': publisherController.text,
        'published': publishedController.text,
        'pages': pagesController.text,
        'description': descController.text,
        'website': webController.text,
      };

      final response = await dio.post(url, data: body);
      if (response.statusCode == 200) {
        print(response.data);
        Map<String, dynamic> responseData = response.data;
        var token = responseData['token'];
        print(token);
        Get.to(HomePage());
      }
    } catch (e) {
      print("error add book: $e");
    }
  }
}
