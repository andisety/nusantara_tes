import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nusantara_tes/ui/add_edit_book.dart';
import 'package:nusantara_tes/ui/detailpage.dart';

import '../controllers/bookController.dart';
import '../model/books.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  BookController bookController = Get.put(BookController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Book"),
      ),
      body: Obx(() {
        return ListView.builder(
            itemCount: bookController.booksList.length,
            itemBuilder: (context, index) {
              Datum book = bookController.booksList[index];
              return GestureDetector(
                  onDoubleTap: () {
                    Get.to(DetailPage(book: book));
                  },
                  child: ListTile(
                    title: Text(book.title),
                    subtitle: Text(book.author),
                  ));
            });
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => const AddEditBook());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
