import 'package:test4/data/genre_data.dart';
import 'package:test4/data/status_data.dart';
import 'package:test4/model/book_genre.dart';
import 'package:test4/model/book_status.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

class Book {
  final String id;
  final String author;
  final String title;
  final String genreID;
  final int pages;
  final String statusID;
  DateTime? endTime;
  final int rating;

  Book(
      {String? id,
      required this.author,
      required this.title,
      required this.genreID,
      required this.pages,
      required this.statusID,
      this.endTime,
      required this.rating})
      : id = id ?? uuid.v4();

  BookGenre get genre {
    return genres.firstWhere((genre) => genre.id == genreID);
  }

  BookStatus get status {
    return statuses.firstWhere((status) => status.id == statusID);
  }
}
