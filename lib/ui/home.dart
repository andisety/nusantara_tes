import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nusantara_tes/ui/add_edit_book.dart';
import 'package:nusantara_tes/ui/detailpage.dart';
import 'package:nusantara_tes/ui/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controllers/bookController.dart';
import '../controllers/userCOntroller.dart';
import '../model/books.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  BookController bookController = Get.put(BookController());
  UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Book"),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'logout') {
                userController.logout();
                removeToken();
                Get.to(() => const LoginPage());
              } else if (value == 'refresh') {
                bookController.booksList.refresh();
              }
            },
            itemBuilder: (BuildContext context) => [
              const PopupMenuItem<String>(
                value: 'logout',
                child: Text('Logout'),
              ),
            ],
          ),
        ],
      ),
      body: Obx(() {
        return bookController.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: bookController.booksList.length,
                itemBuilder: (context, index) {
                  Datum book = bookController.booksList[index];
                  return GestureDetector(
                      onTap: () {
                        _showOptionsDialog(context, book);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 150,
                                height: 150,
                                child: Image.asset('assets/images/book.jpg'),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      book.title,
                                      style: const TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      'Author: ${book.author}',
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                    Text(
                                      'Published:${book.published}',
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
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

  void _showOptionsDialog(BuildContext context, Datum book) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Options for ${book.title}'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _viewBookDetails(context, book);
              },
              child: const Text('View'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _editBook(context, book);
              },
              child: const Text('Edit'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _deleteBook(context, book);
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  void _viewBookDetails(BuildContext context, Datum book) {
    Get.to(() => DetailPage(book: book));
  }

  void _editBook(BuildContext context, Datum book) {
    Get.to(() => AddEditBook(bookData: book));
  }

  void _deleteBook(BuildContext context, Datum book) {
    bookController.deleteBook(book.id);
    bookController.booksList.refresh();
  }

  Future<void> removeToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
  }
}
