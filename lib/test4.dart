import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test4/data/status_data.dart';
import 'package:test4/model/book.dart';
import 'package:test4/screens/books_screen.dart';
import 'package:test4/widgets/book_form.dart';
import 'package:test4/widgets/book_info.dart';

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
        statusID: 'is_reading',
        endTime: null,
        rating: 4),
  ];
  int counter = 0;
  String? selectedStatus = 'all_statuses';

  void deleteBook(String id) {
    setState(() {
      books.removeWhere((book) => book.id == id);
    });
  }

  void onCancel() {
    setState(() {
      Navigator.pop(context);
    });
  }

  void addBook(Book newBook) {
    setState(() {
      books.add(newBook);
      if (newBook.statusID == 'is_read') {
        counter++;
      }
    });
  }

  void editBook(Book editBook) {
    setState(() {
      final index = books.indexWhere((book) => book.id == editBook.id);
      books[index] = editBook;
    });
  }

  void openInfoSheet(Book book) {
    showModalBottomSheet(
      context: context,
      useSafeArea: true,
      isScrollControlled: true,
      builder: (ctx) => BookInfo(
        book: book,
        closeInfo: onCancel,
      ),
    );
  }

  void toEditBook(Book editBook) {
    setState(() {
      final index = books.indexWhere((book) => book.id == editBook.id);
      books[index] = editBook;
    });
  }

  void openAddBookSheet() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        useSafeArea: true,
        builder: (ctx) => BookForm(onBookSaved: addBook));
  }

  void openEditBookSheet(String id) {
    final editBook = books.firstWhere((book) => book.id == id);
    showModalBottomSheet(
        context: context,
        useSafeArea: true,
        isScrollControlled: true,
        builder: (ctx) =>
            BookForm(onBookSaved: toEditBook, editBook: editBook));
  }

  @override
  Widget build(BuildContext context) {
    books.sort((a, b) {
      if (a.statusID == 'is_reading' && b.statusID != 'is_reading') {
        return -1;
      } else if (b.statusID == 'is_reading' && a.statusID != 'is_reading') {
        return 1;
      }

      if (a.statusID == 'on_the_shelf' && b.statusID != 'on_the_shelf') {
        return -1;
      } else if (b.statusID == 'on_the_shelf' && a.statusID != 'on_the_shelf') {
        return 1;
      }

      if (a.statusID == 'postponed' && b.statusID != 'postponed') {
        return -1;
      } else if (b.statusID == 'postponed' && a.statusID != 'postponed') {
        return 1;
      }

      if (a.statusID == 'is_read' && b.statusID != 'is_read') {
        return -1;
      } else if (b.statusID == 'is_read' && a.statusID != 'is_read') {
        return 1;
      }

      return 0;
    });

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
          DropdownMenu(
            width: 200,
            initialSelection: selectedStatus,
            label: Text('Status : '),
            onSelected: ((value) => setState(() => selectedStatus == value)),
            dropdownMenuEntries: statuses
                .map(
                  (status) =>
                      DropdownMenuEntry(value: status.id, label: status.status),
                )
                .toList(),
          ),
          IconButton(
              onPressed: openAddBookSheet,
              icon: Icon(
                Icons.add,
                size: 30,
              ))
        ],
        toolbarHeight: 90,
      ),
      body: BooksScreen(
        books: (selectedStatus == 'all_statuses')
            ? books
            : books.where((book) => book.statusID == selectedStatus).toList(),
        onBookDelete: deleteBook,
        onBookEdit: openEditBookSheet,
        openInfo: openInfoSheet,
        counter: counter,
      ),
    );
  }
}
