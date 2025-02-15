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
  DateTime? selectedDate = DateTime.now();
  TimeOfDay? selectedTime = TimeOfDay.now();
  final dateController = TextEditingController();
  final timeController = TextEditingController();
  final authorController = TextEditingController();
  final titleController = TextEditingController();
  final pagesController = TextEditingController();
  final ratingController = TextEditingController();
  String? selectedGenre;
  String? selectedStatus;
  int? rating;

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
    DateTime? dateTime;
    if (selectedStatus == 'is_read' &&
        selectedDate != null &&
        selectedTime != null) {
      dateTime = DateTime(
        selectedDate!.year,
        selectedDate!.month,
        selectedDate!.day,
        selectedTime!.hour,
        selectedTime!.minute,
      );
    } else {
      dateTime = null;
    }

    if (ratingController.text.isNotEmpty) {
      rating = int.parse(ratingController.text);
    } else {
      rating = null;
    }
    final addBook = Book(
      id: widget.editBook?.id,
      author: authorController.text.trim(),
      title: titleController.text.trim(),
      genreID: selectedGenre!,
      pages: int.parse(pagesController.text.trim()),
      statusID: selectedStatus!,
      endTime: dateTime,
      rating: rating,
    );
    widget.onBookSaved(addBook);
    Navigator.pop(context);
  }

  bool isRightCompleted() {
    return authorController.text.isNotEmpty &&
        titleController.text.isNotEmpty &&
        selectedGenre != null &&
        pagesController.text.isNotEmpty &&
        selectedStatus != null;
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
      initialTime: selectedTime ?? TimeOfDay.now(),
    );
    if (userTime != null) {
      setState(() {
        selectedTime = userTime;
        timeController.text = formatTime(selectedTime);
      });
    }
  }

  void selectRating(int? rate) {
    setState(() {
      if (rate != 0) {
        ratingController.text = rate.toString();
      } else {
        rate = null;
      }
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
                    keyboardType: TextInputType.name,
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
              onSelected: (value) => setState(
                () => selectedGenre = value,
              ),
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
              onSelected: (value) => setState(
                () => selectedStatus = value,
              ),
              dropdownMenuEntries: statuses
                  .where((status) => status.id != 'all_statuses')
                  .map(
                    (status) => DropdownMenuEntry(
                      value: status.id,
                      label: status.status,
                    ),
                  )
                  .toList(),
            ),
            SizedBox(height: 10),
            if (selectedStatus == 'is_read')
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: dateController,
                      onTap: onDateTap,
                      readOnly: true,
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
                      readOnly: true,
                      decoration: const InputDecoration(
                        label: Text('Select Time'),
                      ),
                    ),
                  ),
                ],
              ),
            SizedBox(height: 20),
            if (selectedStatus == 'is_read')
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
                    onPressed: isRightCompleted() ? onSave : null,
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
