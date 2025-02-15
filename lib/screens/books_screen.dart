import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:test4/model/book.dart';
import 'package:test4/widgets/book_card.dart';

class BooksScreen extends StatelessWidget {
  final List<Book> books;
  final void Function(String id) onBookDelete;
  final void Function(String id) onBookEdit;
  final void Function(Book) openInfo;
  final int? counter;

  const BooksScreen({
    super.key,
    required this.books,
    required this.onBookDelete,
    required this.onBookEdit,
    required this.openInfo,
    required this.counter,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bodyLargeStyle = theme.textTheme.bodyLarge!;

    if (books.isEmpty) {
      return Center(
        child: Text(
          'Список Пуст!',
          style: bodyLargeStyle,
        ),
      );
    }
    return Padding(
      padding: EdgeInsets.all(9),
      child: Column(
        children: [
          (counter == 100)
              ? Text(
                  'Поздравляем,цель достигнута!',
                  style: bodyLargeStyle.copyWith(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                      color: Colors.green),
                )
              : Text(
                  counter == null
                      ? 'Прочитано 0 Из 100'
                      : 'Прочитано $counter Из 100',
                  style: bodyLargeStyle.copyWith(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87),
                ),
          SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemBuilder: (ctx, index) {
                final book = books[index];
                return Slidable(
                  endActionPane: ActionPane(
                    motion: DrawerMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (ctx) => onBookDelete(book.id),
                        icon: Icons.delete,
                        backgroundColor: theme.colorScheme.error.withAlpha(220),
                        borderRadius: BorderRadius.circular(15),
                        label: 'Delete',
                        padding: EdgeInsets.zero,
                      ),
                      SlidableAction(
                        onPressed: (ctx) => onBookEdit(book.id),
                        icon: Icons.edit,
                        backgroundColor:
                            theme.colorScheme.secondary.withAlpha(220),
                        label: 'Edit',
                        borderRadius: BorderRadius.circular(15),
                        padding: EdgeInsets.zero,
                      ),
                    ],
                  ),
                  child: BookCard(
                    book: book,
                    openInfo: openInfo,
                  ),
                );
              },
              itemCount: books.length,
            ),
          ),
        ],
      ),
    );
  }
}
