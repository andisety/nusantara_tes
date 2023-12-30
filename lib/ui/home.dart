import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/bookController.dart';
import '../model/books.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  BookController bookController = Get.put(BookController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Obx(() {
      return ListView.builder(
          itemCount: bookController.booksList.length,
          itemBuilder: (context, index) {
            Datum book = bookController.booksList[index];
            return ListTile(
              title: Text(book.title),
              subtitle: Text(book.author),
            );
          });
    }));
  }
}
