import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/books.dart';
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
  final booksList = <Datum>[].obs;

  var isLoading = false.obs;

  Future<String> getToken() async {
    String? token = await SharedPreferences.getInstance()
        .then((prefs) => prefs.getString('token'));
    return 'Bearer $token';
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
      dio.options.headers['Authorization'] = await getToken();
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
      dio.options.headers['Authorization'] = await getToken();
      print(await getToken());
      var url = "${APiEndpoint.baseUrl}/api/books/add";

      var body = {
        'isbn': isbnController.text,
        'title': titleController.text,
        if (subtitleController.text.isNotEmpty)
          'subtitle': subtitleController.text,
        if (authorController.text.isNotEmpty) 'author': authorController.text,
        if (publisherController.text.isNotEmpty)
          'publisher': publisherController.text,
        if (publishedController.text.isNotEmpty)
          'published': publishedController.text,
        if (pagesController.text.isNotEmpty) 'pages': pagesController.text,
        if (descController.text.isNotEmpty) 'description': descController.text,
        if (webController.text.isNotEmpty) 'website': webController.text,
      };

      final response = await dio.post(url, data: body);
      print(response.data);
      if (response.statusCode == 200) {
        fetchdata();
        Get.back();
        isbnController.text = '';
        titleController.text = '';
        subtitleController.text = '';
        authorController.text = '';
        publishedController.text = '';
        publisherController.text = '';
        pagesController.text = '';
        descController.text = '';
        webController.text = '';
      }
    } catch (e) {
      if (e is DioError) {
        if (e.response != null) {
          print(e.response?.data);
        }
      }
      print("error add book: $e");
    }
  }

  editBook(int id) async {
    try {
      final dio = Dio();
      dio.options.headers['Accept'] = 'Application/json';
      dio.options.headers['Authorization'] = await getToken();
      var url = "${APiEndpoint.baseUrl}/api/books/$id/edit";
      var body = {
        'isbn': isbnController.text,
        'title': titleController.text,
        if (subtitleController.text.isNotEmpty)
          'subtitle': subtitleController.text,
        if (authorController.text.isNotEmpty) 'author': authorController.text,
        if (publisherController.text.isNotEmpty)
          'publisher': publisherController.text,
        if (publishedController.text.isNotEmpty)
          'published': publishedController.text,
        if (pagesController.text.isNotEmpty) 'pages': pagesController.text,
        if (descController.text.isNotEmpty) 'description': descController.text,
        if (webController.text.isNotEmpty) 'website': webController.text,
      };

      final response = await dio.put(url, data: body);
      if (response.statusCode == 200) {
        print(response.data);
        fetchdata();
        Get.back();
      }
    } catch (e) {
      print("error edit book: $e");
    }
  }

  deleteBook(int id) async {
    try {
      final dio = Dio();
      dio.options.headers['Accept'] = 'Application/json';
      dio.options.headers['Authorization'] = await getToken();
      var url = "${APiEndpoint.baseUrl}/api/books/$id";

      final response = await dio.delete(url);
      if (response.statusCode == 200) {
        print(response.data);
        booksList.removeWhere((element) => element.id == id);
        fetchdata();
      }
    } catch (e) {
      print("error delete book: $e");
    }
  }
}
