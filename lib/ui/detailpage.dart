import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../model/books.dart';

class DetailPage extends StatefulWidget {
  Datum book;
  DetailPage({super.key, required this.book});

  @override
  State<DetailPage> createState() => _DetailState();
}

class _DetailState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            child: Image.asset('assets/images/book.jpg'),
          ),
          SafeArea(child: buttonArrow(context)),
          scroll()
        ],
      ),
    );
  }

  scroll() {
    return DraggableScrollableSheet(
        minChildSize: 0.4,
        builder: (context, scrollController) {
          return Container(
            clipBehavior: Clip.hardEdge,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30))),
            child: SingleChildScrollView(
              controller: scrollController,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 35,
                          height: 5,
                          color: Colors.black12,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.book.title.toString(),
                            style: const TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold)),
                        const Text("ISBN :",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text(
                          widget.book.isbn.toString(),
                          textAlign: TextAlign.justify,
                        ),
                        const Text("Author :",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text(
                          widget.book.author.toString(),
                          textAlign: TextAlign.justify,
                        ),
                        const Text("Subtitle :",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text(
                          widget.book.subtitle.toString(),
                          textAlign: TextAlign.justify,
                        ),
                        const Text("Published :",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text(
                          widget.book.published.toString(),
                          textAlign: TextAlign.justify,
                        ),
                        const Text("Publisher :",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text(
                          widget.book.publisher.toString(),
                          textAlign: TextAlign.justify,
                        ),
                        const Text("pages :",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text(
                          widget.book.pages.toString(),
                          textAlign: TextAlign.justify,
                        ),
                        const Text("Description :",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text(
                          widget.book.description.toString(),
                          textAlign: TextAlign.justify,
                        ),
                        const Text("Website :",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text(
                          widget.book.website.toString(),
                          textAlign: TextAlign.justify,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Text(
                          "Release Date :",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(widget.book.author.toString()),
                        const SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  buttonArrow(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
            clipBehavior: Clip.hardEdge,
            height: 50,
            width: 50,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(25)),
            child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                ))),
      ),
    );
  }
}
