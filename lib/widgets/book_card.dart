import 'package:flutter/material.dart';
import 'package:test4/helpers/formatted_date.dart';
import 'package:test4/model/book.dart';

class BookCard extends StatelessWidget {
  final Book book;
  final void Function(Book) openInfo;
  const BookCard({super.key, required this.book, required this.openInfo});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bodyLargeStyle = theme.textTheme.bodyLarge!;
    final status = book.status;
    return GestureDetector(
      onTap: () => openInfo(book),
      child: Card(
        color: Colors.brown.shade300,
        child: Padding(
          padding: const EdgeInsets.all(9),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Author: ${book.author}',
                      style: bodyLargeStyle,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Title: ${book.title}',
                      style: bodyLargeStyle,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Status : ${status.status}',
                    style:
                        bodyLargeStyle.copyWith(backgroundColor: Colors.white),
                  ),
                ],
              ),
              if (book.statusID == 'is_read')
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'End Time: ${formatDateTime(book.endTime)}\n'
                        'Rating:${book.rating.toString()}',
                        style: bodyLargeStyle.copyWith(
                            backgroundColor: Colors.white),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                )
            ],
          ),
        ),
      ),
    );
  }
}
