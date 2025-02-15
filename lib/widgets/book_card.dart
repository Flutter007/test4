import 'package:flutter/material.dart';
import 'package:test4/model/book.dart';

class BookCard extends StatelessWidget {
  final Book book;
  const BookCard({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bodyLargeStyle = theme.textTheme.bodyLarge!;

    // final genre = book.genre;
    final status = book.status;
    return GestureDetector(
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
            ],
          ),
        ),
      ),
    );
  }
}
