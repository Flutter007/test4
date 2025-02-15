import 'dart:convert';
import 'dart:io';
import 'package:test4/helpers/get_data_path.dart';
import 'package:test4/model/book.dart';

Future<void> saveBooks(List<Book> books) async {
  final filePath = await getDataFilePath('books');
  final file = File(filePath);

  final booksMap = books
      .map((book) => {
            'id': book.id,
            'author': book.author,
            'title': book.title,
            'genreID': book.genreID,
            'pages': book.pages,
            'statusID': book.statusID,
            'endTime': book.endTime?.toIso8601String() ?? '',
            'rating': book.rating,
          })
      .toList();

  final booksJson = jsonEncode(booksMap);

  await file.writeAsString(booksJson);
}

Future<List<Book>> loadBooks() async {
  try {
    final filePath = await getDataFilePath('books');
    final file = File(filePath);

    final jsonContents = await file.readAsString();

    final booksMaps = jsonDecode(jsonContents) as List<dynamic>;

    return booksMaps.map((bookMap) {
      return Book(
        id: bookMap['id'],
        author: bookMap['author'],
        title: bookMap['title'],
        genreID: bookMap['genreID'],
        pages: bookMap['pages'],
        statusID: bookMap['statusID'],
        endTime: bookMap['endTime'] != ''
            ? DateTime.parse(bookMap['endTime'])
            : null,
        rating: bookMap['rating'],
      );
    }).toList();
  } catch (error) {
    return [];
  }
}
