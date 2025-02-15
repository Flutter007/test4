import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:test4/model/book.dart';
import 'package:test4/widgets/book_card.dart';

class BooksScreen extends StatelessWidget {
  final List<Book> books;
  final void Function(String id) onBookDelete;
  // final void Function(String id) onBookEdit;
  const BooksScreen({
    super.key,
    required this.books,
    required this.onBookDelete,
    // required this.onBookEdit,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.all(9),
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
                  onPressed: (ctx) => () {}, //=> onBookEdit(book.id),
                  icon: Icons.edit,
                  backgroundColor: theme.colorScheme.error.withAlpha(220),
                  label: 'Delete',
                  borderRadius: BorderRadius.circular(15),
                  padding: EdgeInsets.zero,
                ),
              ],
            ),
            child: BookCard(book: book),
          );
        },
        itemCount: books.length,
      ),
    );
  }
}
