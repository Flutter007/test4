import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test4/model/book.dart';
import 'package:test4/screens/books_screen.dart';

class Test4 extends StatefulWidget {
  const Test4({super.key});

  @override
  State<Test4> createState() => _Test4State();
}

class _Test4State extends State<Test4> {
  List<Book> books = [
    Book(
        author: 'Лев Толстой',
        title: 'Преступление и наказание',
        genreID: 'science_fiction',
        pages: 400,
        statusID: 'is_read',
        endTime: DateTime.now(),
        rating: 4),
  ];

  void deleteBook(String id) {
    setState(() {
      books.removeWhere((book) => book.id == id);
    });
  }

  void editBook(Book editBook) {
    setState(() {
      final index = books.indexWhere((book) => book.id == editBook.id);
      books[index] = editBook;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '100 Books a year!',
          style: GoogleFonts.alexandria(
            textStyle: theme.textTheme.bodyLarge!,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.add,
                size: 30,
              ))
        ],
        toolbarHeight: 50,
      ),
      body: BooksScreen(
        books: books,
        onBookDelete: deleteBook,
      ),
    );
  }
}
