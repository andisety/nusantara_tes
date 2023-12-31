import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/books.dart';

class DetailPage extends StatelessWidget {
  final Datum book;
  const DetailPage({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text(book.author)),
    );
  }
}
