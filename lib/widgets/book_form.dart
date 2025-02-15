import 'package:flutter/material.dart';
import 'package:test4/data/genre_data.dart';
import 'package:test4/data/status_data.dart';
import 'package:test4/helpers/formatted_date.dart';
import 'package:test4/model/book.dart';
import 'package:test4/widgets/rating_system.dart';

class BookForm extends StatefulWidget {
  final void Function(Book newBook) onBookSaved;
  final Book? editBook;
  const BookForm({
    super.key,
    required this.onBookSaved,
    this.editBook,
  });

  @override
  State<BookForm> createState() => _BookFormState();
}

class _BookFormState extends State<BookForm> {
  var selectedDate = DateTime.now();
  var selectedTime = TimeOfDay.now();
  final dateController = TextEditingController();
  final timeController = TextEditingController();
  final authorController = TextEditingController();
  final titleController = TextEditingController();
  final pagesController = TextEditingController();
  final ratingController = TextEditingController();
  String? selectedGenre;
  String? selectedStatus;

  @override
  void initState() {
    super.initState();
    if (widget.editBook != null) {
      final editedBook = widget.editBook!;
      authorController.text = editedBook.author;
      titleController.text = editedBook.title;
      pagesController.text = editedBook.pages.toString();
      selectedGenre = editedBook.genreID;
      selectedStatus = editedBook.statusID;
      ratingController.text = editedBook.rating.toString();
    }
    dateController.text = formatDate(selectedDate);
    timeController.text = formatTime(selectedTime);
  }

  @override
  void dispose() {
    super.dispose();
    dateController.dispose();
    timeController.dispose();
    authorController.dispose();
    titleController.dispose();
    pagesController.dispose();
  }

  void onCancel() {
    setState(() {
      Navigator.pop(context);
    });
  }

  void onSave() {
    final dateTime = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      selectedTime.hour,
      selectedTime.minute,
    );
    final addBook = Book(
      id: widget.editBook?.id,
      author: authorController.text.trim(),
      title: titleController.text.trim(),
      genreID: selectedGenre!,
      pages: int.parse(pagesController.text.trim()),
      statusID: selectedStatus!,
      endTime: dateTime,
      rating: int.parse(ratingController.text),
    );
    widget.onBookSaved(addBook);
    Navigator.pop(context);
  }

  void onDateTap() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final lastDate = DateTime(now.year, now.month, now.day);

    final userDateTime = await showDatePicker(
        context: context,
        firstDate: firstDate,
        lastDate: lastDate,
        initialDate: selectedDate);
    if (userDateTime != null) {
      setState(() {
        selectedDate = userDateTime;
        dateController.text = formatDate(selectedDate);
      });
    }
  }

  void onTimeTap() async {
    final userTime = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (userTime != null) {
      setState(() {
        selectedTime = userTime;
        timeController.text = formatTime(selectedTime);
      });
    }
  }

  void selectRating(int rate) {
    setState(() {
      ratingController.text = rate.toString();
    });
  }

  bool isChanged = false;
  void changeIsChanged() {
    setState(() {
      isChanged = !isChanged;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    return SingleChildScrollView(
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.fromLTRB(24, 24, 24, 24 + bottomInset),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: authorController,
                    decoration: const InputDecoration(
                      label: Text('Author'),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: TextField(
                    controller: titleController,
                    decoration: const InputDecoration(
                      label: Text('Title'),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            DropdownMenu(
              expandedInsets: EdgeInsets.zero,
              label: Text('Genre : '),
              inputDecorationTheme: theme.inputDecorationTheme,
              initialSelection: selectedGenre,
              onSelected: ((value) => setState(
                    () => value = selectedGenre,
                  )),
              dropdownMenuEntries: genres
                  .map(
                    (genre) => DropdownMenuEntry(
                      value: genre.id,
                      label: genre.title,
                      leadingIcon: Icon(genre.icon),
                    ),
                  )
                  .toList(),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: pagesController,
                    decoration: const InputDecoration(
                      label: Text('Pages'),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            DropdownMenu(
              expandedInsets: EdgeInsets.zero,
              label: Text('Status : '),
              inputDecorationTheme: theme.inputDecorationTheme,
              initialSelection: selectedStatus,
              onSelected: ((value) => setState(
                    () => value = selectedStatus,
                  )),
              dropdownMenuEntries: statuses
                  .map(
                    (status) => DropdownMenuEntry(
                      value: status.id,
                      label: status.status,
                    ),
                  )
                  .toList(),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: dateController,
                    onTap: onDateTap,
                    decoration: const InputDecoration(
                      label: Text('Select Date'),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: timeController,
                    onTap: onTimeTap,
                    decoration: const InputDecoration(
                      label: Text('Select Time'),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            RatingSystem(
              selectRating: selectRating,
              changeState: changeIsChanged,
            ),
            SizedBox(height: 14),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: onCancel,
                    child: Text('Cancel'),
                  ),
                ),
                SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: onSave,
                    child: Text('Save'),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
