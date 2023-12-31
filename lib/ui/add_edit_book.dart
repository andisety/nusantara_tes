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
  DateTime selectedDate = DateTime.now();
  BookController bookController = Get.put(BookController());

  @override
  void initState() {
    super.initState();
    if (widget.bookData != null) {
      bookController.isbnController.text = widget.bookData!.isbn;
      bookController.titleController.text = widget.bookData!.title;
      widget.bookData!.subtitle != null
          ? bookController.subtitleController.text = widget.bookData!.subtitle!
          : "";
      widget.bookData!.author != null
          ? bookController.authorController.text = widget.bookData!.author!
          : "";

      widget.bookData!.published != null
          ? bookController.publishedController.text =
              widget.bookData!.published!.toString()
          : "";
      widget.bookData!.publisher != null
          ? bookController.publisherController.text =
              widget.bookData!.publisher!
          : "";
      widget.bookData!.pages != null
          ? bookController.pagesController.text =
              widget.bookData!.pages!.toString()
          : "";
      widget.bookData!.description != null
          ? bookController.descController.text = widget.bookData!.description!
          : "";
      widget.bookData!.website != null
          ? bookController.webController.text = widget.bookData!.website!
          : "";
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

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null && pickedDate != selectedDate) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        setState(() {
          selectedDate = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
        });
        bookController.publishedController.text =
            selectedDate.toLocal().toString();
        print(selectedDate.toLocal());
      }
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
                      TextFormField(
                        controller: bookController.publishedController,
                        decoration: InputDecoration(
                          labelText: 'Published Date',
                          suffixIcon: IconButton(
                            onPressed: () => _selectDate(context),
                            icon: Icon(Icons.calendar_today),
                          ),
                        ),
                        readOnly: true,
                        onTap: () => _selectDate(context),
                      ),
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
                          if (bookController.isbnController.text.isEmpty) {
                            Get.snackbar("Error", "ISBN wajib diisi");
                          } else if (bookController
                              .titleController.text.isEmpty) {
                            Get.snackbar("Error", "Title wajib diisi");
                          } else if (widget.bookData != null) {
                            bookController.editBook(widget.bookData!.id);
                          } else if (widget.bookData == null) {
                            bookController.addBook();
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
