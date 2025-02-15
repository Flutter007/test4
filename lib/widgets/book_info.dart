import 'package:flutter/material.dart';
import 'package:test4/helpers/formatted_date.dart';
import 'package:test4/model/book.dart';
import 'package:test4/widgets/book_info_text.dart';

class BookInfo extends StatelessWidget {
  final Book book;
  final void Function() closeInfo;
  const BookInfo({super.key, required this.book, required this.closeInfo});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BookInfoText(txt: 'Author', meaning: book.author),
            BookInfoText(txt: 'Title', meaning: book.title),
            BookInfoText(txt: 'Genre', meaning: book.genre.title),
            BookInfoText(txt: 'Pages', meaning: book.pages.toString()),
            BookInfoText(txt: 'Status', meaning: book.status.status),
            BookInfoText(
              txt: 'End Time',
              meaning: book.endTime != null
                  ? formatDateTime(book.endTime!)
                  : 'No Time',
            ),
            BookInfoText(txt: 'Rating', meaning: book.rating.toString()),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                  onPressed: closeInfo,
                  child: Text(
                    'Close',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
