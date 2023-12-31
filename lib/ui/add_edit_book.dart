// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nusantara_tes/controllers/bookController.dart';
import '../model/books.dart';
import '../widget/input_fields.dart';
import '../widget/submit_button.dart';

class AddEditBook extends StatefulWidget {
  final Datum? bookData;
  const AddEditBook({super.key, this.bookData});

  @override
  State<AddEditBook> createState() => _AddEditBookState();
}

class _AddEditBookState extends State<AddEditBook> {
  var isLogin = false.obs;

  BookController bookController = Get.put(BookController());

  @override
  void initState() {
    super.initState();
    if (widget.bookData != null) {
      bookController.isbnController.text = widget.bookData!.isbn;
      bookController.titleController.text = widget.bookData!.title;
      bookController.subtitleController.text = widget.bookData!.subtitle;
      bookController.authorController.text = widget.bookData!.author;
      bookController.publishedController.text =
          widget.bookData!.published.toString();
      bookController.publisherController.text = widget.bookData!.publisher;
      bookController.pagesController.text = widget.bookData!.pages.toString();
      bookController.descController.text = widget.bookData!.description;
      bookController.webController.text = widget.bookData!.website;
    } else {
      bookController.isbnController.text = '';
      bookController.titleController.text = '';
      bookController.subtitleController.text = '';
      bookController.authorController.text = '';
      bookController.publishedController.text = '';
      bookController.publisherController.text = '';
      bookController.pagesController.text = '';
      bookController.descController.text = '';
      bookController.webController.text = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.bookData != null ? "Edit Book" : "Add Book",
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(36),
          child: Center(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      InputTextFieldWidget(
                          bookController.isbnController, 'ISBN'),
                      SizedBox(
                        height: 20,
                      ),
                      InputTextFieldWidget(
                          bookController.titleController, 'Title'),
                      SizedBox(
                        height: 20,
                      ),
                      InputTextFieldWidget(
                          bookController.subtitleController, 'Subtitle'),
                      SizedBox(
                        height: 20,
                      ),
                      InputTextFieldWidget(
                          bookController.authorController, 'Author'),
                      SizedBox(
                        height: 20,
                      ),
                      InputTextFieldWidget(
                          bookController.publishedController, 'Published'),
                      SizedBox(
                        height: 20,
                      ),
                      InputTextFieldWidget(
                          bookController.publisherController, 'Publisher'),
                      SizedBox(
                        height: 20,
                      ),
                      InputTextFieldWidget(
                          bookController.pagesController, 'Pages'),
                      SizedBox(
                        height: 20,
                      ),
                      InputTextFieldWidget(
                          bookController.descController, 'Description'),
                      SizedBox(
                        height: 20,
                      ),
                      InputTextFieldWidget(
                          bookController.webController, 'Website'),
                      SizedBox(
                        height: 20,
                      ),
                      SubmitButton(
                        onPressed: () {
                          if (widget.bookData == null) {
                            bookController.addBook();
                          } else {
                            bookController.editBook(widget.bookData!.id);
                          }
                        },
                        title: 'Save',
                      )
                    ],
                  )
                ]),
          ),
        ),
      ),
    );
  }
}
