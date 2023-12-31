// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nusantara_tes/controllers/bookController.dart';
import '../widget/input_fields.dart';
import '../widget/submit_button.dart';

class AddEditBook extends StatefulWidget {
  const AddEditBook({super.key});

  @override
  State<AddEditBook> createState() => _AddEditBookState();
}

class _AddEditBookState extends State<AddEditBook> {
  BookController bookController = Get.put(BookController());
  var isLogin = false.obs;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Book"),
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
                        onPressed: () => bookController.addBook(),
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
